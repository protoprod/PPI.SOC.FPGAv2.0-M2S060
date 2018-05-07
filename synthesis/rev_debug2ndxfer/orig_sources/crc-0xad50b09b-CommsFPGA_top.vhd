----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker 
-- 
-- Create Date:     16 September 2014  
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
--    CommsFPGA_top.vhd                 <=
--      -- uP_if.vhd
--           -- Interrupts.vhd
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd
--                -- IdleLineDetector.vhd
--           -- CRC16_Generator.vhd
--      -- FIFOs.vhd
--           -- FIFO_1Kx8.vhd
--      -- ManchesDecoder.vhd 
--           -- AFE_RX_SM.vhd
--           -- ReadFIFO_Write_SM.vhd
--                -- CRC16_Generator.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--
-- Revision:  0.1
-- Revision:  11/30/16
--    Debounce_OUT(0) had to be changed from an output to High-Z with a pulldown.
--    This was due to the requirement of the Redpine WiFi module.
-- Revision:  1.0
--    Initial Release for Production
-- Revision:  1.1
--    Added SPI0_SS1 for use with uSD card.
-- Revision:  1.2
--    Updated uBoot to 1/16/17
--    Changed GPIO_1 from Output to Bidirectional.
--    Revision register changed from 0x11 to 0x12.
-- Revision 1.4_Camera AND
-- Revision 1.3
--    Increased the preable from 1 byte to 3 bytes.  This was required because
--    the start up of a packet on the rail exhibited short pulses.  This fix 
--    provided the appropriate amount of time to let the signal settle out.
-- Revision:  1.5 Unification of Camera and "others" FPGA Designs
--    Changed SPI1 from "IO" to "Fabric" configuration.  This is required on the Camera Board because SPI1 was not properly connect on the PCB.  
--    Removed GPIO13 due to a conflict between SPI_1_SS0 and GPIO13. 
--    Mapped SPI_1_SS0_PAD to pin P19(V7) of FPGA. A BiDidrection buffer was added to support SPI Master and Slave Modes.  Added MUX to select between Camera node and Others.
--    Mapped SPI_1_DO to pin P24(AA7) and M5 of FPGA.
--    Mapped SPI_1_DI to pin P13(D21) of FPGA.  Added MUX to select between Camera node and Others.
--    SPI_1_CLK continues to be mapped to pin N4 of FPGA.  A BiDidrection buffer was added to support SPI Master and Slave Modes.
--    Changed GPIO 6 from output to BiDirectional.
--    Changed GPIO 7 from output to BiDirectional.
--    Resolved Collision Detection logic issue which did not allow the collision detection.  
----------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library std;
use std.textio.all;
--use std.standard.all;

entity CommsFPGA_top is
   generic (										  -- these variables are brought in at the top level schematic
     PREAMBLE_LENGTH : natural range 0 to 4095 := 2;  -- # of Bytes
     POSTAMBLE_LENGTH: natural range 0 to 4095 := 3   -- for iRail 1.0 now 12 for 802.1Q of Bytes iRail 2.0
   );
    Port (
      CLK             : in  std_logic;
      CLK_2xBIT_10MHz : in  std_logic;
      SW_RESET        : in  std_logic;
      BD_RESETn       : in  std_logic;
      LOCK            : in  std_logic;
      APB3_CLK        : in  std_logic;
      APB3_SEL        : in  std_logic;
      APB3_ENABLE     : in  std_logic;
      APB3_ADDR       : in  std_logic_vector(7 downto 0);
      APB3_WDATA      : in  std_logic_vector(7 downto 0);
      APB3_RDATA      : out std_logic_vector(7 downto 0);
      APB3_READY      : out std_logic;
      APB3_WRITE      : in  std_logic;
      ID_RES          : in  std_logic_vector(3 downto 0);
      CAMERA_NODE     : out std_logic;
      OTHERS_NODE     : out std_logic;
      DRVR_EN         : out std_logic;
      RCVR_EN         : out std_logic;
      MANCHESTER_IN   : in  std_logic;
      MANCH_OUT_P     : out std_logic;
      MANCH_OUT_N     : out std_logic;
      INT             : out std_logic;
      DEBOUNCE_IN     : in  std_logic_vector(2 downto 0);
      DEBOUNCE_OUT    : out std_logic_vector(2 downto 0);
      PULLDOWN_R9     : in  std_logic;
      Data_FAIL       : out std_logic;
      TEST_TX         : out std_logic
    );
end CommsFPGA_top;

architecture Behavioral of CommsFPGA_top is

-- constants
constant START_BYTE_SYMBOL       : std_logic_vector(7 downto 0) := x"D5";	--	gwc for 802.1Q iRail 1.0 = x"81"; 

-- signals
signal RESET               : std_logic;
signal bd_reset            : std_logic;
signal ClkDivider		       : unsigned (2 downto 0);
signal byte_clk_en         : std_logic;
signal iMANCH_OUT_P        : std_logic;
signal manches_in_dly      : std_logic_vector(1 downto 0);
signal start_tx_FIFO       : std_logic;
signal internal_loopback   : std_logic; 
signal external_loopback   : std_logic;
signal TX_FIFO_AE          : std_logic; 
signal TX_FIFO_Empty       : std_logic; 
signal TX_FIFO_Full        : std_logic;
signal TX_FIFO_AF          : std_logic;
signal TX_FIFO_wr_en       : std_logic;  
signal TX_FIFO_rd_en       : std_logic;
signal RX_FIFO_rd_en       : std_logic; 
signal RX_FIFO_TxColDetDis_wr_en   : std_logic;
signal RX_FIFO_wr_en       : std_logic; 
signal RX_FIFO_DOUT        : std_logic_vector(8 downto 0); 
signal RX_FIFO_DIN_pipe    : std_logic_vector(8 downto 0); 
signal RX_FIFO_DIN         : std_logic_vector(7 downto 0); 
signal TX_FIFO_DOUT        : std_logic_vector(7 downto 0);
signal RX_FIFO_Empty       : std_logic;
signal RX_FIFO_Full        : std_logic;
signal TX_PreAmble         : std_logic;
signal TX_Enable           : std_logic;
signal RX_FIFO_OVERFLOW    : std_logic;           
signal RX_FIFO_UNDERRUN    : std_logic; 
signal TX_FIFO_OVERFLOW    : std_logic;
signal TX_FIFO_UNDERRUN    : std_logic;
signal RX_FIFO_RST         : std_logic;
signal rx_FIFO_rst_reg     : std_logic;
signal TX_FIFO_RST         : std_logic;
signal tx_packet_complt    : std_logic;
signal TX_collision_detect : std_logic;
signal rx_packet_avail     : std_logic;
signal RX_EarlyTerm        : std_logic;
signal long_reset          : std_logic;
signal long_reset_cntr     : std_logic_vector(7 downto 0);
signal consumer_type1_reg  : std_logic_vector(9 downto 0);
signal consumer_type2_reg  : std_logic_vector(9 downto 0);
signal consumer_type3_reg  : std_logic_vector(9 downto 0);
signal consumer_type4_reg  : std_logic_vector(9 downto 0);
signal rx_CRC_error        : std_logic;
signal rx_packet_end       : std_logic;
signal rx_packet_complt    : std_logic;
signal BIT_CLK             : std_logic;
signal tx_col_detect_en    : std_logic;
signal rx_crc_Byte_en      : std_logic;
signal rx_packet_avail_int : std_logic;
signal up_EOP_CntDown_en   : std_logic;

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- LEDs for DLEM-LRF
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- signal led_cntr            : std_logic_vector(25 downto 0);
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- TEST
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  signal Data_FAIL_ErlyTerm : std_logic;
  signal iData_FAIL     : std_logic;
  
begin
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- TEST
--!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  Data_FAIL_ErlyTerm <= iData_FAIL or RX_EarlyTerm;
  Data_FAIL          <= PULLDOWN_R9;
  TEST_TX            <= PULLDOWN_R9; 

--!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- LEDs for DLEM-LRF
--!!!!!!!!!!!!!!!!!!!!!!!!!!!
--  EVAL_BOARD_LED_PROC : process (CLK_2xBIT_10MHz, bd_reset)
--  begin
--    if (bd_reset = '1') then
--      led_cntr  <= (others => '1');
--    elsif (rising_edge(CLK_2xBIT_10MHz)) then
--      led_cntr  <= led_cntr + '1';
--    end if;
--  end process;
--  
--  GREENn  <= led_cntr(24);
--  REDn    <= led_cntr(23);
--  BLUEn   <= led_cntr(22);
  
 --------------------------------------------------------------------------------
-- Board Signals
---------1---------2---------3---------4---------5---------6---------7---------8  
 
  RESET           <= not LOCK or long_reset;
  bd_reset        <= not BD_RESETn or SW_RESET;
                  
	DRVR_EN         <= TX_Enable; 
	RCVR_EN         <= '1';
                  
  MANCH_OUT_N     <= not iMANCH_OUT_P;
  MANCH_OUT_P     <= iMANCH_OUT_P;

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
-- ID_RES Decoding
---------1---------2---------3---------4---------5---------6---------7---------8  
  ID_RES_DECODE_PROC :  PROCESS (ID_RES)
    begin
      if ( (ID_RES = "1100") or (ID_RES = "1101") ) then
        OTHERS_NODE    <= '0';
        CAMERA_NODE    <= '1';
      else
        OTHERS_NODE    <= '1';
        CAMERA_NODE    <= '0';          
      end if;  
    end process;

--------------------------------------------------------------------------------
-- Synchronize RX_FIFO_RST to 80MHz clock.
---------1---------2---------3---------4---------5---------6---------7---------8 
  SYNC2_APB3_CLK_PROC : process (clk, bd_reset)
  begin
    if (bd_reset = '1') then
      RX_FIFO_RST <= '0' ;
    elsif (rising_edge(clk)) then
      RX_FIFO_RST <= rx_FIFO_rst_reg or RX_EarlyTerm;
    end if;
  end process;
          
	-------------------------------------------------------------		
	-- Generate the Bit Clock Counter
	-------------------------------------------------------------
	BIT_CLOCK_GEN : process(CLK_2xBIT_10MHz, bd_reset)
	begin
		if (bd_reset = '1') then
				BIT_CLK <= '0';
		else
			if (rising_edge(CLK_2xBIT_10MHz)) then
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
	
--------------------------------------------------------------------------------
-- byte clock enable.  Uses BIT_CLK to generate its clock enable signal.
---------1---------2---------3---------4---------5---------6---------7---------8 
  SAMPLE_5MHZ_EN_PROC : process (BIT_CLK, RESET)
  begin
    if (RESET = '1') then
      byte_clk_en <= '0' ;
    elsif (rising_edge(BIT_CLK)) then
      byte_clk_en <= ClkDivider(2) and ClkDivider(1) and not ClkDivider(0);
    end if;
  end process;

--------------------------------------------------------------------------------
 -- Tri-Debounce
---------1---------2---------3---------4---------5---------6---------7---------8
TRIPLE_DEBOUNCE_INST : entity work.TriDebounce
  Port Map(
    reset           => RESET,
    clk             => BIT_CLK,
    debounce_in     => DEBOUNCE_IN,
    debounce_out    => DEBOUNCE_OUT
  );   

--------------------------------------------------------------------------------
 -- Processor Interface Instantiation
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
      rst               => RESET,
      APB3_CLK          => APB3_CLK,
      APB3_RESET        => long_reset,
      APB3_SEL          => APB3_SEL,
      APB3_ENABLE       => APB3_ENABLE,
      APB3_ADDR         => APB3_ADDR,
      APB3_WDATA        => APB3_WDATA,
      APB3_RDATA        => APB3_RDATA,
      APB3_READY        => APB3_READY,
      APB3_WRITE        => APB3_WRITE,
      clk16x            => clk,
      start_tx_FIFO     => start_tx_FIFO,
      internal_loopback => internal_loopback,
      external_loopback => external_loopback,
      TX_PreAmble       => TX_PreAmble,
      TX_FIFO_wr_en     => TX_FIFO_wr_en,
      RX_FIFO_rd_en     => RX_FIFO_rd_en,
      RX_FIFO_DOUT      => RX_FIFO_DOUT,
      TX_FIFO_RST       => TX_FIFO_RST,
      RX_FIFO_RST       => rx_FIFO_rst_reg,
      RX_FIFO_OVERFLOW  => RX_FIFO_OVERFLOW,
      RX_FIFO_UNDERRUN  => RX_FIFO_UNDERRUN,
      TX_FIFO_OVERFLOW  => TX_FIFO_OVERFLOW,
      TX_FIFO_UNDERRUN  => TX_FIFO_UNDERRUN,
      rx_CRC_error      => rx_CRC_error,
      INT               => INT,
      consumer_type1_reg=> consumer_type1_reg,
      consumer_type2_reg=> consumer_type2_reg,
      consumer_type3_reg=> consumer_type3_reg,
      consumer_type4_reg=> consumer_type4_reg,
      tx_packet_complt  => tx_packet_complt,
      rx_packet_complt  => rx_packet_complt,
      col_detect        => TX_collision_detect,
      TX_FIFO_Full      => TX_FIFO_Full, 
      TX_FIFO_Empty     => TX_FIFO_Empty,
      RX_FIFO_Full      => RX_FIFO_Full, 
      RX_FIFO_Empty     => RX_FIFO_Empty,
	  rx_packet_avail_int => rx_packet_avail_int,
	  up_EOP_CntDown_en => up_EOP_CntDown_en 		-- out gwc 080217 increment FIFO read pointer
    );

--------------------------------------------------------------------------------
-- FIFOs Instantiation
---------1---------2---------3---------4---------5---------6---------7---------8
-- The FIFOs consist of both a Transmit FIFO and Receive FIFO.  The Transmit 
-- FIFO provides an 8-bit interface to the AMBA write data interface and an 
-- 8-bit interface to the Transmit Packet Processor.  The Receive FIFO provides 
-- an 8-bit interface to the AMBA read data interface and an 8-bit interface 
-- to the Receive Packet Processor.  Both the Transmit FIFO and Receive FIFO 
-- are 2048 bytes in depth. 
---------1---------2---------3---------4---------5---------6---------7---------8 

  FIFOS_INST : entity work.FIFOs
    Port Map(
      reset             => reset,
      DATA              => APB3_WDATA,
      TX_FIFO_wr_clk    => APB3_CLK,
      TX_FIFO_rd_clk    => BIT_CLK,
      TX_FIFO_wr_en     => TX_FIFO_wr_en,
      TX_FIFO_rd_en     => TX_FIFO_rd_en,
      TX_FIFO_DOUT      => TX_FIFO_DOUT,
      TX_FIFO_AE        => TX_FIFO_AE,
      TX_FIFO_Empty     => TX_FIFO_Empty,
      TX_FIFO_Full      => TX_FIFO_Full,
      TX_FIFO_AF        => TX_FIFO_AF,
      TX_FIFO_OVERFLOW  => TX_FIFO_OVERFLOW,
      TX_FIFO_UNDERRUN  => TX_FIFO_UNDERRUN,
      TX_FIFO_RST       => TX_FIFO_RST,
      RX_FIFO_wr_clk    => clk,
      RX_FIFO_rd_clk    => APB3_CLK,
      RX_FIFO_wr_en     => RX_FIFO_TxColDetDis_wr_en,  --RX_FIFO_wr_en,
      RX_FIFO_rd_en     => RX_FIFO_rd_en,
      RX_FIFO_DIN       => RX_FIFO_DIN_pipe,
      RX_FIFO_DOUT      => RX_FIFO_DOUT,
      RX_FIFO_Empty     => RX_FIFO_Empty,
      RX_FIFO_Full      => RX_FIFO_Full,
      RX_FIFO_OVERFLOW  => RX_FIFO_OVERFLOW, 
      RX_FIFO_UNDERRUN  => RX_FIFO_UNDERRUN,
      RX_FIFO_RST       => RX_FIFO_RST,
	  rx_packet_complt  => rx_packet_complt,
	  clk16x            => clk,
	  rx_packet_avail_int => rx_packet_avail_int,
	  up_EOP_CntDown_en => up_EOP_CntDown_en 		-- out gwc 080217 increment FIFO read pointer
    ); 

--------------------------------------------------------------------------------
-- Manchester Encoder
---------1---------2---------3---------4---------5---------6---------7---------8
-- The Encoder is responsible for accepting packets from the processor 
-- (via the Transmit FIFO) and transmitting them on to the iRail. The Encoder 
-- provides Timing Generation, Parallel to Serial Conversion, Preamble and 
-- Postamble Generation, CRC Generation and Manchester Encoding.
---------1---------2---------3---------4---------5---------6---------7---------8 
     
  MANCHESTER_ENCODER_INST : entity work.ManchesEncoder
  Generic Map(
    START_BYTE_SYMBOL     => START_BYTE_SYMBOL,
    PREAMBLE_LENGTH       => PREAMBLE_LENGTH,
    POSTAMBLE_LENGTH      => POSTAMBLE_LENGTH 
  )
    Port Map(
      reset               => reset,
      clk16x              => clk,      
  	  bit_clk2x           => CLK_2xBIT_10MHz,
      byte_clk_en         => byte_clk_en, 
  	  CLK_BIT_5MHz        => BIT_CLK,
  	  manches_in_dly      => manches_in_dly,
  	  start_tx_FIFO       => start_tx_FIFO,
  	  TX_FIFO_rd_en       => TX_FIFO_rd_en,
  	  TX_FIFO_Empty       => TX_FIFO_Empty,
  	  TX_Enable           => TX_Enable,
  	  TX_PreAmble         => TX_PreAmble,
  	  TX_FIFO_DOUT        => TX_FIFO_DOUT,
  	  tx_packet_complt    => tx_packet_complt,
      RX_FIFO_wr_clk      => clk,
      RX_FIFO_wr_en       => RX_FIFO_wr_en,
      RX_FIFO_DIN         => RX_FIFO_DIN,   --RX_FIFO_DIN_pipe,
      rx_crc_Byte_en      => rx_crc_Byte_en,
      tx_col_detect_en    => tx_col_detect_en,
      TX_collision_detect => TX_collision_detect,
      internal_loopback   => internal_loopback,
      external_loopback   => external_loopback,
      MANCHESTER_OUT      => iMANCH_OUT_P
    );

--------------------------------------------------------------------------------  
 -- Manchester Decoder
---------1---------2---------3---------4---------5---------6---------7---------8
-- The Decoder is responsible for accepting packets from the iRail and pushing
-- them on to the Receive FIFO and then interrupting the processor. The Decoder
-- provides Receive Timing Recovery, Manchester Decoding, Serial to Parallel 
-- Conversion, Preamble Detection, and Collision Detection.
---------1---------2---------3---------4---------5---------6---------7---------8 
   
MANCHESTER_DECODER_INST : entity work.ManchesDecoder
  Generic Map(
    START_BYTE_SYMBOL     => START_BYTE_SYMBOL
  )
  Port Map(
    rst                   => RESET,
    clk16x                => CLK,
    manches_in_dly        => manches_in_dly,
    RX_FIFO_TxColDetDis_wr_en     => RX_FIFO_TxColDetDis_wr_en,  -- Allows TX Collision Detection    
    RX_FIFO_wr_en         => RX_FIFO_wr_en,
    RX_FIFO_DIN           => RX_FIFO_DIN,
    RX_FIFO_DIN_pipe      => RX_FIFO_DIN_pipe,
    RX_FIFO_Empty         => RX_FIFO_Empty,
    MANCHESTER_IN         => MANCHESTER_IN,
    MANCH_OUT_P           => iMANCH_OUT_P,
    consumer_type1_reg    => consumer_type1_reg,
    consumer_type2_reg    => consumer_type2_reg,
    consumer_type3_reg    => consumer_type3_reg,
    consumer_type4_reg    => consumer_type4_reg,
    internal_loopback     => internal_loopback,
    rx_crc_Byte_en        => rx_crc_Byte_en,
    TX_collision_detect   => TX_collision_detect, 
	  rx_packet_avail       => rx_packet_avail,
	  rx_packet_end         => rx_packet_end,
	  rx_packet_complt      => rx_packet_complt,
	  rx_CRC_error          => rx_CRC_error,
	  RX_EarlyTerm          => RX_EarlyTerm,
	  TX_Enable             => TX_Enable,
	  tx_col_detect_en      => tx_col_detect_en
  );
        
end Behavioral;
