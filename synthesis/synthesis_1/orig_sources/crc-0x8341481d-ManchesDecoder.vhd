----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     16 September 2014 
-- Module Name:     ManchesDecoder.vhd 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     
--     The Decoder is responsible for accepting packets from the
--     iRail and pushing then into the Receive FIFO.  Then interrupts the processor.
--     The Decoder provides Receive Timing Recovery, Manchester Decoding, 
--     Serial to Parallel Conversion, Clock Adaption, Preamble Detection, 
--     and Collision Detection.
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
--      -- ManchesDecoder.vhd                  <=
--           -- AFE_RX_SM.vhd
--           -- ReadFIFO_Write_SM.vhd
--                -- CRC16_Generator.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--
-- Revision:  0.1
--
----------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ManchesDecoder is
  Generic (
    START_BYTE_SYMBOL      : std_logic_vector(7 downto 0) := x"81"
  );
  Port (
    rst                       : in  std_logic;
    clk16x                    : in  std_logic;
    manches_in_dly            : out std_logic_vector(1 downto 0);
    RX_FIFO_TxColDetDis_wr_en : out std_logic;  -- Allows TX Collision Detection
    RX_FIFO_wr_en             : out std_logic;
    RX_FIFO_DIN               : out std_logic_vector(7 downto 0);
    RX_FIFO_DIN_pipe          : out std_logic_vector(8 downto 0);
    RX_FIFO_Empty             : in  std_logic;
    MANCHESTER_IN             : in  std_logic;
    MANCH_OUT_P               : in  std_logic;
    consumer_type1_reg        : in  std_logic_vector(9 downto 0);
    consumer_type2_reg        : in  std_logic_vector(9 downto 0);
    consumer_type3_reg        : in  std_logic_vector(9 downto 0);
    consumer_type4_reg        : in  std_logic_vector(9 downto 0);
    internal_loopback         : in  std_logic;
    TX_collision_detect       : in  std_logic;
    rx_crc_Byte_en            : out std_logic;
    rx_packet_avail           : out std_logic;
    rx_packet_end             : out std_logic;
    rx_packet_complt          : out std_logic;
    rx_CRC_error              : out std_logic;
    RX_EarlyTerm              : out std_logic;
    tx_col_detect_en          : in  std_logic;
    TX_Enable                 : in  std_logic
  );
end ManchesDecoder;

architecture v1 of ManchesDecoder is

-- Constants 
  constant RX_IDLE_LINE_CNTR_MAX : std_logic_vector(6 downto 0) := "0111111"; 

-- Signals
  signal clk1x_enable           : std_logic ;
  signal imanches_in_dly        : std_logic_vector(1 downto 0);
  signal sampler_clk1x_en       : std_logic;
  signal irx_center_sample      : std_logic;
  signal idle_line              : std_logic;
  signal packet_avail           : std_logic;
--  signal rx_crc_Byte_en         : std_logic;
  signal rx_packet_end_all      : std_logic; 
  signal iRX_FIFO_DIN           : std_logic_vector(7 downto 0);
  signal iRX_EarlyTerm          : std_logic;
  signal iRX_FIFO_wr_en         : std_logic;
  signal irx_packet_end         : std_logic;
  signal irx_packet_complt      : std_logic;

begin

  rx_packet_complt  <= irx_packet_complt;   

  manches_in_dly    <= imanches_in_dly;

  RX_EarlyTerm      <= iRX_EarlyTerm;
  rx_packet_end     <= irx_packet_end;

  RX_FIFO_wr_en     <= iRX_FIFO_wr_en;
  RX_FIFO_DIN       <= iRX_FIFO_DIN;

  
--------------------------------------------------------------------------------
-- CLOCK ADAPTER
---------1---------2---------3---------4---------5---------6---------7---------8 
-- Since there is no common clock distributed along the iRail, it is possible 
-- to have data errors due to these clock differences between devices.  This 
-- situation is overcome by oversampling the data by a little more the 16 times 
-- clock, or 81.25 MHz and determining when the receive data is about to slip 
-- past the sampling point.  When this occurs, the receiver is told to “skip” 
-- one of the 81.25 MHz clocks, thus realigning the data and sampling point. 
---------1---------2---------3---------4---------5---------6---------7---------8 

MANCHESTER_DECODER_ADAPTER_INST : entity work.ManchesDecoder_Adapter
  Generic Map(
    RX_IDLE_LINE_CNTR_MAX   => RX_IDLE_LINE_CNTR_MAX
  )
  Port Map(
    rst                     => rst,                -- in
    clk16x                  => clk16x,             -- in
    clk1x_enable            => clk1x_enable,       -- in
    rx_packet_end_all       => rx_packet_end_all,  -- in
    MANCHESTER_IN           => MANCHESTER_IN,      -- in
    internal_loopback       => internal_loopback,  -- in
    MANCH_OUT_P             => MANCH_OUT_P,        -- in
    manches_in_dly          => imanches_in_dly,    -- out
    sampler_clk1x_en        => sampler_clk1x_en,   -- out
    rx_center_sample        => irx_center_sample,  -- out
    idle_line               => idle_line,          -- out
    RX_FIFO_DIN             => iRX_FIFO_DIN        -- out
  );

--------------------------------------------------------------------------------
-- AFE State Machine
---------1---------2---------3---------4---------5---------6---------7---------8 
-- The AFE State Machine coordinates the reception of data from the AFE to the 
-- RX Packet Processor.  It starts when an edge is detected on the iRail.  Then 
-- looks for the start byte and when detected, coordinates the byte construction 
-- before passing off to the RX State Machine.
---------1---------2---------3---------4---------5---------6---------7---------8 

  AFE_RX_STATE_MACHINE : entity work.AFE_RX_SM
  Generic Map(
    START_BYTE_SYMBOL     => START_BYTE_SYMBOL
  )
    Port Map(
      reset             => rst,
      clk               => clk16x,
      RX_FIFO_DIN       => iRX_FIFO_DIN,      -- in  All
      RX_FIFO_Empty     => RX_FIFO_Empty,     -- in  None
      manches_in_dly    => imanches_in_dly,   -- in  CA
      sample            => irx_center_sample, -- in  CA<img src="
      idle_line         => idle_line,         -- in  All" />
      rx_packet_end     => irx_packet_end,    -- in  SM
      clk1x_enable      => clk1x_enable,      -- out All
  	  packet_avail      => packet_avail,      -- out All
  	  rx_packet_avail   => rx_packet_avail,   -- out None
  	  rx_packet_end_all => rx_packet_end_all, -- out CA
  	  RX_EarlyTerm      => iRX_EarlyTerm      -- in  CA
    ); 

--------------------------------------------------------------------------------
-- Receiver Byte Controller performs the below functions:
--   1. Stores and Checks Consumer Address
--   2. Stores Packet Length
--   3. Stores Data Bytes
--   4. Stores and checks CRC
---------1---------2---------3---------4---------5---------6---------7---------8 

  ReadFIFO_Write_SM_PROC : entity work.ReadFIFO_Write_SM
    Port Map(
      rst                       => rst,
      clk16x                    => clk16x,
      sampler_clk1x_en          => sampler_clk1x_en,
      idle_line                 => idle_line,
      clk1x_enable              => clk1x_enable,
      packet_avail              => packet_avail,
      rx_crc_Byte_en            => rx_crc_Byte_en,
      consumer_type1_reg        => consumer_type1_reg,
      consumer_type2_reg        => consumer_type2_reg,
      consumer_type3_reg        => consumer_type3_reg,
      consumer_type4_reg        => consumer_type4_reg,
      TX_collision_detect       => TX_collision_detect,
      tx_col_detect_en          => tx_col_detect_en,
      RX_FIFO_DIN               => iRX_FIFO_DIN,
      RX_FIFO_DIN_pipe          => RX_FIFO_DIN_pipe,
      RX_FIFO_wr_en             => iRX_FIFO_wr_en, 
      RX_FIFO_TxColDetDis_wr_en => RX_FIFO_TxColDetDis_wr_en,
      rx_CRC_error              => rx_CRC_error,
      rx_packet_end             => irx_packet_end,
      rx_packet_complt          => irx_packet_complt,
      RX_EarlyTerm              => iRX_EarlyTerm
    ); 

end;

