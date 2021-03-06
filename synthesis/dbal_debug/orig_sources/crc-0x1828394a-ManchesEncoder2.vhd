----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     17 August 2014
-- Design Name:     Powered Rail Performance Tester
-- Module Name:     ManchesEncoder2.vhd - Behavioral
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:
--     The Encoder is responsible for accepting packets from the processor
--     and transmitting them on to the iRail. The Encoder
--     provides Timing Generation, Parallel to Serial Conversion,
--     and Manchester Encoding.
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

entity ManchesEncoder2 is
  Port (
    reset                 : in  std_logic;
	  bit_clk2x             : in  std_logic;
	  bit_clk               : in  std_logic;
	  MII_TX_CLK            : in  std_logic;
	  MII_TX_EN             : in  std_logic;
	  MII_TX_D              : in  std_logic_vector(3 downto 0);
	  MII_COL               : out std_logic;
	  MII_ERROR             : out std_logic;
	  idle_line             : in  std_logic;
	  TX_Enable             : out std_logic;
	  collision_detect      : in  std_logic;
	  Jabber_detect         : out std_logic;
      MANCHESTER_OUT        : out std_logic;
	  TX_State_IDLE			: out std_logic;
	  reset_all_pkt_cntrs	: in std_logic
  );
end ManchesEncoder2;

architecture Behavioral of ManchesEncoder2 is

  -- constants
  constant JABBER_MAX_TIME_150MS  : std_logic_vector(23 downto 0) := x"16E360"; 
  constant JABBER_MAX_TIME_30MS   : std_logic_vector(23 downto 0) := x"0493E0";   
  constant JABBER_MAX_TIME_20MS   : std_logic_vector(23 downto 0) := x"030D40"; 
  constant JABBER_MAX_TIME_TEST   : std_logic_vector(23 downto 0) := x"001800"; 

  -- signals
  signal p2s_data                 : std_logic_vector(3 downto 0);
  signal mii_tx_d_d1              : std_logic_vector(3 downto 0);
  signal mii_tx_en_d1             : std_logic;
  signal i_TX_Enable              : std_logic;
  signal i_Jabber_detect          : std_logic;
  signal collision_detect_s       : std_logic; 
  signal Jabber_TX_Disable        : std_logic; 

  signal col_detect_2MII          : std_logic;
  signal col_detect_2MII_clr      : std_logic;
  signal col_detect_2MII_clr_d    : std_logic_vector(7 downto 0);

  signal Jabber_detect_2MII       : std_logic;
  signal Jabber_detect_2MII_clr   : std_logic;
  signal Jabber_detect_2MII_clr_d : std_logic_vector(7 downto 0);
  
  
begin

  TX_Enable         <= i_TX_Enable;
  Jabber_detect     <= i_Jabber_detect;
  MII_COL           <= col_detect_2MII;
  MII_ERROR         <= col_detect_2MII or Jabber_detect_2MII;
  
  ------------------------------------------------------------------------------
  -- Delay Process
  -------1---------2---------3---------4---------5---------6---------7---------8
  DELAY_PROC : process(bit_clk, reset)
  begin
    if (rising_edge(bit_clk) ) then
      if(reset = '1') then
        mii_tx_d_d1     <= (others => '0');
        mii_tx_en_d1    <= '0';
      else
        mii_tx_d_d1     <= MII_TX_D;
        mii_tx_en_d1    <= MII_TX_EN;
      end if;
    end if;
  end process;

  ------------------------------------------------------------------------------
  -- Sync "collision_detect" from clk16x domain to bit_clk domain.
  -- Detects rising edge of "collision_detect" and syncs to bit_clk.
  -- Cleared synchonously to bit_clk.
  ------------------------------------------------------------------------------
  COLLISION_DETECT_INT_SYNC : entity work.Edge_Detect
    Port Map(
      reset      => reset,
      clk        => bit_clk,
      clk_en     => '1',
      sig_edge   => collision_detect,
      sig_clr    => idle_line,
      sig_out    => collision_detect_s
    );

  ------------------------------------------------------------------------------
  -- MII Transmit State Machine
  -------1---------2---------3---------4---------5---------6---------7---------8
  NIBBLE_TO_SERIAL_SM_INST : entity work.Nib2Ser_SM
    Port Map(
      reset                 => RESET,
      bit_clk               => bit_clk,
      idle_line             => idle_line,
      mii_tx_d_d1           => mii_tx_d_d1,
      mii_tx_en_d1          => mii_tx_en_d1,
      collision_detect_s    => '0',-- 2-21-18 collision_detect_s,
      Jabber_TX_Disable     => Jabber_TX_Disable,
      TX_Enable             => i_TX_Enable,
      p2s_data              => p2s_data,
	  TX_State_IDLE			=> TX_State_IDLE,
	  reset_all_pkt_cntrs	=> reset_all_pkt_cntrs
    );

  ------------------------------------------------------------------------------
  -- Clock Manchester Encoded data with 2x the bit clock to avoid glitches.
  -------1---------2---------3---------4---------5---------6---------7---------8
  MAN_OUT_DATA_PROC : process(bit_clk2x, reset)
  begin
    if ( rising_edge( bit_clk2x ) ) then
      if(reset = '1') then
        MANCHESTER_OUT <= '0';
      else
        if ( i_TX_Enable = '1' and Jabber_TX_Disable = '0' ) then
          MANCHESTER_OUT <= bit_clk xor p2s_data(3);
        else
          MANCHESTER_OUT <= '0';
        end if;
      end if;
    end if;
  end process;

  ------------------------------------------------------------------------------
  -- Jabber Detection
  -------1---------2---------3---------4---------5---------6---------7---------8
  JABBER_DETECT_inst : entity work.Jabber_SM
    Port Map(
      reset                 => reset,
      bit_clk               => bit_clk,  
      TX_Enable             => i_TX_Enable,
      Jabber_detect         => i_Jabber_detect,
      Jabber_TX_Disable     => Jabber_TX_Disable
    );

  ------------------------------------------------------------------------------
  -- It is not required to Sync "collision_detect" to 
  -- MII_RX_CLK domain per IEEE specification Section 2.
  -- Detects rising edge of "collision_detect" and "elongates" the signal
  -- Cleared synchonously to col_detect_2MII_clr.
  ------------------------------------------------------------------------------
  -- MII Clock Domain
  ------------------------------------------------------------------------------
  COLLISION_DETECT_MII_GEN : entity work.Edge_Detect
    Port Map(
      reset      => RESET,                  -- in 
      clk        => MII_TX_CLK,             -- in 
      clk_en     => '1',                    -- in 
      sig_edge   => collision_detect,       -- in 
      sig_clr    => col_detect_2MII_clr,    -- in 
      sig_out    => col_detect_2MII         -- out
    );                                   

  -------------------------------------------------------------
  -- Generate Collision Detect Clear
  -------------------------------------------------------------
  COLLISION_DETECT_CLEAR_GEN : process(MII_TX_CLK, RESET)
  begin
    if (RESET = '1') then
        col_detect_2MII_clr_d <= (others => '0');
    else
      if (rising_edge(MII_TX_CLK)) then
        col_detect_2MII_clr_d <= col_detect_2MII_clr_d(6 downto 0) & col_detect_2MII;
      end if;
    end if;
  end process; 
  
  col_detect_2MII_clr <= col_detect_2MII_clr_d(1);
  
  ------------------------------------------------------------------------------
  -- It is not required to Sync "Jabber_detect" to 
  -- MII_RX_CLK domain per IEEE specification Section 2.
  -- Detects rising edge of "Jabber_detect" and "elongates" the signal
  -- Cleared synchonously to Jabber_detect_2MII_clr.
  ------------------------------------------------------------------------------
  -- MII Clock Domain
  ------------------------------------------------------------------------------
  JABBER_DETECT_MII_GEN : entity work.Edge_Detect
    Port Map(
      reset      => RESET,                  -- in 
      clk        => MII_TX_CLK,             -- in 
      clk_en     => '1',                    -- in 
      sig_edge   => Jabber_detect,          -- in 
      sig_clr    => Jabber_detect_2MII_clr, -- in 
      sig_out    => Jabber_detect_2MII      -- out
    );                                   

  -------------------------------------------------------------
  -- Generate Jabber Detect Clear
  -------------------------------------------------------------
  JABBER_DETECT_CLEAR_GEN : process(MII_TX_CLK, RESET)
  begin
    if (RESET = '1') then
        Jabber_detect_2MII_clr_d <= (others => '0');
    else
      if (rising_edge(MII_TX_CLK)) then
        Jabber_detect_2MII_clr_d <= Jabber_detect_2MII_clr_d(6 downto 0) & Jabber_detect_2MII;
      end if;
    end if;
  end process; 
  
  Jabber_detect_2MII_clr <= Jabber_detect_2MII_clr_d(1);

end Behavioral;
