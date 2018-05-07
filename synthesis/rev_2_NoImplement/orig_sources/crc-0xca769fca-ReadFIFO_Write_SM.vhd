--------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     16 September 2014 
-- Module Name:     ReadFIFO_Write_SM.vhd 
-- Project Name:    Powered Rail
-- Target Devices:  TBD
-- Description:  
--     The Read FIFO Write State Machine is responsible for moving received data
--     from the Receive AFE Interface logic to the Receive FIFO.  In addition, 
--     it handles error condition and provide interrupts to the processor.  
--     The Receive State Machine detects the sync byte, aligns the bits into 
--     bytes, and moves data to the Receive FIFO based on the length bytes received.  
--     The address, length and CRC are included in the Receive FIFO.
--
-------------------------------------------------------------------------------
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
--      -- ManchesDecoder.vhd 
--           -- AFE_RX_SM.vhd
--           -- ReadFIFO_Write_SM.vhd          <=
--                -- CRC16_Generator.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--
-- Revision:  0.1
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

entity ReadFIFO_Write_SM is
  Port (
    rst                       : in  std_logic;
    clk16x                    : in  std_logic;
    sampler_clk1x_en          : in  std_logic;  
    idle_line                 : in  std_logic;
    clk1x_enable              : in  std_logic;
    packet_avail              : in  std_logic;
    consumer_type1_reg        : in  std_logic_vector(9 downto 0);
    consumer_type2_reg        : in  std_logic_vector(9 downto 0);
    consumer_type3_reg        : in  std_logic_vector(9 downto 0);
    consumer_type4_reg        : in  std_logic_vector(9 downto 0);
    TX_collision_detect       : in  std_logic;
    tx_col_detect_en          : in  std_logic;
    RX_FIFO_DIN               : in  std_logic_vector(7 downto 0);
    RX_FIFO_DIN_pipe          : out std_logic_vector(8 downto 0);
    RX_FIFO_wr_en             : out std_logic;  
    RX_FIFO_TxColDetDis_wr_en : out std_logic;
    rx_crc_Byte_en            : out std_logic;
    rx_CRC_error              : out std_logic;
    rx_packet_end             : out std_logic;
    rx_packet_complt          : out std_logic;
    RX_EarlyTerm              : out std_logic;
    TX_Enable                 : in  std_logic   
  );   
end ReadFIFO_Write_SM;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of ReadFIFO_Write_SM is

-- Constants 

-- Signals 
  signal rx_fifo_din_d1       : std_logic_vector(7 downto 0);
  signal rx_fifo_din_d2       : std_logic_vector(7 downto 0);
  signal rx_fifo_din_d3       : std_logic_vector(7 downto 0);
  signal RX_FIFO_DIN_pipe_i   : std_logic_vector(8 downto 0);
  signal rx_byte_cntr         : std_logic_vector(11 downto 0);
  signal rx_packet_length     : std_logic_vector(11 downto 0);
  signal irx_packet_end       : std_logic;
  signal consumer_type        : std_logic_vector( 9 downto 0);
  signal iRX_FIFO_wr_en       : std_logic; 
  signal RX_InProcess         : std_logic; 
  signal RX_InProcess_d1      : std_logic; 
  signal bit_cntr             : std_logic_vector(2 downto 0);
  signal hold_collision       : std_logic;
  signal iRX_EarlyTerm        : std_logic;
  signal rx_crc_reset         : std_logic;
  signal rx_end_rst           : std_logic;
  signal rx_crc_gen           : std_logic;
  signal rx_crc_en            : std_logic;
  signal rx_crc_data_calc     : std_logic_vector (15 downto 0);
  signal rx_crc_data_store    : std_logic_vector(15 downto 0);
  signal rx_crc_HighByte_en   : std_logic;
  signal rx_crc_LowByte_en    : std_logic;
--  signal rx_crc_Byte_en       : std_logic;
  signal SM_advance           : std_logic;
  signal SM_advance_i         : std_logic;
  signal SM_advancebit_cntr   : std_logic_vector(2 downto 0);
  signal rx_EndOfPacket_2FIFO : std_logic;
  signal First_time_reg	      : std_logic; 
 
  
-- state machine state defintions
type   ReadFIFO_WR_STATE_TYPE is (
              IDLE, HDR_BYTE1, HDR_BYTE2, HDR_BYTE3, HDR_BYTE4, DATA_BYTES,
              EARLY_TERM, STORE_HIGH_CRC, STORE_LOW_CRC, CRC_CHECK_ST, RX_END );
signal ReadFIFO_WR_STATE         : ReadFIFO_WR_STATE_TYPE; 
    
---------1---------2---------3---------4---------5---------6---------7---------8
begin

  RX_FIFO_DIN_pipe    <= RX_FIFO_DIN_pipe_i;
  RX_FIFO_DIN_pipe_i  <= rx_EndOfPacket_2FIFO & rx_fifo_din_d3;

  RX_FIFO_wr_en             <= iRX_FIFO_wr_en and sampler_clk1x_en
                               and RX_InProcess_d1;
  RX_FIFO_TxColDetDis_wr_en <= iRX_FIFO_wr_en and sampler_clk1x_en 
                               and RX_InProcess_d1 and not tx_col_detect_en;

  SM_advance                <= SM_advance_i and sampler_clk1x_en; 
  RX_EarlyTerm              <= iRX_EarlyTerm;
  rx_packet_end             <= irx_packet_end;
  rx_EndOfPacket_2FIFO      <= rx_crc_LowByte_en;

  rx_crc_reset              <= rst or rx_end_rst;
  rx_crc_en                 <= rx_crc_gen and iRX_FIFO_wr_en;
  rx_crc_Byte_en            <= rx_crc_HighByte_en or rx_crc_LowByte_en;
  
-------------------------------------------------------------------------------
  -- Hold Collision Detected State during Receive
---------1---------2---------3---------4---------5---------6---------7---------8
  HOLD_COL_PROC: PROCESS (rst, TX_collision_detect, idle_line)
  begin
    if ( rst = '1' or idle_line = '1' ) then
      hold_collision    <= '0';
    elsif ( TX_collision_detect = '1' and tx_col_detect_en = '1' ) then
      hold_collision    <= '1';
    else
      hold_collision    <= hold_collision;
    end if;  
  end process;
  
--------------------------------------------------------------------------------
-- Delay / Synchroizer @ clk16x
---------1---------2---------3---------4---------5---------6---------7---------8 
  RX_DELAY_SYNC_PROC : process (rst, clk16x)
  begin
    if ( rst = '1' ) then
      RX_InProcess_d1 <= '0';
    elsif ( rising_edge(clk16x) ) then 
      RX_InProcess_d1 <= RX_InProcess;
    end if ;
  end process;
  
   
--------------------------------------------------------------------------------
-- first time through flag to simulate CRC error -- gwc
---------1---------2---------3---------4---------5---------6---------7---------8 
  First_Time : process (rst, clk16x, ReadFIFO_WR_STATE)
  begin
    if ( rst = '1' ) then
      First_Time_reg <= '0';
    elsif ( rising_edge(clk16x) and (ReadFIFO_WR_STATE = EARLY_TERM) and (First_Time_reg = '0')) then 
      First_Time_reg <= '1';
	else 
	  First_Time_reg <= First_Time_reg;
    end if ;
  end process;
  
  
  
--------------------------------------------------------------------------------
-- Read FIFO State Machine Advance
---------1---------2---------3---------4---------5---------6---------7---------8 
  SM_ADVANCE_PROC : process (rst, clk16x, sampler_clk1x_en, iRX_EarlyTerm, clk1x_enable)
  begin
    if ( rst = '1' or iRX_EarlyTerm = '1' or clk1x_enable = '0' ) then
      SM_advance_i       <= '0' after 1ns;
      SM_advancebit_cntr <= (others => '0');
    elsif ( rising_edge(clk16x) and sampler_clk1x_en = '1' ) then 
      if ( packet_avail = '1' ) then  
        if (SM_advancebit_cntr = "111") then
          SM_advance_i       <= '1' after 1ns;
          SM_advancebit_cntr <= (others => '0');
        else
          SM_advance_i       <= '0' after 1ns;
          SM_advancebit_cntr <= SM_advancebit_cntr + '1';
        end if;
     end if ;
    end if ;
  end process;
  
--------------------------------------------------------------------------------
-- Read FIFO Write Process - When 8 bits occur, assert write to ReadFIFO
---------1---------2---------3---------4---------5---------6---------7---------8 
  ReadFIFO_WRITE_PROC : process (rst, clk16x, sampler_clk1x_en, iRX_EarlyTerm, irx_packet_end, clk1x_enable)
  begin
    if (    rst = '1'           or irx_packet_end = '1' 
         or iRX_EarlyTerm = '1' or clk1x_enable = '0' ) then
      iRX_FIFO_wr_en <= '0' after 1ns;
      bit_cntr       <= (others => '0');
    elsif ( rising_edge(clk16x) and sampler_clk1x_en = '1' ) then 
      if ( packet_avail = '1' ) then  
        if (bit_cntr = "111") then
          iRX_FIFO_wr_en <= '1' after 1ns;
          bit_cntr       <= (others => '0');
        else
          iRX_FIFO_wr_en <= '0' after 1ns;
          bit_cntr       <= bit_cntr + '1';
        end if;
     end if ;
    end if ;
  end process;

--------------------------------------------------------------------------------
  -- Receiver CRC Generater
---------1---------2---------3---------4---------5---------6---------7---------8  
  RX_CRC_GEN_INST : entity work.CRC16_Generator
    port map( 
      rst       => rx_crc_reset,
      clk       => clk16x,
      clk_en    => sampler_clk1x_en,
      data_in   => RX_FIFO_DIN,
      crc_en    => rx_crc_en,
      crc_out   => rx_crc_data_calc
    );

-------------------------------------------------------------------------------
  -- CRC Data Store Process
---------1---------2---------3---------4---------5---------6---------7---------8
  CRC_DATA_STORE_PROC: process (clk16x, sampler_clk1x_en, rst)
  begin
    if ( rst = '1' ) then
      rx_crc_data_store       <= (others => '0');
    elsif ( rising_edge(clk16x) and sampler_clk1x_en = '1' ) then 
      if ( SM_advance_i = '1' and rx_crc_HighByte_en = '1' ) then  
        rx_crc_data_store(15 downto 8)  <= RX_FIFO_DIN_pipe_i(7 downto 0);
        rx_crc_data_store( 7 downto 0)  <= (others => '0');
      elsif ( SM_advance_i = '1' and rx_crc_LowByte_en = '1' ) then 
        rx_crc_data_store(15 downto 8)  <= rx_crc_data_store(15 downto 8);
        rx_crc_data_store( 7 downto 0)  <= RX_FIFO_DIN_pipe_i(7 downto 0);
      else
        rx_crc_data_store               <= rx_crc_data_store;
     end if ;
   end if ;
  end process;

--------------------------------------------------------------------------------
-- Delay RX_FIFO_DIN 
---------1---------2---------3---------4---------5---------6---------7---------8 
  RX_FIFO_DIN_DELAY_PROC : process (clk16x, rst)
  begin
    if (rst = '1') then
      rx_fifo_din_d1 <= (others => '0') ;
      rx_fifo_din_d2 <= (others => '0') ;
      rx_fifo_din_d3 <= (others => '0') ;
    elsif (rising_edge(clk16x) and SM_advance = '1' ) then
      rx_fifo_din_d1 <= RX_FIFO_DIN;
      rx_fifo_din_d2 <= rx_fifo_din_d1;
      rx_fifo_din_d3 <= rx_fifo_din_d2;
    end if;
  end process;

--------------------------------------------------------------------------------
-- Main state machine
---------1---------2---------3---------4---------5---------6---------7---------8
  ReadFIFO_WR_SM : PROCESS (clk16x, sampler_clk1x_en, rst, idle_line)
  begin
      if ( rst = '1' ) then
        ReadFIFO_WR_STATE     <= IDLE;
        rx_byte_cntr          <= (others => '0');
        consumer_type         <= (others => '0');
        rx_packet_length      <= (others => '0');
        irx_packet_end        <= '0';
        rx_packet_complt      <= '0';
        RX_InProcess          <= '0';
        iRX_EarlyTerm         <= '0';
        rx_end_rst            <= '1'; 
        rx_crc_gen            <= '0';
        rx_crc_HighByte_en    <= '0';
        rx_crc_LowByte_en     <= '0';
        rx_CRC_error          <= '0';
      elsif ( rising_edge(clk16x) ) then 
        CASE ReadFIFO_WR_STATE    IS

        ------------------------ IDLE ----------------------------------------
          when IDLE =>                                 -- Store High Consumer
            if ( packet_avail = '1' and SM_advance_i = '1' 
                 and sampler_clk1x_en = '1' ) then       
              if ( hold_collision = '1' ) then
                ReadFIFO_WR_STATE   <= EARLY_TERM;       
              else
                ReadFIFO_WR_STATE   <= HDR_BYTE1;
              end if;                      
--              rx_byte_cntr                  <= rx_byte_cntr + '1';
              rx_byte_cntr                  <= rx_byte_cntr;
              consumer_type(9 downto 2)     <= RX_FIFO_DIN(7 downto 0);
              consumer_type(1 downto 0)     <= consumer_type(1 downto 0);
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '1';                      
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            else                      
              ReadFIFO_WR_STATE             <= IDLE;
              rx_byte_cntr                  <= (others => '0');
              consumer_type                 <= (others => '0');
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '1';
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            end if;
            
        --------------------- HDR_BYTE1 --------------------------------------
          when HDR_BYTE1 =>                              -- Store Low Consumer
            if ( SM_advance_i = '1' and sampler_clk1x_en = '1' ) then
              if ( hold_collision = '1' ) then        
                ReadFIFO_WR_STATE   <= EARLY_TERM;
              else
                ReadFIFO_WR_STATE   <= HDR_BYTE2;            
              end if; 
--              rx_byte_cntr                  <= rx_byte_cntr + '1';
              rx_byte_cntr                  <= rx_byte_cntr;
              consumer_type(9 downto 2)     <= consumer_type(9 downto 2);
              consumer_type(1 downto 0)     <= RX_FIFO_DIN(7 downto 6);
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '1';
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            end if;

        --------------------- HDR_BYTE2 --------------------------------------
          when HDR_BYTE2 =>                              -- Store Upper Length
            if ( SM_advance_i = '1' and sampler_clk1x_en = '1' ) then
              if  ( hold_collision = '1' or
                      (     (consumer_type /=    consumer_type1_reg) 
                       and  (consumer_type /=    consumer_type2_reg) 
                       and  (consumer_type /=    consumer_type3_reg) 
                       and  (consumer_type /=    consumer_type4_reg) 
                       and   TX_Enable = '0') ) then
                                          
                ReadFIFO_WR_STATE   <= EARLY_TERM;
              else
                ReadFIFO_WR_STATE   <= HDR_BYTE3;            
              end if;
--              rx_byte_cntr                  <= rx_byte_cntr + '1';
              rx_byte_cntr                  <= rx_byte_cntr;
              consumer_type                 <= consumer_type;
              rx_packet_length(10 downto 8) <= RX_FIFO_DIN(2 downto 0);
              rx_packet_length( 7 downto 0) <= rx_packet_length(7 downto 0);
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '1';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '1';
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            end if;

        --------------------- HDR_BYTE3 --------------------------------------
          when HDR_BYTE3 =>                              -- Store Lower Length
            if ( SM_advance_i = '1' and sampler_clk1x_en = '1' ) then
              if ( hold_collision = '1' ) then 
                ReadFIFO_WR_STATE   <= EARLY_TERM;
              else
                ReadFIFO_WR_STATE   <= DATA_BYTES;            
              end if;                             
              rx_byte_cntr                  <= rx_byte_cntr + '1';
              consumer_type                 <= consumer_type;
              rx_packet_length(10 downto 8) <= rx_packet_length(10 downto 8);
              rx_packet_length(7 downto 0)  <= RX_FIFO_DIN(7 downto 0);
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '1';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '1';
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            end if;
      
        --------------------- DATA_BYTES --------------------------------------
          when DATA_BYTES =>                             -- Store Data Bytes
            if ( SM_advance_i = '1' and sampler_clk1x_en = '1' ) then
              if ( hold_collision = '1' ) then
                ReadFIFO_WR_STATE   <= EARLY_TERM;
                rx_crc_gen                  <= '0';
                rx_crc_HighByte_en          <= '0';
                rx_crc_LowByte_en           <= '0';
              elsif ( rx_byte_cntr = (rx_packet_length - 2) ) then
                ReadFIFO_WR_STATE   <= STORE_HIGH_CRC;
                rx_crc_gen                  <= '0';              
                rx_crc_HighByte_en          <= '1';
                rx_crc_LowByte_en           <= '0';
              else
                ReadFIFO_WR_STATE   <= DATA_BYTES;
                if ( rx_byte_cntr > (rx_packet_length - 6 ) ) then
                  rx_crc_gen                <= '0';
                else
                  rx_crc_gen                <= '1';                
                end if;
                rx_crc_HighByte_en          <= '0';
               rx_crc_LowByte_en            <= '0';
             end if;
              consumer_type                 <= consumer_type;
              rx_byte_cntr                  <= rx_byte_cntr + '1';
              rx_packet_length              <= rx_packet_length;
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '1';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_CRC_error                  <= '0';
            end if;
                          
        --------------------- STORE_HIGH_CRC -----------------------------------
          when STORE_HIGH_CRC =>                      -- Store High Bytes of CRC
            if ( SM_advance_i = '1' and sampler_clk1x_en = '1' ) then
              if ( hold_collision = '1' ) then
                ReadFIFO_WR_STATE   <= EARLY_TERM;              
              else
                ReadFIFO_WR_STATE   <= STORE_LOW_CRC;
              end if;
              consumer_type                 <= consumer_type;
              rx_byte_cntr                  <= rx_byte_cntr + '1';
              rx_packet_length              <= rx_packet_length;
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '1';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '0';  
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '1';
              rx_CRC_error                  <= '0';
            end if;           

        --------------------- STORE_LOW_CRC -----------------------------------
          when STORE_LOW_CRC =>                       -- Store Low Bytes of CRC
            if ( SM_advance_i = '1' and sampler_clk1x_en = '1' ) then
              ReadFIFO_WR_STATE             <= CRC_CHECK_ST; 
              consumer_type                 <= (others => '0');
              rx_byte_cntr                  <= (others => '0');
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '1';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '0';  
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            end if;   

        --------------------- CRC_CHECK_ST -----------------------------------
          when CRC_CHECK_ST =>
            if ( sampler_clk1x_en = '1' ) then
              consumer_type                 <= (others => '0');
              rx_byte_cntr                  <= (others => '0');
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '1';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '0';  
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              if ( (rx_crc_data_store /= rx_crc_data_calc) ) then -- or First_time_reg = '0') then  -- uncomment line to simulate CRC gwc
                rx_CRC_error                <= '1';
				ReadFIFO_WR_STATE           <= EARLY_TERM;	-- gwc
              else
                rx_CRC_error                <= '0';            
                ReadFIFO_WR_STATE           <= RX_END; -- gwc
              end if; 
            end if;
          
        --------------------- RX_END --------------------------------------
          when RX_END =>                                    -- END of  
            if ( idle_line = '1' ) then                     -- Normal RX
              ReadFIFO_WR_STATE             <= IDLE; 
              consumer_type                 <= (others => '0');
              rx_byte_cntr                  <= rx_byte_cntr;
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '1';    
                if ( tx_col_detect_en = '1' ) then
                  rx_packet_complt          <= '0';
                else
                  rx_packet_complt          <= '1';
                end if;
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '1';
              rx_crc_gen                    <= '0';
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            else                                
              ReadFIFO_WR_STATE             <= RX_END;
              consumer_type                 <= (others => '0');
              rx_byte_cntr                  <= rx_byte_cntr;
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '1';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '0';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '0';
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            end if; 
            
        --------------------- EARLY_TERM --------------------------------------
          when EARLY_TERM =>                             -- Terminate if 
--            if ( idle_line = '1' and sampler_clk1x_en = '1' ) then                  -- Collision or not 
            if ( idle_line = '1' ) then                  -- Collision or not 
              ReadFIFO_WR_STATE             <= IDLE;     -- consumer
              consumer_type                 <= (others => '0');
              rx_byte_cntr                  <= rx_byte_cntr;
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '1';
              rx_end_rst                    <= '1';
              rx_crc_gen                    <= '0';
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            else                                
              ReadFIFO_WR_STATE             <= EARLY_TERM;
              consumer_type                 <= (others => '0');
              rx_byte_cntr                  <= rx_byte_cntr;
              rx_packet_length              <= (others => '0');
              irx_packet_end                <= '0';
              rx_packet_complt              <= '0';
              RX_InProcess                  <= '0';
              iRX_EarlyTerm                 <= '1';
              rx_end_rst                    <= '0';
              rx_crc_gen                    <= '0';
              rx_crc_HighByte_en            <= '0';
              rx_crc_LowByte_en             <= '0';
              rx_CRC_error                  <= '0';
            end if;                            

         ----------------------- OTHERS ---------------------------------------
          when others =>
            null;  
        end case;
      end if;
  end process;
   
end Behavioral;