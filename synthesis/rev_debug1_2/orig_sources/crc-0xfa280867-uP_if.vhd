----------------------------------------------------------------------------------
-- Company:       Prototype Performance Incorporated
-- Engineer:      Scott Walker
-- 
-- Create Date:   17 August 2014 
-- Design Name:   Powered Rail Performance Tester
-- Module Name:   uP_if.vhd - Behavioral 
-- Project Name:  Powered Rail Performance Tester
-- Target Devices:TBD
-- Description:   
--     The Processor Interface provides the means for the processor to communicate 
--     with the FPGA logic.  This is communication path, or bus, utilizes a 
--     standard interface referred to as the ARM Advanced Microcontroller Bus 
--     Architecture (AMBA).  AMBA is an open-standard, on-chip interconnect 
--     specification for the connection and management of functional blocks in 
--     (SoC) designs. It facilitates development of multi-processor designs with 
--     large numbers of controllers and peripherals.  This interface consists of an 
--     address bus, control signals and an 8-bit data bus.  Furthermore, the 
--     processor interface supports address decoding, data bus interface, 
--     status/control registers and interrupt control.
--  Address	Description
--  0x0	    
--  0x1	    
--  0x2	    
--  0x3	    
--  0x4	    
--  0x5	    
--  0x6	    
--  0x7	    
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd                   <=
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
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY uP_if IS
  PORT (
    rst               : in  std_logic;
    APB3_CLK          : in  std_logic;  -- Free running clock
    APB3_RESET        : in  std_logic;
    APB3_SEL          : in  std_logic;
    APB3_ENABLE       : in  std_logic;
    APB3_ADDR         : in  std_logic_vector(7 downto 0); 
    APB3_WDATA        : in  std_logic_vector(7 downto 0);
    APB3_RDATA        : out std_logic_vector(7 downto 0);
    APB3_READY        : out std_logic;
    APB3_WRITE        : in  std_logic;
    clk16x            : in  std_logic;
    start_tx_FIFO     : out std_logic;
    internal_loopback : out std_logic;
    external_loopback : out std_logic;
    TX_PreAmble       : in  std_logic;
    TX_FIFO_wr_en     : out std_logic;
    RX_FIFO_rd_en     : out std_logic;
    RX_FIFO_DOUT      : in  std_logic_vector (8 downto 0);
    TX_FIFO_RST       : out std_logic;
    RX_FIFO_RST       : out std_logic;
    RX_FIFO_OVERFLOW  : in  std_logic;
    RX_FIFO_UNDERRUN  : in  std_logic;
    TX_FIFO_OVERFLOW  : in  std_logic;
    TX_FIFO_UNDERRUN  : in  std_logic;
    rx_CRC_error      : in  std_logic;
    INT               : out std_logic;
-- DELETE below 4 lines when converting to MAC address
    consumer_type1_reg: out std_logic_vector (9 downto 0);
    consumer_type2_reg: out std_logic_vector (9 downto 0);
    consumer_type3_reg: out std_logic_vector (9 downto 0);
    consumer_type4_reg: out std_logic_vector (9 downto 0);
-- ADD below 4 lines when converting to MAC address
--    MAC_1_address     : out std_logic_vector (47 downto 0);
--    MAC_2_address     : out std_logic_vector (47 downto 0);
--    MAC_3_address     : out std_logic_vector (47 downto 0);
--    MAC_4_address     : out std_logic_vector (47 downto 0);
    tx_packet_complt  : in  std_logic;
    rx_packet_complt  : in  std_logic;
    col_detect        : in  std_logic;
    TX_FIFO_Full      : in  std_logic;
    TX_FIFO_Empty     : in  std_logic;
    RX_FIFO_Full      : in  std_logic;
    RX_FIFO_Empty     : in  std_logic;
	rx_packet_avail_int : out  std_logic;
	up_EOP			  : out std_logic;	
	FIFO_Ptr_Err      : in std_logic
  );
      
END uP_if;

ARCHITECTURE Behavioral OF uP_if IS

-- Constants
  constant REVISION_NUM        : std_logic_vector(7 downto 0) := "00010110";	-- gwc 1.6 is the beginning for iRail 2.0
  constant VERSION_REG_C       : std_logic_vector(7 downto 0) := "00000000";
  constant SCRATCH_PAD_REG_C   : std_logic_vector(7 downto 0) := "00000100";
  constant TX_FIFO_REG_C       : std_logic_vector(7 downto 0) := "00001000";
  constant RX_FIFO_REG_C       : std_logic_vector(7 downto 0) := "00001100";
  constant CONTROL_REG_C       : std_logic_vector(7 downto 0) := "00010000";
  constant INTR_REG_C          : std_logic_vector(7 downto 0) := "00010100";
  constant INTR_MASK_REG_C     : std_logic_vector(7 downto 0) := "00011000";
  constant STATUS_REG_C        : std_logic_vector(7 downto 0) := "00011100";
  constant BT_USB_STAT_C       : std_logic_vector(7 downto 0) := "00101000";
  constant MAC_1_BYTE_1_C      : std_logic_vector(7 downto 0) := "00110000";
  constant MAC_1_BYTE_2_C      : std_logic_vector(7 downto 0) := "00110100";
  constant MAC_1_BYTE_3_C      : std_logic_vector(7 downto 0) := "00111000";
  constant MAC_1_BYTE_4_C      : std_logic_vector(7 downto 0) := "00111100";
  constant MAC_1_BYTE_5_C      : std_logic_vector(7 downto 0) := "01000000";
  constant MAC_1_BYTE_6_C      : std_logic_vector(7 downto 0) := "01000100";
  constant MAC_2_BYTE_1_C      : std_logic_vector(7 downto 0) := "01001000";
  constant MAC_2_BYTE_2_C      : std_logic_vector(7 downto 0) := "01001100";
  constant MAC_2_BYTE_3_C      : std_logic_vector(7 downto 0) := "01010000";
  constant MAC_2_BYTE_4_C      : std_logic_vector(7 downto 0) := "01010100";
  constant MAC_2_BYTE_5_C      : std_logic_vector(7 downto 0) := "01011000";
  constant MAC_2_BYTE_6_C      : std_logic_vector(7 downto 0) := "01011100";
  constant MAC_3_BYTE_1_C      : std_logic_vector(7 downto 0) := "01100000";
  constant MAC_3_BYTE_2_C      : std_logic_vector(7 downto 0) := "01100100";
  constant MAC_3_BYTE_3_C      : std_logic_vector(7 downto 0) := "01101000";
  constant MAC_3_BYTE_4_C      : std_logic_vector(7 downto 0) := "01101100";
  constant MAC_3_BYTE_5_C      : std_logic_vector(7 downto 0) := "01110000";
  constant MAC_3_BYTE_6_C      : std_logic_vector(7 downto 0) := "01110100";  
  constant MAC_4_BYTE_1_C      : std_logic_vector(7 downto 0) := "01111000";
  constant MAC_4_BYTE_2_C      : std_logic_vector(7 downto 0) := "01111100";
  constant MAC_4_BYTE_3_C      : std_logic_vector(7 downto 0) := "10000000";
  constant MAC_4_BYTE_4_C      : std_logic_vector(7 downto 0) := "10000100";
  constant MAC_4_BYTE_5_C      : std_logic_vector(7 downto 0) := "10001000";
  constant MAC_4_BYTE_6_C      : std_logic_vector(7 downto 0) := "10001100";  
 
-- Signals
  signal apb3_wr_en            : std_logic;
  signal apb3_rd_en            : std_logic;
  signal apb3_rst              : std_logic;
  signal iAPB3_READY           : std_logic_vector(1 downto 0);
  signal iTX_FIFO_wr_en        : std_logic;
  signal scratch_pad_reg       : std_logic_vector(7 downto 0);
  signal control_reg           : std_logic_vector(7 downto 0);
  signal write_scratch_reg_en  : std_logic;
  signal status_reg            : std_logic_vector(7 downto 0);
  signal control_reg_en        : std_logic;
  signal int_mask_reg_en       : std_logic;
  signal read_reg_en           : std_logic;
  signal write_reg_en          : std_logic;
  signal iRX_FIFO_rd_en        : std_logic;
  signal i_int_mask_reg        : std_logic_vector(7 downto 0);
  signal int_reg               : std_logic_vector(7 downto 0);
  
  signal mac_1_byte_1_reg_en   : std_logic;
  signal mac_1_byte_1_reg      : std_logic_vector(7 downto 0);
  signal mac_1_byte_2_reg_en   : std_logic;
  signal mac_1_byte_2_reg      : std_logic_vector(7 downto 0);
  signal mac_1_byte_3_reg_en   : std_logic;
  signal mac_1_byte_3_reg      : std_logic_vector(7 downto 0);
  signal mac_1_byte_4_reg_en   : std_logic;
  signal mac_1_byte_4_reg      : std_logic_vector(7 downto 0);
  signal mac_1_byte_5_reg_en   : std_logic;
  signal mac_1_byte_5_reg      : std_logic_vector(7 downto 0);
  signal mac_1_byte_6_reg_en   : std_logic;
  signal mac_1_byte_6_reg      : std_logic_vector(7 downto 0);
  signal mac_2_byte_1_reg_en   : std_logic;
  signal mac_2_byte_1_reg      : std_logic_vector(7 downto 0);
  signal mac_2_byte_2_reg_en   : std_logic;
  signal mac_2_byte_2_reg      : std_logic_vector(7 downto 0);
  signal mac_2_byte_3_reg_en   : std_logic;
  signal mac_2_byte_3_reg      : std_logic_vector(7 downto 0);
  signal mac_2_byte_4_reg_en   : std_logic;
  signal mac_2_byte_4_reg      : std_logic_vector(7 downto 0);
  signal mac_2_byte_5_reg_en   : std_logic;
  signal mac_2_byte_5_reg      : std_logic_vector(7 downto 0);
  signal mac_2_byte_6_reg_en   : std_logic;
  signal mac_2_byte_6_reg      : std_logic_vector(7 downto 0);
  signal mac_3_byte_1_reg_en   : std_logic;
  signal mac_3_byte_1_reg      : std_logic_vector(7 downto 0);
  signal mac_3_byte_2_reg_en   : std_logic;
  signal mac_3_byte_2_reg      : std_logic_vector(7 downto 0);
  signal mac_3_byte_3_reg_en   : std_logic;
  signal mac_3_byte_3_reg      : std_logic_vector(7 downto 0);
  signal mac_3_byte_4_reg_en   : std_logic;
  signal mac_3_byte_4_reg      : std_logic_vector(7 downto 0);
  signal mac_3_byte_5_reg_en   : std_logic;
  signal mac_3_byte_5_reg      : std_logic_vector(7 downto 0);
  signal mac_3_byte_6_reg_en   : std_logic;
  signal mac_3_byte_6_reg      : std_logic_vector(7 downto 0);
  signal mac_4_byte_1_reg_en   : std_logic;
  signal mac_4_byte_1_reg      : std_logic_vector(7 downto 0);
  signal mac_4_byte_2_reg_en   : std_logic;
  signal mac_4_byte_2_reg      : std_logic_vector(7 downto 0);
  signal mac_4_byte_3_reg_en   : std_logic;
  signal mac_4_byte_3_reg      : std_logic_vector(7 downto 0);
  signal mac_4_byte_4_reg_en   : std_logic;
  signal mac_4_byte_4_reg      : std_logic_vector(7 downto 0);
  signal mac_4_byte_5_reg_en   : std_logic;
  signal mac_4_byte_5_reg      : std_logic_vector(7 downto 0);
  signal mac_4_byte_6_reg_en   : std_logic;
  signal mac_4_byte_6_reg      : std_logic_vector(7 downto 0);
          
--  signal up_EOP                : std_logic;
  signal iup_EOP               : std_logic;
  signal up_EOP_sync           : std_logic_vector(2 downto 0);
  signal iup_EOP_CntDown_en    : std_logic;
  signal RX_packet_depth       : std_logic_vector(7 downto 0);
  signal RX_packet_depth_status: std_logic;
  
   
-- debug
  signal Pkt_Depth_TX_Err	 : std_logic;
  signal RX_packet_depth_d1       : std_logic_vector(7 downto 0);
  signal RX_packet_depth_d2       : std_logic_vector(7 downto 0);
  

BEGIN

-- ADD below 8 lines when converting to MAC address
--  MAC_1_address <= mac_1_byte_6_reg & mac_1_byte_5_reg & mac_1_byte_4_reg
--                   mac_1_byte_3_reg & mac_1_byte_2_reg & mac_1_byte_1_reg;
--  MAC_2_address <= mac_2_byte_6_reg & mac_2_byte_5_reg & mac_2_byte_4_reg
--                   mac_2_byte_3_reg & mac_2_byte_2_reg & mac_2_byte_1_reg;
--  MAC_3_address <= mac_3_byte_6_reg & mac_3_byte_5_reg & mac_3_byte_4_reg
--                   mac_3_byte_3_reg & mac_3_byte_2_reg & mac_3_byte_1_reg;
--  MAC_4_address <= mac_4_byte_6_reg & mac_4_byte_5_reg & mac_4_byte_4_reg
--                   mac_4_byte_3_reg & mac_4_byte_2_reg & mac_4_byte_1_reg;

  TX_FIFO_RST       <= control_reg(7);
  RX_FIFO_RST       <= control_reg(6);
  start_tx_FIFO     <= control_reg(5);
  internal_loopback <= control_reg(4);
  up_EOP <= iup_EOP;		-- gwc 080417
  --    <= control_reg(3);
  --    <= control_reg(2);
  external_loopback <= control_reg(1);   

  consumer_type1_reg <= mac_1_byte_1_reg(1 downto 0) & mac_1_byte_2_reg;
  consumer_type2_reg <= mac_1_byte_3_reg(1 downto 0) & mac_1_byte_4_reg;
  consumer_type3_reg <= mac_1_byte_5_reg(1 downto 0) & mac_1_byte_6_reg;
  consumer_type4_reg <= mac_2_byte_1_reg(1 downto 0) & mac_2_byte_2_reg;

  status_reg        <= FIFO_Ptr_Err
							  & Pkt_Depth_TX_Err
							  & '0'
							  & RX_packet_depth_status
                              & TX_FIFO_Full & TX_FIFO_Empty 
                              & RX_FIFO_Full & RX_FIFO_Empty;
   
  RX_FIFO_rd_en  <= iRX_FIFO_rd_en;
  TX_FIFO_wr_en  <= iTX_FIFO_wr_en after 1ns;
  APB3_READY     <= iAPB3_READY(1);
  
  apb3_wr_en     <= APB3_SEL and APB3_ENABLE and APB3_WRITE;
  apb3_rd_en     <= APB3_SEL and APB3_ENABLE and not APB3_WRITE;
  apb3_rst       <= not apb3_wr_en and not apb3_rd_en;
  
--------------------------------------------------------------------------------
-- Interrupt Instantiation
---------1---------2---------3---------4---------5---------6---------7---------8
  INTERRUPT_INST : entity work.Interrupts
    Port Map(
      rst                 => rst,
      clk16x              => clk16x,
      APB3_RESET          => APB3_RESET,
      APB3_CLK            => APB3_CLK,
      APB3_ADDR           => APB3_ADDR,
      APB3_WDATA          => APB3_WDATA,
      write_reg_en        => write_reg_en,
      tx_packet_complt    => tx_packet_complt,
-- gwc      rx_packet_complt    => rx_packet_complt,
      RX_packet_depth_status    => RX_packet_depth_status,
      TX_FIFO_UNDERRUN    => TX_FIFO_UNDERRUN,
      TX_FIFO_OVERFLOW    => TX_FIFO_OVERFLOW,
      RX_FIFO_UNDERRUN    => RX_FIFO_UNDERRUN,
      RX_FIFO_OVERFLOW    => RX_FIFO_OVERFLOW,
      col_detect          => col_detect,
      rx_CRC_error        => rx_CRC_error,
      int_mask_reg        => i_int_mask_reg,
      int_reg             => int_reg,
      INT                 => INT,
	  rx_packet_avail_int => rx_packet_avail_int,
	  up_EOP			  => up_EOP			-- gwc 080417
    );

--------------------------------------------------------------------------------
-- APB3_READY Delay by 1 APB3_CLK
---------1---------2---------3---------4---------5---------6---------7---------8  
  READY_DELAY_PROC :  PROCESS (APB3_CLK, APB3_RESET, apb3_rst)
    begin
      if ( APB3_RESET = '1' ) then
        iAPB3_READY    <= (others => '1');
      elsif ( apb3_rst = '1' ) then
        iAPB3_READY    <= (others => '0');
      else  
        if ( rising_edge( APB3_CLK ) ) then
          iAPB3_READY    <= iAPB3_READY(0) & (apb3_wr_en or apb3_rd_en); 
        end if;
      end if;  
    end process; 

--------------------------------------------------------------------------------
-- Write Register Enable Generation
---------1---------2---------3---------4---------5---------6---------7---------8  
  WRITE_REGISTER_GEN_PROC :  PROCESS (APB3_CLK, APB3_RESET, apb3_wr_en)
    begin
      if ( APB3_RESET = '1' or apb3_wr_en = '0') then
        write_reg_en    <= '0';
      elsif ( rising_edge( APB3_CLK ) ) then
        write_reg_en    <= apb3_wr_en; 
      else
        write_reg_en    <= write_reg_en;      
      end if; 
    end process;  
    
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Write Register
--------------------------------------------------------------------------------
---------1---------2---------3---------4---------5---------6---------7---------8  

--------------------------------------------------------------------------------
-- Write Register Selection - Single pulse from APB3_CLK, required for FIFO
---------1---------2---------3---------4---------5---------6---------7---------8  
  WRITE_REGISTER_ENABLE_PROC :  PROCESS (APB3_CLK, APB3_RESET, apb3_wr_en)
    begin
      if ( APB3_RESET = '1' or apb3_wr_en = '0') then
        write_scratch_reg_en    <= '0'; 
        iTX_FIFO_wr_en          <= '0';
        control_reg_en          <= '0';
        int_mask_reg_en         <= '0';
        mac_1_byte_1_reg_en     <= '0';
        mac_1_byte_2_reg_en     <= '0';
        mac_1_byte_3_reg_en     <= '0';
        mac_1_byte_4_reg_en     <= '0';
        mac_1_byte_5_reg_en     <= '0';
        mac_1_byte_6_reg_en     <= '0';
        mac_2_byte_1_reg_en     <= '0';
        mac_2_byte_2_reg_en     <= '0';
        mac_2_byte_3_reg_en     <= '0';
        mac_2_byte_4_reg_en     <= '0';
        mac_2_byte_5_reg_en     <= '0';
        mac_2_byte_6_reg_en     <= '0';
        mac_3_byte_1_reg_en     <= '0';
        mac_3_byte_2_reg_en     <= '0';
        mac_3_byte_3_reg_en     <= '0';
        mac_3_byte_4_reg_en     <= '0';
        mac_3_byte_5_reg_en     <= '0';
        mac_3_byte_6_reg_en     <= '0';
        mac_4_byte_1_reg_en     <= '0';
        mac_4_byte_2_reg_en     <= '0';
        mac_4_byte_3_reg_en     <= '0';
        mac_4_byte_4_reg_en     <= '0';
        mac_4_byte_5_reg_en     <= '0';
        mac_4_byte_6_reg_en     <= '0';
      elsif  ( rising_edge( APB3_CLK ) ) then
        if ( APB3_ADDR = SCRATCH_PAD_REG_C ) then
          write_scratch_reg_en  <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = TX_FIFO_REG_C ) then
          iTX_FIFO_wr_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = CONTROL_REG_C ) then
          control_reg_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = INTR_MASK_REG_C ) then
          int_mask_reg_en       <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_1_BYTE_1_C ) then 
          mac_1_byte_1_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_1_BYTE_2_C ) then 
          mac_1_byte_2_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_1_BYTE_3_C ) then 
          mac_1_byte_3_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_1_BYTE_4_C ) then 
          mac_1_byte_4_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_1_BYTE_5_C ) then 
          mac_1_byte_5_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_1_BYTE_6_C ) then 
          mac_1_byte_6_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_2_BYTE_1_C ) then 
          mac_2_byte_1_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_2_BYTE_2_C ) then 
          mac_2_byte_2_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_2_BYTE_3_C ) then 
          mac_2_byte_3_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_2_BYTE_4_C ) then 
          mac_2_byte_4_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_2_BYTE_5_C ) then 
          mac_2_byte_5_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_2_BYTE_6_C ) then 
          mac_2_byte_6_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_3_BYTE_1_C ) then 
          mac_3_byte_1_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_3_BYTE_2_C ) then 
          mac_3_byte_2_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_3_BYTE_3_C ) then 
          mac_3_byte_3_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_3_BYTE_4_C ) then 
          mac_3_byte_4_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_3_BYTE_5_C ) then 
          mac_3_byte_5_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_3_BYTE_6_C ) then 
          mac_3_byte_6_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_4_BYTE_1_C ) then 
          mac_4_byte_1_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_4_BYTE_2_C ) then 
          mac_4_byte_2_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_4_BYTE_3_C ) then 
          mac_4_byte_3_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_4_BYTE_4_C ) then 
          mac_4_byte_4_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_4_BYTE_5_C ) then 
          mac_4_byte_5_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = MAC_4_BYTE_6_C ) then 
          mac_4_byte_6_reg_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        else
          write_scratch_reg_en  <= write_scratch_reg_en; 
          iTX_FIFO_wr_en        <= iTX_FIFO_wr_en;
          control_reg_en        <= control_reg_en;
          int_mask_reg_en       <= int_mask_reg_en;
          mac_1_byte_1_reg_en   <= mac_1_byte_1_reg_en;
          mac_1_byte_2_reg_en   <= mac_1_byte_2_reg_en;
          mac_1_byte_3_reg_en   <= mac_1_byte_3_reg_en;
          mac_1_byte_4_reg_en   <= mac_1_byte_4_reg_en;
          mac_1_byte_5_reg_en   <= mac_1_byte_5_reg_en;
          mac_1_byte_6_reg_en   <= mac_1_byte_6_reg_en;
          mac_2_byte_1_reg_en   <= mac_2_byte_1_reg_en;
          mac_2_byte_2_reg_en   <= mac_2_byte_2_reg_en;
          mac_2_byte_3_reg_en   <= mac_2_byte_3_reg_en;
          mac_2_byte_4_reg_en   <= mac_2_byte_4_reg_en;
          mac_2_byte_5_reg_en   <= mac_2_byte_5_reg_en;
          mac_2_byte_6_reg_en   <= mac_2_byte_6_reg_en;
          mac_3_byte_1_reg_en   <= mac_3_byte_1_reg_en;
          mac_3_byte_2_reg_en   <= mac_3_byte_2_reg_en;
          mac_3_byte_3_reg_en   <= mac_3_byte_3_reg_en;
          mac_3_byte_4_reg_en   <= mac_3_byte_4_reg_en;
          mac_3_byte_5_reg_en   <= mac_3_byte_5_reg_en;
          mac_3_byte_6_reg_en   <= mac_3_byte_6_reg_en;
          mac_4_byte_1_reg_en   <= mac_4_byte_1_reg_en;
          mac_4_byte_2_reg_en   <= mac_4_byte_2_reg_en;
          mac_4_byte_3_reg_en   <= mac_4_byte_3_reg_en;
          mac_4_byte_4_reg_en   <= mac_4_byte_4_reg_en;
          mac_4_byte_5_reg_en   <= mac_4_byte_5_reg_en;
          mac_4_byte_6_reg_en   <= mac_4_byte_6_reg_en;
        end if;
      end if;  
    end process;  

--------------------------------------------------------------------------------
-- Register Write Process
---------1---------2---------3---------4---------5---------6---------7---------8
  REG_WRITE_PROC :  PROCESS (APB3_CLK, APB3_RESET)
    begin
        if ( APB3_RESET = '1' ) then
          scratch_pad_reg    <= (others => '0');  
          control_reg        <= (others => '0');
          i_int_mask_reg     <= (others => '0');
          mac_1_byte_1_reg   <= (others => '0');
          mac_1_byte_2_reg   <= (others => '0');
          mac_1_byte_3_reg   <= (others => '0');
          mac_1_byte_4_reg   <= (others => '0');
          mac_1_byte_5_reg   <= (others => '0');
          mac_1_byte_6_reg   <= (others => '0');
          mac_2_byte_1_reg   <= (others => '0');
          mac_2_byte_2_reg   <= (others => '0');
          mac_2_byte_3_reg   <= (others => '0');
          mac_2_byte_4_reg   <= (others => '0');
          mac_2_byte_5_reg   <= (others => '0');
          mac_2_byte_6_reg   <= (others => '0');
          mac_3_byte_1_reg   <= (others => '0');
          mac_3_byte_2_reg   <= (others => '0');
          mac_3_byte_3_reg   <= (others => '0');
          mac_3_byte_4_reg   <= (others => '0');
          mac_3_byte_5_reg   <= (others => '0');
          mac_3_byte_6_reg   <= (others => '0');
          mac_4_byte_1_reg   <= (others => '0');
          mac_4_byte_2_reg   <= (others => '0');
          mac_4_byte_3_reg   <= (others => '0');
          mac_4_byte_4_reg   <= (others => '0');
          mac_4_byte_5_reg   <= (others => '0');
          mac_4_byte_6_reg   <= (others => '0');
        elsif ( rising_edge( APB3_CLK ) ) then
          if (write_scratch_reg_en = '1') then
            scratch_pad_reg    <= APB3_WDATA;
          elsif (control_reg_en = '1') then 
            control_reg        <= APB3_WDATA; 
          elsif (int_mask_reg_en = '1') then
            i_int_mask_reg     <= APB3_WDATA;            
          elsif ( mac_1_byte_1_reg_en = '1') then
            mac_1_byte_1_reg   <= APB3_WDATA;
          elsif ( mac_1_byte_2_reg_en = '1') then
            mac_1_byte_2_reg   <= APB3_WDATA;
          elsif ( mac_1_byte_3_reg_en = '1') then
            mac_1_byte_3_reg   <= APB3_WDATA;
          elsif ( mac_1_byte_4_reg_en = '1') then
            mac_1_byte_4_reg   <= APB3_WDATA;
          elsif ( mac_1_byte_5_reg_en = '1') then
            mac_1_byte_5_reg   <= APB3_WDATA;
          elsif ( mac_1_byte_6_reg_en = '1') then
            mac_1_byte_6_reg   <= APB3_WDATA;
          elsif ( mac_2_byte_1_reg_en = '1') then
            mac_2_byte_1_reg   <= APB3_WDATA;
          elsif ( mac_2_byte_2_reg_en = '1') then
            mac_2_byte_2_reg   <= APB3_WDATA;
          elsif ( mac_2_byte_3_reg_en = '1') then
            mac_2_byte_3_reg   <= APB3_WDATA;
          elsif ( mac_2_byte_4_reg_en = '1') then
            mac_2_byte_4_reg   <= APB3_WDATA;
          elsif ( mac_2_byte_5_reg_en = '1') then
            mac_2_byte_5_reg   <= APB3_WDATA;
          elsif ( mac_2_byte_6_reg_en = '1') then
            mac_2_byte_6_reg   <= APB3_WDATA;
          elsif ( mac_3_byte_1_reg_en = '1') then
            mac_3_byte_1_reg   <= APB3_WDATA;
          elsif ( mac_3_byte_2_reg_en = '1') then
            mac_3_byte_2_reg   <= APB3_WDATA;
          elsif ( mac_3_byte_3_reg_en = '1') then
            mac_3_byte_3_reg   <= APB3_WDATA;
          elsif ( mac_3_byte_4_reg_en = '1') then
            mac_3_byte_4_reg   <= APB3_WDATA;
          elsif ( mac_3_byte_5_reg_en = '1') then
            mac_3_byte_5_reg   <= APB3_WDATA;
          elsif ( mac_3_byte_6_reg_en = '1') then
            mac_3_byte_6_reg   <= APB3_WDATA;
          elsif ( mac_4_byte_1_reg_en = '1') then
            mac_4_byte_1_reg   <= APB3_WDATA;
          elsif ( mac_4_byte_2_reg_en = '1') then
            mac_4_byte_2_reg   <= APB3_WDATA;
          elsif ( mac_4_byte_3_reg_en = '1') then
            mac_4_byte_3_reg   <= APB3_WDATA;
          elsif ( mac_4_byte_4_reg_en = '1') then
            mac_4_byte_4_reg   <= APB3_WDATA;
          elsif ( mac_4_byte_5_reg_en = '1') then
            mac_4_byte_5_reg   <= APB3_WDATA;
          elsif ( mac_4_byte_6_reg_en = '1') then
            mac_4_byte_6_reg   <= APB3_WDATA;
          else
            scratch_pad_reg    <= scratch_pad_reg;
            if ( TX_PreAmble = '1') then
              control_reg      <= control_reg and x"DF";  
            else
              control_reg      <= control_reg;
            end if;
          end if; 
        end if; 
    end process;

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- Read Register
--------------------------------------------------------------------------------
---------1---------2---------3---------4---------5---------6---------7---------8  
        
--------------------------------------------------------------------------------
-- Read Register Enable Generation
---------1---------2---------3---------4---------5---------6---------7---------8  
  READ_REGISTER_ENABLE_PROC :  PROCESS (APB3_CLK, APB3_RESET, apb3_rd_en)
    begin
      if ( APB3_RESET = '1' or apb3_rd_en = '0') then
        read_reg_en    <= '0';
      elsif ( rising_edge( APB3_CLK ) ) then
        read_reg_en    <= apb3_rd_en; 
      else
        read_reg_en    <= read_reg_en;      
      end if; 
    end process;  
      
--------------------------------------------------------------------------------
-- Read Register Selection - Single pulse from APB3_CLK, required for FIFO
---------1---------2---------3---------4---------5---------6---------7---------8  
  READ_FIFO_ENABLE_PROC :  PROCESS (APB3_CLK, APB3_RESET, apb3_rd_en)
    begin
      if ( APB3_RESET = '1' or apb3_rd_en = '0') then
        iRX_FIFO_rd_en    <= '0';
      elsif ( rising_edge( APB3_CLK ) ) then
        if ( APB3_ADDR = RX_FIFO_REG_C ) then
          iRX_FIFO_rd_en  <= apb3_rd_en and not iAPB3_READY(0);     
        else
          iRX_FIFO_rd_en  <= iRX_FIFO_rd_en;
        end if;
      end if; 
    end process; 
    
--------------------------------------------------------------------------------
-- Read Registers
---------1---------2---------3---------4---------5---------6---------7---------8
    REG_READ_PROC: PROCESS (APB3_RESET, APB3_ADDR, read_reg_en, 
                            scratch_pad_reg, RX_FIFO_DOUT, apb3_rd_en,int_reg)
    begin
        if ( APB3_RESET = '1' and apb3_rd_en = '0') then
          APB3_RDATA   <= (others => '1');
        elsif ( read_reg_en = '1' ) then
          CASE APB3_ADDR IS
            when VERSION_REG_C =>     -- Revision Register
              APB3_RDATA <= REVISION_NUM; -- x"10";
            when SCRATCH_PAD_REG_C =>     -- Scratch Pad Register
              APB3_RDATA <= RX_packet_depth; -- scratch_pad_reg;
--          when TX_FIFO_REG_C =>     -- 
            when RX_FIFO_REG_C =>     -- Receive FIFO Read Port
              APB3_RDATA <= RX_FIFO_DOUT(7 downto 0);             
            when CONTROL_REG_C =>     -- Control Register
              APB3_RDATA <= control_reg;
            when INTR_REG_C =>     -- Interrupt Register
              APB3_RDATA <= int_reg;
            when INTR_MASK_REG_C =>
              APB3_RDATA <= i_int_mask_reg;
            when STATUS_REG_C =>
              APB3_RDATA <= status_reg;
            when MAC_1_BYTE_1_C =>
              APB3_RDATA <= mac_1_byte_1_reg;
            when MAC_1_BYTE_2_C =>
              APB3_RDATA <= mac_1_byte_2_reg;
            when MAC_1_BYTE_3_C =>
              APB3_RDATA <= mac_1_byte_3_reg;
            when MAC_1_BYTE_4_C =>
              APB3_RDATA <= mac_1_byte_4_reg;
            when MAC_1_BYTE_5_C =>
              APB3_RDATA <= mac_1_byte_5_reg;
            when MAC_1_BYTE_6_C =>
              APB3_RDATA <= mac_1_byte_6_reg;
            when MAC_2_BYTE_1_C =>
              APB3_RDATA <= mac_2_byte_1_reg;
            when MAC_2_BYTE_2_C =>
              APB3_RDATA <= mac_2_byte_2_reg;
            when MAC_2_BYTE_3_C =>
              APB3_RDATA <= mac_2_byte_3_reg;
            when MAC_2_BYTE_4_C =>
              APB3_RDATA <= mac_2_byte_4_reg;
            when MAC_2_BYTE_5_C =>
              APB3_RDATA <= mac_2_byte_5_reg;
            when MAC_2_BYTE_6_C =>
              APB3_RDATA <= mac_2_byte_6_reg;
            when MAC_3_BYTE_1_C =>
              APB3_RDATA <= mac_3_byte_1_reg;
            when MAC_3_BYTE_2_C =>
              APB3_RDATA <= mac_3_byte_2_reg;
            when MAC_3_BYTE_3_C =>
              APB3_RDATA <= mac_3_byte_3_reg;
            when MAC_3_BYTE_4_C =>
              APB3_RDATA <= mac_3_byte_4_reg;
            when MAC_3_BYTE_5_C =>
              APB3_RDATA <= mac_3_byte_5_reg;
            when MAC_3_BYTE_6_C =>
              APB3_RDATA <= mac_3_byte_6_reg;
            when MAC_4_BYTE_1_C =>
              APB3_RDATA <= mac_4_byte_1_reg;
            when MAC_4_BYTE_2_C =>
              APB3_RDATA <= mac_4_byte_2_reg;
            when MAC_4_BYTE_3_C =>
              APB3_RDATA <= mac_4_byte_3_reg;
            when MAC_4_BYTE_4_C =>
              APB3_RDATA <= mac_4_byte_4_reg;
            when MAC_4_BYTE_5_C =>
              APB3_RDATA <= mac_4_byte_5_reg;
            when MAC_4_BYTE_6_C =>
              APB3_RDATA <= mac_4_byte_6_reg;
            when others =>
              null;  
          end case;
        else
          APB3_RDATA   <= (others => '1');
        end if; 
    end process;

--------------------------------------------------------------------------------
-- Processor End of Packet Read
---------1---------2---------3---------4---------5---------6---------7---------8  
  PROCESSOR_EOP_READ_PROC :  PROCESS (APB3_CLK, APB3_RESET)
    begin
      if ( APB3_RESET = '1' ) then
        iup_EOP    <= '0';
      elsif ( rising_edge( APB3_CLK ) ) then
        if ( (APB3_ADDR = RX_FIFO_REG_C) and (RX_FIFO_DOUT(8) = '1') 
              and (read_reg_en = '1') and (iAPB3_READY(1) = '1' ) ) then
          iup_EOP   <= '1'; 
        else
          iup_EOP   <= '0'; 
        end if;     
      end if; 
    end process; 

--------------------------------------------------------------------------------
-- Processor End of Packet Read Sync to clk16x
---------1---------2---------3---------4---------5---------6---------7---------8  
  uP_EOP_SYNC_PROC :  PROCESS (clk16x, APB3_RESET)
    begin
      if ( APB3_RESET = '1' ) then
        up_EOP_sync    <= (others => '0');
      elsif ( rising_edge( clk16x ) ) then
        up_EOP_sync   <= up_EOP_sync( 1 downto 0) & iup_EOP;     
      end if; 
    end process;  
    
  iup_EOP_CntDown_en <= up_EOP_sync(2) and not up_EOP_sync(1);

--------------------------------------------------------------------------------
-- Packet Depth Counter
---------1---------2---------3---------4---------5---------6---------7---------8  
  RX_PACKET_DEPTH_PROC :  PROCESS (clk16x, APB3_RESET)
    begin
      if ( APB3_RESET = '1' ) then
        RX_packet_depth    <= ( others => '0');
      elsif ( rising_edge( clk16x ) ) then
        if ( iup_EOP_CntDown_en = '1' and rx_packet_complt = '1' ) then
          RX_packet_depth <= RX_packet_depth;
        elsif ( rx_packet_complt = '1' ) then
          RX_packet_depth <= RX_packet_depth + '1';
        elsif ( iup_EOP_CntDown_en = '1' ) then
          RX_packet_depth <= RX_packet_depth - '1';
        else
          RX_packet_depth <= RX_packet_depth;
        end if;
      end if; 
    end process;  

--------------------------------------------------------------------------------
-- Packet Depth Counter Status.  1 = packet available, 0 = NO packet available.
---------1---------2---------3---------4---------5---------6---------7---------8  
  RX_PACKET_DEPTH_STATUS_PROC :  PROCESS (APB3_CLK, APB3_RESET)
    begin
      if ( APB3_RESET = '1' ) then
        RX_packet_depth_status    <= '0';
      elsif ( rising_edge( APB3_CLK ) ) then
	    if ( up_EOP ='1' and RX_packet_depth_status = '0' ) then
		  RX_packet_depth_status  <= '0';
        elsif ( RX_packet_depth >= x"01" ) then
          RX_packet_depth_status  <= '1';
        else
          RX_packet_depth_status  <= '0';
        end if;
      end if; 
    end process;  
	
--------------------------------------------------------------------------------
-- Debug Code to make sure every Tx packet in loopback mode is seen by the Rx path
---------1---------2---------3---------4---------5---------6---------7---------8  

	
  Debug2 :  PROCESS (APB3_CLK, APB3_RESET)	-- capture if 4 packets and we try to transfer another packet
    begin
      if (APB3_RESET = '1') then
		RX_packet_depth_d1 <= ( others => '0');
		RX_packet_depth_d2 <= ( others => '0');
		Pkt_Depth_TX_Err <= '0';
	  elsif (rising_edge( APB3_CLK )) then
	    RX_packet_depth_d1 <= RX_packet_depth;	-- standardize to clock domain
		RX_packet_depth_d2 <= RX_packet_depth_d1;
	    if (RX_packet_depth_d2 = x"04"  and (start_tx_FIFO = '1')) then	-- error if we have 4 packets and we try to xfer again
		  Pkt_Depth_TX_Err <= '1';
		end if;
	  end if;
	end process;		
	
	
END Behavioral;