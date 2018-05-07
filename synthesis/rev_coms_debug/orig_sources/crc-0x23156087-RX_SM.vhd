-------------------------------------------------------------------------------
-- Filename:      RX_SM.vhd
-- Description:   RX_SM  -
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
--           -- RX_SM.vhd                 <=
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

entity RX_SM is
  Generic (
    START_BYTE_SYMBOL   : std_logic_vector(7 downto 0) := x"5D" -- 802.3 = x"D5"
  );
  Port (
    reset               : in  std_logic;
    clk16x              : in  std_logic;
    manches_in_dly      : in  std_logic_vector(1 downto 0);
    rx_center_sample    : in  std_logic;
    RX_s2p              : in  std_logic_vector(7 downto 0);
    NoClock_Detected    : in  std_logic;
    idle_line           : in  std_logic;
    RX_byte_valid       : out std_logic;
    RX_byte             : out std_logic_vector(7 downto 0);
    clk1x_enable        : out std_logic;
    rx_packet_end_all   : out std_logic;
    SFD_timeout         : out std_logic;
    start_bit_mask      : out std_logic;
	TX_State_IDLE		: in  std_logic;
	reset_all_pkt_cntrs	: in std_logic
  );
end RX_SM;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of RX_SM is

  -- Constants
  constant START_BIT_MASK_NUM : std_logic_vector(15 downto 0) := x"018E"; -- 101817 092917 "00011000";  -- gwc "0011"; need more delay for single bit error
  constant SFD_DETECT_TIMEOUT : std_logic_vector(15 downto 0) := x"0090";     

  -- Signals
  signal i_rx_packet_end_all  : std_logic;
  signal i_start_bit_mask     : std_logic;
  signal start_bit_cntr       : std_logic_vector(15 downto 0);  
  signal bit_cntr             : std_logic_vector(3 downto 0);
  signal long_bit_cntr        : std_logic_vector(15 downto 0);
  signal missed_sfd_flag      : std_logic;
  
  -- debug counters
  signal cnt_non_idle_rail	  : std_logic_vector(15 downto 0);  
  signal cnt_SFD			  : std_logic_vector(15 downto 0);  
  signal cnt_pkt_to_idle	  : std_logic_vector(15 downto 0);  
  signal cnt_pkt_to_wait	  : std_logic_vector(15 downto 0);  
  signal reset_all_pkt_cntrs_d: std_logic_vector(2 downto 0);  
  signal reset_all_pkt_cntrs_c: std_logic;  
  
  -- state machine state defintions
  type   RX_STATE_TYPE is (
              IDLE, CARRIER_DETECT_ST, SFD_BYTE_DETECT_ST, 
              BYTE_IN_ST, WAIT_FOR_FIRST_BYTE, WAIT_FOR_IDLE_LINE_ST
                );
  signal RX_STATE         : RX_STATE_TYPE;

  -------1---------2---------3---------4---------5---------6---------7---------8


begin

  rx_packet_end_all <= i_rx_packet_end_all;
  start_bit_mask    <= i_start_bit_mask;
  missed_sfd_flag <= '1' when (long_bit_cntr >= SFD_DETECT_TIMEOUT) else '0';
  
  -- capture the falling edge of FPGA version read to generate reset pulse to counters
  reset_all_pkt_cntrs_c <= reset_all_pkt_cntrs_d(2) and (not reset_all_pkt_cntrs_d(1));
  
  -----------------------------------------------------------------------------
  -- Delay / Synchronizer
  -------1---------2---------3---------4---------5---------6---------7---------8
  SYNCHRONIZATION_PROC: PROCESS (clk16x, reset)
  begin
    if (rising_edge( clk16x ) ) then
      if ( reset = '1' ) then
         RX_byte  <= (others => '0');      
      else
         RX_byte  <= RX_s2p;
      end if;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Standardize reset packet counters from ABH to 163 MHz
  -------1---------2---------3---------4---------5---------6---------7---------8
  RST_PKT_COUNTERS: PROCESS (clk16x, reset)
  begin
    if (rising_edge( clk16x ) ) then
      if (reset = '1') then
	    reset_all_pkt_cntrs_d <= (others => '0');
      else
	    reset_all_pkt_cntrs_d(2 downto 0) <= reset_all_pkt_cntrs_d(1 downto 0) & reset_all_pkt_cntrs;
      end if;
    end if;
  end process;
  
    
  -----------------------------------------------------------------------------
  -- Start Bit Counter
  -- This logic is used to mask out aberations on the AFE circuit/rail.  It
  -- maskes looking for a start bit before the "START_BIT_MASK_NUM" of incoming
  -- bits.  This is intended as a temporary work-a-round.
  -------1---------2---------3---------4---------5---------6---------7---------8
  START_BIT_COUNTER_PROC: PROCESS (clk16x, reset, i_rx_packet_end_all)
  begin
    if (rising_edge( clk16x ) ) then    
      if ( reset = '1' or (RX_STATE = IDLE)) then	--i_rx_packet_end_all= '1' ) then
        start_bit_cntr <= (others => '0');
        i_start_bit_mask <= '0';
      elsif (start_bit_cntr /= START_BIT_MASK_NUM) then
        start_bit_cntr <= start_bit_cntr + '1';
        i_start_bit_mask <= '1';
      else
        start_bit_cntr <= start_bit_cntr;
        i_start_bit_mask <= '0'; -- i_start_bit_mask;
      end if;
    end if;
  end process;
/*
START_BIT_COUNTER_PROC: PROCESS (clk16x, reset, i_rx_packet_end_all)
  begin
    if (rising_edge( clk16x ) ) then    
      if ( reset = '1' or (RX_STATE = IDLE)) then	--i_rx_packet_end_all= '1' ) then
        start_bit_cntr <= (others => '0');
        i_start_bit_mask <= '0';
      elsif ( rx_center_sample = '1' and start_bit_cntr /= START_BIT_MASK_NUM) then
        start_bit_cntr <= start_bit_cntr + '1';
        i_start_bit_mask <= '1';
      elsif ( rx_center_sample = '1' and start_bit_cntr = START_BIT_MASK_NUM) then
        start_bit_cntr <= start_bit_cntr;
        i_start_bit_mask <= '0';
      else
        start_bit_cntr <= start_bit_cntr;
        i_start_bit_mask <= i_start_bit_mask;
      end if;
    end if;
  end process;

*/  
  ------------------------------------------------------------------------------
  -- Main State Machine
  -------1---------2---------3---------4---------5---------6---------7---------8
  RX_SM : PROCESS (clk16x, reset)
  begin
      if ( rising_edge( clk16x ) ) then
        if ( reset = '1' ) then
          RX_STATE                  <= IDLE;
          clk1x_enable              <= '0';
          i_rx_packet_end_all       <= '0';
          bit_cntr                  <= (others => '0');
          long_bit_cntr             <= (others => '0');
          RX_byte_valid             <= '0';              
          SFD_timeout               <= '0';
		  cnt_non_idle_rail			<= (others => '0');
		  cnt_SFD					<= (others => '0');
		  cnt_pkt_to_idle			<= (others => '0');
		  cnt_pkt_to_wait			<= (others => '0');
        else 
          CASE RX_STATE    IS
          
          ------------------------ IDLE ----------------------------------------
            when IDLE =>
              if ((manches_in_dly(0) = '1' and manches_in_dly(1) = '0') and (TX_State_IDLE = '1')) then
                RX_STATE            <= CARRIER_DETECT_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= (others => '0');
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
				cnt_non_idle_rail	<= cnt_non_idle_rail + '1';
             else
                RX_STATE            <= IDLE;
                clk1x_enable        <= '0';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= (others => '0');
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
				-- allow read of FPGA Version register by the host to reset packet counters during idle state
				if (reset_all_pkt_cntrs_c = '1')  then 
				  cnt_non_idle_rail		<= (others => '0');
				  cnt_SFD				<= (others => '0');
				  cnt_pkt_to_idle		<= (others => '0');
				  cnt_pkt_to_wait		<= (others => '0');
				end if;
              end if;
          
          --------------------- CARRIER_DETECT_ST ------------------------------
            when CARRIER_DETECT_ST =>             
                RX_STATE            <= SFD_BYTE_DETECT_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= (others => '0');
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
          
          --------------------- SFD_BYTE_DETECT_ST ----------------------------
            when SFD_BYTE_DETECT_ST =>
              if ( idle_line = '1' ) then
                RX_STATE            <= IDLE;
                clk1x_enable        <= '0';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= (others => '0');
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
              elsif ( RX_s2p = START_BYTE_SYMBOL and i_start_bit_mask = '0'
                      and rx_center_sample = '1' ) then
                RX_STATE            <= WAIT_FOR_FIRST_BYTE;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= long_bit_cntr + '1';
                RX_byte_valid       <= '1'; 
                SFD_timeout         <= '0';
				cnt_SFD				<=  cnt_SFD + '1';
              elsif ( long_bit_cntr >= SFD_DETECT_TIMEOUT and i_start_bit_mask = '0'
                      and rx_center_sample = '1' ) then
                RX_STATE            <= WAIT_FOR_IDLE_LINE_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= long_bit_cntr + '1';
                RX_byte_valid       <= '0'; 
                SFD_timeout         <= '1';
              elsif ( i_start_bit_mask = '0' and rx_center_sample = '1' ) then
                RX_STATE            <= SFD_BYTE_DETECT_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= long_bit_cntr + '1';
                RX_byte_valid       <= '0';                         
                SFD_timeout         <= '0';
             else
                RX_STATE            <= SFD_BYTE_DETECT_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= long_bit_cntr;
                RX_byte_valid       <= '0';   
                SFD_timeout         <= '0';
              end if;

          --------------------- WAIT_FOR_FIRST_BYTE -----------------------------------
            when WAIT_FOR_FIRST_BYTE =>
              if (rx_center_sample = '1' and bit_cntr = "0011") then
                RX_STATE            <= BYTE_IN_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= long_bit_cntr + '1';
                RX_byte_valid       <= '0';
                SFD_timeout         <= '0';
             elsif (rx_center_sample = '1') then
                RX_STATE            <= WAIT_FOR_FIRST_BYTE;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= bit_cntr + '1';
                long_bit_cntr       <= long_bit_cntr + '1';
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
             else
                RX_STATE            <= WAIT_FOR_FIRST_BYTE;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= bit_cntr;
                long_bit_cntr       <= long_bit_cntr;
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
            end if;
             
          --------------------- BYTE_IN_ST -----------------------------------
            when BYTE_IN_ST =>
              if ( NoClock_Detected = '1' ) then
                RX_STATE            <= WAIT_FOR_IDLE_LINE_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= (others => '0');
                RX_byte_valid       <= '0';
                SFD_timeout         <= '0';
				cnt_pkt_to_wait		<= cnt_pkt_to_wait + '1';
              elsif ( idle_line = '1' ) then
                RX_STATE            <= IDLE;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= (others => '0');
                RX_byte_valid       <= '0';
                SFD_timeout         <= '0';
				cnt_pkt_to_idle		<= cnt_pkt_to_idle + '1';
              elsif (rx_center_sample = '1' and bit_cntr /= "1100") then
                RX_STATE            <= BYTE_IN_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= bit_cntr + '1';
                long_bit_cntr       <= long_bit_cntr + '1';
                RX_byte_valid       <= '0';
                SFD_timeout         <= '0';
             elsif (rx_center_sample = '1' and bit_cntr = "1100") then
                RX_STATE            <= BYTE_IN_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= bit_cntr + '1';
                long_bit_cntr       <= long_bit_cntr + '1';
                RX_byte_valid       <= '1';              
                SFD_timeout         <= '0';
             else
                RX_STATE            <= BYTE_IN_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= bit_cntr;
                long_bit_cntr       <= long_bit_cntr;
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
             end if;
          
          --------------------- WAIT_FOR_IDLE_LINE_ST ----------------------------
            when WAIT_FOR_IDLE_LINE_ST =>
              if ( idle_line = '1' ) then
                RX_STATE            <= IDLE;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '1';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= (others => '0');
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
              else
                RX_STATE            <= WAIT_FOR_IDLE_LINE_ST;
                clk1x_enable        <= '1';
                i_rx_packet_end_all <= '0';
                bit_cntr            <= (others => '0');
                long_bit_cntr       <= (others => '0');
                RX_byte_valid       <= '0';              
                SFD_timeout         <= '0';
              end if;
          
           ----------------------- OTHERS ---------------------------------------
            when others =>
              null;
          end case;
        end if;
      end if;
  end process;

end Behavioral;