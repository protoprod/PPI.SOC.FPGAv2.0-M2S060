
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
-- MDIO_Master entity declaration
----------------------------------------------------------------------
entity MDIO_Master is
    -- Port list
    port(
        -- Outputs
        H_MDC				: out   std_logic;
		MII_DBG_PHYn		: out   std_logic;
		Add_Error			: out   std_logic;
        -- Inouts
        H_MDIO				: inout std_logic
        );
end MDIO_Master;

----------------------------------------------------------------------
-- MDIO_Master architecture body
----------------------------------------------------------------------
architecture RTL of MDIO_Master is

   CONSTANT xhdl_timescale         : time := 1 ns;

----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------

--signal H_MDC			: std_logic;
--signal H_MDIO			: std_logic;
signal data_out 		: std_logic_vector(15 downto 0);
signal condition 		: boolean;

begin
 
-----------------------------------------------------------------------------------------
--  MDIO Logic
-----------------------------------------------------------------------------------------

PROCESS
VARIABLE xhdl_initial : BOOLEAN := TRUE;
variable line_out: line;
--
procedure mdio_write(
			delay	: in integer;
			Phyadd 	: in std_logic_vector(4 downto 0);
			RegAdd  : in std_logic_vector(4 downto 0);
			data_in	: in std_logic_vector(15 downto 0)
			) is
begin
		-- wait initial delay
		H_MDIO <= '1';
		
		-- preamble should be 32 1's
		for X in 1 to delay loop
		   wait until (H_MDC'event AND H_MDC = '0');
		   H_MDIO <= '1';
		end loop;
		
		-- SFD  0 -> 1
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '0';
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '1';
		
		-- Write Op Code  0 -> 1
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '0';
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '1';
		
		-- Phy address
		for X in 1 to 5 loop
		  wait until (H_MDC'event AND H_MDC = '0');
		  H_MDIO <= Phyadd(5-X);
		end loop;
		
		-- Register address
		for X in 1 to 5 loop
		  wait until (H_MDC'event AND H_MDC = '0');
		  H_MDIO <= RegAdd(5-X);
		end loop;
		
		-- Turn Around  1 -> 0
		
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '1';
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '0';
		
		-- data_in write data to slave
		for X in 1 to 16 loop
		  wait until (H_MDC'event AND H_MDC = '0');
		  H_MDIO <= data_in(16-X);
		end loop;
		
		-- go High Z after last bit transmitted
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= 'Z';

end procedure mdio_write;
--
--
--
procedure mdio_read(
			delay	: in integer;
			Phyadd 	: in std_logic_vector(4 downto 0);
			RegAdd  : in std_logic_vector(4 downto 0);
			data_in : in std_logic_vector(15 downto 0) ) is
	
begin
		-- wait initial delay
		H_MDIO <= '1';
		
		-- preamble should be 32 1's
		for X in 1 to delay loop
		   wait until (H_MDC'event AND H_MDC = '0');
		   H_MDIO <= '1';
		end loop;
		
		-- SFD  0 -> 1
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '0';
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '1';
		
		-- Read Op Code  1 -> 0
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '1';
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= '0';
		
		-- Phy address
		for X in 1 to 5 loop
		  wait until (H_MDC'event AND H_MDC = '0');
		  H_MDIO <= Phyadd(5-X);
		end loop;
		
		-- Register address
		for X in 1 to 5 loop
		  wait until (H_MDC'event AND H_MDC = '0');
		  H_MDIO <= RegAdd(5-X);
		end loop;
		
		-- Turn Around  1 -> 0
		wait until (H_MDC'event AND H_MDC = '0');
		H_MDIO <= 'Z';
		wait until (H_MDC'event AND H_MDC = '0');
		wait until (H_MDC'event AND H_MDC = '0');
		wait until (H_MDC'event AND H_MDC = '0');
		
		-- data_out read data from slave
		for X in 1 to 16 loop
		  wait until (H_MDC'event AND H_MDC = '1');
		  data_out(15 downto 0) <= data_out(14 downto 0) & H_MDIO;
		end loop;
		
		wait until (H_MDC'event AND H_MDC = '1');
		
		if (data_in /= data_out) then
		  report "MDIO Read compare failed" severity warning;
--		  assert condition;
		  write(line_out, now);
		  write(line_out, string'(" MDIO Compare Err: Value Read = "));
		  write(line_out, data_out);
		  write(line_out, string'("  CompareValue = "));
		  write(line_out, data_in);
		  writeline(output, line_out);
		end if;
		
--		assert condition report " Encountered MDIO W/R Compare Error" severity error;
--		assert condition REPORT "'$stop' Encountered MDIO W/R Compare Error" SEVERITY FAILURE;
	
end procedure mdio_read;

procedure mdio_wait_clks(delay:in integer) is
begin
		for X in 1 to delay loop
		   wait until (H_MDC'event AND H_MDC = '0');
		end loop;

end procedure mdio_wait_clks;


BEGIN
	
	IF (TRUE) THEN
			
			Add_Error 	 <= '1';	-- set to introduce error signal at Test Bench Level
			MII_DBG_PHYn <= '0';	-- selected Host interface for FPGA Phy MDIO Slave
			mdio_wait_clks(1);
			
--			MII_DBG_PHYn <= '1';	-- selected SoC interface for FPGA Phy MDIO Slave
			H_MDIO <= '1';
			
			mdio_wait_clks(4);		-- and check MDIO and MDC
			
			Add_Error 	 <= '0';	-- set to introduce error signal at Test Bench Level
			mdio_wait_clks(40);		-- and check MDIO and MDC
			Add_Error 	 <= '1';	-- set to introduce error signal at Test Bench Level
			mdio_wait_clks(1);		-- and check MDIO and MDC
			Add_Error 	 <= '0';	-- set to introduce error signal at Test Bench Level

	
			MII_DBG_PHYn <= '0';	-- selected Host interface for FPGA Phy MDIO Slave
			
			--		  (preamble, Phy address, Register address, data
			mdio_write(32, b"00000", b"00000", x"8000");	-- force MDIO Reset
			mdio_wait_clks(5);
			mdio_read(32, b"00000", b"00000", x"0000");	-- read MDIO control register
			mdio_wait_clks(5);
		
			-- Register1 status register is read only with default = 0x0804	(half duplex only, link up)
			mdio_read(32, b"00000", b"00001", x"0804");	-- read MDIO Status register
			mdio_wait_clks(5);
					
			Add_Error 	 <= '1';	-- set to introduce error signal at Test Bench Level
			
			-- set fault in FPGA_Top and read status register again
			mdio_read(32, b"00000", b"00001", x"0814");	-- read MDIO Status register
			mdio_wait_clks(5);
			-- make sure fault is cleared when read
			mdio_read(32, b"00000", b"00001", x"0804");	-- read MDIO Status register
			mdio_wait_clks(5);
	
			Add_Error 	 <= '0';	-- set to introduce error signal at Test Bench Level
				
			-- set Jabber Detect in FPGA_Top and read status register again
			mdio_read(32, b"00000", b"00001", x"0806");	-- read MDIO Status register
			mdio_wait_clks(5);
			-- make sure fault is cleared when read
			mdio_read(32, b"00000", b"00001", x"0804");	-- read MDIO Status register
			mdio_wait_clks(5);
						
			-- cause link down in FPGA_Top and read status register again
			mdio_read(32, b"00000", b"00001", x"0800");	-- read MDIO Status register
			mdio_wait_clks(5);
			-- make sure fault is cleared when read
			mdio_read(32, b"00000", b"00001", x"0804");	-- read MDIO Status register
			mdio_wait_clks(5);
			
			-- Register4 is r/w
			mdio_write(32, b"00000", b"00100", x"d504");
			mdio_wait_clks(5);
			mdio_read(32, b"00000", b"00100", x"d504");	-- read MDIO control register and compare
			mdio_wait_clks(5);
						
			-- Register7 is r/w
			mdio_write(32, b"00000", b"00111", x"d507");
			mdio_wait_clks(5);
			mdio_read(32, b"00000", b"00111", x"d507");	-- read MDIO control register and compare
			mdio_wait_clks(5);
			
			-- Register9 is r/w
			mdio_write(32, b"00000", b"01001", x"d509");
			mdio_wait_clks(5);
			mdio_read(32, b"00000", b"01001", x"d509");	-- read MDIO control register
			mdio_wait_clks(5);			
			mdio_read(32, b"00000", b"01001", x"d508");	-- read again and force miscompare
			mdio_wait_clks(5);
			
			-- Register11 is r/w
			mdio_write(32, b"00000", b"01011", x"d50B");
			mdio_wait_clks(5);
			mdio_read(32, b"00000", b"01011", x"d50B");	-- read MDIO control register and compare
			mdio_wait_clks(5);	
			-- Register13 is r/w
			mdio_write(32, b"00000", b"01101", x"d50D");
			mdio_wait_clks(5);
			mdio_read(32, b"00000", b"01101", x"d50D");	-- read MDIO control register and compare
			mdio_wait_clks(5);
			-- Register14 is r/w
			mdio_write(32, b"00000", b"01110", x"d50E");
			mdio_wait_clks(5);
			mdio_read(32, b"00000", b"01110", x"d50E");	-- read MDIO control register and compare
			mdio_wait_clks(5);
			
			mdio_write(32, b"00000", b"00000", x"8000");	-- force MDIO Reset
			mdio_wait_clks(5);
			mdio_read(32, b"00000", b"01001", x"0000");	-- read MDIO and make sure cleared after reset
			mdio_wait_clks(25);			
		
			
--     		ASSERT (FALSE) REPORT "'$stop' Encountered" SEVERITY FAILURE;
	ELSE
        WAIT;
    END IF;
END PROCESS;

PROCESS
VARIABLE xhdl_initial : BOOLEAN := TRUE;
BEGIN
  	IF (xhdl_initial) THEN
     		H_MDC <= '0';
     		WHILE (TRUE) LOOP
        		WAIT FOR 500 * xhdl_timescale;
        		H_MDC <= NOT H_MDC;
     		END LOOP;
     		xhdl_initial := FALSE;
  	ELSE
     	WAIT;
  	END IF;
END process;	


end RTL;