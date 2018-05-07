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
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- TX_Collision_Detector2.vhd
--      -- IdleLineDetector.vhd
--      -- uP_if.vhd                           <=
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
-- Revision:  0.1
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

ENTITY uP_if IS
  PORT (
    rst                      : in  std_logic;
    APB3_CLK                 : in  std_logic;  -- Free running clock
    APB3_RESET               : in  std_logic;
    APB3_SEL                 : in  std_logic;
    APB3_ENABLE              : in  std_logic;
    APB3_ADDR                : in  std_logic_vector(7 downto 0);
    APB3_WDATA               : in  std_logic_vector(7 downto 0);
    APB3_RDATA               : out std_logic_vector(7 downto 0);
    APB3_READY               : out std_logic;
    APB3_WRITE               : in  std_logic;
    clk16x                   : in  std_logic;
    start_tx_FIFO            : out std_logic;
    internal_loopback        : out std_logic;
    control_reg_7            : out std_logic;
    control_reg_6            : out std_logic;
    MII_MUX_control_reg      : out std_logic_vector(7 downto 0);
    INT                      : out std_logic;
    collision_detect         : in  std_logic;
    Jabber_detect            : in  std_logic;
    SFD_timeout              : in  std_logic;
    MII_RX_D_fail            : in  std_logic;
    force_collision          : out std_logic;
    force_jabber             : out std_logic;
    rx_packet_end_all        : in  std_logic;
	reset_all_pkt_cntrs		 : out std_logic
  );

END uP_if;

ARCHITECTURE Behavioral OF uP_if IS

-- Constants
  constant MAJOR_REVISION_NUM    : std_logic_vector(7 downto 0) := "00100000";
  constant MINOR_REVISION_NUM    : std_logic_vector(7 downto 0) := "00000000";

  constant MAJOR_VERSION_REG_C   : std_logic_vector(7 downto 0) := "00000000";
  constant SCRATCH_PAD_REG_C     : std_logic_vector(7 downto 0) := "00000100";
  constant CONTROL_REG_C         : std_logic_vector(7 downto 0) := "00010000";
  constant INTR_REG_C            : std_logic_vector(7 downto 0) := "00010100";
  constant INTR_MASK_REG_C       : std_logic_vector(7 downto 0) := "00011000";
  constant STATUS_REG_C          : std_logic_vector(7 downto 0) := "00011100";
  constant MINOR_VERSION_REG_C   : std_logic_vector(7 downto 0) := "00100000";
  constant MII_MUX_CONTROL_REG_C : std_logic_vector(7 downto 0) := "00100100";

-- Signals
  signal apb3_wr_en            : std_logic;
  signal apb3_rd_en            : std_logic;
  signal apb3_rst              : std_logic;
  signal iAPB3_READY           : std_logic_vector(1 downto 0);
  signal scratch_pad_reg       : std_logic_vector(7 downto 0);
  signal control_reg           : std_logic_vector(7 downto 0);
  signal write_scratch_reg_en  : std_logic;
  signal status_reg            : std_logic_vector(7 downto 0);
  signal control_reg_en        : std_logic;
  signal int_mask_reg_en       : std_logic;
  signal iMII_MUX_control_en   : std_logic;
  signal read_reg_en           : std_logic;
  signal write_reg_en          : std_logic;
  signal i_int_mask_reg        : std_logic_vector(7 downto 0);
  signal int_reg               : std_logic_vector(7 downto 0);
  signal i_MII_MUX_control_reg : std_logic_vector(7 downto 0);


BEGIN

  -- Control Register
  control_reg_7       <= control_reg(7);
  control_reg_6       <= control_reg(6);
  start_tx_FIFO       <= control_reg(5);
  internal_loopback   <= control_reg(4);
  force_collision     <= control_reg(3);
  force_jabber        <= control_reg(2);
  --                  <= control_reg(1);
  --                  <= control_reg(0);

  -- Status Register
  status_reg          <=   x"00";

  -- MII MUX Control Register
  MII_MUX_control_reg <= i_MII_MUX_control_reg;

  APB3_READY          <= iAPB3_READY(1);

  apb3_wr_en          <= APB3_SEL and APB3_ENABLE and APB3_WRITE;
  apb3_rd_en          <= APB3_SEL and APB3_ENABLE and not APB3_WRITE;
  apb3_rst            <= not apb3_wr_en and not apb3_rd_en;

--------------------------------------------------------------------------------
-- Interrupt Instantiation
---------1---------2---------3---------4---------5---------6---------7---------8
  INTERRUPT_INST : entity work.Interrupts
    Port Map(
      rst                   => APB3_RESET,
      clk16x                => clk16x,
      APB3_RESET            => APB3_RESET,
      APB3_CLK              => APB3_CLK,
      APB3_ADDR             => APB3_ADDR,
      APB3_WDATA            => APB3_WDATA,
      write_reg_en          => write_reg_en,
      collision_detect      => collision_detect,
      Jabber_detect         => Jabber_detect,
      SFD_timeout           => SFD_timeout,
      MII_RX_D_fail         => MII_RX_D_fail,
      int_mask_reg          => i_int_mask_reg,
      int_reg               => int_reg,
      INT                   => INT,
      rx_packet_end_all     => rx_packet_end_all
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
          iAPB3_READY  <= iAPB3_READY(0) & (apb3_wr_en or apb3_rd_en);
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
-- Write Register Selection
---------1---------2---------3---------4---------5---------6---------7---------8
  WRITE_REGISTER_ENABLE_PROC :  PROCESS (APB3_CLK, APB3_RESET, apb3_wr_en)
    begin
      if ( APB3_RESET = '1' or apb3_wr_en = '0') then
        write_scratch_reg_en    <= '0';
        control_reg_en          <= '0';
        int_mask_reg_en         <= '0';
        iMII_MUX_control_en     <= '0';
      elsif  ( rising_edge( APB3_CLK ) ) then
        if ( APB3_ADDR = SCRATCH_PAD_REG_C ) then
          write_scratch_reg_en  <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = CONTROL_REG_C ) then
          control_reg_en        <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = INTR_MASK_REG_C ) then
          int_mask_reg_en       <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        elsif ( APB3_ADDR = MII_MUX_CONTROL_REG_C ) then
          iMII_MUX_control_en   <= apb3_wr_en and iAPB3_READY(0) and not iAPB3_READY(1);
        else
          write_scratch_reg_en  <= write_scratch_reg_en;
          control_reg_en        <= control_reg_en;
          int_mask_reg_en       <= int_mask_reg_en;
          iMII_MUX_control_en   <= iMII_MUX_control_en;
        end if;
      end if;
    end process;

--------------------------------------------------------------------------------
-- Register Write Process
---------1---------2---------3---------4---------5---------6---------7---------8
  REG_WRITE_PROC :  PROCESS (APB3_CLK, APB3_RESET)
    begin
        if ( APB3_RESET = '1' ) then
          scratch_pad_reg        <= (others => '0');
          control_reg            <= (others => '0');   
          i_int_mask_reg         <= (others => '0');
          i_MII_MUX_control_reg  <= (others => '0'); 
        elsif ( rising_edge( APB3_CLK ) ) then
          if (write_scratch_reg_en = '1') then   
            scratch_pad_reg        <= APB3_WDATA;     -- Scratch Pad Register
          elsif (control_reg_en = '1') then
            control_reg            <= APB3_WDATA;     -- Control Register 
          elsif (int_mask_reg_en = '1') then
            i_int_mask_reg         <= APB3_WDATA;     -- Interrupt Mask Register 
          elsif (iMII_MUX_control_en = '1') then
            i_MII_MUX_control_reg  <= APB3_WDATA;     -- MII Mux Control Register            
          else
            scratch_pad_reg        <= scratch_pad_reg;
            control_reg            <= control_reg;
            i_int_mask_reg         <= i_int_mask_reg;
            i_MII_MUX_control_reg  <= i_MII_MUX_control_reg;            
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
-- Read Registers
---------1---------2---------3---------4---------5---------6---------7---------8
    REG_READ_PROC: PROCESS (APB3_RESET, APB3_ADDR, read_reg_en,
                            scratch_pad_reg, apb3_rd_en,int_reg)
    begin
        if ( APB3_RESET = '1' and apb3_rd_en = '0') then
          APB3_RDATA   <= (others => '1');
		  reset_all_pkt_cntrs	<= '0';		
        elsif ( read_reg_en = '1' ) then
          CASE APB3_ADDR IS
            when MAJOR_VERSION_REG_C =>         -- Major Revision Register
              APB3_RDATA <= MAJOR_REVISION_NUM;
            when SCRATCH_PAD_REG_C =>           -- Scratch Pad Register
              APB3_RDATA <= scratch_pad_reg;
            when CONTROL_REG_C =>               -- Control Register
              APB3_RDATA <= control_reg;
            when INTR_REG_C =>                  -- Interrupt Register
              APB3_RDATA <= int_reg;
            when INTR_MASK_REG_C =>             -- Interrupt Mask Register
              APB3_RDATA <= i_int_mask_reg;
            when STATUS_REG_C =>                -- Status Register
              APB3_RDATA <= status_reg;
            when MINOR_VERSION_REG_C =>         -- Minor Revision Register
              APB3_RDATA <= MINOR_REVISION_NUM;
			  reset_all_pkt_cntrs	<= '1';		-- reset all packet counters when reading FPGA version reg (only hook available)
            when MII_MUX_CONTROL_REG_C =>       -- MII Mux Control Register
              APB3_RDATA <= i_MII_MUX_control_reg;
            when others =>                      -- others
              null;
          end case;
        else
          APB3_RDATA   <= (others => '1');
		  reset_all_pkt_cntrs	<= '0';		
        end if;
    end process;

END Behavioral;