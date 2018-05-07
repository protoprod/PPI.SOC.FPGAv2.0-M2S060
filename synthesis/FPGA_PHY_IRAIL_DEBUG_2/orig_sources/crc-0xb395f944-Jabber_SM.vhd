--------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     16 September 2014
-- Module Name:     Jabber_SM.vhd
-- Project Name:    Powered Rail
-- Target Devices:  TBD
-- Description:
--      The Transmit State Machine is responsible for moving data to
--      the TX AFE Interface during the appropriate transmission window.
--      In addition, it handles error conditions and interrupts to the
--      processor.  Transmit data is loaded into the Transmit FIFO by the
--      processor.  The data loaded by the processor includes the Header and
--      Data but not the CRC.  The Transmit State Machine provides control
--      to the following functions and discussed in subsequent sections.
-------------------------------------------------------------------------------
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
--           -- Jabber_SM.vhd                <=
--           -- Edge_Detect.vhd
--      -- ManchesDecoder2.vhd
--           -- RX_SM.vhd
--           -- CLOCK_DOMAIN_BUFFER.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--           -- BitDector.vhd
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

entity Jabber_SM is
  Port (
    reset                 : in  std_logic;
    bit_clk               : in  std_logic;
    TX_Enable             : in  std_logic;
    Jabber_detect         : out std_logic;
    Jabber_TX_Disable     : out std_logic
  );
end Jabber_SM;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of Jabber_SM is

  -- Constants
  constant JABBER_MAX_TIME_150MS    : std_logic_vector(23 downto 0) := x"16E360"; 
  constant JABBER_MAX_TIME_30MS     : std_logic_vector(23 downto 0) := x"0493E0";   
  constant JABBER_MAX_TIME_20MS     : std_logic_vector(23 downto 0) := x"030D40"; 
  constant JABBER_MAX_TIME_TEST     : std_logic_vector(23 downto 0) := x"000200"; 

  constant UNJABBER_MAX_TIME_250MS  : std_logic_vector(23 downto 0) := x"2625A0"; 
  constant UNJABBER_MAX_TIME_500MS  : std_logic_vector(23 downto 0) := x"4C4B40"; 
  constant UNJABBER_MAX_TIME_TEST   : std_logic_vector(23 downto 0) := x"000100"; 

  -- Signals
  signal i_Jabber_detect            : std_logic;
  signal Jabber_cntr                : std_logic_vector(23 downto 0);
  signal UnJab_timer                : std_logic_vector(23 downto 0);

  -- state machine state defintions
  type   JABBER_STATE_TYPE is ( IDLE, JABBER_TIMER_ST, UNJABBER_TIMER_ST );
  signal JABBER_STATE               : JABBER_STATE_TYPE;

---------1---------2---------3---------4---------5---------6---------7---------8
begin

  jabber_detect   <= i_Jabber_detect;

-----------------------------------------------------------------------------
-- Main state machine
---------1---------2---------3---------4---------5---------6---------7---------8
  JABBER_SM : PROCESS (bit_clk, reset)
  begin
    if ( rising_edge(bit_clk) ) then
      if ( reset = '1' ) then
        JABBER_STATE      <= IDLE;
        Jabber_cntr       <= (others => '0');
        UnJab_timer       <= (others => '0');
        i_Jabber_detect   <= '0';
        Jabber_TX_Disable <= '0';
      else
        CASE JABBER_STATE    IS

        ------------------------ IDLE ----------------------------------------
          when IDLE =>
            if ( TX_Enable = '1'  ) then
              JABBER_STATE      <= JABBER_TIMER_ST;
              Jabber_cntr       <= (others => '0');
              UnJab_timer       <= (others => '0');
              i_Jabber_detect   <= '0';
              Jabber_TX_Disable <= '0';
            else
              JABBER_STATE      <= IDLE;
              Jabber_cntr       <= (others => '0');
              UnJab_timer       <= (others => '0');
              i_Jabber_detect   <= '0';
              Jabber_TX_Disable <= '0';
            end if;

        --------------------- JABBER_TIMER_ST ----------------------------------
          when JABBER_TIMER_ST =>
            if ( TX_Enable = '0' ) then
                JABBER_STATE      <= IDLE;
                Jabber_cntr       <= (others => '0');
                UnJab_timer       <= (others => '0');
                i_Jabber_detect   <= '0';
                Jabber_TX_Disable <= '0';            
            else
              if ( Jabber_cntr = JABBER_MAX_TIME_20MS ) then
                JABBER_STATE      <= UNJABBER_TIMER_ST;
                Jabber_cntr       <= (others => '0');
                UnJab_timer       <= (others => '0');
                i_Jabber_detect   <= '1';
                Jabber_TX_Disable <= '1';
              else
                JABBER_STATE      <= JABBER_TIMER_ST;
                Jabber_cntr       <= Jabber_cntr + '1';
                UnJab_timer       <= (others => '0');
                i_Jabber_detect   <= '0';
                Jabber_TX_Disable <= '0';
              end if;
            end if;

        --------------------- UNJABBER_TIMER_ST ----------------------------------
          when UNJABBER_TIMER_ST =>
            if ( UnJab_timer = UNJABBER_MAX_TIME_250MS ) then
              JABBER_STATE        <= IDLE;
              Jabber_cntr         <= (others => '0');
              UnJab_timer         <= (others => '0');
              i_Jabber_detect     <= '0';
              Jabber_TX_Disable   <= '0';
            else                  
              JABBER_STATE        <= UNJABBER_TIMER_ST;
              Jabber_cntr         <= (others => '0');
              UnJab_timer         <= UnJab_timer + '1';
              i_Jabber_detect     <= '0';
              Jabber_TX_Disable   <= '1';
            end if;


         ----------------------- OTHERS ---------------------------------------
          when others =>
            null;
        end case;
      end if;
    end if;
  end process;

end Behavioral;