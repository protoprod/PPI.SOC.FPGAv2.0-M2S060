--------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     16 September 2014 
-- Module Name:     TX_SM.vhd 
-- Project Name:    Powered Rail
-- Target Devices:  TBD
-- Description: 
--      The Transmit State Machine is responsible for moving data to 
--      the TX AFE Interface during the appropriate transmission window.  
--      In addition, it handles error conditions and interrupts to the 
--      processor.  Transmit data is loaded into the Transmit FIFO by the 
--      processor.  The data loaded by the processor includes the Header and 
--      Data but not the CRC.  The Transmit State Machine provides control 
--      to the following functions and discussed in subsequent sections.
-------------------------------------------------------------------------------
-- Structure:
--    CommsFPGA_top.vhd 
--      -- uP_if.vhd
--           -- Interrupts.vhd
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd                       <=
--                -- IdleLineDetector.vhd
--           -- CRC16_Generator.vhd
--      -- FIFOs.vhd
--           -- FIFO_1Kx8.vhd
--      -- ManchesDecoder.vhd 
--           -- AFE_RX_SM.vhd
--           -- ReadFIFO_Write_SM.vhd
--                -- CRC16_Generator.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--
--
-------------------------------------------------------------------------------
-- This revision history is a PPI history
--
-- v 1.0 PPI 2/17/2015 original release
--
---------1---------2---------3---------4---------5---------6---------7---------8

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TX_SM is
  Generic (
    PREAMBLE_LENGTH     : natural range 0 to 4095 := 1;  -- # of Bytes
    POSTAMBLE_LENGTH    : natural range 0 to 4095 := 1   -- # of Bytes
  );
  Port (
    -- System Interface
    reset               : in  std_logic;
    byte_clk_en         : in  std_logic;
    CLK_BIT_5MHz        : in  std_logic; 
    clk16x              : in  std_logic;
    manches_in_dly      : in  std_logic_vector(1 downto 0); 
    start_tx_FIFO       : in  std_logic; -- control_reg(5); 
    TX_FIFO_DOUT        : in  std_logic_vector(7 downto 0);
    TX_FIFO_rd_en       : out std_logic; 
    TX_FIFO_Empty       : in  std_logic; -- Line Clock Domain
    TX_PreAmble         : out std_logic;
	  TX_DataEn           : out std_logic;
	  TX_PostAmble        : out std_logic;
	  TX_Enable           : out std_logic;
	  tx_preamble_pat_en  : out std_logic;
	  tx_packet_complt    : out std_logic;
	  tx_crc_gen          : out std_logic;
    tx_crc_byte1_en     : out std_logic;
    tx_crc_byte2_en     : out std_logic

  );   
end TX_SM;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of TX_SM is

-- Constants 
  -- Below constant defines the time in "CLK_BIT_5MHz" periods to delay between
  -- the assertion of "TX_EN" and the start of transmitted data.
  constant TXEN_EARLY_LENGTH : std_logic_vector(11 downto 0) := x"000";  --x"100"; 
  constant TX_IDLE_LINE_CNTR_MAX : std_logic_vector(6 downto 0) := "1001111"; 

-- Signals 
  signal start_tx_FIFO_s    : std_logic;
  signal tx_idle_line_s     : std_logic;
  signal PreAmble_cntr      : std_logic_vector( PREAMBLE_LENGTH-1 downto 0);
  signal PostAmble_cntr     : std_logic_vector(POSTAMBLE_LENGTH-1 downto 0);  
  signal iTX_FIFO_rd_en     : std_logic;  
  signal tx_byte_cntr       : std_logic_vector(11 downto 0);
  signal tx_packet_length   : std_logic_vector(11 downto 0);
  signal tx_idle_line       : std_logic;
  signal tx_idle_line_cntr  : std_logic_vector(6 downto 0);
  signal iTX_PostAmble      : std_logic;
  
  signal txen_early_cntr    : std_logic_vector(11 downto 0);
  
-- state machine state defintions
type   TX_STATE_TYPE is (
--              IDLE, TX_PREAMBLE_ST, TX_DATA_ST, TX_START_ST, TX_DATA_END_ST1, 
              IDLE, TX_EARLY_TXEN, TX_PREAMBLE_ST, TX_DATA_ST, TX_START_ST, TX_DATA_END_ST1, 
              TX_DATA_END_ST2, TX_POSTAMBLE_ST, TX_END_ST
                );
signal TX_STATE         : TX_STATE_TYPE; 
    
---------1---------2---------3---------4---------5---------6---------7---------8
begin

  TX_FIFO_rd_en  <= iTX_FIFO_rd_en and byte_clk_en;
  TX_PostAmble   <= iTX_PostAmble;
  
-------------------------------------------------------------------------------
  -- Synchronizers
---------1---------2---------3---------4---------5---------6---------7---------8
  SYNCHRONIZATION_PROC: PROCESS (CLK_BIT_5MHz, byte_clk_en, reset)
  begin
    if ( reset = '1' ) then
      start_tx_FIFO_s     <= '0';
      tx_idle_line_s      <= '0';
   elsif ( rising_edge(CLK_BIT_5MHz) and byte_clk_en = '1' ) then
      start_tx_FIFO_s     <= start_tx_FIFO;
      tx_idle_line_s      <= tx_idle_line;
    end if;
  end process;

--------------------------------------------------------------------------------
-- Idle Line Detection
---------1---------2---------3---------4---------5---------6---------7---------8
  TX_IDLE_LINE_DETECTOR : entity work.IdleLineDetector
    Generic Map(
      IDLE_LINE_CNTR_MAX  => TX_IDLE_LINE_CNTR_MAX
    )
    Port Map(
      reset               => reset,
      clk                 => clk16x,
      manches_in_dly      => manches_in_dly,
      idle_line           => tx_idle_line
    );
      
  -----------------------------------------------------------------------------
  -- Main state machine
  ---------1---------2---------3---------4---------5---------6---------7---------8
  TX_SM : PROCESS (CLK_BIT_5MHz, byte_clk_en, reset)
  begin  
      if ( reset = '1' ) then
        TX_STATE           <= IDLE;
        PreAmble_cntr      <= (others => '0');
        PostAmble_cntr     <= (others => '0');
        tx_byte_cntr       <= (others => '0');
        TX_PreAmble        <= '0';
        TX_DataEn          <= '0';  
        iTX_FIFO_rd_en     <= '0';
        iTX_PostAmble      <= '0';
        TX_Enable          <= '0';    
        tx_packet_complt   <= '0';
        tx_packet_length   <= (others => '0');
        tx_preamble_pat_en <= '0';
        tx_crc_gen         <= '0';
        tx_crc_byte1_en    <= '0';
        tx_crc_byte2_en    <= '0';
        txen_early_cntr <= (others => '0');        
      elsif ( rising_edge(CLK_BIT_5MHz) and byte_clk_en = '1' ) then 
        CASE TX_STATE    IS

        ------------------------ IDLE ----------------------------------------
          when IDLE =>
            if ( start_tx_FIFO_s = '1' and tx_idle_line_s = '1' ) then
--            if ( start_tx_FIFO_s = '1' ) then
              TX_STATE           <= TX_EARLY_TXEN;
              PreAmble_cntr      <= (others => '0');
              PostAmble_cntr     <= (others => '0');
              tx_byte_cntr       <= (others => '0'); 
              TX_PreAmble        <= '0';
              TX_DataEn          <= '0';  
              iTX_FIFO_rd_en     <= '0';
              iTX_PostAmble      <= '0';
              TX_Enable          <= '0';
              tx_packet_complt   <= '0';
              tx_packet_length   <= (others => '0'); 
              tx_preamble_pat_en <= '0';
              tx_crc_gen         <= '0';
              tx_crc_byte1_en    <= '0';
              tx_crc_byte2_en    <= '0';
              txen_early_cntr    <= (others => '0');  
            else                      
              TX_STATE           <= IDLE;
              PreAmble_cntr      <= (others => '0');
              PostAmble_cntr     <= (others => '0');
              tx_byte_cntr       <= (others => '0'); 
              TX_PreAmble        <= '0'; 
              TX_DataEn          <= '0';  
              iTX_FIFO_rd_en     <= '0'; 
              iTX_PostAmble      <= '0';
              TX_Enable          <= '0';
              tx_packet_complt   <= '0';
              tx_packet_length   <= (others => '0'); 
              tx_preamble_pat_en <= '0';
              tx_crc_gen         <= '0';
              tx_crc_byte1_en    <= '0';
              tx_crc_byte2_en    <= '0';
              txen_early_cntr    <= (others => '0');
            end if;

        --------------------- TX_EARLY_TXEN ----------------------------------
          when TX_EARLY_TXEN => 
            if ( txen_early_cntr = TXEN_EARLY_LENGTH ) then
              TX_STATE           <= TX_PREAMBLE_ST;
              PreAmble_cntr      <= (others => '0');
              PostAmble_cntr     <= (others => '0');
              tx_byte_cntr       <= (others => '0'); 
              TX_PreAmble        <= '0';
              TX_DataEn          <= '0';  
              iTX_FIFO_rd_en     <= '0';
              iTX_PostAmble      <= '0';
              TX_Enable          <= '1';
              tx_packet_complt   <= '0';
              tx_packet_length   <= (others => '0'); 
              tx_preamble_pat_en <= '0';
              tx_crc_gen         <= '0';
              tx_crc_byte1_en    <= '0';
              tx_crc_byte2_en    <= '0';
              txen_early_cntr    <= (others => '0');
            else                       
              TX_STATE           <= TX_EARLY_TXEN;
              PreAmble_cntr      <= (others => '0');
              PostAmble_cntr     <= (others => '0');
              tx_byte_cntr       <= (others => '0'); 
              TX_PreAmble        <= '0'; 
              TX_DataEn          <= '0';  
              iTX_FIFO_rd_en     <= '0'; 
              iTX_PostAmble      <= '0';
              TX_Enable          <= '1';
              tx_packet_complt   <= '0';
              tx_packet_length   <= (others => '0'); 
              tx_preamble_pat_en <= '0';
              tx_crc_gen         <= '0';
              tx_crc_byte1_en    <= '0';
              tx_crc_byte2_en    <= '0';
              txen_early_cntr    <= txen_early_cntr + '1';
            end if;
            
        --------------------- TX_PREAMBLE_ST --------------------------------------
          when TX_PREAMBLE_ST =>
            if ( TX_FIFO_Empty = '0' ) then
              if ( PreAmble_cntr = (PREAMBLE_LENGTH-1) ) then
                TX_STATE           <= TX_START_ST; 
                PreAmble_cntr      <= (others => '0');
                PostAmble_cntr     <= (others => '0');
                tx_byte_cntr       <= (others => '0'); 
                TX_PreAmble        <= '1'; 
                TX_DataEn          <= '1';
                iTX_FIFO_rd_en     <= '1';
                iTX_PostAmble      <= '0';
                TX_Enable          <= '1';
                tx_packet_complt   <= '0';
                tx_packet_length   <= (others => '0');
                tx_preamble_pat_en <= '1';
                tx_crc_gen         <= '0';
                tx_crc_byte1_en    <= '0';
                tx_crc_byte2_en    <= '0';
                txen_early_cntr    <= (others => '0');
             else                  
                TX_STATE           <= TX_PREAMBLE_ST; 
                PreAmble_cntr      <= PreAmble_cntr + '1';
                PostAmble_cntr     <= (others => '0'); 
                tx_byte_cntr       <= (others => '0'); 
                TX_PreAmble        <= '1'; 
                TX_DataEn          <= '0';
                iTX_FIFO_rd_en     <= '0';
                iTX_PostAmble      <= '0';
                TX_Enable          <= '1';
                tx_packet_complt   <= '0';
                tx_packet_length   <= (others => '0');
                tx_preamble_pat_en <= '0';
                tx_crc_gen         <= '0';
                tx_crc_byte1_en    <= '0';
                tx_crc_byte2_en    <= '0';
                txen_early_cntr    <= (others => '0');
              end if;
            else                      
              TX_STATE             <= TX_PREAMBLE_ST;
              PreAmble_cntr        <= PreAmble_cntr;
              PostAmble_cntr       <= (others => '0');
              tx_byte_cntr         <= (others => '0'); 
              TX_PreAmble          <= '1'; 
              TX_DataEn            <= '0';
              iTX_FIFO_rd_en       <= '0';
              iTX_PostAmble        <= '0';
              TX_Enable            <= '1';
              tx_packet_complt     <= '0';
              tx_packet_length     <= (others => '0'); 
              tx_preamble_pat_en   <= '0';
              tx_crc_gen           <= '0';
              tx_crc_byte1_en      <= '0';
              tx_crc_byte2_en      <= '0';
              txen_early_cntr      <= (others => '0');  
            end if;

        --------------------- TX_START_ST --------------------------------------
          when TX_START_ST => 
              TX_STATE             <= TX_DATA_ST; 
              PreAmble_cntr        <= (others => '0');
              PostAmble_cntr       <= (others => '0'); 
              tx_byte_cntr         <= tx_byte_cntr + '1'; 
              TX_PreAmble          <= '0'; 
              TX_DataEn            <= '1';
              iTX_FIFO_rd_en       <= '1';
              iTX_PostAmble        <= '0';
              TX_Enable            <= '1';
              tx_packet_complt     <= '0';
              tx_packet_length     <= tx_packet_length; 
              tx_preamble_pat_en   <= '0';
              tx_crc_gen           <= '1';
              tx_crc_byte1_en      <= '0';
              tx_crc_byte2_en      <= '0';
              txen_early_cntr      <= (others => '0');
                
        --------------------- TX_DATA_ST --------------------------------------
          when TX_DATA_ST => 
            if    (tx_byte_cntr = "000000000011" ) then  --load MSB of tx_packet_length
              TX_STATE                   <= TX_DATA_ST; 
              PreAmble_cntr              <= (others => '0');
              PostAmble_cntr             <= (others => '0'); 
              tx_byte_cntr               <= tx_byte_cntr + '1'; 
              TX_PreAmble                <= '0';
              TX_DataEn                  <= '1';
              iTX_FIFO_rd_en             <= '1';
              iTX_PostAmble              <= '0';
              TX_Enable                  <= '1';
              tx_packet_complt           <= '0';
              tx_packet_length(10 downto 8) <= TX_FIFO_DOUT(2 downto 0);
              tx_packet_length(7 downto 0)  <= tx_packet_length(7 downto 0);
              tx_preamble_pat_en         <= '0';
              tx_crc_gen                 <= '1';
              tx_crc_byte1_en            <= '0';
              tx_crc_byte2_en            <= '0';
              txen_early_cntr            <= (others => '0');
            elsif (tx_byte_cntr = "000000000100" ) then  --load LSB of tx_packet_length
              TX_STATE                   <= TX_DATA_ST; 
              PreAmble_cntr              <= (others => '0');
              PostAmble_cntr             <= (others => '0'); 
              tx_byte_cntr               <= tx_byte_cntr + '1'; 
              TX_PreAmble                <= '0'; 
              TX_DataEn                  <= '1';
              iTX_FIFO_rd_en             <= '1';
              iTX_PostAmble              <= '0';
              TX_Enable                  <= '1';
              tx_packet_complt           <= '0';
              tx_packet_length(10 downto 8) <= tx_packet_length(10 downto 8);
              tx_packet_length(7 downto 0)  <= TX_FIFO_DOUT(7 downto 0);
              tx_preamble_pat_en         <= '0';
              tx_crc_gen                 <= '1';
              tx_crc_byte1_en            <= '0';
              tx_crc_byte2_en            <= '0';
              txen_early_cntr            <= (others => '0');
            elsif (tx_byte_cntr = (tx_packet_length - "10") ) then  --End of Packet
              TX_STATE                   <= TX_DATA_END_ST1; 
              PreAmble_cntr              <= (others => '0');
              PostAmble_cntr             <= (others => '0'); 
              tx_byte_cntr               <= tx_byte_cntr + '1'; 
              TX_PreAmble                <= '0';
              TX_DataEn                  <= '1';
              iTX_FIFO_rd_en             <= '0';
              iTX_PostAmble              <= '0';
              TX_Enable                  <= '1';
              tx_packet_complt           <= '0';
              tx_packet_length           <= tx_packet_length;                
              tx_preamble_pat_en         <= '0';
              tx_crc_gen                 <= '1';
              tx_crc_byte1_en            <= '0';
              tx_crc_byte2_en            <= '0';
              txen_early_cntr            <= (others => '0');
            else          
              TX_STATE                   <= TX_DATA_ST; 
              PreAmble_cntr              <= (others => '0');
              PostAmble_cntr             <= (others => '0'); 
              tx_byte_cntr               <= tx_byte_cntr + '1'; 
              TX_PreAmble                <= '0'; 
              TX_DataEn                  <= '1';
              iTX_FIFO_rd_en             <= '1';
              iTX_PostAmble              <= '0';
              TX_Enable                  <= '1';
              tx_packet_complt           <= '0';
              tx_packet_length           <= tx_packet_length;
              tx_preamble_pat_en         <= '0';
              tx_crc_gen                 <= '1';
              tx_crc_byte1_en            <= '0';
              tx_crc_byte2_en            <= '0';
              txen_early_cntr            <= (others => '0');
            end if;

        --------------------- TX_DATA_END_ST1 ----------------------------------
          when TX_DATA_END_ST1 => 
              TX_STATE             <= TX_DATA_END_ST2; 
              PreAmble_cntr        <= (others => '0');
              PostAmble_cntr       <= (others => '0');
              tx_byte_cntr         <= (others => '0');
              TX_PreAmble          <= '0'; 
              TX_DataEn            <= '1';
              iTX_FIFO_rd_en       <= '0';
              iTX_PostAmble        <= '0';
              TX_Enable            <= '1';
              tx_packet_complt     <= '0';
              tx_packet_length     <= tx_packet_length;
              tx_preamble_pat_en   <= '0';
              tx_crc_gen           <= '0';
              tx_crc_byte1_en      <= '1';
              tx_crc_byte2_en      <= '0';
              txen_early_cntr      <= (others => '0');

        --------------------- TX_DATA_END_ST2 ----------------------------------
          when TX_DATA_END_ST2 => 
              TX_STATE             <= TX_POSTAMBLE_ST; 
              PreAmble_cntr        <= (others => '0');
              PostAmble_cntr       <= (others => '0');
              tx_byte_cntr         <= (others => '0');
              TX_PreAmble          <= '0'; 
              TX_DataEn            <= '1';
              iTX_FIFO_rd_en       <= '0';
              iTX_PostAmble        <= '0';
              TX_Enable            <= '1';
              tx_packet_complt     <= '0';
              tx_packet_length     <= tx_packet_length;
              tx_preamble_pat_en   <= '0';
              tx_crc_gen           <= '0';
              tx_crc_byte1_en      <= '0';
              tx_crc_byte2_en      <= '1';
              txen_early_cntr      <= (others => '0');
                            
        --------------------- TX_POSTAMBLE_ST --------------------------------------
          when TX_POSTAMBLE_ST =>
              if ( PostAmble_cntr = (POSTAMBLE_LENGTH-1) ) then
                TX_STATE           <= TX_END_ST; 
                PreAmble_cntr      <= (others => '0');
                PostAmble_cntr     <= (others => '0');
                tx_byte_cntr       <= (others => '0');
                TX_PreAmble        <= '0'; 
                TX_DataEn          <= '0';
                iTX_FIFO_rd_en     <= '0';
                iTX_PostAmble      <= '1';
                TX_Enable          <= '1';
                tx_packet_complt   <= '0';
                tx_packet_length   <= (others => '0'); 
                tx_preamble_pat_en <= '0';
                tx_crc_gen         <= '0';
                tx_crc_byte1_en    <= '0';
                tx_crc_byte2_en    <= '0';
                txen_early_cntr    <= (others => '0');
              else
                TX_STATE           <= TX_POSTAMBLE_ST; 
                PreAmble_cntr      <= (others => '0');
                PostAmble_cntr     <= PostAmble_cntr + '1'; 
                tx_byte_cntr       <= (others => '0');
                TX_PreAmble        <= '0'; 
                TX_DataEn          <= '0';
                iTX_FIFO_rd_en     <= '0';
                iTX_PostAmble      <= '1';
                TX_Enable          <= '1';
                tx_packet_complt   <= '0';
                tx_packet_length   <= (others => '0');  
                tx_preamble_pat_en <= '0';
                tx_crc_gen         <= '0';
                tx_crc_byte1_en    <= '0';
                tx_crc_byte2_en    <= '0';
                txen_early_cntr    <= (others => '0');
              end if;

        --------------------- TX_END_ST ----------------------------------
          when TX_END_ST => 
              TX_STATE             <= IDLE; 
              PreAmble_cntr        <= (others => '0');
              PostAmble_cntr       <= (others => '0');
              tx_byte_cntr         <= (others => '0');
              TX_PreAmble          <= '0'; 
              TX_DataEn            <= '0';
              iTX_FIFO_rd_en       <= '0';
              iTX_PostAmble        <= '0';
              TX_Enable            <= '1';
              tx_packet_complt     <= '1';
              tx_packet_length     <= (others => '0'); 
              tx_preamble_pat_en   <= '0';
              tx_crc_gen           <= '0';
              tx_crc_byte1_en      <= '0';
              tx_crc_byte2_en      <= '0';
              txen_early_cntr      <= (others => '0');
      
         ----------------------- OTHERS ---------------------------------------
          when others =>
            null;  
        end case;
      end if;
--    end if;
  end process;

end Behavioral;