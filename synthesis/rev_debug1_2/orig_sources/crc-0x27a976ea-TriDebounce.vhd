-------------------------------------------------------------------------------
-- Filename:      TriDebounce.vhd
-- Description:   TriDebounce  -
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

entity TriDebounce is
  Port (
    reset           : in  std_logic;
    clk             : in  std_logic; 
    debounce_in     : in  std_logic_vector(2 downto 0);
    debounce_out    : out std_logic_vector(2 downto 0)
  );   
end TriDebounce;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of TriDebounce is

-- Constants 

-- Signals 


---------1---------2---------3---------4---------5---------6---------7---------8
begin

--------------------------------------------------------------------------------	
-- Debounce #0
---------1---------2---------3---------4---------5---------6---------7---------8 
DEBOUNCE_0_INST : entity work.Debounce
  Port Map(
    reset        => reset,
    clk          => clk, 
    debounce_in  => debounce_in(0),
    debounce_out => debounce_out(0)
  ); 

--------------------------------------------------------------------------------	
-- Debounce #1
---------1---------2---------3---------4---------5---------6---------7---------8 
DEBOUNCE_1_INST : entity work.Debounce
  Port Map(
    reset        => reset,
    clk          => clk, 
    debounce_in  => debounce_in(1),
    debounce_out => debounce_out(1)
  ); 

--------------------------------------------------------------------------------	
-- Debounce #2
---------1---------2---------3---------4---------5---------6---------7---------8 
DEBOUNCE_2_INST : entity work.Debounce
  Port Map(
    reset        => reset,
    clk          => clk, 
    debounce_in  => debounce_in(2),
    debounce_out => debounce_out(2)
  ); 

end Behavioral;