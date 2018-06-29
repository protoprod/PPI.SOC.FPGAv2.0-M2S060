
----------------------------------------------------------------------
-- Created by SmartDesign Thu Jul 27 15:02:36 2017
-- Version: v11.8 11.8.0.26
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.std_logic_textio.all;
use ieee.numeric_std.all;
use std.textio.all;

library smartfusion2;
use smartfusion2.all;

----------------------------------------------------------------------
-- MAC Testbench entity declaration
----------------------------------------------------------------------
entity MAC_tb is
    -- Port list
    port(
		-- Inputs from FPGA Phy
		H_RXD              : in std_logic_vector(3 downto 0);
		H_RXER             : in std_logic;
		H_RXDV             : in std_logic;
		H_CRS              : in std_logic;
		H_COL              : in std_logic;
		H_RXC              : in std_logic;
		H_TXC              : in std_logic;
--		H_MDO_EN           : in std_logic;
--		H_MDO              : in std_logic;		
		-- Outputs to FPGA Phy
		H_TXD              : out std_logic_vector(3 downto 0);
		H_TXEN             : out std_logic;
		-- misc
		HOST_DETn          : out std_logic;
		MANCH_OUT_P_Del    : out std_logic;
		MANCHESTER_IN      : in  std_logic
        );
end MAC_tb;

----------------------------------------------------------------------
-- MAC_tb architecture body
----------------------------------------------------------------------
architecture RTL of MAC_tb is

   CONSTANT xhdl_timescale         : time := 1 ns;

----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------

--signal H_MDC			: std_logic;
--signal H_MDIO			: std_logic;
signal data_out 		: std_logic_vector(3 downto 0);
signal condition 		: boolean;
signal event_cntr 		: std_logic_vector(31 downto 0) := x"00000000";
signal i_MANCH_OUT_P_del: std_logic;

begin

  	i_MANCH_OUT_P_del	<= transport MANCHESTER_IN after 60ns;
	MANCH_OUT_P_del		<= (i_MANCH_OUT_P_del xor '1') when (event_cntr > 265 and event_cntr < 270) else i_MANCH_OUT_P_del;
 
-----------------------------------------------------------------------------------------
--  MAC Logic
-----------------------------------------------------------------------------------------

PROCESS
VARIABLE xhdl_initial : BOOLEAN := TRUE;
variable line_out: line;
--

procedure H_RXC_wait_clks(delay:in integer) is
begin
	for X in 1 to delay loop
	   wait until (H_RXC'event AND H_RXC = '0');
	   event_cntr	<= event_cntr + '1';
	end loop;
end procedure H_RXC_wait_clks;


BEGIN
	
	IF (TRUE) THEN
		-- Initialize
		HOST_DETn <= '0';		-- set up as capable node
		H_TXD       <= x"F";
		H_TXEN		<= '0';     
		H_RXC_wait_clks(100);
		data_out <= x"0";
		--	Preamble	
		H_TXD       <= x"5";
		H_TXEN		<= '1';     
		H_RXC_wait_clks(14);
		--	SFD	
		H_TXD       <= x"d";
		H_TXEN		<= '1';     
		H_RXC_wait_clks(1);
		
		-- Count Pattern
		H_TXD       <= x"F";
		WAIT FOR 5 * xhdl_timescale;
		for X in 1 to 10 loop
			H_TXD	<= H_TXD + '1';
			H_RXC_wait_clks(1);
		end loop;
		
		-- write some 0's 
		for X in 1 to 10 loop
			H_TXD	<= x"0";
			H_RXC_wait_clks(1);
		end loop;
		--
		H_TXD	<= x"9";
		H_RXC_wait_clks(1);
		H_TXD	<= x"A";
		H_RXC_wait_clks(1);
		H_TXD	<= x"B";
		H_RXC_wait_clks(1);
		H_TXD	<= x"C";
		H_RXC_wait_clks(1);
		H_TXD	<= x"D";
		H_RXC_wait_clks(1);
		H_TXD	<= x"E";
		H_RXC_wait_clks(1);
	ELSE
        WAIT;
    END IF;
END PROCESS;

end RTL;