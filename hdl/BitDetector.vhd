----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     01 December 2015
-- Module Name:     BitDetector.vhd 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     This module detects when the iRial line is idle.
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
--      -- ManchesDecoder2.vhd
--           -- RX_SM.vhd
--           -- CLOCK_DOMAIN_BUFFER.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--           -- BitDector.vhd                  <=
--
-- Revision:  0.1
--
----------------------------------------------------------------------------------

---------1---------2---------3---------4---------5---------6---------7---------8

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BitDetector is 
  Port (
    reset               : in  std_logic;
    clk16x              : in  std_logic; 
    manches_in_dly      : in  std_logic_vector(1 downto 0);
    NoClock_Detected    : out std_logic
  );   
end BitDetector;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of BitDetector is

  -- Constants 
  constant NO_CLOCK_DETECT_MAX : std_logic_vector(15 downto 0) := x"0030";
                                                      -- x"0030" = 3 iRail Bit times (300 ns)
  
  -- Signals 
  signal bit_detect_timer      : std_logic_vector(15 downto 0);
    

---------1---------2---------3---------4---------5---------6---------7---------8
begin

--------------------------------------------------------------------------------		
-- Idle Line Detector - If 4 bits (@ bit rate) show no manchester transitions,
-- Then declare line is idle.  
-- The 16x clock is used to oversample the incoming manchester data.  If there
-- are no transitions for 64 clocks, declare line idle.
---------1---------2---------3---------4---------5---------6---------7---------8
  NO_CLK_DETECT_PROC: process (clk16x, reset)
  begin
    if reset = '1' then
      NoClock_Detected      <= '0';
      bit_detect_timer      <= (others => '0');
    elsif ( rising_edge(clk16x) ) then 
	  if ( manches_in_dly(1) = manches_in_dly(0) ) then
        if (bit_detect_timer = NO_CLOCK_DETECT_MAX) then
          NoClock_Detected  <= '1';
          bit_detect_timer  <= bit_detect_timer;
        else
          NoClock_Detected  <= '0';
          bit_detect_timer  <= bit_detect_timer + '1';
        end if;
      else
        NoClock_Detected    <= '0';
        bit_detect_timer    <= (others => '0');
      end if;
    end if;
  end process;
  
end Behavioral;