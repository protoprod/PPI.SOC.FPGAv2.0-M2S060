----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     17 August 2014 
-- Design Name:     Powered Rail Performance Tester 
-- Module Name:     ManchesEncoder.vhd - Behavioral 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     
--     The Encoder is responsible for accepting packets from the processor 
--     (via the Transmit FIFO) and transmitting them on to the iRail. The Encoder 
--     provides Timing Generation, Parallel to Serial Conversion, Preamble and 
--     Postamble Generation, CRC Generation and Manchester Encoding.
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd
--                -- IdleLineDetector.vhd
--           -- CRC16_Generator.vhd
--      -- FIFOs.vhd
--           -- FIFO_1Kx8.vhd
--      -- ManchesDecoder.vhd                   <=
--           -- AFE_RX_SM.vhd
--           -- ReadFIFO_Write_SM.vhd
--                -- CRC16_Generator.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--
--         
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

entity ManchesEncoder is
  Generic (
    START_BYTE_SYMBOL     : std_logic_vector(7 downto 0) := x"D5";	-- for 802.1Q  was x"81";
	START_PREAMBLE_SYMBOL : std_logic_vector(7 downto 0) := x"55";	-- for 802.1Q  
    PREAMBLE_LENGTH       : natural range 0 to 4095 := 1;  -- # of Bytes
    POSTAMBLE_LENGTH      : natural range 0 to 4095 := 1   -- # of Bytes
  );                      
  Port (                  
    reset                 : in  std_logic;
    clk16x                : in  std_logic;
	  bit_clk2x             : in  std_logic;
	  byte_clk_en           : in  std_logic;
	  CLK_BIT_5MHz          : in  std_logic;
	  manches_in_dly        : in  std_logic_vector(1 downto 0);
	  start_tx_FIFO         : in  std_logic;
	  TX_FIFO_rd_en         : out std_logic;
	  TX_FIFO_Empty         : in  std_logic;
	  TX_Enable             : out std_logic;
	  TX_PreAmble           : out std_logic; 
	  TX_FIFO_DOUT          : in  std_logic_vector(7 downto 0);
    tx_packet_complt      : out std_logic;
    RX_FIFO_wr_clk        : in  std_logic; 
    RX_FIFO_wr_en         : in  std_logic; 
    RX_FIFO_DIN           : in  std_logic_vector(7 downto 0);
    rx_crc_Byte_en        : in  std_logic; 
    tx_col_detect_en      : out std_logic;
    TX_collision_detect   : out std_logic;
    internal_loopback     : in  std_logic;
    external_loopback     : in  std_logic;
    MANCHESTER_OUT        : out std_logic
  );
end ManchesEncoder;

architecture Behavioral of ManchesEncoder is

-- constants
  
-- signals
signal man_data               : std_logic;
signal p2s_data               : std_logic_vector(7 downto 0); 
signal tx_crc_reset           : std_logic;
signal tx_crc_data            : std_logic_vector (15 downto 0);
signal byte_clk_en_d          : std_logic_vector ( 1 downto 0);
signal TX_PostAmble_d1        : std_logic;
signal TX_DataEn_d1           : std_logic;
signal iTX_PreAmble           : std_logic;
signal TX_PreAmble_d         : std_logic_vector (2 downto 0); -- gwc
signal TX_DataEn              : std_logic;
signal TX_PostAmble           : std_logic;
signal itx_packet_complt      : std_logic;
signal tx_preamble_pat_en     : std_logic;
signal tx_crc_gen             : std_logic;
signal tx_crc_byte1_en        : std_logic;
signal tx_crc_byte2_en        : std_logic;
signal iTX_FIFO_rd_en         : std_logic;
signal iTX_Enable             : std_logic;
signal nCLK_BIT_5MHz		  : std_logic;
  
begin
                  
  tx_crc_reset      <= reset or itx_packet_complt;
  TX_PreAmble       <= iTX_PreAmble;
  tx_packet_complt  <= itx_packet_complt;
  TX_FIFO_rd_en     <= iTX_FIFO_rd_en;
  TX_Enable         <= iTX_Enable;
  
  nCLK_BIT_5MHz <= not CLK_BIT_5MHz;
  
--------------------------------------------------------------------------------		
  -- Delay Process
---------1---------2---------3---------4---------5---------6---------7---------8  
  DELAY_PROC : process(CLK_BIT_5MHz, reset)
  begin
    if(reset = '1') then
      byte_clk_en_d         <= (others => '0');
      TX_PostAmble_d1       <= '0';
      TX_DataEn_d1          <= '0';
    elsif rising_edge(CLK_BIT_5MHz) then
      byte_clk_en_d         <= byte_clk_en_d(0) & byte_clk_en;
      TX_PostAmble_d1       <= TX_PostAmble;
      TX_DataEn_d1          <= TX_DataEn;
    end if;
  end process;

--------------------------------------------------------------------------------
  -- Parallel to Serial Conversion
---------1---------2---------3---------4---------5---------6---------7---------8  
  PARALLEL_2_SERIAL_PROC : process(CLK_BIT_5MHz, reset)
  begin
    if( reset = '1' ) then
      p2s_data  <= (others => '0');
    elsif rising_edge( CLK_BIT_5MHz ) then
	  if ( TX_PreAmble_d(1) = '1' and byte_clk_en_d(0) = '1' and tx_preamble_pat_en = '0') then	-- gwc new state to allow programmable preamble symbol
		  p2s_data  <= START_PREAMBLE_SYMBOL;
      elsif ( TX_DataEn = '1' and byte_clk_en_d(0) = '1' ) then
        if ( tx_preamble_pat_en = '1' ) then
          p2s_data  <= START_BYTE_SYMBOL;
		elsif ( tx_crc_byte1_en = '1' ) then
          p2s_data  <= tx_crc_data(15 downto 8);
        elsif ( tx_crc_byte2_en = '1' ) then
          p2s_data  <= tx_crc_data(7 downto 0);
        else
          p2s_data  <= TX_FIFO_DOUT;
        end if;
      elsif ( TX_DataEn = '1' or iTX_PreAmble = '1' ) then	-- gwc shift out preamble or data
        p2s_data  <= p2s_data(6 downto 0) & '0'; 
      else
        p2s_data  <= (others => '0');
      end if;
    end if;
  end process;

--------------------------------------------------------------------------------	
  -- Clock Manchester Encoded data with 2x the bit clock to avoid glitches.
---------1---------2---------3---------4---------5---------6---------7---------8
  MAN_OUT_DATA_PROC : process(bit_clk2x, reset)
  begin
    if(reset = '1') then
      MANCHESTER_OUT <= '0'; 	
	  TX_PreAmble_d <= "000";
    elsif rising_edge(bit_clk2x) then
	  TX_PreAmble_d <= TX_PreAmble_d(1) & TX_PreAmble_d(0) & iTX_PreAmble;
      if ( TX_PreAmble_d(1) = '1' and tx_preamble_pat_en = '0' ) then
--        MANCHESTER_OUT <= ( CLK_BIT_5MHz xor '1');   
		MANCHESTER_OUT <= ( CLK_BIT_5MHz xor p2s_data(7));   -- gwc write preamble pattern 0x55 instead of all 1's
      elsif ( iTX_PreAmble = '1' and tx_preamble_pat_en = '1' ) then
        MANCHESTER_OUT <= ( CLK_BIT_5MHz xor p2s_data(7) );
      elsif ( TX_DataEn = '1' or TX_DataEn_d1 = '1' ) then
        MANCHESTER_OUT <= ( CLK_BIT_5MHz xor p2s_data(7) );     
--      elsif ( TX_DataEn = '1' ) then
--        MANCHESTER_OUT <= ( CLK_BIT_5MHz xor not p2s_data(7) );     
      elsif ( TX_PostAmble_d1 = '1' ) then
        MANCHESTER_OUT <= ( CLK_BIT_5MHz xor '1' );  
      else
        MANCHESTER_OUT <= p2s_data(7);
      end if;   
    end if;
  end process;

--------------------------------------------------------------------------------
-- Transmit Collision Detector
---------1---------2---------3---------4---------5---------6---------7---------
TX_COLLISION_DETECTOR_INST : entity work.TX_Collision_Detector
  Port Map(
    reset                 => reset,
    RX_FIFO_wr_clk        => RX_FIFO_wr_clk, 
    RX_FIFO_wr_en         => RX_FIFO_wr_en,
    RX_FIFO_DIN           => RX_FIFO_DIN,
    rx_crc_Byte_en        => rx_crc_Byte_en,
    TX_FIFO_rd_clk        => CLK_BIT_5MHz, 
    TX_FIFO_DOUT          => p2s_data,
    TX_Enable             => iTX_Enable,
    byte_clk_en           => byte_clk_en_d(1),
    internal_loopback     => internal_loopback,
    external_loopback     => external_loopback,
    tx_packet_complt      => itx_packet_complt,
    tx_col_detect_en      => tx_col_detect_en,
    TX_collision_detect   => TX_collision_detect
  );
    
--------------------------------------------------------------------------------
-- Transmit State Machine
---------1---------2---------3---------4---------5---------6---------7---------8 
-- The Transmit State Machine is responsible for moving data to the TX AFE 
-- Interface during the appropriate transmission window.  In addition, it 
-- handles error conditions and provides interrupts to the processor.  
-- Transmit data is loaded into the Transmit FIFO by the processor.  The data 
-- loaded by the processor includes the Header and Data but not the CRC.  
-- The Transmit State Machine provides Preamble Generation, pulls Data from the 
-- Transmit FIFO, CRC Generation Control, and Postamble Generation Control.
---------1---------2---------3---------4---------5---------6---------7---------8 
  TRANSMIT_SM : entity work.TX_SM
    generic map(
      PREAMBLE_LENGTH     => PREAMBLE_LENGTH,
      POSTAMBLE_LENGTH    => POSTAMBLE_LENGTH    
    )
    port map(
      reset               => reset,
      byte_clk_en         => byte_clk_en,
      CLK_BIT_5MHz        => CLK_BIT_5MHz,
      clk16x              => clk16x,
      manches_in_dly      => manches_in_dly,
      start_tx_FIFO       => start_tx_FIFO,
      TX_FIFO_DOUT        => TX_FIFO_DOUT,
      TX_FIFO_rd_en       => iTX_FIFO_rd_en,
      TX_FIFO_Empty       => TX_FIFO_Empty,
      TX_PreAmble         => iTX_PreAmble,
      TX_DataEn           => TX_DataEn,
      TX_PostAmble        => TX_PostAmble,
      TX_Enable           => iTX_Enable,
      tx_packet_complt    => itx_packet_complt,
      tx_preamble_pat_en  => tx_preamble_pat_en,
      tx_crc_gen          => tx_crc_gen,
      tx_crc_byte1_en     => tx_crc_byte1_en,
      tx_crc_byte2_en     => tx_crc_byte2_en
    );

--------------------------------------------------------------------------------
  -- Transmitter CRC Generater
---------1---------2---------3---------4---------5---------6---------7---------8  
  TX_CRC_GEN_INST : entity work.CRC16_Generator
    port map( 
      rst           => tx_crc_reset,
      clk           => CLK_BIT_5MHz,
      clk_en        => byte_clk_en,
      data_in       => TX_FIFO_DOUT,
      crc_en        => tx_crc_gen,
      crc_out       => tx_crc_data
    );
            
end Behavioral;
