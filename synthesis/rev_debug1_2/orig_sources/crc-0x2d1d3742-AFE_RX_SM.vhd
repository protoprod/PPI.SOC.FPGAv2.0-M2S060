-------------------------------------------------------------------------------
-- Filename:      AFE_RX_SM.vhd
-- Description:   AFE_RX_SM  -
--
-- VHDL-Standard: VHDL'93
-------------------------------------------------------------------------------
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd
--           -- CRC16_Generator.vhd
--      -- FIFOs.vhd
--           -- FIFO_1Kx8.vhd
--      -- ManchesDecoder.vhd 
--           -- AFE_RX_SM.vhd                 <=
--                -- rx_end_mask_SM.vhd
--           -- ReadFIFO_Write_SM.vhd
--           -- CRC16_Generator.vhd
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

entity AFE_RX_SM is
  Generic (
    START_BYTE_SYMBOL       : std_logic_vector(7 downto 0) := x"D5"	--gwc x"81"
  );
  Port (
    -- System Interface
    reset               : in  std_logic;
    clk                 : in  std_logic; 
    -- 
    RX_FIFO_DIN         : in  std_logic_vector(7 downto 0);
    RX_FIFO_Empty       : in  std_logic; 
    manches_in_dly      : in  std_logic_vector(1 downto 0);
    sample              : in  std_logic;   
    idle_line           : in  std_logic; 
    rx_packet_end       : in  std_logic;
    clk1x_enable        : out std_logic;
	  packet_avail        : out std_logic;
	  rx_packet_avail     : out std_logic;
	  rx_packet_end_all   : out std_logic;
	  RX_EarlyTerm        : in  std_logic
  );   
end AFE_RX_SM;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of AFE_RX_SM is

-- Constants 
  constant START_BIT_MASK_NUM : std_logic_vector(7 downto 0) := "00011000";  -- gwc "0011"; need more delay for single bit error

   
-- Signals 
  signal RX_FIFO_Empty_s     : std_logic; 
  signal RX_EarlyTerm_s      : std_logic;
  signal irx_packet_end_all  : std_logic;
  signal start_bit_cntr      : std_logic_vector(7 downto 0);	-- gwc single bit error on first bit will show D5; delay
  signal start_bit_mask      : std_logic; 
--  signal rx_end_holdoff      : std_logic;
  
-- state machine state defintions
type   AFE_RX_STATE_TYPE is (
              IDLE, CARRIER_DETECT_ST, START_BIT_ST, PACKET_IN_ST, DELAY_FOR_IDLE,
              EARLY_TERM
                );
signal AFE_RX_STATE         : AFE_RX_STATE_TYPE; 
    
---------1---------2---------3---------4---------5---------6---------7---------8
begin

  rx_packet_end_all <= irx_packet_end_all;
  
--  rx_end_holdoff    <= '0';
  
-------------------------------------------------------------------------------
  -- Synchronizer
---------1---------2---------3---------4---------5---------6---------7---------8
  SYNCHRONIZATION_PROC: PROCESS (clk, reset)
  begin
    if (rising_edge( clk ) ) then
      if ( reset = '1' ) then
        RX_FIFO_Empty_s    <= '0';
        RX_EarlyTerm_s     <= '0';
      else
        RX_FIFO_Empty_s    <= RX_FIFO_Empty;
        RX_EarlyTerm_s     <= RX_EarlyTerm;
      end if;
    end if;  
  end process;
  

-------------------------------------------------------------------------------
  -- Start Bit Counter
  -- This logic is used to mask out aberations on the AFE circuit/rail.  It
  -- maskes looking for a start bit before the "START_BIT_MASK_NUM" of incoming
  -- bits.  This is intended as a temporary work-a-round.
---------1---------2---------3---------4---------5---------6---------7---------8
  START_BIT_COUNTER_PROC: PROCESS (clk, reset, irx_packet_end_all)
  begin
    if (rising_edge( clk ) ) then			-- gwc this only works for the 1st packet.  Need a reset
      if ( reset = '1' or irx_packet_end_all= '1' or AFE_RX_STATE = IDLE ) then
        start_bit_cntr <= (others => '0');
        start_bit_mask <= '1';
      elsif ( sample = '1' and start_bit_cntr /= START_BIT_MASK_NUM) then
        start_bit_cntr <= start_bit_cntr + '1';
        start_bit_mask <= '1';
      elsif ( sample = '1' and start_bit_cntr = START_BIT_MASK_NUM) then
        start_bit_cntr <= start_bit_cntr;
        start_bit_mask <= '0';
      else
        start_bit_cntr <= start_bit_cntr;
        start_bit_mask <= start_bit_mask;
      end if;
    end if; 
  end process;

--------------------------------------------------------------------------------
-- This state machine holds off any reception for a period of "RX_END_MASK_NUM"
-- (initial set to 15us).  This is due to the fact that the AFE circuitry
-- is creating oscillations at the end of reception.  This is intended to be a
-- temporary patch.
---------1---------2---------3---------4---------5---------6---------7---------8  
--  RX_END_MASK_PROC: entity work.rx_end_mask_SM
--    Port Map(
--      reset               => reset,
--      clk16x              => clk, 
--      rx_packet_end       => rx_packet_end,
--      RX_EarlyTerm        => RX_EarlyTerm,
----      rx_end_holdoff      => rx_end_holdoff
--      rx_end_holdoff      => open
--    );  
   
--------------------------------------------------------------------------------
-- Main state machine
---------1---------2---------3---------4---------5---------6---------7---------8
  AFE_RX_SM : PROCESS (clk, reset)
  begin 
      if ( reset = '1' ) then
        AFE_RX_STATE        <= IDLE;
        clk1x_enable        <= '0'; 
        packet_avail        <= '0';
        rx_packet_avail     <= '0';
        irx_packet_end_all  <= '0';
      elsif ( rising_edge( clk ) ) then 
        CASE AFE_RX_STATE    IS

        ------------------------ IDLE ----------------------------------------
          when IDLE =>
            if ( manches_in_dly(0) = '1' and manches_in_dly(1) = '0') then
--                and rx_end_holdoff = '0' ) then
              AFE_RX_STATE        <= CARRIER_DETECT_ST;
              clk1x_enable        <= '1'; 
              packet_avail        <= '0';
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '0';
            else                      
              AFE_RX_STATE        <= IDLE;
              clk1x_enable        <= '0'; 
              packet_avail        <= '0'; 
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '0';
            end if;

        --------------------- CARRIER_DETECT_ST --------------------------------------
          when CARRIER_DETECT_ST =>
            if ( idle_line = '1' ) then
              AFE_RX_STATE        <= IDLE;
              clk1x_enable        <= '0'; 
              packet_avail        <= '0';
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '1';
            else                     
              AFE_RX_STATE        <= START_BIT_ST;
              clk1x_enable        <= '1'; 
              packet_avail        <= '0';
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '0';
            end if;

        --------------------- START_BIT_ST --------------------------------------
          when START_BIT_ST => 
            if ( idle_line = '1' ) then
              AFE_RX_STATE        <= IDLE;
              clk1x_enable        <= '0'; 
              packet_avail        <= '0';
              rx_packet_avail     <= '1';
              irx_packet_end_all  <= '1';
            elsif ( RX_FIFO_DIN = START_BYTE_SYMBOL and start_bit_mask = '0') then
              AFE_RX_STATE        <= PACKET_IN_ST; 
              clk1x_enable        <= '1'; 
              packet_avail        <= '1';
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '0';
            else
              AFE_RX_STATE        <= START_BIT_ST;  
              clk1x_enable        <= '1'; 
              packet_avail        <= '0';
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '0';
            end if;

        --------------------- PACKET_IN_ST --------------------------------------
          when PACKET_IN_ST =>
            if ( idle_line = '1' ) then
              AFE_RX_STATE        <= IDLE;
              clk1x_enable        <= '1'; 
              packet_avail        <= '0';	-- 090217
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '0';
            elsif ( RX_EarlyTerm_s = '1' ) then
              AFE_RX_STATE        <= EARLY_TERM;
              clk1x_enable        <= '1';
              packet_avail        <= '0';
              rx_packet_avail     <= '0';              
              irx_packet_end_all  <= '0';
            else
              AFE_RX_STATE        <= PACKET_IN_ST; 
              clk1x_enable        <= '1';
              packet_avail        <= '1';
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '0';
           end if;

        --------------------- EARLY_TERM --------------------------------------
          when EARLY_TERM => 
            if ( idle_line = '1' ) then
              AFE_RX_STATE        <= IDLE; 
              clk1x_enable        <= '1'; 
              packet_avail        <= '0';
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '1';
            else
              AFE_RX_STATE        <= EARLY_TERM;  
              clk1x_enable        <= '1'; 
              packet_avail        <= '0';
              rx_packet_avail     <= '0';
              irx_packet_end_all  <= '0';
            end if;
                  
         ----------------------- OTHERS ---------------------------------------
          when others =>
            null;  
        end case;
      end if;
--    end if;
  end process;

end Behavioral;