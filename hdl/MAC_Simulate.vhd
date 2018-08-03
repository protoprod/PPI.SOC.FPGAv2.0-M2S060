
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
		MANCHESTER_IN      : in  std_logic;
		TX_RXn      	   : in  std_logic		-- tie high for transmitter and low for receiver
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
signal event_cntRX 		: std_logic_vector(31 downto 0) := x"00000000";
signal i_MANCH_OUT_P_del: std_logic;

signal H_RXD_c	 		: std_logic_vector(3 downto 0);

--first define the type of array.
type array_type2 is array (0 to 99) of std_logic_vector(3 downto 0); 
--array_name2 is a 100 element array of 4-bit vectors.
signal array_name2 : array_type2;   


begin

  	i_MANCH_OUT_P_del	<= transport MANCHESTER_IN after 60ns;
	MANCH_OUT_P_del		<= (i_MANCH_OUT_P_del xor '1') when (event_cntr > 265 and event_cntr < 270) else i_MANCH_OUT_P_del;
 
	--initializing a 10 element array of 4 bit elements to zero.
--	array_name2 <= (others=> (others=>'0')); 
	array_name2(0) <= x"0"; 
	array_name2(1) <= x"0"; 
	array_name2(2) <= x"0"; 
	array_name2(3) <= x"0"; 
	array_name2(4) <= x"0"; 
	array_name2(5) <= x"0"; 
	array_name2(6) <= x"0"; 
	array_name2(7) <= x"0"; 
	array_name2(8) <= x"0"; 
	array_name2(9) <= x"0"; 
	array_name2(10) <= x"5"; 
	array_name2(11) <= x"D"; 
	array_name2(12) <= b"0000"; 	
	array_name2(13) <= x"1"; 
	array_name2(14) <= x"2"; 
	array_name2(15) <= x"3"; 
	array_name2(16) <= x"4"; 
	array_name2(17) <= x"5"; 
	array_name2(18) <= x"6"; 
	array_name2(19) <= x"7"; 
	array_name2(20) <= x"8"; 
	array_name2(21) <= x"9"; 
	array_name2(22) <= x"0"; 
	array_name2(23) <= x"0"; 
	array_name2(24) <= x"0"; 
	array_name2(25) <= x"0"; 
	array_name2(26) <= x"0"; 
	array_name2(27) <= x"0"; 
	array_name2(28) <= x"0"; 
	array_name2(29) <= x"0"; 
	array_name2(30) <= x"0"; 
	array_name2(31) <= x"0"; 
	array_name2(32) <= x"9"; 
	array_name2(33) <= x"A"; 
	array_name2(34) <= x"B"; 
	array_name2(35) <= x"C"; 
	array_name2(36) <= x"D"; 
	array_name2(37) <= x"E"; 
	array_name2(38) <= x"F"; 
	array_name2(39) <= x"F"; 
	array_name2(40) <= x"0"; 
	array_name2(40) <= x"0"; 
	
 
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
		H_TXD       <= x"0";
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
		H_TXD	<= x"F";
		H_RXC_wait_clks(1);
		H_TXD	<= x"F";
		H_RXC_wait_clks(1);
	ELSE
        WAIT;
    END IF;
END PROCESS;

PROCESS (H_RXC) is
	VARIABLE FLAG : integer := 0;
	variable line_out: line;
	variable IndexCNT : integer := 10;
/*
procedure RXC_wait_clks(delay:in integer) is
begin
	for X in 1 to delay loop
	   wait until (H_RXC'event AND H_RXC = '0');
	   event_cntRX	<= event_cntRX + '1';
	end loop;
end procedure RXC_wait_clks;
*/

BEGIN

--	FLAG := to_integer(H_RXDV);
	
	IF (H_RXDV = '1' and (H_RXC'event AND H_RXC = '0')) THEN
		-- Initialize
--		RXC_wait_clks(1);
		H_RXD_c	<= H_RXD;
		
		if (H_RXD /= array_name2(IndexCNT)) then
		  report "MII Read compare failed" severity warning;
--		  assert condition;
		  write(line_out, now);
		  write(line_out, string'(" MII Compare Err: Value Read = "));
		  write(line_out, H_RXD);
		  write(line_out, string'("  CompareValue = "));
		  write(line_out, array_name2(IndexCNT));
		  write(line_out, string'("  IndexCnt = "));
		  write(line_out, IndexCNT);
		  writeline(output, line_out);
		else
		  write(line_out, string'(" PASS CompareValue = "));
		  write(line_out, array_name2(IndexCNT));
		  write(line_out, string'(" IndexCnt = "));
		  write(line_out, IndexCNT);
		  writeline(output, line_out);
		end if;
		IndexCNT := IndexCNT + 1;
		if (IndexCNT > 39) then
			IndexCNT := 10;
		end if;
	ELSE
--        WAIT;
--		IndexCNT := 0;
    END IF;
--	end loop;
END PROCESS;



end RTL;