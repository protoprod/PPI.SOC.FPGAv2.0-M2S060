
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
-- Host-MAC entity declaration
----------------------------------------------------------------------
entity Host-MAC is
    -- Port list
    port(
		CLK_20MHz			: in std_logic;
        -- Outputs
        H_MDC				: out   std_logic;
		MII_DBG_PHYn		: out   std_logic;
		Add_Error			: out   std_logic;
        -- Inouts
        H_MDIO				: inout std_logic
        );
end Host-MAC;

----------------------------------------------------------------------
-- Host-MAC architecture body
----------------------------------------------------------------------
architecture RTL of Host-MAC is


----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------

signal data_out 		: std_logic_vector(15 downto 0);
signal condition 		: boolean;

begin

--------------------------------------------------------------------------------
-- Reset in processing: Can’t guarantee MDC when reset comes in so must be async
---------1---------2---------3---------4---------5---------6---------7---------8 
	process (PMAD_clk,PMAD_rst_reg)
	begin
	  if (PMAD_rst_in = '1') then		
	    PMAD_rst_reg <= '1';
      elsif (PMAD_clk'EVENT AND PMAD_clk = '1') then
		PMAD_rst_reg <= PMAD_rst_out;		--Register0(15) combine all PMAD resets here
      end if;
	end process;
	
--------------------------------------------------------------------------------
-- Remote fault is phy specific.  It is set on the fault and cleared when Status Register0 is read or phy reset
---------1---------2---------3---------4---------5---------6---------7---------8 
	process (PMAD_fault_status, PMAD_rst_reg, status_regClear_d(2))
	begin
      if (PMAD_fault_status'EVENT AND PMAD_fault_status = '1') then
    	PMAD_fault_status_d <= '1';		-- set on fault
	  elsif (PMAD_rst_reg'EVENT AND PMAD_rst_reg = '1') then
    	PMAD_fault_status_d <= '0';		-- reset on register on Phy reset
	  elsif (status_regClear_d(2)'EVENT AND status_regClear_d(2) = '1') then
    	PMAD_fault_status_d <= '0';		-- reset when status register is read
      end if;
	end process;
	

END process;	

end RTL;