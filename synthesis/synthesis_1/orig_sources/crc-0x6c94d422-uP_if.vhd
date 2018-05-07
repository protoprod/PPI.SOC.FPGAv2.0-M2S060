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
    consumer_type1_reg: out std_logic_vector (9 downto 0);
    consumer_type2_reg: out std_logic_vector (9 downto 0);
    consumer_type3_reg: out std_logic_vector (9 downto 0);
    consumer_type4_reg: out std_logic_vector (9 downto 0);
    tx_packet_complt  : in  std_logic;
    rx_packet_complt  : in  std_logic;
    col_detect        : in  std_logic;
    TX_FIFO_Full      : in  std_logic;
    TX_FIFO_Empty     : in  std_logic;
    RX_FIFO_Full      : in  std_logic;
    RX_FIFO_Empty     : in  std_logic
  );
      
END uP_if;

ARCHITECTURE Behavioral OF uP_if IS

-- Constants
  constant REVISION_NUM        : std_logic_vector(7 downto 0) := "00010101";
  constant VERSION_REG_C       : std_logic_vector(7 downto 0) := "00000000";
  constant SCRATCH_PAD_REG_C   : std_logic_vector(7 downto 0) := "00000100";
  constant TX_FIFO_REG_C       : std_logic_vector(7 downto 0) := "00001000";
  constant RX_FIFO_REG_C       : std_logic_vector(7 downto 0) := "00001100";
  constant CONTROL_REG_C       : std_logic_vector(7 downto 0) := "00010000";
  constant INTR_REG_C          : std_logic_vector(7 downto 0) := "00010100";
  constant INTR_MASK_REG_C     : std_logic_vector(7 downto 0) := "00011000";
  constant STATUS_REG_C        : std_logic_vector(7 downto 0) := "00011100";
  constant BT_USB_STAT_C       : std_logic_vector(7 downto 0) := "00101000";
  constant ADDRESS_HIGH1_REG_C : std_logic_vector(7 downto 0) := "00110000";
  constant ADDRESS_LOW1_REG_C  : std_logic_vector(7 downto 0) := "00110100";
  constant ADDRESS_HIGH2_REG_C : std_logic_vector(7 downto 0) := "00111000";
  constant ADDRESS_LOW2_REG_C  : std_logic_vector(7 downto 0) := "00111100";
  constant ADDRESS_HIGH3_REG_C : std_logic_vector(7 downto 0) := "01000000";
  constant ADDRESS_LOW3_REG_C  : std_logic_vector(7 downto 0) := "01000100";
  constant ADDRESS_HIGH4_REG_C : std_logic_vector(7 downto 0) := "01001000";
  constant ADDRESS_LOW4_REG_C  : std_logic_vector(7 downto 0) := "01001100";

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
  signal address_high1_reg_en  : std_logic;
  signal address_low1_reg_en   : std_logic;
  signal address_high1_reg     : std_logic_vector(7 downto 0);
  signal address_low1_reg      : std_logic_vector(7 downto 0);
  signal address_high2_reg_en  : std_logic;
  signal address_low2_reg_en   : std_logic;
  signal address_high2_reg     : std_logic_vector(7 downto 0);
  signal address_low2_reg      : std_logic_vector(7 downto 0);
  signal address_high3_reg_en  : std_logic;
  signal address_low3_reg_en   : std_logic;
  signal address_high3_reg     : std_logic_vector(7 downto 0);
  signal address_low3_reg      : std_logic_vector(7 downto 0);
  signal address_high4_reg_en  : std_logic;
  signal address_low4_reg_en   : std_logic;
  signal address_high4_reg     : std_logic_vector(7 downto 0);
  signal address_low4_reg      : std_logic_vector(7 downto 0);
  signal up_EOP                : std_logic;
  signal up_EOP_sync           : std_logic_vector(2 downto 0);
  signal up_EOP_CntDown_en     : std_logic;
  signal RX_packet_depth       : std_logic_vector(7 downto 0);
  signal RX_packet_depth_status: std_logic;

BEGIN

  TX_FIFO_RST       <= control_reg(7);
  RX_FIFO_RST       <= control_reg(6);
  start_tx_FIFO     <= control_reg(5);
  internal_loopback <= control_reg(4);
  --    <= control_reg(3);
  --    <= control_reg(2);
  external_loopback <= control_reg(1);   

  consumer_type1_reg <= address_high1_reg(1 downto 0) & address_low1_reg;
  consumer_type2_reg <= address_high2_reg(1 downto 0) & address_low2_reg;
  consumer_type3_reg <= address_high3_reg(1 downto 0) & address_low3_reg;
  consumer_type4_reg <= address_high4_reg(1 downto 0) & address_low4_reg;

  status_reg        <= "000"  & RX_packet_depth_status
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
      rx_packet_complt    => rx_packet_complt,
      TX_FIFO_UNDERRUN    => TX_FIFO_UNDERRUN,
      TX_FIFO_OVERFLOW    => TX_FIFO_OVERFLOW,
      RX_FIFO_UNDERRUN    => RX_FIFO_UNDERRUN,
      RX_FIFO_OVERFLOW    => RX_FIFO_OVERFLOW,
      col_detect          => col_detect,
      rx_CRC_error        => rx_CRC_error,
      int_mask_reg        => i_int_mask_reg,
      int_reg             => int_reg,
      INT                 => INT         
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
--        BT_USB_cntl_reg_en      <= '0';
        address_high1_reg_en    <= '0';
        address_low1_reg_en     <= '0';
        address_high2_reg_en    <= '0';
        address_low2_reg_en     <= '0';
        address_high3_reg_en    <= '0';
        address_low3_reg_en     <= '0';
        address_high4_reg_en    <= '0';
        address_low4_reg_en     <= '0';
      elsif  ( rising_edge( APB3_CLK ) ) then
        if ( APB3_ADDR = SCRATCH_PAD_REG_C ) then
          write_scratch_reg_en  <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = TX_FIFO_REG_C ) then
          iTX_FIFO_wr_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = CONTROL_REG_C ) then
          control_reg_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = INTR_MASK_REG_C ) then
          int_mask_reg_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
--        elsif ( APB3_ADDR = BT_USB_CNTL_C ) then 
--          BT_USB_cntl_reg_en    <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = ADDRESS_HIGH1_REG_C ) then 
          address_high1_reg_en       <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = ADDRESS_LOW1_REG_C ) then 
          address_low1_reg_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = ADDRESS_HIGH2_REG_C ) then 
          address_high2_reg_en       <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = ADDRESS_LOW2_REG_C ) then 
          address_low2_reg_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = ADDRESS_HIGH3_REG_C ) then 
          address_high3_reg_en       <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = ADDRESS_LOW3_REG_C ) then 
          address_low3_reg_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = ADDRESS_HIGH4_REG_C ) then 
          address_high4_reg_en       <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        elsif ( APB3_ADDR = ADDRESS_LOW4_REG_C ) then 
          address_low4_reg_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1); 
        else
          write_scratch_reg_en  <= write_scratch_reg_en; 
          iTX_FIFO_wr_en        <= iTX_FIFO_wr_en;
          control_reg_en        <= control_reg_en;
          int_mask_reg_en       <= int_mask_reg_en;
--          BT_USB_cntl_reg_en    <= BT_USB_cntl_reg_en;
          address_high1_reg_en  <= address_high1_reg_en;
          address_low1_reg_en   <= address_low1_reg_en;
          address_high2_reg_en  <= address_high2_reg_en;
          address_low2_reg_en   <= address_low2_reg_en;
          address_high3_reg_en  <= address_high3_reg_en;
          address_low3_reg_en   <= address_low3_reg_en;
          address_high4_reg_en  <= address_high4_reg_en;
          address_low4_reg_en   <= address_low4_reg_en;
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
--          BT_USB_cntl_reg    <= (others => '0');
          address_high1_reg  <= (others => '0');
          address_low1_reg   <= (others => '0');
          address_high2_reg  <= (others => '0');
          address_low2_reg   <= (others => '0');
          address_high3_reg  <= (others => '0');
          address_low3_reg   <= (others => '0');
          address_high4_reg  <= (others => '0');
          address_low4_reg   <= (others => '0');
        elsif ( rising_edge( APB3_CLK ) ) then
          if (write_scratch_reg_en = '1') then
            scratch_pad_reg    <= APB3_WDATA;
          elsif (control_reg_en = '1') then 
            control_reg        <= APB3_WDATA; 
          elsif (int_mask_reg_en = '1') then
            i_int_mask_reg     <= APB3_WDATA;
--          elsif ( BT_USB_cntl_reg_en = '1') then
--            BT_USB_cntl_reg   <= APB3_WDATA;              
          elsif ( address_high1_reg_en= '1') then
            address_high1_reg      <= APB3_WDATA;
          elsif ( address_low1_reg_en = '1') then
            address_low1_reg       <= APB3_WDATA;
          elsif ( address_high2_reg_en= '1') then
            address_high2_reg      <= APB3_WDATA;
          elsif ( address_low2_reg_en = '1') then
            address_low2_reg       <= APB3_WDATA;
          elsif ( address_high3_reg_en= '1') then
            address_high3_reg      <= APB3_WDATA;
          elsif ( address_low3_reg_en = '1') then
            address_low3_reg       <= APB3_WDATA;
          elsif ( address_high4_reg_en= '1') then
            address_high4_reg      <= APB3_WDATA;
          elsif ( address_low4_reg_en = '1') then
            address_low4_reg       <= APB3_WDATA;
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
                            scratch_pad_reg, RX_FIFO_DOUT, apb3_rd_en)
    begin
        if ( APB3_RESET = '1' and apb3_rd_en = '0') then
          APB3_RDATA   <= (others => '1');
        elsif ( read_reg_en = '1' ) then
          CASE APB3_ADDR IS
            when VERSION_REG_C =>     -- Revision Register
              APB3_RDATA <= REVISION_NUM; -- x"10";
            when SCRATCH_PAD_REG_C =>     -- Scratch Pad Register
              APB3_RDATA <= scratch_pad_reg;
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
            when ADDRESS_HIGH1_REG_C =>
              APB3_RDATA <= address_high1_reg;
            when ADDRESS_LOW1_REG_C =>
              APB3_RDATA <= address_low1_reg;
            when ADDRESS_HIGH2_REG_C =>
              APB3_RDATA <= address_high2_reg;
            when ADDRESS_LOW2_REG_C =>
              APB3_RDATA <= address_low2_reg;
            when ADDRESS_HIGH3_REG_C =>
              APB3_RDATA <= address_high3_reg;
            when ADDRESS_LOW3_REG_C =>
              APB3_RDATA <= address_low3_reg;
            when ADDRESS_HIGH4_REG_C =>
              APB3_RDATA <= address_high4_reg;
            when ADDRESS_LOW4_REG_C =>
              APB3_RDATA <= address_low4_reg;
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
        up_EOP    <= '0';
      elsif ( rising_edge( APB3_CLK ) ) then
        if ( (APB3_ADDR = RX_FIFO_REG_C) and (RX_FIFO_DOUT(8) = '1') 
              and (read_reg_en = '1') and (iAPB3_READY(1) = '1' ) ) then
          up_EOP   <= '1'; 
        else
          up_EOP   <= '0'; 
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
        up_EOP_sync   <= up_EOP_sync( 1 downto 0) & up_EOP;     
      end if; 
    end process;  
    
  up_EOP_CntDown_en <= up_EOP_sync(2) and not up_EOP_sync(1);

--------------------------------------------------------------------------------
-- Packet Depth Counter
---------1---------2---------3---------4---------5---------6---------7---------8  
  RX_PACKET_DEPTH_PROC :  PROCESS (clk16x, APB3_RESET)
    begin
      if ( APB3_RESET = '1' ) then
        RX_packet_depth    <= ( others => '0');
      elsif ( rising_edge( clk16x ) ) then
        if ( up_EOP_CntDown_en = '1' and rx_packet_complt = '1' ) then
          RX_packet_depth <= RX_packet_depth;
        elsif ( rx_packet_complt = '1' ) then
          RX_packet_depth <= RX_packet_depth + '1';
        elsif ( up_EOP_CntDown_en = '1' ) then
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
        if ( RX_packet_depth >= x"01" ) then
          RX_packet_depth_status  <= '1';
        else
          RX_packet_depth_status  <= '0';
        end if;
      end if; 
    end process;  

END Behavioral;