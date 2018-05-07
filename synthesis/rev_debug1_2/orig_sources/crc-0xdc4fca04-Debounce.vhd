-------------------------------------------------------------------------------
-- Filename:      Debounce.vhd
-- Description:   Debounce  -
--
-- VHDL-Standard: VHDL'93
-------------------------------------------------------------------------------
-- Structure:

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

entity Debounce is
  Port (
    reset         : in  std_logic;
    clk           : in  std_logic; 
    debounce_in   : in  std_logic;
    debounce_out  : out std_logic
  );   
end Debounce;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of Debounce is

-- Constants 
constant DEBOUNCE_CNT  : std_logic_vector(15 downto 0) := x"C350"; 

-- Signals 
signal debounce_cntr   : std_logic_vector(15 downto 0);  


---------1---------2---------3---------4---------5---------6---------7---------8
begin

--------------------------------------------------------------------------------	
-- Synch Manchester data input
---------1---------2---------3---------4---------5---------6---------7---------8 
  DEBOUNCE_PROC: process (clk, reset)
  begin
    if reset = '1' then
      debounce_cntr <= DEBOUNCE_CNT;
      debounce_out  <= '1';
    elsif (debounce_in = '0' ) then
      debounce_cntr <= (others => '0'); 
      debounce_out  <= '0';
    elsif ( rising_edge(clk) ) then 
      if ( debounce_cntr = DEBOUNCE_CNT ) then      -- 50usec
        debounce_cntr <= DEBOUNCE_CNT;
        debounce_out  <= '1';
      else 
        debounce_cntr <= debounce_cntr + '1';
        debounce_out  <= '0';      
      end if;
    end if;
  end process;

end Behavioral;