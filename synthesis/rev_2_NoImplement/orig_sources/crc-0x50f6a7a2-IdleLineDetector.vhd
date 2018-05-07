----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     01 December 2015
-- Module Name:     IdleLineDetector.vhd 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     This module detects when the iRial line is idle.
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd
--                -- IdleLineDetector.vhd         <=
--           -- CRC16_Generator.vhd
--      -- FIFOs.vhd
--           -- FIFO_1Kx8.vhd
--      -- ManchesDecoder.vhd 
--           -- AFE_RX_SM.vhd
--           -- ReadFIFO_Write_SM.vhd
--                -- CRC16_Generator.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd         <=
--   
-- Revision:  0.1
--
----------------------------------------------------------------------------------

---------1---------2---------3---------4---------5---------6---------7---------8

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IdleLineDetector is 
  Generic (
    IDLE_LINE_CNTR_MAX  : std_logic_vector(15 downto 0) := x"0600"	--  gwc Intergap processing  = 16*8*12 = 1536 Clocks or 0x600
  );
  Port (
    reset               : in  std_logic;
    clk                 : in  std_logic; 
    manches_in_dly      : in  std_logic_vector(1 downto 0);
    idle_line           : out std_logic;
	TX_Enable           : in std_logic		-- gwc
  );   
end IdleLineDetector;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of IdleLineDetector is

-- Constants 

-- Signals 
  signal idle_line_cntr       : std_logic_vector(15 downto 0);

---------1---------2---------3---------4---------5---------6---------7---------8
begin

--------------------------------------------------------------------------------		
-- Idle Line Detector - If 4 bits (@ bit rate) show no manchester transitions,
-- Then declare line is idle.  
-- The 16x clock is used to oversample the incoming manchester data.  If there
-- are no transitions for 64 clocks, declare line idle.
---------1---------2---------3---------4---------5---------6---------7---------8
  IDLE_LINE_DETECT_PROC: process (clk, reset)
  begin
    if reset = '1' then
      idle_line       <= '0';
      idle_line_cntr  <= (others => '0');
    elsif ( rising_edge(clk) ) then 
	  if ( manches_in_dly(1) = manches_in_dly(0) ) then
        if (idle_line_cntr = IDLE_LINE_CNTR_MAX ) then
          idle_line       <= '1';
          idle_line_cntr  <= idle_line_cntr;
        else
          idle_line       <= '0';
          idle_line_cntr  <= idle_line_cntr + '1';
        end if;
      else
        idle_line       <= '0';
        idle_line_cntr  <=  (others => '0');
     end if;
    end if;
  end process;

end Behavioral;