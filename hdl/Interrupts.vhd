----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     17 August 2014
-- Design Name:     Powered Rail Performance Tester
-- Module Name:     Interrupts.vhd - Behavioral
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     The Interrupt into the MSS is level sensitive, active high.
--                  Interrupts are cleared by writing a logi 1 to the bit to be
--                  cleared.
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd               <=
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd
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
-- Revision:  0.1
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

entity Interrupts is
  Port (
    rst                    : in  std_logic;
    clk16x                 : in  std_logic;
    APB3_RESET             : in  std_logic;
    APB3_CLK               : in  std_logic;
    APB3_ADDR              : in  std_logic_vector(7 downto 0);
    APB3_WDATA             : in  std_logic_vector(7 downto 0);
    write_reg_en           : in  std_logic;
    collision_detect       : in  std_logic;
    Jabber_detect          : in  std_logic;
    SFD_timeout            : in  std_logic;
    MII_RX_D_fail          : in  std_logic;
    int_mask_reg           : in  std_logic_vector(7 downto 0);
    int_reg                : out std_logic_vector(7 downto 0);
    INT                    : out std_logic;
    rx_packet_end_all      : in  std_logic
  );
end Interrupts;

architecture Behavioral of Interrupts is

-- constants
  constant INTR_REG_C              : std_logic_vector(7 downto 0) := "00010100";

-- signals
  signal int_reg_clr               : std_logic;
  signal iINT                      : std_logic;
  signal iint_reg                  : std_logic_vector(7 downto 0);
  signal rx_packet_end_all_int     : std_logic;
  signal rx_packet_end_all_clr     : std_logic;
  signal col_detect_int            : std_logic;
  signal col_detect_int_clr        : std_logic;
  signal Jabber_detect_int         : std_logic;
  signal Jabber_detect_int_clr     : std_logic;
  signal SFD_timeout_int           : std_logic;
  signal SFD_timeout_int_clr       : std_logic;
  signal MII_RX_D_fail_int         : std_logic;
  signal MII_RX_D_fail_int_clr     : std_logic;

begin

  INT      <=  '0';--iINT;
  int_reg  <=  iint_reg;

--------------------------------------------------------------------------------
-- Generate qualifying signal for write of interrupt register.
---------1---------2---------3---------4---------5---------6---------7---------8
  REGISTER_CLEAR_INST : process (APB3_RESET, APB3_CLK)
    begin
      if ( APB3_RESET = '1' ) then
        int_reg_clr  <= '0';
      elsif (rising_edge (APB3_CLK)) then
        if (write_reg_en = '1' and (INTR_REG_C = APB3_ADDR)) then
          int_reg_clr  <= '1';
        else
          int_reg_clr  <= '0';
        end if;
      end if;
    end process;

  ------------------------------------------------------------------------------
  -- Sync "collision_detect" from clk16x domain to APB3_CLK domain.
  -- Detects rising edge of "collision_detect" and syncs to APB3_CLK.
  -- Cleared synchonously to APB3_CLK.
  ------------------------------------------------------------------------------
  COLLISION_DETECT_INT_SYNC : entity work.Edge_Detect
    Port Map(
      reset      => rst,
      clk        => APB3_CLK,
      clk_en     => '1',
      sig_edge   => collision_detect,
      sig_clr    => col_detect_int_clr,
      sig_out    => col_detect_int
    );

    col_detect_int_clr <= int_reg_clr and APB3_WDATA(0);

  ------------------------------------------------------------------------------
  -- Sync "Jabber_detect" from clk16x domain to APB3_CLK domain.
  -- Detects rising edge of "Jabber_detect" and syncs to APB3_CLK.
  -- Cleared synchonously to APB3_CLK.
  ------------------------------------------------------------------------------
  JABBER_DETECT_INT_SYNC : entity work.Edge_Detect
    Port Map(
      reset      => rst,
      clk        => APB3_CLK,
      clk_en     => '1',
      sig_edge   => Jabber_detect,
      sig_clr    => Jabber_detect_int_clr,
      sig_out    => Jabber_detect_int
    );

    Jabber_detect_int_clr <= int_reg_clr and APB3_WDATA(1);

  ------------------------------------------------------------------------------
  -- Sync "SFD_timeout" from clk16x domain to APB3_CLK domain.
  -- Detects rising edge of "SFD_timeout" and syncs to APB3_CLK.
  -- Cleared synchonously to APB3_CLK.
  ------------------------------------------------------------------------------
  SFD_TIMEOUT_INT_SYNC : entity work.Edge_Detect
    Port Map(
      reset      => rst,
      clk        => APB3_CLK,
      clk_en     => '1',
      sig_edge   => SFD_timeout,
      sig_clr    => SFD_timeout_int_clr,
      sig_out    => SFD_timeout_int
    );

    SFD_timeout_int_clr <= int_reg_clr and APB3_WDATA(2);

  ------------------------------------------------------------------------------
  -- Sync "MII_RX_D_fail" from clk16x domain to APB3_CLK domain.
  -- Detects rising edge of "MII_RX_D_fail" and syncs to APB3_CLK.
  -- Cleared synchonously to APB3_CLK.
  ------------------------------------------------------------------------------
  MII_RX_DATA_FAIL_INT_SYNC : entity work.Edge_Detect
    Port Map(
      reset      => rst,
      clk        => APB3_CLK,
      clk_en     => '1',
      sig_edge   => MII_RX_D_fail,
      sig_clr    => MII_RX_D_fail_int_clr,
      sig_out    => MII_RX_D_fail_int
    );

    MII_RX_D_fail_int_clr <= int_reg_clr and APB3_WDATA(3);

  ------------------------------------------------------------------------------
  -- Sync "rx_packet_end_all" from clk16x domain to APB3_CLK domain.
  -- Detects rising edge of "rx_packet_end_all" and syncs to APB3_CLK.
  ------------------------------------------------------------------------------
  RX_PACKET_END_ALL_NEW_SYNC : entity work.Edge_Detect
    Port Map(
      reset      => rst,
      clk        => APB3_CLK,
      clk_en     => '1',
      sig_edge   => rx_packet_end_all,
      sig_clr    => rx_packet_end_all_clr,
      sig_out    => rx_packet_end_all_int
    );

    rx_packet_end_all_clr <= int_reg_clr and APB3_WDATA(6);

--------------------------------------------------------------------------------
-- Clock these 2 interrupt signals so not combinational into the APB
--
---------1---------2---------3---------4---------5---------6---------7---------8
  SYNC_INTERRUPTS_TO_APB_DOMAIN : process (APB3_RESET, rst, APB3_CLK)
    begin
      if (APB3_RESET = '1' or rst = '1') then
        iINT      <= '0';
        iint_reg  <= (others => '0');
      elsif (rising_edge ( APB3_CLK )) then
        iINT      <= ( rx_packet_end_all_int   and not int_mask_reg(6) )
                       or ( MII_RX_D_fail_int  and not int_mask_reg(3) )
                       or ( SFD_timeout_int    and not int_mask_reg(2) )
                       or ( Jabber_detect_int  and not int_mask_reg(1) )
                       or ( col_detect_int     and not int_mask_reg(0) );
        iint_reg  <=   '0'
                     & ( rx_packet_end_all_int and not int_mask_reg(6) )
                     & '0'
                     & '0'
                     & ( MII_RX_D_fail_int     and not int_mask_reg(3) )
                     & ( SFD_timeout_int       and not int_mask_reg(2) )
                     & ( Jabber_detect_int     and not int_mask_reg(1) )
                     & ( col_detect_int        and not int_mask_reg(0) );
      end if;
  end process;

end Behavioral;