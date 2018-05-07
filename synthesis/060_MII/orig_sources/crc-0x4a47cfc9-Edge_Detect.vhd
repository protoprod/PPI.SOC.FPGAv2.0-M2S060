----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     01 December 2015
-- Module Name:     Edge_Detect.vhd
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     This module detects a rising edge
--  reset    = input.  Asynchronous reset.
--  clk      = input.  Clock domain of generated output signals.
--  clk_en   = input.  When high, enables the clock to be registered.
--  sig_edge = input.  Signal to detect the edge.
--                     NOTE:  SIGNAL MUST BE SYCNRONIZED TO ITS SOURCE CLOCK
--                            TO AVOID GLITCHES AND FALSE EDGE DETECTION.
--  sig_clr  = input.  Asynchronous clear of edge detect signal latch.
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- TX_Collision_Detector2.vhd
--      -- IdleLineDetector.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--              -- Edge_Detect.vhd              <=
--      -- ManchesterEncoder2.vhd
--           -- Nib2Ser_SM.vhd
--           -- Jabber_SM.vhd
--           -- Edge_Detect.vhd                 <=
--      -- ManchesDecoder2.vhd
--           -- RX_SM.vhd
--           -- CLOCK_DOMAIN_BUFFER.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--           -- BitDector.vhd
--
-- Revision:  0.1
--
----------------------------------------------------------------------------------

---------1---------2---------3---------4---------5---------6---------7---------8

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Edge_Detect is
  Port (
    reset      : in  std_logic;
    clk        : in  std_logic;
    clk_en     : in  std_logic;
    sig_edge   : in  std_logic;
    sig_clr    : in  std_logic;
    sig_out    : out std_logic
  );
end Edge_Detect;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of Edge_Detect is

-- Constants

-- Signals
  signal sig_edge_detect : std_logic;
  signal sig_out_d       : std_logic_vector(7 downto 0);
  signal sig_clr_sync    : std_logic_vector(3 downto 0);

---------1---------2---------3---------4---------5---------6---------7---------8
begin

  sig_out <= sig_out_d(3);

-------------------------------------------------------------------------------
-- Detect Edge
---------1---------2---------3---------4---------5---------6---------7---------8
  DETECT_EDGE_PROC: PROCESS (sig_edge, reset, sig_clr_sync)
  begin
    if (reset = '1' or sig_clr_sync(1) = '1') then
      sig_edge_detect <= '0';
    elsif (rising_edge( sig_edge ) ) then
      sig_edge_detect <= '1';
    end if;
  end process;

-------------------------------------------------------------------------------
-- Synchronizer to domain "clk"
---------1---------2---------3---------4---------5---------6---------7---------8
  SYNCH_PROC: PROCESS (clk, reset)
  begin
    if (reset = '1') then
      sig_out_d     <= (others => '0');
      sig_clr_sync  <= (others => '0');
    elsif (rising_edge( clk ) and clk_en = '1' ) then
      sig_out_d     <= sig_out_d(6 downto 0) & sig_edge_detect;
      sig_clr_sync  <= sig_clr_sync(2 downto 0) & sig_clr;
    else
      sig_out_d     <= sig_out_d;
      sig_clr_sync  <= sig_clr_sync;
    end if;
  end process;

end Behavioral;
