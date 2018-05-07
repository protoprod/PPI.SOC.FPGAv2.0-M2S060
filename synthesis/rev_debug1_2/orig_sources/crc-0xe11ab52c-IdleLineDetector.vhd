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
    IDLE_LINE_CNTR_MAX  : std_logic_vector(15 downto 0) := x"0630"  -- x"0600"	--  gwc Intergap processing  = 16*8*12 = 1536 Clocks or 0x600
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
    
  signal Idle_Debug_SM  : std_logic_vector(3 downto 0);
  signal prbs_gen_reg   : std_logic_vector(15 downto 0);
  signal prbs_gen_hold  : std_logic_vector(15 downto 0);
  signal idle_line_temp : std_logic;
  signal prbs_gen_reg0  : std_logic;

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
      idle_line_temp      <= '0';
      idle_line_cntr  <= (others => '0');
    elsif ( rising_edge(clk) ) then 
	  if ( manches_in_dly(1) = manches_in_dly(0) ) then
        if (idle_line_cntr = IDLE_LINE_CNTR_MAX) then
          idle_line_temp       <= '1';
          idle_line_cntr  <= idle_line_cntr;
        else
          idle_line_temp  <= '0';
          idle_line_cntr  <= idle_line_cntr + '1';
        end if;
      else
        idle_line_temp  <= '0';
        idle_line_cntr  <=  (others => '0');
      end if;
    end if;
  end process;

--------------------------------------------------------------------------------		
-- These 2 processes implement random hold off
--
---------1---------2---------3---------4---------5---------6---------7---------8
  
  PRBS_GENERATOR: process (clk, reset)
  begin
    if (reset = '1') then
      prbs_gen_reg  <= (others => '1');		-- won't start if 0's
    elsif ( rising_edge(clk) ) then 
	  if (prbs_gen_reg = x"0000") then  -- error condition and reset to known state
	    prbs_gen_reg  <= (others => '1');	-- don't allow all zeros because it won't start up again.
      else
	    prbs_gen_reg (15 downto 0) <=  prbs_gen_reg(14 downto 0) & prbs_gen_reg0;
	  end if;
	end if;
  end process;
  
  prbs_gen_reg0 <= prbs_gen_reg(15) xor prbs_gen_reg(14) xor prbs_gen_reg(12) xor prbs_gen_reg(3);
  	
  Idle_Debug_SM_PROC :  PROCESS (clk, reset)
    begin
      if (reset = '1') then
        Idle_Debug_SM <= (others => '0');
		idle_line <= '0';
		prbs_gen_hold <= (others => '0');
	  elsif (rising_edge( clk )) then
	    case Idle_Debug_SM IS			-- in idle mode
		  when x"0" => 
			if (idle_line_temp = '1') then
			  Idle_Debug_SM <= x"1" ;
			else 
			  idle_line <= '0';
			  Idle_Debug_SM <= x"0" ;
			end if;
		  when x"1" => 		-- sample prbs generator
			prbs_gen_hold(15 downto 10) <= (others => '0');
			prbs_gen_hold(9 downto 0) <= prbs_gen_reg(9 downto 0);
			Idle_Debug_SM <= x"2" ;
		  when x"2" => 
		    if (prbs_gen_hold = x"0000") then 
			  Idle_Debug_SM <= x"3" ;
			else 
		      prbs_gen_hold <= prbs_gen_hold - 1;
			  Idle_Debug_SM <= x"2" ;
			end if ;
		  when x"3" => 
		    if(idle_line_temp = '1') then	-- make sure didn't go idle during prbs count down
			  idle_line <= '1';
			  Idle_Debug_SM <= x"4" ;
			else	
			  Idle_Debug_SM <= x"0" ;
			  idle_line <= '0';
			end if;
  		  when x"4" =>  
		    if(idle_line_temp = '1') then
			  idle_line <= '1';
			  Idle_Debug_SM <= x"4" ;
			else	
			  Idle_Debug_SM <= x"0" ;
			  idle_line <= '0';
			end if;
		  when others =>
		    null;
		end case;			
	  end if; 
    end process;  	
	
  
end Behavioral;