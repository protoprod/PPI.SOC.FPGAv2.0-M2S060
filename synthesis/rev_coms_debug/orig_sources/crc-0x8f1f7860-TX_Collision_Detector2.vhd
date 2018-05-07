----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     01 December 2015
-- Module Name:     TX_Collision_Detector2.vhd
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     This module detects when there is a collision while
--                  transmitting.  It does so by comparing the TX data to the
--                  RX data.
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- TX_Collision_Detector2.vhd         <=
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

entity TX_Collision_Detector2 is
  Port (
    reset                 : in  std_logic;
    bit_clk2x             : in  std_logic;
    TX_Enable             : in  std_logic;
    MANCHESTER_OUT        : in  std_logic;
    MANCHESTER_IN         : in  std_logic;
    force_collision       : in  std_logic;
    TX_collision_detect   : out std_logic   -- USE EDGE DETECTOR FOR INTERRUPT
  );
end TX_Collision_Detector2;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of TX_Collision_Detector2 is

  -- Constants
  constant CLK_CNT_FORCE_COLLISION_NUM : std_logic_vector(15 downto 0) := x"0080";

  -- Signals
  signal MANCHESTER_IN_n   : std_logic;
  signal clk_count         : std_logic_vector(15 downto 0);
  signal force_collision_d : std_logic_vector(1 downto 0);

begin

  MANCHESTER_IN_n <= not MANCHESTER_IN;
  
--------------------------------------------------------------------------------
-- sync to bit_clk2x
---------1---------2---------3---------4---------5---------6---------7---------8
  SYNC_2_BIT_CLK2X_PROC : process(bit_clk2x, reset)
  begin
    if ( rising_edge(bit_clk2x) ) then
      if(reset = '1' ) then
         force_collision_d   <= (others => '0');
      else
         force_collision_d   <= force_collision_d(0) & force_collision;
      end if;
    end if;
  end process;  

--------------------------------------------------------------------------------
-- Data Compare and Check for Collision
---------1---------2---------3---------4---------5---------6---------7---------8
  COLLISION_CHECK_PROC : process(bit_clk2x, reset)
  begin
    if ( rising_edge(bit_clk2x) ) then
      if(reset = '1' ) then
           TX_collision_detect   <= '0';
      elsif ( TX_Enable = '1' ) then
        if (     (force_collision_d(1) = '1')
             and (clk_count       = CLK_CNT_FORCE_COLLISION_NUM)
             and (MANCHESTER_OUT /= not MANCHESTER_IN_n) ) then -- NOTE inverted version
           TX_collision_detect   <= '1';      
        elsif ( MANCHESTER_OUT   /= MANCHESTER_IN_n ) then
           TX_collision_detect   <= '1';
        else
           TX_collision_detect   <= '0';
        end if;
      end if;
    end if;
  end process;

--------------------------------------------------------------------------------
-- Counts the number of bit_clk2x during each packet
---------1---------2---------3---------4---------5---------6---------7---------8
  CLOCK_COUNT_PROC : process(bit_clk2x, reset)
  begin
    if ( rising_edge(bit_clk2x) ) then
      if(reset = '1' ) then
        clk_count  <= (others => '0');
      elsif ( TX_Enable = '1' ) then
        clk_count  <= clk_count + '1';
      end if;
    end if;
  end process;

end Behavioral;
