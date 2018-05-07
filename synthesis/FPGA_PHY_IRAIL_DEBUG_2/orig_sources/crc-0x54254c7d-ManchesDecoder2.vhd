----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     16 September 2014
-- Module Name:     ManchesDecoder2.vhd
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:
--     The Decoder is responsible for accepting packets from the
--     iRail and pushing then into the Receive FIFO.  Then interrupts the processor.
--     The Decoder provides Receive Timing Recovery, Manchester Decoding,
--     Serial to Parallel Conversion, Clock Adaption, Preamble Detection,
--     and Collision Detection.
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- TX_Collision_Detector2.vhd
--      -- IdleLineDetector.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--              -- Edge_Detect.vhd
--      -- ManchesterEncoder2.vhd
--           -- Nib2Ser_SM.vhd
--           -- Jabber_SM.vhd
--           -- Edge_Detect.vhd
--      -- ManchesDecoder2.vhd                  <=
--           -- RX_SM.vhd
--           -- CLOCK_DOMAIN_BUFFER.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--           -- BitDector.vhd
--
-- Revision:  0.1
--
----------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ManchesDecoder2 is
  Generic (
    START_BYTE_SYMBOL      : std_logic_vector(7 downto 0) := x"5D";
    PREABLE_PATTERN        : std_logic_vector(7 downto 0) := x"55"
  );
  Port (
    rx_packet_end_all         : out std_logic;
    rst                       : in  std_logic;
    clk16x                    : in  std_logic;
    manches_in_dly            : out std_logic_vector(1 downto 0);
    MII_RX_CLK                : in  std_logic;
    MII_RX_EN                 : out std_logic;
    MII_RX_D                  : out std_logic_vector(3 downto 0);
    MANCHESTER_IN             : in  std_logic;
    MANCH_OUT_P               : in  std_logic;
    SFD_timeout               : out std_logic;
    internal_loopback         : in  std_logic
  );
end ManchesDecoder2;

architecture v1 of ManchesDecoder2 is

-- Constants
  constant RX_IDLE_LINE_CNTR_MAX : std_logic_vector(15 downto 0) := x"0600";    -- gwc intergap packet timing

-- Signals
  signal clk1x_enable           : std_logic ;
  signal imanches_in_dly        : std_logic_vector(1 downto 0);
  signal sampler_clk1x_en       : std_logic;
  signal irx_center_sample      : std_logic;
  signal i_rx_packet_end_all    : std_logic;
  signal start_bit_mask         : std_logic;  --101817
  signal idle_line              : std_logic;

  signal NoClock_Detected       : std_logic;
  signal RX_byte_valid          : std_logic;
  signal RX_byte                : std_logic_vector(7 downto 0);
  signal RX_byte_Nibble_Swap    : std_logic_vector(7 downto 0);
  signal ClkDomain_Buf_UnderFlow: std_logic;
  signal ClkDomain_Buf_OverRun  : std_logic;
  signal ClkDomain_Buf_Full     : std_logic;
  signal ClkDomain_Buf_Empty    : std_logic;

  signal i_MII_RX_D             : std_logic_vector(3 downto 0);
  signal i_MII_RX_EN            : std_logic;
  signal ClkDomain_Buf_NotEmpty : std_logic;

  signal PacketLength_bytes     : std_logic_vector(9 downto 0);
  signal MII_RX_D_fail          : std_logic;
  signal RX_s2p                 : std_logic_vector(7 downto 0);

begin

  rx_packet_end_all <= i_rx_packet_end_all;

  manches_in_dly          <= imanches_in_dly;
  ClkDomain_Buf_NotEmpty  <= not ClkDomain_Buf_Empty;
  MII_RX_D                <= i_MII_RX_D;
  MII_RX_EN               <= i_MII_RX_EN;

  ------------------------------------------------------------------------------
  -- CLOCK ADAPTER
  -------1---------2---------3---------4---------5---------6---------7---------8
  -- Since there is no common clock distributed along the iRail, it is possible
  -- to have data errors due to these clock differences between devices.  This
  -- situation is overcome by oversampling the data by a little more the 16 times
  -- clock, or 81.25 MHz and determining when the receive data is about to slip
  -- past the sampling point.  When this occurs, the receiver is told to “skip”
  -- one of the 81.25 MHz clocks, thus realigning the data and sampling point.
  -------1---------2---------3---------4---------5---------6---------7---------8
  MANCHESTER_DECODER_ADAPTER_INST : entity work.ManchesDecoder_Adapter
    Generic Map(
      PREABLE_PATTERN         => PREABLE_PATTERN,
      RX_IDLE_LINE_CNTR_MAX   => RX_IDLE_LINE_CNTR_MAX
    )
    Port Map(
      rst                     => rst,                -- in
      clk16x                  => clk16x,             -- in
      clk1x_enable            => clk1x_enable,       -- in
      rx_packet_end_all       => i_rx_packet_end_all,-- in
      MANCHESTER_IN           => MANCHESTER_IN,      -- in
      internal_loopback       => internal_loopback,  -- in
      MANCH_OUT_P             => MANCH_OUT_P,        -- in
      manches_in_dly          => imanches_in_dly,    -- out
      sampler_clk1x_en        => sampler_clk1x_en,   -- out
      rx_center_sample        => irx_center_sample,  -- out
      idle_line               => idle_line,          -- out
      RX_s2p                  => RX_s2p,             -- out
      start_bit_mask          => start_bit_mask      -- in
    );

  ------------------------------------------------------------------------------
  -- Look for no transition in three bit times (300 ns)
  -------1---------2---------3---------4---------5---------6---------7---------8
  LINE_BIT_IDLE_DETECTOR : entity work.BitDetector
    Port Map(
      reset               => rst,
      clk16x              => clk16x,
      manches_in_dly      => manches_in_dly,
      NoClock_Detected    => NoClock_Detected
    );

  ------------------------------------------------------------------------------
  -- RECEIVE STATE MACHINE
  -------1---------2---------3---------4---------5---------6---------7---------8
  RECEIVE_STATE_MACHINE_INST : entity work.RX_SM
    Generic Map(
    START_BYTE_SYMBOL     => START_BYTE_SYMBOL
    )
    Port Map(
      reset               => rst,                      -- in
      clk16x              => clk16x,                   -- in
      manches_in_dly      => manches_in_dly,           -- in
      rx_center_sample    => irx_center_sample,        -- in
      RX_s2p              => RX_s2p,                   -- in
      NoClock_Detected    => NoClock_Detected,         -- in
      idle_line           => idle_line,                -- in
      RX_byte_valid       => RX_byte_valid,            -- out
      RX_byte             => RX_byte,                  -- out
      clk1x_enable        => clk1x_enable,             -- out
      rx_packet_end_all   => i_rx_packet_end_all,      -- out
      SFD_timeout         => SFD_timeout,              -- out
      start_bit_mask      => start_bit_mask            -- out
    );

  ----------------------------------------------------------------------
  -- CLOCK_DOMAIN_BUFFER between clk16x and MII Clock
  ----------------------------------------------------------------------
  RX_byte_Nibble_Swap  <= RX_byte(3 downto 0) & RX_byte(7 downto 4);

  CLOCK_DOMAIN_BUFFER_INST : entity work.CLOCK_DOMAIN_BUFFER
    port Map(
      DATA        => RX_byte_Nibble_Swap,     -- in
      RCLOCK      => MII_RX_CLK,              -- in
      RE          => ClkDomain_Buf_NotEmpty,  -- in
      RESET       => rst,                     -- in
      WCLOCK      => clk16x,                  -- in
      WE          => RX_byte_valid,           -- in
      DVLD        => i_MII_RX_EN,             -- out
      EMPTY       => ClkDomain_Buf_Empty,     -- out
      FULL        => ClkDomain_Buf_Full,      -- out
      OVERFLOW    => ClkDomain_Buf_OverRun,   -- out
      Q           => i_MII_RX_D,              -- out
      UNDERFLOW   => ClkDomain_Buf_UnderFlow  -- out
   );

end;

