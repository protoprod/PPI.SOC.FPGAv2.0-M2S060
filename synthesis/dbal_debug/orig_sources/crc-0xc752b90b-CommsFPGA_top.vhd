----------------------------------------------------------------------------------
-- Company:         Bluefin Innovations
-- Create Date:     10 Jan 2018
-- Module Name:     CommsFPGA_top.vhd
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:
--    The PPI Proprietary FPGA Fabric supports both the transmission and
--    reception of packets and resides between the AFE and processor.
--    Transmit packets are first loaded into the Transmit FPGA FIFO.
--    The packet then is converted from bytes to bits, Manchester Encoded,
--    and transmitted over the iRail.  When the packet is successfully
--    transmitted, the processor is notified via an interrupt.  Received packets
--    are Manchester Decoded, converted from bits to bytes and loaded into the
--    FPGA Receive FIFO.  The processor is then notified of a packet reception
--    via an interrupt.
--
-- Structure:
--    CommsFPGA_top.vhd                            <=
--      -- TX_Collision_Detector2.vhd
--      -- IdleLineDetector.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--              -- Edge_Detect.vhd
--      -- ManchesterEncoder2.vhd

--           -- Nib2Ser_SM.vhd
--           -- Jabber_SM.vhd
--           -- Edge_Detect.vhd
--      -- ManchesDecoder2.vhd
--           -- RX_SM.vhd
--           -- CLOCK_DOMAIN_BUFFER.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--           -- BitDector.vhd
--
--
-- Revisions:
--	0x1 	Initial FPGA 2.0 without host MII interface
--	0x2		FPGA 2.0 + host interface
--	0x3		ASK AFE design
--	0x4		simple node baseline merged with ASK AFE 6/22/18
--	0x5		simple node baseline after merge with M2S060 logic  6/25/18
--	0x6		simple node LEDs and buttons to SoC IOs; TB simulation working   7/11/18
--	0x7		RTC 32KHz input clock Implementation  7/18/18 updated 7/25/18 for LED uP control w/ GPIO8
--	0x8		RTC 1MHz input clock Implementation  7/18/18 updated 7/25/18 for LED uP control w/ GPIO8
--	0x9		RTC 25/50MHz input clock Implementation  7/18/18
--  0xA		RTC 32KHz input clock Implementation; worked GPIOs for SEP	9/5/18
--  0xB		RTC 32KHz input clock Implementation; worked DBAL and WML GPIOs for SEP	9/8/18
--  0xC		RTC 32KHz input clock Implementation; Added Pullups to Controller Buttons for SEP	9/9/18
--  0xD		RTC 32KHz; Added Node Res Bits GPIOs, PTT GPIOs 17 & 18 for SEP II	9/22/18
----------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library std;
use std.textio.all;
--use std.standard.all;

entity CommsFPGA_top is
    Port (
      SIMOnly_idle_line         : out std_logic;
      SIMOnly_rx_packet_end_all : out std_logic;
      SIMonly_start_tx          : out std_logic;
      SIMonly_force_jabber      : out std_logic;
      clk16x                    : in  std_logic;
      bit_clk2x                 : in  std_logic;
      Clk_25MHz                 : in  std_logic;						   
      SW_RESET                  : in  std_logic;
      BD_RESETn                 : in  std_logic;
      RESET_OUTn                : out std_logic;    -- fix for Phy reset on SOM
      LOCK                      : in  std_logic;
      APB3_CLK                  : in  std_logic;
      APB3_SEL                  : in  std_logic;
      APB3_ENABLE               : in  std_logic;
      APB3_ADDR                 : in  std_logic_vector(7 downto 0);
      APB3_WDATA                : in  std_logic_vector(7 downto 0);
      APB3_RDATA                : out std_logic_vector(7 downto 0);
      APB3_READY                : out std_logic;
      APB3_WRITE                : in  std_logic;
      DEBOUNCE_IN               : in  std_logic_vector(2 downto 0);
      DEBOUNCE_OUT0             : out std_logic;
      DEBOUNCE_OUT1             : out std_logic;
      DEBOUNCE_OUT2             : out std_logic;
      DRVR_EN                   : out std_logic;
      RCVR_EN                   : out std_logic;
      MANCHESTER_IN             : in  std_logic;
      MANCH_OUT_P               : out std_logic;
      MANCH_OUT_N               : out std_logic;
      INT                       : out std_logic;
      -- FPGA 2.0 IOs
      H_TXD                     : in  std_logic_vector(3 downto 0);
      H_RXD                     : out std_logic_vector(3 downto 0);
      H_MDI                     : in  std_logic;
      H_MDO                     : out std_logic;
      H_MDO_EN                  : out std_logic;
      H_MDC                     : in  std_logic;
      H_TXC                     : out std_logic;
      H_TXEN                    : in  std_logic;
      H_RXC                     : out std_logic;
      H_RXDV                    : out std_logic;
      H_RXER                    : out std_logic;
      H_CRS                     : out std_logic;
      H_COL                     : out std_logic;
      DormantREQn               : in  std_logic;
      EngageREQn                : in  std_logic;
      HOST_DETn                 : in  std_logic;
      SPI_FLASH_RSTn            : out std_logic;
      uSD_DETLVR                : in  std_logic;
      uSD_DETSW                 : in  std_logic;
      SPI_FLASH_IO2             : out std_logic;
      SPI_FLASH_IO3             : out std_logic;
      MAC_MII_MDC               : in  std_logic;
      MII_DBG_PHYn              : in  std_logic;    -- Phy Select (Debug Phy or FPGA Phy)
      MAC_MII_TXD               : in  std_logic_vector(3 downto 0);
      MAC_MII_TX_EN             : in  std_logic;
      MAC_MII_RXD               : out std_logic_vector(3 downto 0);
      MAC_MII_RX_ER             : out std_logic;
      MAC_MII_RX_DV             : out std_logic;
      MAC_MII_CRS               : out std_logic;
      MAC_MII_COL               : out std_logic;
      MAC_MII_RX_CLK            : out std_logic;
      MAC_MII_TX_CLK            : out std_logic;
      MAC_MII_MDO_EN            : in  std_logic;
      MAC_MII_MDO               : in  std_logic;
      MAC_MII_MDI               : out std_logic;
      D_MDO_EN                  : out std_logic;
      D_MDO                     : out std_logic;
      D_MDI                     : in  std_logic;
      D_TXD                     : out std_logic_vector(3 downto 0);
      D_RXD                     : in  std_logic_vector(3 downto 0);
      D_MDC                     : out std_logic;
      D_TXC                     : in  std_logic;
      D_TXEN                    : out std_logic;
      D_RXC                     : in  std_logic;
      D_RXDV                    : in  std_logic;
      D_RXER                    : in  std_logic;
      D_CRS                     : in  std_logic;
      D_COL                     : in  std_logic;
	  MII_RX_D_fail_reg			: out std_logic;
	  LED_GREEN					: out std_logic;
	  LED_BLUE					: out std_logic;
	  LED_RED					: out std_logic;
	  THOs_AFE					: in std_logic;
	  GPIO8_M2F					: in std_logic;		-- use for uP control of LEDs = '1'
	  GPIO29_GREEN				: in std_logic;
	  GPIO30_RED				: in std_logic;
	  GPIO31_BLUE				: in std_logic
    );
end CommsFPGA_top;

architecture Behavioral of CommsFPGA_top is

  -- constants
  constant PREABLE_PATTERN       : std_logic_vector( 7 downto 0) := x"55";
  constant START_BYTE_SYMBOL     : std_logic_vector( 7 downto 0) := x"5D";
  constant RX_IDLE_LINE_CNTR_MAX : std_logic_vector(15 downto 0) := x"0600";
  constant CONSUMER_ADDRESS_C    : std_logic_vector( 9 downto 0) := "1010101010";

  -- signals
  signal RESET                 : std_logic;
  signal bd_reset              : std_logic;
  signal long_reset            : std_logic;
  signal long_reset_cntr       : std_logic_vector(7 downto 0);
  signal ClkDivider            : unsigned (2 downto 0);
  signal BIT_CLK               : std_logic;
  signal internal_loopback     : std_logic;
  signal RX_s2p                : std_logic_vector(7 downto 0);
  signal collision_detect      : std_logic;
  signal Jabber_detect         : std_logic;
  signal force_collision       : std_logic;
  signal rx_packet_end_all     : std_logic;
  signal manches_in_dly        : std_logic_vector(1 downto 0);
  signal MII_TX_CLK            : std_logic;
                               
  signal control_reg_6         : std_logic;
  signal control_reg_7         : std_logic;
  signal MII_MUX_control_reg   : std_logic_vector(7 downto 0);
  signal PMAD_rst_out          : std_logic;
  signal PMAD_link_status      : std_logic := '1';
  signal PMAD_fault_status     : std_logic := '0';
  signal PMAD_loopbk_en        : std_logic;
  signal PMAD_lowpwr_en        : std_logic;
  signal start_tx_FIFO         : std_logic;
  signal idle_line             : std_logic;
  signal TX_Enable             : std_logic;
  signal idle_line_s           : std_logic_vector(1 downto 0);
  signal iMANCH_OUT_P          : std_logic;
  signal iMANCH_OUT_N          : std_logic;
                               
  signal PMAD_jabber_det       : std_logic := '0'; -- PMA/PMD jabber detect active high
  signal PMAD_isolate_en       : std_logic;        -- isolate Phy from MII active high
  signal PMAD_COL_test         : std_logic;        -- test PHY signal active high
                               
  signal F_TXD                 : std_logic_vector(3 downto 0);
  signal F_RXD                 : std_logic_vector(3 downto 0);
  signal F_MDC                 : std_logic;
  signal F_TXC                 : std_logic;
  signal F_TXEN                : std_logic;
  signal F_RXC                 : std_logic;
  signal F_RXDV                : std_logic;
  signal F_RXER                : std_logic;
  signal F_CRS                 : std_logic;
  signal F_COL                 : std_logic;
  signal F_MDO_EN              : std_logic;
  signal F_MDO                 : std_logic;
  signal F_MDI                 : std_logic;

  signal i_F_TXD               : std_logic_vector(3 downto 0);
  signal i_F_TXEN              : std_logic;
  signal t_F_TXD               : std_logic_vector(3 downto 0);
  signal t_F_TXEN              : std_logic;

  signal DEBOUNCE_OUT          : std_logic_vector(2 downto 0);

  signal MII_TX_EN             : std_logic;
  signal MII_TX_D              : std_logic_vector(3 downto 0);
  signal MII_ERROR             : std_logic;

  signal MII_CLK               : std_logic;

  signal MII_RX_CLK            : std_logic;
  signal MII_RX_EN             : std_logic;
  signal MII_RX_D              : std_logic_vector(3 downto 0);

  signal test_count_clr        : std_logic;
  signal force_jabber          : std_logic;
  signal SFD_timeout           : std_logic;
  signal MII_RX_D_fail         : std_logic;

  signal T_TXD                 : std_logic_vector(3 downto 0); 
  signal T_TXEN                : std_logic;
  signal T_RXD                 : std_logic_vector(3 downto 0);
  signal T_RXER                : std_logic;
  signal T_RXDV                : std_logic;
  signal T_CRS                 : std_logic; 
  signal T_COL                 : std_logic; 
  signal T_RXC                 : std_logic; 
  signal T_TXC                 : std_logic; 
  
  signal Tx_Data_d1            : std_logic_vector(7 downto 0);
  signal Tx_Data_d2            : std_logic_vector(7 downto 0);
  signal RX_byte               : std_logic_vector(7 downto 0);
  signal RX_byte_valid		   : std_logic;
  signal Collision_det		   : std_logic_vector(23 downto 0);
  signal Collision_det_s	   : std_logic;
  signal wait_for_first_state  : std_logic;
  signal MANCHESTER_INc		   : std_logic;
  signal THOs_AFEn			   : std_logic;
  signal THO_compare_s		   : std_logic;
  signal THO_compare_reg	   : std_logic_vector(23 downto 0);
  signal THOs_AFE_reg		   : std_logic_vector(2 downto 0);
  signal AFE_Compare_reg	   : std_logic;
  signal THOs_AFE_reg_2		   : std_logic;
  signal THO_compare_reg_14	   : std_logic;

  signal TX_State_IDLE 		   : std_logic; 
  
  signal reset_all_pkt_cntrs   : std_logic; 	
  
  
  /*  PRBS signals
  */
  signal q				: std_logic_vector(23 downto 0);
  signal random_data_bit: std_logic;
  signal n1				: std_logic;
  signal manInVec		: std_logic_vector(23 downto 0);
  
  signal gen_data_delay : std_logic_vector(23 downto 0);
  signal start_packet_SM: std_logic;
  signal force_error	: std_logic;
  

begin

  SIMonly_start_tx   <= start_tx_FIFO;
  SIMOnly_idle_line  <= idle_line;
  MII_CLK            <= ClkDivider(1);

  -----------------------------------------------------------------------------
  -- Board Signals
  -------1---------2---------3---------4---------5---------6---------7---------8

  RESET           <= not LOCK or long_reset;
  RESET_OUTn      <= not RESET;
  bd_reset        <= not BD_RESETn or SW_RESET;

  DRVR_EN         <= TX_Enable;  
  RCVR_EN         <= '1';
  
		-- simple node inverter change for 060 support
  MANCH_OUT_N     <= iMANCH_OUT_P;
  MANCH_OUT_P     <= not iMANCH_OUT_P;

  -- Clocks from FPGA to MAC or Host
  F_TXC           <= MII_CLK;
  F_RXC           <= MII_CLK;

  SPI_FLASH_RSTn  <= uSD_DETLVR;
  SPI_FLASH_IO2   <= uSD_DETSW;
  SPI_FLASH_IO3   <= uSD_DETSW;

--------------------------------------------------------------------------------
-- Reset Elongation
---------1---------2---------3---------4---------5---------6---------7---------8
  RESET_DELAY_PROC :  PROCESS (BIT_CLK, bd_reset)
    begin
      if ( bd_reset = '1' ) then
        long_reset_cntr <= (others => '0');
        long_reset    <= '1';
      elsif  ( rising_edge( BIT_CLK ) ) then
        if (long_reset_cntr = x"1F" ) then
          long_reset_cntr <= long_reset_cntr;
          long_reset    <= '0';
        else
          long_reset_cntr <= long_reset_cntr + '1';
          long_reset    <= '1';
        end if;
      end if;
    end process;

--------------------------------------------------------------------------------
-- PRBS Generator with Manch encoding to test AFE
---------1---------2---------3---------4---------5---------6---------7---------8
  
  AFE_PRBS1_PROC :  PROCESS (bit_clk2x, bd_reset)
  begin
    if (bd_reset = '1') then 
	  random_data_bit 		<= '0';
    elsif rising_edge(bit_clk2x) then
	  random_data_bit <= q(23) xor BIT_CLK;
    end if;
  end process;
  
  AFE_PRBS2_PROC :  PROCESS (BIT_CLK, bd_reset)
  begin
    if (bd_reset = '1') then 
      q 	<= x"FFFFFF";
    elsif rising_edge(BIT_CLK) then
--      q 	<= q(22 downto 0) & n1;
      q 	<= q + '1';		-- use for red LED heart beat
	end if;
  end process;
  
    n1 <= q(23) xor q(18);

  -------------------------------------------------------------
  -- Generate the Bit Clock Counter
  -------------------------------------------------------------
  BIT_CLOCK_GEN : process(bit_clk2x, bd_reset)
  begin
    if (bd_reset = '1') then
        BIT_CLK <= '0';
    else
      if (rising_edge(bit_clk2x)) then
        BIT_CLK <= not BIT_CLK;
      end if;
    end if;
  end process;

  -------------------------------------------------------------
  -- Generate the Byte Clock Counter
  -------------------------------------------------------------
  CLOCK_GEN : process(BIT_CLK, bd_reset)
  begin
    if (bd_reset = '1') then
        ClkDivider <= (others => '0');
    else
      if (rising_edge(BIT_CLK)) then
        ClkDivider <= ClkDivider + '1';
      end if;
    end if;
  end process;


-------------------------------------------------------------
-- Capture Tx Nibble to compare on Rx side for Collision/loopback signal
-------------------------------------------------------------
  TX_Nibble : process(MII_CLK, bd_reset)
  begin
    if (rising_edge(MII_CLK)) then
	  if (bd_reset = '1') then
        Tx_Data_d1 <= (others => '0');
        Tx_Data_d2 <= (others => '0');
	  elsif (F_TXEN = '1') then
        Tx_Data_d1 <= Tx_Data_d1(3 downto 0) & F_TXD;
        Tx_Data_d2 <= Tx_Data_d1;
	  end if;
    end if;
  end process;
  
  Collision_cmpr : process(clk16x, bd_reset)
  begin
    if (rising_edge(clk16x)) then
	  if (bd_reset = '1') then
        Collision_det <= (others => '0');
	  -- timing is different in first state so compare to d1 value
	  elsif ((wait_for_first_state = '1') and (F_TXEN = '1') and (RX_byte_valid = '1') and 
			(Tx_Data_d2 /= RX_byte) and (Tx_Data_d1 /= RX_byte)) then
		Collision_det <= Collision_det(22 downto 0) & '1';
	  elsif ((wait_for_first_state = '0') and (F_TXEN = '1') and (RX_byte_valid = '1') and 
			(Tx_Data_d2 /= RX_byte)) 	then
        Collision_det <= Collision_det(22 downto 0) & '1';
	  else
	    Collision_det <= Collision_det(22 downto 0) & '0';
	  end if;
    end if;
  end process;

  Collision_det_s <= '1' when (Collision_det /= x"000000") else '0';

  
------------------------------------------------------------------------------
-- Compare baseline AFE Manchester in Signal to new ASK AFE input
-------1---------2---------3---------4---------5---------6---------7---------8
  
  AFE_COMPARE : process(clk16x, bd_reset)
  begin
    if (rising_edge(clk16x)) then
	  if (bd_reset = '1') then
        THO_compare_reg <= (others => '0');
		THOs_AFE_reg	<= (others => '0');
		AFE_Compare_reg	<= '0';
	  else
	    THO_compare_reg <= THO_compare_reg(22 downto 0) & MANCHESTER_IN;
		THOs_AFE_reg	<= THOs_AFE_reg (1 downto 0) & THOs_AFEn;
		AFE_Compare_reg	<= THO_compare_reg(16) xor THOs_AFE_reg(2);
	  end if;
    end if;
  end process;
  
  THO_compare_s 	<= '1' when (THO_compare_reg(16) /= THOs_AFEn) else '0';
  THOs_AFE_reg_2	<= THOs_AFE_reg(2);
  THO_compare_reg_14<= THO_compare_reg(16);
  
------------------------------------------------------------------------------
-- Tri-Debounce
-------1---------2---------3---------4---------5---------6---------7---------8
  TRIPLE_DEBOUNCE_INST : entity work.TriDebounce
    Port Map(
      reset           => RESET,
      clk             => BIT_CLK,
      debounce_in     => DEBOUNCE_IN,
      debounce_out    => DEBOUNCE_OUT
    );

  DEBOUNCE_OUT0             <= DEBOUNCE_OUT(0);
  DEBOUNCE_OUT1             <= DEBOUNCE_OUT(1);
  DEBOUNCE_OUT2             <= DEBOUNCE_OUT(2);

------------------------------------------------------------------------------
-- LEDs are the 'OR' of the MII Tx/Rx signals and the GPIOs
-- 
--									SoC Pins
--							Simple Node	Sep Nodes
--	BLUE  LED	 MSS_GPIO_31	   Y15	R8
--	Red   LED	 MSS_GPIO_30	   W15	P8
--	Green LED	 MSS_GPIO_29	   V16	P9
-------1---------2---------3---------4---------5---------6---------7---------8
  LED_BLUE      <= '0' when ((MAC_MII_TX_EN = '1' and GPIO8_M2F = '0') or 
							(GPIO31_BLUE = '1' and GPIO8_M2F = '1')) else '1';	--  Pull output to '0' to turn on LEDs
  LED_RED      	<= '0' when ((GPIO30_RED = '1'  and GPIO8_M2F = '1') or 
							((q(23 downto 16) = x"FF") and (MAC_MII_TX_EN = '0') and (GPIO8_M2F = '0') and 
									(MAC_MII_RX_DV = '0')))  else '1';	--  Red LED for heart beat when no traffic
  LED_GREEN     <= '0' when ((MAC_MII_RX_DV = '1' and GPIO8_M2F = '0') or (GPIO29_GREEN ='1' and GPIO8_M2F = '1')) else '1';	
  iMANCH_OUT_N              <= not iMANCH_OUT_P;
  SIMOnly_rx_packet_end_all <= rx_packet_end_all;

--------------------------------------------------------------------------------
-- Data Generator Window Logic (FSM)
---------1---------2---------3---------4---------5---------6---------7---------8
  
  DATA_GEN_CNTL_PROC :  PROCESS (bit_clk2x, bd_reset, MII_DBG_PHYn)
  begin
    if (bd_reset = '1' or MII_DBG_PHYn = '1') then 		-- don't generate packets if receiver
	  gen_data_delay	<= (others => '0');
    elsif rising_edge(bit_clk2x) then
	  if (gen_data_delay > x"0002C7") then
	    gen_data_delay	<= (others => '0');
	  else
	    gen_data_delay <= gen_data_delay + '1';
	  end if;
    end if;
  end process;
  
  start_packet_SM <= '1'  when ((gen_data_delay > x"000200") and (gen_data_delay < x"000309")) else '0';
--  force_error <= '1'  when ((gen_data_delay > x"0001da") and (gen_data_delay < x"0001e8")) else '0';
  
  
  
  ------------------------------------------------------------------------------
      -- Data Generater for Test Purposes
  -------1---------2---------3---------4---------5---------6---------7---------8
      TEST_DATA_GENERATER_INST : entity work.MII_DataGen
        Generic Map(
          START_BYTE_SYMBOL      => START_BYTE_SYMBOL,
          PREABLE_PATTERN        => PREABLE_PATTERN
        )
        Port Map(
          reset                   => RESET,                 -- in
          count_clr               => test_count_clr,        -- in
          Consumer_Address        => CONSUMER_ADDRESS_C,    -- in  
          PacketStart             => start_packet_SM, --start_tx_FIFO,         -- in  
          Increment_Packet_Count  => '0', -- rx_packet_end_all,     -- in  
          force_jabber            => force_jabber,          -- in  
          MII_TX_CLK              => T_TXC,                 -- in  
          MII_TX_EN               => T_TXEN,                -- out 
          MII_TX_D                => T_TXD                  -- out 
        );

  ------------------------------------------------------------------------------
      -- Data Checker for Test Purposes
  -------1---------2---------3---------4---------5---------6---------7---------8

      TEST_DATA_CHECKER_INST : entity work.MII_DataCheck
        Generic Map(
          START_BYTE_SYMBOL     => START_BYTE_SYMBOL
        )
        Port Map(
          reset                   => RESET,                  -- in  
          count_clr               => test_count_clr,         -- in
          Consumer_Address        => CONSUMER_ADDRESS_C,     -- in  
          PacketStart             => '1',--MII_DBG_PHYn, -- start_packet_SM, -- start_tx_FIFO,          -- in  
          rx_packet_end_all       => rx_packet_end_all,      -- in  
          idle_line               => idle_line_s(1),         -- in  
          MII_RX_CLK              => T_RXC,                  -- in  
          MII_RX_EN               => T_RXDV,                 -- in  
          MII_RX_D                => T_RXD,                  -- in  
          MII_RX_D_fail           => MII_RX_D_fail           -- out 
        );

    ------------------------------------------------------------------------------
    -- Sync to MII_CLK 2.5MHz Process for Test Purposes.
    -------1---------2---------3---------4---------5---------6---------7---------8
    DELAY_PROC : process(MII_CLK, reset)
    begin
      if (rising_edge(MII_CLK) ) then
        if(reset = '1') then
          idle_line_s     <= (others => '0');
		  MII_RX_D_fail_reg <= '1';		
        else
          idle_line_s     <= idle_line_s(0) & idle_line;
		  MII_RX_D_fail_reg <= not MII_RX_D_fail;		-- Drive LED low when miscompare 
        end if;
      end if;
    end process;

--------------------------------------------------------------------------------
 -- Processor Interface Instance
---------1---------2---------3---------4---------5---------6---------7---------8
-- The Processor Interface provides the means for the processor to communicate
-- with the FPGA logic.  This is communication path, or bus, utilizes a
-- standard interface referred to as the ARM Advanced Microcontroller Bus
-- Architecture (AMBA).  AMBA is an open-standard, on-chip interconnect
-- specification for the connection and management of functional blocks in
-- (SoC) designs. It facilitates development of multi-processor designs with
-- large numbers of controllers and peripherals.  This interface consists of an
-- address bus, control signals and an 8-bit data bus.  Furthermore, the
-- processor interface supports address decoding, data bus interface,
-- status/control registers and interrupt control.
---------1---------2---------3---------4---------5---------6---------7---------8
  PROCESSOR_INTERFACE_INST : entity work.uP_if
    PORT Map(
      rst                      => RESET,               -- in
      APB3_CLK                 => APB3_CLK,            -- in
      APB3_RESET               => long_reset,          -- in
      APB3_SEL                 => APB3_SEL,            -- in
      APB3_ENABLE              => APB3_ENABLE,         -- in
      APB3_ADDR                => APB3_ADDR,           -- in
      APB3_WDATA               => APB3_WDATA,          -- in
      APB3_RDATA               => APB3_RDATA,          -- out
      APB3_READY               => APB3_READY,          -- out
      APB3_WRITE               => APB3_WRITE,          -- in
      clk16x                   => clk16x,              -- in
      start_tx_FIFO            => start_tx_FIFO,       -- out
      internal_loopback        => internal_loopback,   -- out
      control_reg_7            => control_reg_7,       -- out
      control_reg_6            => test_count_clr,      -- out
      MII_MUX_control_reg      => MII_MUX_control_reg, -- out
      INT                      => INT,                 -- out
      collision_detect         => collision_detect,    -- in
      Jabber_detect            => Jabber_detect,       -- in
      SFD_timeout              => SFD_timeout,         -- in
      MII_RX_D_fail            => MII_RX_D_fail,       -- in
      force_collision          => force_collision,     -- out
      force_jabber             => force_jabber,        -- out
      rx_packet_end_all        => rx_packet_end_all,   -- in
	  reset_all_pkt_cntrs	   => reset_all_pkt_cntrs  -- out	-- 70 MHz pulse from uP logic ABH
    );

  --------------------------------------------------------------------------------
  -- Idle Line Detection Instance
  ---------1---------2---------3---------4---------5---------6---------7---------8
  IDLE_LINE_DETECTOR : entity work.IdleLineDetector
    Generic Map(
      IDLE_LINE_CNTR_MAX  => RX_IDLE_LINE_CNTR_MAX
    )
    Port Map(
      reset               => RESET,                    -- in
      clk                 => clk16x,                   -- in
      manches_in_dly      => manches_in_dly,           -- in
      idle_line           => idle_line,                -- out
      TX_Enable           => '0'                       -- in
    );

  -----------------------------------------------------------------------------
  -- Manchester Encoder Instance
  -----------------------------------------------------------------------------
  MANCHESTER_ENCODER_2_INST : entity work.ManchesEncoder2
    Port Map(
      reset                 => RESET,                  -- in
      bit_clk2x             => bit_clk2x,              -- in
      bit_clk               => BIT_CLK,                -- in
      MII_TX_CLK            => MII_CLK,                -- in
      MII_TX_EN             => F_TXEN,                 -- in
      MII_TX_D              => F_TXD,                  -- in
      MII_COL               => F_COL,                  -- out
      MII_ERROR             => F_RXER,                 -- out
      idle_line             => idle_line,              -- in
      TX_Enable             => TX_Enable,              -- out
      collision_detect      => collision_detect,       -- in
      Jabber_detect         => Jabber_detect,          -- out
      MANCHESTER_OUT        => iMANCH_OUT_P,           -- out
	  TX_State_IDLE			=> TX_State_IDLE,	       -- out
	  reset_all_pkt_cntrs	=> reset_all_pkt_cntrs	   -- in
    );

  -----------------------------------------------------------------------------
  -- Manchester Decoder Instance
  -----------------------------------------------------------------------------
  MANCHESTER_DECODER2_INST : entity work.ManchesDecoder2
    Generic Map(
      START_BYTE_SYMBOL      => START_BYTE_SYMBOL,
      PREABLE_PATTERN        => PREABLE_PATTERN
    )
    Port Map(
      rx_packet_end_all      => rx_packet_end_all,     -- out
      rst                    => RESET,                 -- in
      clk16x                 => clk16x,                -- in
      manches_in_dly         => manches_in_dly,        -- out
      MII_RX_CLK             => MII_CLK,               -- in
      MII_RX_EN              => F_RXDV,                -- out
      MII_RX_D               => F_RXD,                 -- out
      MANCHESTER_IN          => MANCHESTER_IN,         -- in
      MANCH_OUT_P            => iMANCH_OUT_P,          -- in
      SFD_timeout            => SFD_timeout,           -- out
      internal_loopback      => internal_loopback,     -- in
	  TX_State_IDLE 	     => TX_State_IDLE, 		   -- in
	  reset_all_pkt_cntrs	 => reset_all_pkt_cntrs,   -- in
	  RX_byte_valid          => RX_byte_valid, 		   -- out
	  RX_byte		         => RX_byte,	 		   -- out
	  wait_for_first_state	 => wait_for_first_state   -- out
    );

  -----------------------------------------------------------------------------
  -- Collision_Detector Instance
  -----------------------------------------------------------------------------
  COLLISION_DETECTOR_INST : entity work.TX_Collision_Detector2
    Port Map(
      reset                 => RESET,                  -- in
      bit_clk2x             => bit_clk2x,              -- in
      TX_Enable             => TX_Enable,              -- in
      MANCHESTER_OUT        => iMANCH_OUT_P,           -- in
      MANCHESTER_IN         => MANCHESTER_IN,          -- in
      force_collision       => force_collision,        -- in
      TX_collision_detect   => collision_detect        -- out
    );

  ------------------------------------------------------------------------------
  -- Host, SoC, FPGA and Debug Phy Mux
  -------1---------2---------3---------4---------5---------6---------7---------8
  Phy_Mux_Inst : entity work.Phy_Mux
    Port Map(
      Clk_25MHz           => Clk_25MHz,
      -- Inputs from SoC MAC
      MII_MUX_control_reg => MII_MUX_control_reg,  -- in
      MII_DBG_PHYn        => MII_DBG_PHYn,         -- in
      MAC_MII_MDC         => MAC_MII_MDC,          -- in
      MAC_MII_MDO_EN      => MAC_MII_MDO_EN,       -- in
      MAC_MII_MDO         => MAC_MII_MDO,          -- in
      --
      MAC_MII_TXD         => MAC_MII_TXD,          -- in
      MAC_MII_TX_EN       => MAC_MII_TX_EN,        -- in
      -- Outputs to SoC MAC
      MAC_MII_RXD         => MAC_MII_RXD,          -- out 
      MAC_MII_RX_ER       => MAC_MII_RX_ER,        -- out 
      MAC_MII_RX_DV       => MAC_MII_RX_DV,        -- out 
      MAC_MII_CRS         => MAC_MII_CRS,          -- out 
      MAC_MII_COL         => MAC_MII_COL,          -- out 
      MAC_MII_RX_CLK      => MAC_MII_RX_CLK,       -- out 
      MAC_MII_TX_CLK      => MAC_MII_TX_CLK,       -- out 
      MAC_MII_MDI         => MAC_MII_MDI,          -- out 
      -- Inputs from FPGA I-Rail PHY
      F_MDO_EN            => F_MDO_EN,
      F_MDO               => F_MDO,
      F_MDC               => F_MDC,
      F_MDI               => F_MDI,
      -- Inputs from FPGA I-Rail PHY
      F_RXD               => F_RXD,                -- in 
      F_RXER              => F_RXER,               -- in 
      F_RXDV              => F_RXDV,               -- in 
      F_CRS               => not idle_line_s(1),   -- in
      F_COL               => Collision_det_s,	   -- in  
      F_RXC               => F_RXC,                -- in 
      F_TXC               => F_TXC,                -- in 
      -- Outputs to FPGA I-RAIL PHY
      F_TXD               => F_TXD,                -- out
      F_TXEN              => F_TXEN,               -- out
      -- Inputs from Host MII
      H_TXD               => H_TXD,                -- in 
      H_TXEN              => H_TXEN,               -- in 
      H_MDC               => H_MDC,                -- in 
      H_MDI               => H_MDI,                -- in  
	  HOST_DETn			  => HOST_DETn,			   -- in 0 = capable node
      -- Outputs to Host Phy
      H_RXD               => H_RXD,                -- out 
      H_RXER              => H_RXER,               -- out 
      H_RXDV              => H_RXDV,               -- out 
      H_CRS               => H_CRS,                -- out 
      H_COL               => H_COL,                -- out 
      H_RXC               => H_RXC,                -- out 
      H_TXC               => H_TXC,                -- out 
      H_MDO_EN            => H_MDO_EN,             -- out 
      H_MDO               => H_MDO,                -- out 
      -- Inputs from Debug PHY KSZ8081
      D_RXD               => D_RXD,                -- in 
      D_RXER              => D_RXER,               -- in 
      D_RXDV              => D_RXDV,               -- in 
      D_CRS               => D_CRS,                -- in 
      D_COL               => D_COL,                -- in 
      D_RXC               => D_RXC,                -- in 
      D_TXC               => D_TXC,                -- in 
      D_MDI               => D_MDI,                -- in 
      -- Outputs to Debug PHY KSZ8081
      D_TXD               => D_TXD,                -- out 
      D_TXEN              => D_TXEN,               -- out 
      D_MDC               => D_MDC,                -- out 
      D_MDO_EN            => D_MDO_EN,             -- out 
      D_MDO               => D_MDO,                -- out 
      -- Inputs from Test Logic
      T_TXD               => T_TXD,                -- in
      T_TXEN              => T_TXEN,               -- in
      -- Outputs to Test Logic
      T_RXD               => T_RXD,                -- out
      T_RXER              => T_RXER,               -- out
      T_RXDV              => T_RXDV,               -- out
      T_CRS               => T_CRS,                -- out
      T_COL               => T_COL,                -- out
      T_RXC               => T_RXC,                -- out
      T_TXC               => T_TXC                 -- out
  );

  ------------------------------------------------------------------------------
  -- MDIO Slave Instantiation
  -------1---------2---------3---------4---------5---------6---------7---------8

  -- model events to check in testbench
  PMAD_link_status        <= '0' after 509066 ns;
  PMAD_fault_status       <= '1' after 224643 ns;
  PMAD_jabber_det         <= '1' after 369122 ns;

  MDIO_SLAVE_INST : entity work.mdio_slave_interface
      Port Map(
        PMAD_rst_in       => RESET,
        PMAD_clk          => F_MDC,
        PMAD_link_status  => PMAD_link_status,
        PMAD_fault_status => PMAD_fault_status,
        PMAD_jabber_det   => PMAD_jabber_det,
        PMAD_mdo          => F_MDO,
        PMAD_mdi          => F_MDI,
        PMAD_mdo_en       => F_MDO_EN,
        PMAD_rst_out      => PMAD_rst_out,
        PMAD_loopbk_en    => PMAD_loopbk_en,
        PMAD_lowpwr_en    => PMAD_lowpwr_en,
        PMAD_isolate_en   => PMAD_isolate_en,
        PMAD_COL_test     => PMAD_COL_test
      );

end Behavioral;
