----------------------------------------------------------------------
-- Created by SmartDesign Thu Aug 24 11:26:13 2017
-- Version: v11.8 SP1 11.8.1.12
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- m2s010_som_sb_MSS entity declaration
----------------------------------------------------------------------
entity m2s010_som_sb_MSS is
    -- Port list
    port(
        -- Inputs
        FIC_0_APB_M_PRDATA     : in    std_logic_vector(31 downto 0);
        FIC_0_APB_M_PREADY     : in    std_logic;
        FIC_0_APB_M_PSLVERR    : in    std_logic;
        FIC_2_APB_M_PRDATA     : in    std_logic_vector(31 downto 0);
        FIC_2_APB_M_PREADY     : in    std_logic;
        FIC_2_APB_M_PSLVERR    : in    std_logic;
        GPIO_10_F2M            : in    std_logic;
        GPIO_19_F2M            : in    std_logic;
        GPIO_1_F2M             : in    std_logic;
        GPIO_27_F2M            : in    std_logic;
        GPIO_29_F2M            : in    std_logic;
        GPIO_2_F2M             : in    std_logic;
        GPIO_30_F2M            : in    std_logic;
        GPIO_6_F2M             : in    std_logic;
        GPIO_7_F2M             : in    std_logic;
        GPIO_9_F2M             : in    std_logic;
        M3_RESET_N             : in    std_logic;
        MAC_MII_COL            : in    std_logic;
        MAC_MII_CRS            : in    std_logic;
        MAC_MII_MDI            : in    std_logic;
        MAC_MII_RXD            : in    std_logic_vector(3 downto 0);
        MAC_MII_RX_CLK         : in    std_logic;
        MAC_MII_RX_DV          : in    std_logic;
        MAC_MII_RX_ER          : in    std_logic;
        MAC_MII_TX_CLK         : in    std_logic;
        MCCC_CLK_BASE          : in    std_logic;
        MCCC_CLK_BASE_PLL_LOCK : in    std_logic;
        MDDR_APB_S_PADDR       : in    std_logic_vector(10 downto 2);
        MDDR_APB_S_PCLK        : in    std_logic;
        MDDR_APB_S_PENABLE     : in    std_logic;
        MDDR_APB_S_PRESET_N    : in    std_logic;
        MDDR_APB_S_PSEL        : in    std_logic;
        MDDR_APB_S_PWDATA      : in    std_logic_vector(15 downto 0);
        MDDR_APB_S_PWRITE      : in    std_logic;
        MDDR_DQS_TMATCH_0_IN   : in    std_logic;
        MMUART_0_RXD_F2M       : in    std_logic;
        MMUART_1_RXD           : in    std_logic;
        MSS_INT_F2M            : in    std_logic_vector(15 downto 0);
        MSS_RESET_N_F2M        : in    std_logic;
        SPI_0_DI               : in    std_logic;
        SPI_1_CLK_F2M          : in    std_logic;
        SPI_1_DI_F2M           : in    std_logic;
        SPI_1_SS0_F2M          : in    std_logic;
        -- Outputs
        FIC_0_APB_M_PADDR      : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PENABLE    : out   std_logic;
        FIC_0_APB_M_PSEL       : out   std_logic;
        FIC_0_APB_M_PWDATA     : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PWRITE     : out   std_logic;
        FIC_2_APB_M_PADDR      : out   std_logic_vector(15 downto 2);
        FIC_2_APB_M_PCLK       : out   std_logic;
        FIC_2_APB_M_PENABLE    : out   std_logic;
        FIC_2_APB_M_PRESET_N   : out   std_logic;
        FIC_2_APB_M_PSEL       : out   std_logic;
        FIC_2_APB_M_PWDATA     : out   std_logic_vector(31 downto 0);
        FIC_2_APB_M_PWRITE     : out   std_logic;
        GPIO_11_M2F            : out   std_logic;
        GPIO_1_M2F             : out   std_logic;
        GPIO_1_M2F_OE          : out   std_logic;
        GPIO_20_OUT            : out   std_logic;
        GPIO_21_M2F            : out   std_logic;
        GPIO_22_M2F            : out   std_logic;
        GPIO_24_M2F            : out   std_logic;
        GPIO_28_M2F            : out   std_logic;
        GPIO_5_M2F             : out   std_logic;
        GPIO_6_M2F             : out   std_logic;
        GPIO_6_M2F_OE          : out   std_logic;
        GPIO_7_M2F             : out   std_logic;
        GPIO_7_M2F_OE          : out   std_logic;
        GPIO_8_M2F             : out   std_logic;
        MAC_MII_MDC            : out   std_logic;
        MAC_MII_MDO            : out   std_logic;
        MAC_MII_MDO_EN         : out   std_logic;
        MAC_MII_TXD            : out   std_logic_vector(3 downto 0);
        MAC_MII_TX_EN          : out   std_logic;
        MAC_MII_TX_ER          : out   std_logic;
        MDDR_ADDR              : out   std_logic_vector(15 downto 0);
        MDDR_APB_S_PRDATA      : out   std_logic_vector(15 downto 0);
        MDDR_APB_S_PREADY      : out   std_logic;
        MDDR_APB_S_PSLVERR     : out   std_logic;
        MDDR_BA                : out   std_logic_vector(2 downto 0);
        MDDR_CAS_N             : out   std_logic;
        MDDR_CKE               : out   std_logic;
        MDDR_CLK               : out   std_logic;
        MDDR_CLK_N             : out   std_logic;
        MDDR_CS_N              : out   std_logic;
        MDDR_DQS_TMATCH_0_OUT  : out   std_logic;
        MDDR_ODT               : out   std_logic;
        MDDR_RAS_N             : out   std_logic;
        MDDR_RESET_N           : out   std_logic;
        MDDR_WE_N              : out   std_logic;
        MMUART_0_TXD_M2F       : out   std_logic;
        MMUART_1_TXD           : out   std_logic;
        MSS_RESET_N_M2F        : out   std_logic;
        SPI_0_DO               : out   std_logic;
        SPI_0_SS1              : out   std_logic;
        SPI_1_CLK_M2F          : out   std_logic;
        SPI_1_DO_M2F           : out   std_logic;
        SPI_1_SS0_M2F          : out   std_logic;
        SPI_1_SS0_M2F_OE       : out   std_logic;
        -- Inouts
        GPIO_0_BI              : inout std_logic;
        GPIO_12_BI             : inout std_logic;
        GPIO_14_BI             : inout std_logic;
        GPIO_15_BI             : inout std_logic;
        GPIO_16_BI             : inout std_logic;
        GPIO_17_BI             : inout std_logic;
        GPIO_18_BI             : inout std_logic;
        GPIO_25_BI             : inout std_logic;
        GPIO_26_BI             : inout std_logic;
        GPIO_31_BI             : inout std_logic;
        GPIO_3_BI              : inout std_logic;
        GPIO_4_BI              : inout std_logic;
        I2C_1_SCL              : inout std_logic;
        I2C_1_SDA              : inout std_logic;
        MDDR_DM_RDQS           : inout std_logic_vector(1 downto 0);
        MDDR_DQ                : inout std_logic_vector(15 downto 0);
        MDDR_DQS               : inout std_logic_vector(1 downto 0);
        SPI_0_CLK              : inout std_logic;
        SPI_0_SS0              : inout std_logic
        );
end m2s010_som_sb_MSS;
----------------------------------------------------------------------
-- m2s010_som_sb_MSS architecture body
----------------------------------------------------------------------
architecture RTL of m2s010_som_sb_MSS is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- BIBUF
component BIBUF
    generic( 
        IOSTD : string := "" 
        );
    -- Port list
    port(
        -- Inputs
        D   : in    std_logic;
        E   : in    std_logic;
        -- Outputs
        Y   : out   std_logic;
        -- Inouts
        PAD : inout std_logic
        );
end component;
-- OUTBUF
component OUTBUF
    generic( 
        IOSTD : string := "" 
        );
    -- Port list
    port(
        -- Inputs
        D   : in  std_logic;
        -- Outputs
        PAD : out std_logic
        );
end component;
-- OUTBUF_DIFF
component OUTBUF_DIFF
    generic( 
        IOSTD : string := "" 
        );
    -- Port list
    port(
        -- Inputs
        D    : in  std_logic;
        -- Outputs
        PADN : out std_logic;
        PADP : out std_logic
        );
end component;
-- INBUF
component INBUF
    generic( 
        IOSTD : string := "" 
        );
    -- Port list
    port(
        -- Inputs
        PAD : in  std_logic;
        -- Outputs
        Y   : out std_logic
        );
end component;
-- TRIBUFF
component TRIBUFF
    generic( 
        IOSTD : string := "" 
        );
    -- Port list
    port(
        -- Inputs
        D   : in  std_logic;
        E   : in  std_logic;
        -- Outputs
        PAD : out std_logic
        );
end component;
-- MSS_060
component MSS_060
    generic( 
        INIT              : std_logic_vector(1437 downto 0) := "00" & x"00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000" ;
        ACT_UBITS         : std_logic_vector(55 downto 0)   := x"FFFFFFFFFFFFFF" ;
        MEMORYFILE        : string                          := "" ;
        RTC_MAIN_XTL_FREQ : real                            := 0.0 ;
        RTC_MAIN_XTL_MODE : string                          := "1" ;
        DDR_CLK_FREQ      : real                            := 0.0 
        );
    -- Port list
    port(
        -- Inputs
        CAN_RXBUS_F2H_SCP                       : in  std_logic;
        CAN_RXBUS_USBA_DATA1_MGPIO3A_IN         : in  std_logic;
        CAN_TXBUS_F2H_SCP                       : in  std_logic;
        CAN_TXBUS_USBA_DATA0_MGPIO2A_IN         : in  std_logic;
        CAN_TX_EBL_F2H_SCP                      : in  std_logic;
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_IN        : in  std_logic;
        CLK_BASE                                : in  std_logic;
        CLK_MDDR_APB                            : in  std_logic;
        COLF                                    : in  std_logic;
        CRSF                                    : in  std_logic;
        DM_IN                                   : in  std_logic_vector(2 downto 0);
        DRAM_DQS_IN                             : in  std_logic_vector(2 downto 0);
        DRAM_DQ_IN                              : in  std_logic_vector(17 downto 0);
        DRAM_FIFO_WE_IN                         : in  std_logic_vector(1 downto 0);
        F2HCALIB                                : in  std_logic;
        F2H_INTERRUPT                           : in  std_logic_vector(15 downto 0);
        F2_DMAREADY                             : in  std_logic_vector(1 downto 0);
        FAB_AVALID                              : in  std_logic;
        FAB_HOSTDISCON                          : in  std_logic;
        FAB_IDDIG                               : in  std_logic;
        FAB_LINESTATE                           : in  std_logic_vector(1 downto 0);
        FAB_M3_RESET_N                          : in  std_logic;
        FAB_PLL_LOCK                            : in  std_logic;
        FAB_RXACTIVE                            : in  std_logic;
        FAB_RXERROR                             : in  std_logic;
        FAB_RXVALID                             : in  std_logic;
        FAB_RXVALIDH                            : in  std_logic;
        FAB_SESSEND                             : in  std_logic;
        FAB_TXREADY                             : in  std_logic;
        FAB_VBUSVALID                           : in  std_logic;
        FAB_VSTATUS                             : in  std_logic_vector(7 downto 0);
        FAB_XDATAIN                             : in  std_logic_vector(7 downto 0);
        FPGA_MDDR_ARESET_N                      : in  std_logic;
        F_ARADDR_HADDR1                         : in  std_logic_vector(31 downto 0);
        F_ARBURST_HTRANS1                       : in  std_logic_vector(1 downto 0);
        F_ARID_HSEL1                            : in  std_logic_vector(3 downto 0);
        F_ARLEN_HBURST1                         : in  std_logic_vector(3 downto 0);
        F_ARLOCK_HMASTLOCK1                     : in  std_logic_vector(1 downto 0);
        F_ARSIZE_HSIZE1                         : in  std_logic_vector(1 downto 0);
        F_ARVALID_HWRITE1                       : in  std_logic;
        F_AWADDR_HADDR0                         : in  std_logic_vector(31 downto 0);
        F_AWBURST_HTRANS0                       : in  std_logic_vector(1 downto 0);
        F_AWID_HSEL0                            : in  std_logic_vector(3 downto 0);
        F_AWLEN_HBURST0                         : in  std_logic_vector(3 downto 0);
        F_AWLOCK_HMASTLOCK0                     : in  std_logic_vector(1 downto 0);
        F_AWSIZE_HSIZE0                         : in  std_logic_vector(1 downto 0);
        F_AWVALID_HWRITE0                       : in  std_logic;
        F_BREADY                                : in  std_logic;
        F_DMAREADY                              : in  std_logic_vector(1 downto 0);
        F_FM0_ADDR                              : in  std_logic_vector(31 downto 0);
        F_FM0_ENABLE                            : in  std_logic;
        F_FM0_MASTLOCK                          : in  std_logic;
        F_FM0_READY                             : in  std_logic;
        F_FM0_SEL                               : in  std_logic;
        F_FM0_SIZE                              : in  std_logic_vector(1 downto 0);
        F_FM0_TRANS1                            : in  std_logic;
        F_FM0_WDATA                             : in  std_logic_vector(31 downto 0);
        F_FM0_WRITE                             : in  std_logic;
        F_HM0_RDATA                             : in  std_logic_vector(31 downto 0);
        F_HM0_READY                             : in  std_logic;
        F_HM0_RESP                              : in  std_logic;
        F_RMW_AXI                               : in  std_logic;
        F_RREADY                                : in  std_logic;
        F_WDATA_HWDATA01                        : in  std_logic_vector(63 downto 0);
        F_WID_HREADY01                          : in  std_logic_vector(3 downto 0);
        F_WLAST                                 : in  std_logic;
        F_WSTRB                                 : in  std_logic_vector(7 downto 0);
        F_WVALID                                : in  std_logic;
        GTX_CLKPF                               : in  std_logic;
        I2C0_BCLK                               : in  std_logic;
        I2C0_SCL_F2H_SCP                        : in  std_logic;
        I2C0_SCL_USBC_DATA1_MGPIO31B_IN         : in  std_logic;
        I2C0_SDA_F2H_SCP                        : in  std_logic;
        I2C0_SDA_USBC_DATA0_MGPIO30B_IN         : in  std_logic;
        I2C1_BCLK                               : in  std_logic;
        I2C1_SCL_F2H_SCP                        : in  std_logic;
        I2C1_SCL_USBA_DATA4_MGPIO1A_IN          : in  std_logic;
        I2C1_SDA_F2H_SCP                        : in  std_logic;
        I2C1_SDA_USBA_DATA3_MGPIO0A_IN          : in  std_logic;
        MDDR_FABRIC_PADDR                       : in  std_logic_vector(10 downto 2);
        MDDR_FABRIC_PENABLE                     : in  std_logic;
        MDDR_FABRIC_PSEL                        : in  std_logic;
        MDDR_FABRIC_PWDATA                      : in  std_logic_vector(15 downto 0);
        MDDR_FABRIC_PWRITE                      : in  std_logic;
        MDIF                                    : in  std_logic;
        MGPIO0A_F2H_GPIN                        : in  std_logic;
        MGPIO0B_IN                              : in  std_logic;
        MGPIO10A_F2H_GPIN                       : in  std_logic;
        MGPIO10B_IN                             : in  std_logic;
        MGPIO11A_F2H_GPIN                       : in  std_logic;
        MGPIO11B_F2H_GPIN                       : in  std_logic;
        MGPIO12A_F2H_GPIN                       : in  std_logic;
        MGPIO13A_F2H_GPIN                       : in  std_logic;
        MGPIO14A_F2H_GPIN                       : in  std_logic;
        MGPIO15A_F2H_GPIN                       : in  std_logic;
        MGPIO16A_F2H_GPIN                       : in  std_logic;
        MGPIO17B_F2H_GPIN                       : in  std_logic;
        MGPIO18B_F2H_GPIN                       : in  std_logic;
        MGPIO19B_F2H_GPIN                       : in  std_logic;
        MGPIO1A_F2H_GPIN                        : in  std_logic;
        MGPIO1B_IN                              : in  std_logic;
        MGPIO20B_F2H_GPIN                       : in  std_logic;
        MGPIO21B_F2H_GPIN                       : in  std_logic;
        MGPIO22B_F2H_GPIN                       : in  std_logic;
        MGPIO24B_F2H_GPIN                       : in  std_logic;
        MGPIO25A_IN                             : in  std_logic;
        MGPIO25B_F2H_GPIN                       : in  std_logic;
        MGPIO26A_IN                             : in  std_logic;
        MGPIO26B_F2H_GPIN                       : in  std_logic;
        MGPIO27A_IN                             : in  std_logic;
        MGPIO27B_F2H_GPIN                       : in  std_logic;
        MGPIO28A_IN                             : in  std_logic;
        MGPIO28B_F2H_GPIN                       : in  std_logic;
        MGPIO29A_IN                             : in  std_logic;
        MGPIO29B_F2H_GPIN                       : in  std_logic;
        MGPIO2A_F2H_GPIN                        : in  std_logic;
        MGPIO2B_IN                              : in  std_logic;
        MGPIO30A_IN                             : in  std_logic;
        MGPIO30B_F2H_GPIN                       : in  std_logic;
        MGPIO31A_IN                             : in  std_logic;
        MGPIO31B_F2H_GPIN                       : in  std_logic;
        MGPIO3A_F2H_GPIN                        : in  std_logic;
        MGPIO3B_IN                              : in  std_logic;
        MGPIO4A_F2H_GPIN                        : in  std_logic;
        MGPIO4B_IN                              : in  std_logic;
        MGPIO5A_F2H_GPIN                        : in  std_logic;
        MGPIO5B_IN                              : in  std_logic;
        MGPIO6A_F2H_GPIN                        : in  std_logic;
        MGPIO6B_IN                              : in  std_logic;
        MGPIO7A_F2H_GPIN                        : in  std_logic;
        MGPIO7B_IN                              : in  std_logic;
        MGPIO8A_F2H_GPIN                        : in  std_logic;
        MGPIO8B_IN                              : in  std_logic;
        MGPIO9A_F2H_GPIN                        : in  std_logic;
        MGPIO9B_IN                              : in  std_logic;
        MMUART0_CTS_F2H_SCP                     : in  std_logic;
        MMUART0_CTS_USBC_DATA7_MGPIO19B_IN      : in  std_logic;
        MMUART0_DCD_F2H_SCP                     : in  std_logic;
        MMUART0_DCD_MGPIO22B_IN                 : in  std_logic;
        MMUART0_DSR_F2H_SCP                     : in  std_logic;
        MMUART0_DSR_MGPIO20B_IN                 : in  std_logic;
        MMUART0_DTR_F2H_SCP                     : in  std_logic;
        MMUART0_DTR_USBC_DATA6_MGPIO18B_IN      : in  std_logic;
        MMUART0_RI_F2H_SCP                      : in  std_logic;
        MMUART0_RI_MGPIO21B_IN                  : in  std_logic;
        MMUART0_RTS_F2H_SCP                     : in  std_logic;
        MMUART0_RTS_USBC_DATA5_MGPIO17B_IN      : in  std_logic;
        MMUART0_RXD_F2H_SCP                     : in  std_logic;
        MMUART0_RXD_USBC_STP_MGPIO28B_IN        : in  std_logic;
        MMUART0_SCK_F2H_SCP                     : in  std_logic;
        MMUART0_SCK_USBC_NXT_MGPIO29B_IN        : in  std_logic;
        MMUART0_TXD_F2H_SCP                     : in  std_logic;
        MMUART0_TXD_USBC_DIR_MGPIO27B_IN        : in  std_logic;
        MMUART1_CTS_F2H_SCP                     : in  std_logic;
        MMUART1_CTS_MGPIO13B_IN                 : in  std_logic;
        MMUART1_DCD_F2H_SCP                     : in  std_logic;
        MMUART1_DCD_MGPIO16B_IN                 : in  std_logic;
        MMUART1_DSR_F2H_SCP                     : in  std_logic;
        MMUART1_DSR_MGPIO14B_IN                 : in  std_logic;
        MMUART1_DTR_MGPIO12B_IN                 : in  std_logic;
        MMUART1_RI_F2H_SCP                      : in  std_logic;
        MMUART1_RI_MGPIO15B_IN                  : in  std_logic;
        MMUART1_RTS_F2H_SCP                     : in  std_logic;
        MMUART1_RTS_MGPIO11B_IN                 : in  std_logic;
        MMUART1_RXD_F2H_SCP                     : in  std_logic;
        MMUART1_RXD_USBC_DATA3_MGPIO26B_IN      : in  std_logic;
        MMUART1_SCK_F2H_SCP                     : in  std_logic;
        MMUART1_SCK_USBC_DATA4_MGPIO25B_IN      : in  std_logic;
        MMUART1_TXD_F2H_SCP                     : in  std_logic;
        MMUART1_TXD_USBC_DATA2_MGPIO24B_IN      : in  std_logic;
        PER2_FABRIC_PRDATA                      : in  std_logic_vector(31 downto 0);
        PER2_FABRIC_PREADY                      : in  std_logic;
        PER2_FABRIC_PSLVERR                     : in  std_logic;
        PRESET_N                                : in  std_logic;
        RCGF                                    : in  std_logic_vector(9 downto 0);
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_IN     : in  std_logic;
        RGMII_MDC_RMII_MDC_IN                   : in  std_logic;
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_IN      : in  std_logic;
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_IN      : in  std_logic;
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_IN      : in  std_logic;
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_IN     : in  std_logic;
        RGMII_RXD3_USBB_DATA4_IN                : in  std_logic;
        RGMII_RX_CLK_IN                         : in  std_logic;
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_IN  : in  std_logic;
        RGMII_TXD0_RMII_TXD0_USBB_DIR_IN        : in  std_logic;
        RGMII_TXD1_RMII_TXD1_USBB_STP_IN        : in  std_logic;
        RGMII_TXD2_USBB_DATA5_IN                : in  std_logic;
        RGMII_TXD3_USBB_DATA6_IN                : in  std_logic;
        RGMII_TX_CLK_IN                         : in  std_logic;
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_IN     : in  std_logic;
        RXDF                                    : in  std_logic_vector(7 downto 0);
        RX_CLKPF                                : in  std_logic;
        RX_DVF                                  : in  std_logic;
        RX_ERRF                                 : in  std_logic;
        RX_EV                                   : in  std_logic;
        SLEEPHOLDREQ                            : in  std_logic;
        SMBALERT_NI0                            : in  std_logic;
        SMBALERT_NI1                            : in  std_logic;
        SMBSUS_NI0                              : in  std_logic;
        SMBSUS_NI1                              : in  std_logic;
        SPI0_CLK_IN                             : in  std_logic;
        SPI0_SCK_USBA_XCLK_IN                   : in  std_logic;
        SPI0_SDI_F2H_SCP                        : in  std_logic;
        SPI0_SDI_USBA_DIR_MGPIO5A_IN            : in  std_logic;
        SPI0_SDO_F2H_SCP                        : in  std_logic;
        SPI0_SDO_USBA_STP_MGPIO6A_IN            : in  std_logic;
        SPI0_SS0_F2H_SCP                        : in  std_logic;
        SPI0_SS0_USBA_NXT_MGPIO7A_IN            : in  std_logic;
        SPI0_SS1_F2H_SCP                        : in  std_logic;
        SPI0_SS1_USBA_DATA5_MGPIO8A_IN          : in  std_logic;
        SPI0_SS2_F2H_SCP                        : in  std_logic;
        SPI0_SS2_USBA_DATA6_MGPIO9A_IN          : in  std_logic;
        SPI0_SS3_F2H_SCP                        : in  std_logic;
        SPI0_SS3_USBA_DATA7_MGPIO10A_IN         : in  std_logic;
        SPI0_SS4_MGPIO19A_IN                    : in  std_logic;
        SPI0_SS5_MGPIO20A_IN                    : in  std_logic;
        SPI0_SS6_MGPIO21A_IN                    : in  std_logic;
        SPI0_SS7_MGPIO22A_IN                    : in  std_logic;
        SPI1_CLK_IN                             : in  std_logic;
        SPI1_SCK_IN                             : in  std_logic;
        SPI1_SDI_F2H_SCP                        : in  std_logic;
        SPI1_SDI_MGPIO11A_IN                    : in  std_logic;
        SPI1_SDO_F2H_SCP                        : in  std_logic;
        SPI1_SDO_MGPIO12A_IN                    : in  std_logic;
        SPI1_SS0_F2H_SCP                        : in  std_logic;
        SPI1_SS0_MGPIO13A_IN                    : in  std_logic;
        SPI1_SS1_F2H_SCP                        : in  std_logic;
        SPI1_SS1_MGPIO14A_IN                    : in  std_logic;
        SPI1_SS2_F2H_SCP                        : in  std_logic;
        SPI1_SS2_MGPIO15A_IN                    : in  std_logic;
        SPI1_SS3_F2H_SCP                        : in  std_logic;
        SPI1_SS3_MGPIO16A_IN                    : in  std_logic;
        SPI1_SS4_MGPIO17A_IN                    : in  std_logic;
        SPI1_SS5_MGPIO18A_IN                    : in  std_logic;
        SPI1_SS6_MGPIO23A_IN                    : in  std_logic;
        SPI1_SS7_MGPIO24A_IN                    : in  std_logic;
        TX_CLKPF                                : in  std_logic;
        USBC_XCLK_IN                            : in  std_logic;
        USBD_DATA0_IN                           : in  std_logic;
        USBD_DATA1_IN                           : in  std_logic;
        USBD_DATA2_IN                           : in  std_logic;
        USBD_DATA3_IN                           : in  std_logic;
        USBD_DATA4_IN                           : in  std_logic;
        USBD_DATA5_IN                           : in  std_logic;
        USBD_DATA6_IN                           : in  std_logic;
        USBD_DATA7_MGPIO23B_IN                  : in  std_logic;
        USBD_DIR_IN                             : in  std_logic;
        USBD_NXT_IN                             : in  std_logic;
        USBD_STP_IN                             : in  std_logic;
        USBD_XCLK_IN                            : in  std_logic;
        USER_MSS_GPIO_RESET_N                   : in  std_logic;
        USER_MSS_RESET_N                        : in  std_logic;
        XCLK_FAB                                : in  std_logic;
        -- Outputs
        CAN_RXBUS_MGPIO3A_H2F_A                 : out std_logic;
        CAN_RXBUS_MGPIO3A_H2F_B                 : out std_logic;
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OE         : out std_logic;
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT        : out std_logic;
        CAN_TXBUS_MGPIO2A_H2F_A                 : out std_logic;
        CAN_TXBUS_MGPIO2A_H2F_B                 : out std_logic;
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OE         : out std_logic;
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OUT        : out std_logic;
        CAN_TX_EBL_MGPIO4A_H2F_A                : out std_logic;
        CAN_TX_EBL_MGPIO4A_H2F_B                : out std_logic;
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE        : out std_logic;
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT       : out std_logic;
        CLK_CONFIG_APB                          : out std_logic;
        COMMS_INT                               : out std_logic;
        CONFIG_PRESET_N                         : out std_logic;
        DM_OE                                   : out std_logic_vector(2 downto 0);
        DRAM_ADDR                               : out std_logic_vector(15 downto 0);
        DRAM_BA                                 : out std_logic_vector(2 downto 0);
        DRAM_CASN                               : out std_logic;
        DRAM_CKE                                : out std_logic;
        DRAM_CLK                                : out std_logic;
        DRAM_CSN                                : out std_logic;
        DRAM_DM_RDQS_OUT                        : out std_logic_vector(2 downto 0);
        DRAM_DQS_OE                             : out std_logic_vector(2 downto 0);
        DRAM_DQS_OUT                            : out std_logic_vector(2 downto 0);
        DRAM_DQ_OE                              : out std_logic_vector(17 downto 0);
        DRAM_DQ_OUT                             : out std_logic_vector(17 downto 0);
        DRAM_FIFO_WE_OUT                        : out std_logic_vector(1 downto 0);
        DRAM_ODT                                : out std_logic;
        DRAM_RASN                               : out std_logic;
        DRAM_RSTN                               : out std_logic;
        DRAM_WEN                                : out std_logic;
        EDAC_ERROR                              : out std_logic_vector(7 downto 0);
        FAB_CHRGVBUS                            : out std_logic;
        FAB_DISCHRGVBUS                         : out std_logic;
        FAB_DMPULLDOWN                          : out std_logic;
        FAB_DPPULLDOWN                          : out std_logic;
        FAB_DRVVBUS                             : out std_logic;
        FAB_IDPULLUP                            : out std_logic;
        FAB_OPMODE                              : out std_logic_vector(1 downto 0);
        FAB_SUSPENDM                            : out std_logic;
        FAB_TERMSEL                             : out std_logic;
        FAB_TXVALID                             : out std_logic;
        FAB_VCONTROL                            : out std_logic_vector(3 downto 0);
        FAB_VCONTROLLOADM                       : out std_logic;
        FAB_XCVRSEL                             : out std_logic_vector(1 downto 0);
        FAB_XDATAOUT                            : out std_logic_vector(7 downto 0);
        FACC_GLMUX_SEL                          : out std_logic;
        FIC32_0_MASTER                          : out std_logic_vector(1 downto 0);
        FIC32_1_MASTER                          : out std_logic_vector(1 downto 0);
        FPGA_RESET_N                            : out std_logic;
        F_ARREADY_HREADYOUT1                    : out std_logic;
        F_AWREADY_HREADYOUT0                    : out std_logic;
        F_BID                                   : out std_logic_vector(3 downto 0);
        F_BRESP_HRESP0                          : out std_logic_vector(1 downto 0);
        F_BVALID                                : out std_logic;
        F_FM0_RDATA                             : out std_logic_vector(31 downto 0);
        F_FM0_READYOUT                          : out std_logic;
        F_FM0_RESP                              : out std_logic;
        F_HM0_ADDR                              : out std_logic_vector(31 downto 0);
        F_HM0_ENABLE                            : out std_logic;
        F_HM0_SEL                               : out std_logic;
        F_HM0_SIZE                              : out std_logic_vector(1 downto 0);
        F_HM0_TRANS1                            : out std_logic;
        F_HM0_WDATA                             : out std_logic_vector(31 downto 0);
        F_HM0_WRITE                             : out std_logic;
        F_RDATA_HRDATA01                        : out std_logic_vector(63 downto 0);
        F_RID                                   : out std_logic_vector(3 downto 0);
        F_RLAST                                 : out std_logic;
        F_RRESP_HRESP1                          : out std_logic_vector(1 downto 0);
        F_RVALID                                : out std_logic;
        F_WREADY                                : out std_logic;
        GTX_CLK                                 : out std_logic;
        H2FCALIB                                : out std_logic;
        H2F_INTERRUPT                           : out std_logic_vector(15 downto 0);
        H2F_NMI                                 : out std_logic;
        I2C0_SCL_MGPIO31B_H2F_A                 : out std_logic;
        I2C0_SCL_MGPIO31B_H2F_B                 : out std_logic;
        I2C0_SCL_USBC_DATA1_MGPIO31B_OE         : out std_logic;
        I2C0_SCL_USBC_DATA1_MGPIO31B_OUT        : out std_logic;
        I2C0_SDA_MGPIO30B_H2F_A                 : out std_logic;
        I2C0_SDA_MGPIO30B_H2F_B                 : out std_logic;
        I2C0_SDA_USBC_DATA0_MGPIO30B_OE         : out std_logic;
        I2C0_SDA_USBC_DATA0_MGPIO30B_OUT        : out std_logic;
        I2C1_SCL_MGPIO1A_H2F_A                  : out std_logic;
        I2C1_SCL_MGPIO1A_H2F_B                  : out std_logic;
        I2C1_SCL_USBA_DATA4_MGPIO1A_OE          : out std_logic;
        I2C1_SCL_USBA_DATA4_MGPIO1A_OUT         : out std_logic;
        I2C1_SDA_MGPIO0A_H2F_A                  : out std_logic;
        I2C1_SDA_MGPIO0A_H2F_B                  : out std_logic;
        I2C1_SDA_USBA_DATA3_MGPIO0A_OE          : out std_logic;
        I2C1_SDA_USBA_DATA3_MGPIO0A_OUT         : out std_logic;
        MDCF                                    : out std_logic;
        MDDR_FABRIC_PRDATA                      : out std_logic_vector(15 downto 0);
        MDDR_FABRIC_PREADY                      : out std_logic;
        MDDR_FABRIC_PSLVERR                     : out std_logic;
        MDOENF                                  : out std_logic;
        MDOF                                    : out std_logic;
        MGPIO0B_OE                              : out std_logic;
        MGPIO0B_OUT                             : out std_logic;
        MGPIO10B_OE                             : out std_logic;
        MGPIO10B_OUT                            : out std_logic;
        MGPIO1B_OE                              : out std_logic;
        MGPIO1B_OUT                             : out std_logic;
        MGPIO25A_OE                             : out std_logic;
        MGPIO25A_OUT                            : out std_logic;
        MGPIO26A_OE                             : out std_logic;
        MGPIO26A_OUT                            : out std_logic;
        MGPIO27A_OE                             : out std_logic;
        MGPIO27A_OUT                            : out std_logic;
        MGPIO28A_OE                             : out std_logic;
        MGPIO28A_OUT                            : out std_logic;
        MGPIO29A_OE                             : out std_logic;
        MGPIO29A_OUT                            : out std_logic;
        MGPIO2B_OE                              : out std_logic;
        MGPIO2B_OUT                             : out std_logic;
        MGPIO30A_OE                             : out std_logic;
        MGPIO30A_OUT                            : out std_logic;
        MGPIO31A_OE                             : out std_logic;
        MGPIO31A_OUT                            : out std_logic;
        MGPIO3B_OE                              : out std_logic;
        MGPIO3B_OUT                             : out std_logic;
        MGPIO4B_OE                              : out std_logic;
        MGPIO4B_OUT                             : out std_logic;
        MGPIO5B_OE                              : out std_logic;
        MGPIO5B_OUT                             : out std_logic;
        MGPIO6B_OE                              : out std_logic;
        MGPIO6B_OUT                             : out std_logic;
        MGPIO7B_OE                              : out std_logic;
        MGPIO7B_OUT                             : out std_logic;
        MGPIO8B_OE                              : out std_logic;
        MGPIO8B_OUT                             : out std_logic;
        MGPIO9B_OE                              : out std_logic;
        MGPIO9B_OUT                             : out std_logic;
        MMUART0_CTS_MGPIO19B_H2F_A              : out std_logic;
        MMUART0_CTS_MGPIO19B_H2F_B              : out std_logic;
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OE      : out std_logic;
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OUT     : out std_logic;
        MMUART0_DCD_MGPIO22B_H2F_A              : out std_logic;
        MMUART0_DCD_MGPIO22B_H2F_B              : out std_logic;
        MMUART0_DCD_MGPIO22B_OE                 : out std_logic;
        MMUART0_DCD_MGPIO22B_OUT                : out std_logic;
        MMUART0_DSR_MGPIO20B_H2F_A              : out std_logic;
        MMUART0_DSR_MGPIO20B_H2F_B              : out std_logic;
        MMUART0_DSR_MGPIO20B_OE                 : out std_logic;
        MMUART0_DSR_MGPIO20B_OUT                : out std_logic;
        MMUART0_DTR_MGPIO18B_H2F_A              : out std_logic;
        MMUART0_DTR_MGPIO18B_H2F_B              : out std_logic;
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OE      : out std_logic;
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OUT     : out std_logic;
        MMUART0_RI_MGPIO21B_H2F_A               : out std_logic;
        MMUART0_RI_MGPIO21B_H2F_B               : out std_logic;
        MMUART0_RI_MGPIO21B_OE                  : out std_logic;
        MMUART0_RI_MGPIO21B_OUT                 : out std_logic;
        MMUART0_RTS_MGPIO17B_H2F_A              : out std_logic;
        MMUART0_RTS_MGPIO17B_H2F_B              : out std_logic;
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OE      : out std_logic;
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OUT     : out std_logic;
        MMUART0_RXD_MGPIO28B_H2F_A              : out std_logic;
        MMUART0_RXD_MGPIO28B_H2F_B              : out std_logic;
        MMUART0_RXD_USBC_STP_MGPIO28B_OE        : out std_logic;
        MMUART0_RXD_USBC_STP_MGPIO28B_OUT       : out std_logic;
        MMUART0_SCK_MGPIO29B_H2F_A              : out std_logic;
        MMUART0_SCK_MGPIO29B_H2F_B              : out std_logic;
        MMUART0_SCK_USBC_NXT_MGPIO29B_OE        : out std_logic;
        MMUART0_SCK_USBC_NXT_MGPIO29B_OUT       : out std_logic;
        MMUART0_TXD_MGPIO27B_H2F_A              : out std_logic;
        MMUART0_TXD_MGPIO27B_H2F_B              : out std_logic;
        MMUART0_TXD_USBC_DIR_MGPIO27B_OE        : out std_logic;
        MMUART0_TXD_USBC_DIR_MGPIO27B_OUT       : out std_logic;
        MMUART1_CTS_MGPIO13B_OE                 : out std_logic;
        MMUART1_CTS_MGPIO13B_OUT                : out std_logic;
        MMUART1_DCD_MGPIO16B_OE                 : out std_logic;
        MMUART1_DCD_MGPIO16B_OUT                : out std_logic;
        MMUART1_DSR_MGPIO14B_OE                 : out std_logic;
        MMUART1_DSR_MGPIO14B_OUT                : out std_logic;
        MMUART1_DTR_MGPIO12B_H2F_A              : out std_logic;
        MMUART1_DTR_MGPIO12B_OE                 : out std_logic;
        MMUART1_DTR_MGPIO12B_OUT                : out std_logic;
        MMUART1_RI_MGPIO15B_OE                  : out std_logic;
        MMUART1_RI_MGPIO15B_OUT                 : out std_logic;
        MMUART1_RTS_MGPIO11B_H2F_A              : out std_logic;
        MMUART1_RTS_MGPIO11B_H2F_B              : out std_logic;
        MMUART1_RTS_MGPIO11B_OE                 : out std_logic;
        MMUART1_RTS_MGPIO11B_OUT                : out std_logic;
        MMUART1_RXD_MGPIO26B_H2F_A              : out std_logic;
        MMUART1_RXD_MGPIO26B_H2F_B              : out std_logic;
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OE      : out std_logic;
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OUT     : out std_logic;
        MMUART1_SCK_MGPIO25B_H2F_A              : out std_logic;
        MMUART1_SCK_MGPIO25B_H2F_B              : out std_logic;
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OE      : out std_logic;
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OUT     : out std_logic;
        MMUART1_TXD_MGPIO24B_H2F_A              : out std_logic;
        MMUART1_TXD_MGPIO24B_H2F_B              : out std_logic;
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OE      : out std_logic;
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT     : out std_logic;
        MPLL_LOCK                               : out std_logic;
        PER2_FABRIC_PADDR                       : out std_logic_vector(15 downto 2);
        PER2_FABRIC_PENABLE                     : out std_logic;
        PER2_FABRIC_PSEL                        : out std_logic;
        PER2_FABRIC_PWDATA                      : out std_logic_vector(31 downto 0);
        PER2_FABRIC_PWRITE                      : out std_logic;
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OE     : out std_logic;
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OUT    : out std_logic;
        RGMII_MDC_RMII_MDC_OE                   : out std_logic;
        RGMII_MDC_RMII_MDC_OUT                  : out std_logic;
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OE      : out std_logic;
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OUT     : out std_logic;
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OE      : out std_logic;
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OUT     : out std_logic;
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OE      : out std_logic;
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OUT     : out std_logic;
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OE     : out std_logic;
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OUT    : out std_logic;
        RGMII_RXD3_USBB_DATA4_OE                : out std_logic;
        RGMII_RXD3_USBB_DATA4_OUT               : out std_logic;
        RGMII_RX_CLK_OE                         : out std_logic;
        RGMII_RX_CLK_OUT                        : out std_logic;
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OE  : out std_logic;
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OUT : out std_logic;
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OE        : out std_logic;
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OUT       : out std_logic;
        RGMII_TXD1_RMII_TXD1_USBB_STP_OE        : out std_logic;
        RGMII_TXD1_RMII_TXD1_USBB_STP_OUT       : out std_logic;
        RGMII_TXD2_USBB_DATA5_OE                : out std_logic;
        RGMII_TXD2_USBB_DATA5_OUT               : out std_logic;
        RGMII_TXD3_USBB_DATA6_OE                : out std_logic;
        RGMII_TXD3_USBB_DATA6_OUT               : out std_logic;
        RGMII_TX_CLK_OE                         : out std_logic;
        RGMII_TX_CLK_OUT                        : out std_logic;
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OE     : out std_logic;
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OUT    : out std_logic;
        RTC_MATCH                               : out std_logic;
        SLEEPDEEP                               : out std_logic;
        SLEEPHOLDACK                            : out std_logic;
        SLEEPING                                : out std_logic;
        SMBALERT_NO0                            : out std_logic;
        SMBALERT_NO1                            : out std_logic;
        SMBSUS_NO0                              : out std_logic;
        SMBSUS_NO1                              : out std_logic;
        SPI0_CLK_OUT                            : out std_logic;
        SPI0_SCK_USBA_XCLK_OE                   : out std_logic;
        SPI0_SCK_USBA_XCLK_OUT                  : out std_logic;
        SPI0_SDI_MGPIO5A_H2F_A                  : out std_logic;
        SPI0_SDI_MGPIO5A_H2F_B                  : out std_logic;
        SPI0_SDI_USBA_DIR_MGPIO5A_OE            : out std_logic;
        SPI0_SDI_USBA_DIR_MGPIO5A_OUT           : out std_logic;
        SPI0_SDO_MGPIO6A_H2F_A                  : out std_logic;
        SPI0_SDO_MGPIO6A_H2F_B                  : out std_logic;
        SPI0_SDO_USBA_STP_MGPIO6A_OE            : out std_logic;
        SPI0_SDO_USBA_STP_MGPIO6A_OUT           : out std_logic;
        SPI0_SS0_MGPIO7A_H2F_A                  : out std_logic;
        SPI0_SS0_MGPIO7A_H2F_B                  : out std_logic;
        SPI0_SS0_USBA_NXT_MGPIO7A_OE            : out std_logic;
        SPI0_SS0_USBA_NXT_MGPIO7A_OUT           : out std_logic;
        SPI0_SS1_MGPIO8A_H2F_A                  : out std_logic;
        SPI0_SS1_MGPIO8A_H2F_B                  : out std_logic;
        SPI0_SS1_USBA_DATA5_MGPIO8A_OE          : out std_logic;
        SPI0_SS1_USBA_DATA5_MGPIO8A_OUT         : out std_logic;
        SPI0_SS2_MGPIO9A_H2F_A                  : out std_logic;
        SPI0_SS2_MGPIO9A_H2F_B                  : out std_logic;
        SPI0_SS2_USBA_DATA6_MGPIO9A_OE          : out std_logic;
        SPI0_SS2_USBA_DATA6_MGPIO9A_OUT         : out std_logic;
        SPI0_SS3_MGPIO10A_H2F_A                 : out std_logic;
        SPI0_SS3_MGPIO10A_H2F_B                 : out std_logic;
        SPI0_SS3_USBA_DATA7_MGPIO10A_OE         : out std_logic;
        SPI0_SS3_USBA_DATA7_MGPIO10A_OUT        : out std_logic;
        SPI0_SS4_MGPIO19A_H2F_A                 : out std_logic;
        SPI0_SS4_MGPIO19A_OE                    : out std_logic;
        SPI0_SS4_MGPIO19A_OUT                   : out std_logic;
        SPI0_SS5_MGPIO20A_H2F_A                 : out std_logic;
        SPI0_SS5_MGPIO20A_OE                    : out std_logic;
        SPI0_SS5_MGPIO20A_OUT                   : out std_logic;
        SPI0_SS6_MGPIO21A_H2F_A                 : out std_logic;
        SPI0_SS6_MGPIO21A_OE                    : out std_logic;
        SPI0_SS6_MGPIO21A_OUT                   : out std_logic;
        SPI0_SS7_MGPIO22A_H2F_A                 : out std_logic;
        SPI0_SS7_MGPIO22A_OE                    : out std_logic;
        SPI0_SS7_MGPIO22A_OUT                   : out std_logic;
        SPI1_CLK_OUT                            : out std_logic;
        SPI1_SCK_OE                             : out std_logic;
        SPI1_SCK_OUT                            : out std_logic;
        SPI1_SDI_MGPIO11A_H2F_A                 : out std_logic;
        SPI1_SDI_MGPIO11A_H2F_B                 : out std_logic;
        SPI1_SDI_MGPIO11A_OE                    : out std_logic;
        SPI1_SDI_MGPIO11A_OUT                   : out std_logic;
        SPI1_SDO_MGPIO12A_H2F_A                 : out std_logic;
        SPI1_SDO_MGPIO12A_H2F_B                 : out std_logic;
        SPI1_SDO_MGPIO12A_OE                    : out std_logic;
        SPI1_SDO_MGPIO12A_OUT                   : out std_logic;
        SPI1_SS0_MGPIO13A_H2F_A                 : out std_logic;
        SPI1_SS0_MGPIO13A_H2F_B                 : out std_logic;
        SPI1_SS0_MGPIO13A_OE                    : out std_logic;
        SPI1_SS0_MGPIO13A_OUT                   : out std_logic;
        SPI1_SS1_MGPIO14A_H2F_A                 : out std_logic;
        SPI1_SS1_MGPIO14A_H2F_B                 : out std_logic;
        SPI1_SS1_MGPIO14A_OE                    : out std_logic;
        SPI1_SS1_MGPIO14A_OUT                   : out std_logic;
        SPI1_SS2_MGPIO15A_H2F_A                 : out std_logic;
        SPI1_SS2_MGPIO15A_H2F_B                 : out std_logic;
        SPI1_SS2_MGPIO15A_OE                    : out std_logic;
        SPI1_SS2_MGPIO15A_OUT                   : out std_logic;
        SPI1_SS3_MGPIO16A_H2F_A                 : out std_logic;
        SPI1_SS3_MGPIO16A_H2F_B                 : out std_logic;
        SPI1_SS3_MGPIO16A_OE                    : out std_logic;
        SPI1_SS3_MGPIO16A_OUT                   : out std_logic;
        SPI1_SS4_MGPIO17A_H2F_A                 : out std_logic;
        SPI1_SS4_MGPIO17A_OE                    : out std_logic;
        SPI1_SS4_MGPIO17A_OUT                   : out std_logic;
        SPI1_SS5_MGPIO18A_H2F_A                 : out std_logic;
        SPI1_SS5_MGPIO18A_OE                    : out std_logic;
        SPI1_SS5_MGPIO18A_OUT                   : out std_logic;
        SPI1_SS6_MGPIO23A_H2F_A                 : out std_logic;
        SPI1_SS6_MGPIO23A_OE                    : out std_logic;
        SPI1_SS6_MGPIO23A_OUT                   : out std_logic;
        SPI1_SS7_MGPIO24A_H2F_A                 : out std_logic;
        SPI1_SS7_MGPIO24A_OE                    : out std_logic;
        SPI1_SS7_MGPIO24A_OUT                   : out std_logic;
        TCGF                                    : out std_logic_vector(9 downto 0);
        TRACECLK                                : out std_logic;
        TRACEDATA                               : out std_logic_vector(3 downto 0);
        TXCTL_EN_RIF                            : out std_logic;
        TXDF                                    : out std_logic_vector(7 downto 0);
        TXD_RIF                                 : out std_logic_vector(3 downto 0);
        TXEV                                    : out std_logic;
        TX_CLK                                  : out std_logic;
        TX_ENF                                  : out std_logic;
        TX_ERRF                                 : out std_logic;
        USBC_XCLK_OE                            : out std_logic;
        USBC_XCLK_OUT                           : out std_logic;
        USBD_DATA0_OE                           : out std_logic;
        USBD_DATA0_OUT                          : out std_logic;
        USBD_DATA1_OE                           : out std_logic;
        USBD_DATA1_OUT                          : out std_logic;
        USBD_DATA2_OE                           : out std_logic;
        USBD_DATA2_OUT                          : out std_logic;
        USBD_DATA3_OE                           : out std_logic;
        USBD_DATA3_OUT                          : out std_logic;
        USBD_DATA4_OE                           : out std_logic;
        USBD_DATA4_OUT                          : out std_logic;
        USBD_DATA5_OE                           : out std_logic;
        USBD_DATA5_OUT                          : out std_logic;
        USBD_DATA6_OE                           : out std_logic;
        USBD_DATA6_OUT                          : out std_logic;
        USBD_DATA7_MGPIO23B_OE                  : out std_logic;
        USBD_DATA7_MGPIO23B_OUT                 : out std_logic;
        USBD_DIR_OE                             : out std_logic;
        USBD_DIR_OUT                            : out std_logic;
        USBD_NXT_OE                             : out std_logic;
        USBD_NXT_OUT                            : out std_logic;
        USBD_STP_OE                             : out std_logic;
        USBD_STP_OUT                            : out std_logic;
        USBD_XCLK_OE                            : out std_logic;
        USBD_XCLK_OUT                           : out std_logic;
        WDOGTIMEOUT                             : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal FIC_0_APB_MASTER_PADDR                             : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PENABLE                           : std_logic;
signal FIC_0_APB_MASTER_PSELx                             : std_logic;
signal FIC_0_APB_MASTER_PWDATA                            : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PWRITE                            : std_logic;
signal FIC_2_APB_M_PCLK_0                                 : std_logic;
signal FIC_2_APB_M_PRESET_N_0                             : std_logic;
signal FIC_2_APB_MASTER_0_PADDR                           : std_logic_vector(15 downto 2);
signal FIC_2_APB_MASTER_0_PENABLE                         : std_logic;
signal FIC_2_APB_MASTER_0_PSELx                           : std_logic;
signal FIC_2_APB_MASTER_0_PWDATA                          : std_logic_vector(31 downto 0);
signal FIC_2_APB_MASTER_0_PWRITE                          : std_logic;
signal GPIO_1_M2F_net_0                                   : std_logic;
signal GPIO_1_M2F_OE_0                                    : std_logic;
signal GPIO_5_M2F_net_0                                   : std_logic;
signal GPIO_6_M2F_net_0                                   : std_logic;
signal GPIO_6_M2F_OE_net_0                                : std_logic;
signal GPIO_7_M2F_net_0                                   : std_logic;
signal GPIO_7_M2F_OE_net_0                                : std_logic;
signal GPIO_8_M2F_net_0                                   : std_logic;
signal GPIO_11_M2F_net_0                                  : std_logic;
signal GPIO_20_OUT_net_0                                  : std_logic;
signal GPIO_21_M2F_net_0                                  : std_logic;
signal GPIO_22_M2F_net_0                                  : std_logic;
signal GPIO_24_M2F_net_0                                  : std_logic;
signal GPIO_28_M2F_net_0                                  : std_logic;
signal GPIO_GPIO_0_BI_PAD_Y                               : std_logic;
signal GPIO_GPIO_3_BI_PAD_Y                               : std_logic;
signal GPIO_GPIO_4_BI_PAD_Y                               : std_logic;
signal GPIO_GPIO_12_BI_PAD_Y                              : std_logic;
signal GPIO_GPIO_14_BI_PAD_Y                              : std_logic;
signal GPIO_GPIO_15_BI_PAD_Y                              : std_logic;
signal GPIO_GPIO_16_BI_PAD_Y                              : std_logic;
signal GPIO_GPIO_17_BI_PAD_Y                              : std_logic;
signal GPIO_GPIO_18_BI_PAD_Y                              : std_logic;
signal GPIO_GPIO_25_BI_PAD_Y                              : std_logic;
signal GPIO_GPIO_26_BI_PAD_Y                              : std_logic;
signal GPIO_GPIO_31_BI_PAD_Y                              : std_logic;
signal I2C_1_SCL_PAD_Y                                    : std_logic;
signal I2C_1_SDA_PAD_Y                                    : std_logic;
signal MAC_MII_MDC_net_0                                  : std_logic;
signal MAC_MII_MDO_net_0                                  : std_logic;
signal MAC_MII_MDO_EN_net_0                               : std_logic;
signal MAC_MII_RXD_slice_0                                : std_logic_vector(3 to 3);
signal MAC_MII_RXD_slice_1                                : std_logic_vector(2 to 2);
signal MAC_MII_RXD_slice_2                                : std_logic_vector(1 to 1);
signal MAC_MII_RXD_slice_3                                : std_logic_vector(0 to 0);
signal MAC_MII_TX_EN_net_0                                : std_logic;
signal MAC_MII_TX_ER_net_0                                : std_logic;
signal MAC_MII_TXD_net_0                                  : std_logic_vector(3 to 3);
signal MAC_MII_TXD_0                                      : std_logic_vector(2 to 2);
signal MAC_MII_TXD_1                                      : std_logic_vector(1 to 1);
signal MAC_MII_TXD_2                                      : std_logic_vector(0 to 0);
signal MDDR_ADDR_net_0                                    : std_logic;
signal MDDR_ADDR_0                                        : std_logic;
signal MDDR_ADDR_1                                        : std_logic;
signal MDDR_ADDR_2                                        : std_logic;
signal MDDR_ADDR_3                                        : std_logic;
signal MDDR_ADDR_4                                        : std_logic;
signal MDDR_ADDR_5                                        : std_logic;
signal MDDR_ADDR_6                                        : std_logic;
signal MDDR_ADDR_7                                        : std_logic;
signal MDDR_ADDR_8                                        : std_logic;
signal MDDR_ADDR_9                                        : std_logic;
signal MDDR_ADDR_10                                       : std_logic;
signal MDDR_ADDR_11                                       : std_logic;
signal MDDR_ADDR_12                                       : std_logic;
signal MDDR_ADDR_13                                       : std_logic;
signal MDDR_ADDR_14                                       : std_logic;
signal MDDR_APB_SLAVE_PRDATA                              : std_logic_vector(15 downto 0);
signal MDDR_APB_SLAVE_PREADY                              : std_logic;
signal MDDR_APB_SLAVE_PSLVERR                             : std_logic;
signal MDDR_BA_net_0                                      : std_logic;
signal MDDR_BA_0                                          : std_logic;
signal MDDR_BA_1                                          : std_logic;
signal MDDR_CAS_N_net_0                                   : std_logic;
signal MDDR_CKE_net_0                                     : std_logic;
signal MDDR_CLK_net_0                                     : std_logic;
signal MDDR_CLK_N_net_0                                   : std_logic;
signal MDDR_CS_N_net_0                                    : std_logic;
signal MDDR_DM_RDQS_0_PAD_Y                               : std_logic;
signal MDDR_DM_RDQS_1_PAD_Y                               : std_logic;
signal MDDR_DQ_0_PAD_Y                                    : std_logic;
signal MDDR_DQ_1_PAD_Y                                    : std_logic;
signal MDDR_DQ_2_PAD_Y                                    : std_logic;
signal MDDR_DQ_3_PAD_Y                                    : std_logic;
signal MDDR_DQ_4_PAD_Y                                    : std_logic;
signal MDDR_DQ_5_PAD_Y                                    : std_logic;
signal MDDR_DQ_6_PAD_Y                                    : std_logic;
signal MDDR_DQ_7_PAD_Y                                    : std_logic;
signal MDDR_DQ_8_PAD_Y                                    : std_logic;
signal MDDR_DQ_9_PAD_Y                                    : std_logic;
signal MDDR_DQ_10_PAD_Y                                   : std_logic;
signal MDDR_DQ_11_PAD_Y                                   : std_logic;
signal MDDR_DQ_12_PAD_Y                                   : std_logic;
signal MDDR_DQ_13_PAD_Y                                   : std_logic;
signal MDDR_DQ_14_PAD_Y                                   : std_logic;
signal MDDR_DQ_15_PAD_Y                                   : std_logic;
signal MDDR_DQS_0_PAD_Y                                   : std_logic;
signal MDDR_DQS_1_PAD_Y                                   : std_logic;
signal MDDR_DQS_TMATCH_0_IN_PAD_Y                         : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_0                        : std_logic;
signal MDDR_ODT_net_0                                     : std_logic;
signal MDDR_RAS_N_net_0                                   : std_logic;
signal MDDR_RESET_N_net_0                                 : std_logic;
signal MDDR_WE_N_net_0                                    : std_logic;
signal MMUART_0_TXD_M2F_net_0                             : std_logic;
signal MMUART_1_RXD_PAD_Y                                 : std_logic;
signal MMUART_1_TXD_net_0                                 : std_logic;
signal MSS_ADLIB_INST_CAN_RXBUS_USBA_DATA1_MGPIO3A_OE     : std_logic;
signal MSS_ADLIB_INST_CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT    : std_logic;
signal MSS_ADLIB_INST_CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE    : std_logic;
signal MSS_ADLIB_INST_CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT   : std_logic;
signal MSS_ADLIB_INST_DM_OE0to0                           : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DM_OE1to1                           : std_logic_vector(1 to 1);
signal MSS_ADLIB_INST_DRAM_ADDR0to0                       : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DRAM_ADDR1to1                       : std_logic_vector(1 to 1);
signal MSS_ADLIB_INST_DRAM_ADDR2to2                       : std_logic_vector(2 to 2);
signal MSS_ADLIB_INST_DRAM_ADDR3to3                       : std_logic_vector(3 to 3);
signal MSS_ADLIB_INST_DRAM_ADDR4to4                       : std_logic_vector(4 to 4);
signal MSS_ADLIB_INST_DRAM_ADDR5to5                       : std_logic_vector(5 to 5);
signal MSS_ADLIB_INST_DRAM_ADDR6to6                       : std_logic_vector(6 to 6);
signal MSS_ADLIB_INST_DRAM_ADDR7to7                       : std_logic_vector(7 to 7);
signal MSS_ADLIB_INST_DRAM_ADDR8to8                       : std_logic_vector(8 to 8);
signal MSS_ADLIB_INST_DRAM_ADDR9to9                       : std_logic_vector(9 to 9);
signal MSS_ADLIB_INST_DRAM_ADDR10to10                     : std_logic_vector(10 to 10);
signal MSS_ADLIB_INST_DRAM_ADDR11to11                     : std_logic_vector(11 to 11);
signal MSS_ADLIB_INST_DRAM_ADDR12to12                     : std_logic_vector(12 to 12);
signal MSS_ADLIB_INST_DRAM_ADDR13to13                     : std_logic_vector(13 to 13);
signal MSS_ADLIB_INST_DRAM_ADDR14to14                     : std_logic_vector(14 to 14);
signal MSS_ADLIB_INST_DRAM_ADDR15to15                     : std_logic_vector(15 to 15);
signal MSS_ADLIB_INST_DRAM_BA0to0                         : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DRAM_BA1to1                         : std_logic_vector(1 to 1);
signal MSS_ADLIB_INST_DRAM_BA2to2                         : std_logic_vector(2 to 2);
signal MSS_ADLIB_INST_DRAM_CASN                           : std_logic;
signal MSS_ADLIB_INST_DRAM_CKE                            : std_logic;
signal MSS_ADLIB_INST_DRAM_CLK                            : std_logic;
signal MSS_ADLIB_INST_DRAM_CSN                            : std_logic;
signal MSS_ADLIB_INST_DRAM_DM_RDQS_OUT0to0                : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DRAM_DM_RDQS_OUT1to1                : std_logic_vector(1 to 1);
signal MSS_ADLIB_INST_DRAM_DQ_OE0to0                      : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DRAM_DQ_OE1to1                      : std_logic_vector(1 to 1);
signal MSS_ADLIB_INST_DRAM_DQ_OE2to2                      : std_logic_vector(2 to 2);
signal MSS_ADLIB_INST_DRAM_DQ_OE3to3                      : std_logic_vector(3 to 3);
signal MSS_ADLIB_INST_DRAM_DQ_OE4to4                      : std_logic_vector(4 to 4);
signal MSS_ADLIB_INST_DRAM_DQ_OE5to5                      : std_logic_vector(5 to 5);
signal MSS_ADLIB_INST_DRAM_DQ_OE6to6                      : std_logic_vector(6 to 6);
signal MSS_ADLIB_INST_DRAM_DQ_OE7to7                      : std_logic_vector(7 to 7);
signal MSS_ADLIB_INST_DRAM_DQ_OE8to8                      : std_logic_vector(8 to 8);
signal MSS_ADLIB_INST_DRAM_DQ_OE9to9                      : std_logic_vector(9 to 9);
signal MSS_ADLIB_INST_DRAM_DQ_OE10to10                    : std_logic_vector(10 to 10);
signal MSS_ADLIB_INST_DRAM_DQ_OE11to11                    : std_logic_vector(11 to 11);
signal MSS_ADLIB_INST_DRAM_DQ_OE12to12                    : std_logic_vector(12 to 12);
signal MSS_ADLIB_INST_DRAM_DQ_OE13to13                    : std_logic_vector(13 to 13);
signal MSS_ADLIB_INST_DRAM_DQ_OE14to14                    : std_logic_vector(14 to 14);
signal MSS_ADLIB_INST_DRAM_DQ_OE15to15                    : std_logic_vector(15 to 15);
signal MSS_ADLIB_INST_DRAM_DQ_OUT0to0                     : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DRAM_DQ_OUT1to1                     : std_logic_vector(1 to 1);
signal MSS_ADLIB_INST_DRAM_DQ_OUT2to2                     : std_logic_vector(2 to 2);
signal MSS_ADLIB_INST_DRAM_DQ_OUT3to3                     : std_logic_vector(3 to 3);
signal MSS_ADLIB_INST_DRAM_DQ_OUT4to4                     : std_logic_vector(4 to 4);
signal MSS_ADLIB_INST_DRAM_DQ_OUT5to5                     : std_logic_vector(5 to 5);
signal MSS_ADLIB_INST_DRAM_DQ_OUT6to6                     : std_logic_vector(6 to 6);
signal MSS_ADLIB_INST_DRAM_DQ_OUT7to7                     : std_logic_vector(7 to 7);
signal MSS_ADLIB_INST_DRAM_DQ_OUT8to8                     : std_logic_vector(8 to 8);
signal MSS_ADLIB_INST_DRAM_DQ_OUT9to9                     : std_logic_vector(9 to 9);
signal MSS_ADLIB_INST_DRAM_DQ_OUT10to10                   : std_logic_vector(10 to 10);
signal MSS_ADLIB_INST_DRAM_DQ_OUT11to11                   : std_logic_vector(11 to 11);
signal MSS_ADLIB_INST_DRAM_DQ_OUT12to12                   : std_logic_vector(12 to 12);
signal MSS_ADLIB_INST_DRAM_DQ_OUT13to13                   : std_logic_vector(13 to 13);
signal MSS_ADLIB_INST_DRAM_DQ_OUT14to14                   : std_logic_vector(14 to 14);
signal MSS_ADLIB_INST_DRAM_DQ_OUT15to15                   : std_logic_vector(15 to 15);
signal MSS_ADLIB_INST_DRAM_DQS_OE0to0                     : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DRAM_DQS_OE1to1                     : std_logic_vector(1 to 1);
signal MSS_ADLIB_INST_DRAM_DQS_OUT0to0                    : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DRAM_DQS_OUT1to1                    : std_logic_vector(1 to 1);
signal MSS_ADLIB_INST_DRAM_FIFO_WE_OUT0to0                : std_logic_vector(0 to 0);
signal MSS_ADLIB_INST_DRAM_ODT                            : std_logic;
signal MSS_ADLIB_INST_DRAM_RASN                           : std_logic;
signal MSS_ADLIB_INST_DRAM_RSTN                           : std_logic;
signal MSS_ADLIB_INST_DRAM_WEN                            : std_logic;
signal MSS_ADLIB_INST_I2C1_SCL_USBA_DATA4_MGPIO1A_OE      : std_logic;
signal MSS_ADLIB_INST_I2C1_SCL_USBA_DATA4_MGPIO1A_OUT     : std_logic;
signal MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OE      : std_logic;
signal MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OUT     : std_logic;
signal MSS_ADLIB_INST_MGPIO0B_OE                          : std_logic;
signal MSS_ADLIB_INST_MGPIO0B_OUT                         : std_logic;
signal MSS_ADLIB_INST_MGPIO25A_OE                         : std_logic;
signal MSS_ADLIB_INST_MGPIO25A_OUT                        : std_logic;
signal MSS_ADLIB_INST_MGPIO26A_OE                         : std_logic;
signal MSS_ADLIB_INST_MGPIO26A_OUT                        : std_logic;
signal MSS_ADLIB_INST_MGPIO31A_OE                         : std_logic;
signal MSS_ADLIB_INST_MGPIO31A_OUT                        : std_logic;
signal MSS_ADLIB_INST_MMUART1_DCD_MGPIO16B_OE             : std_logic;
signal MSS_ADLIB_INST_MMUART1_DCD_MGPIO16B_OUT            : std_logic;
signal MSS_ADLIB_INST_MMUART1_DSR_MGPIO14B_OE             : std_logic;
signal MSS_ADLIB_INST_MMUART1_DSR_MGPIO14B_OUT            : std_logic;
signal MSS_ADLIB_INST_MMUART1_DTR_MGPIO12B_OE             : std_logic;
signal MSS_ADLIB_INST_MMUART1_DTR_MGPIO12B_OUT            : std_logic;
signal MSS_ADLIB_INST_MMUART1_RI_MGPIO15B_OE              : std_logic;
signal MSS_ADLIB_INST_MMUART1_RI_MGPIO15B_OUT             : std_logic;
signal MSS_ADLIB_INST_MMUART1_TXD_USBC_DATA2_MGPIO24B_OE  : std_logic;
signal MSS_ADLIB_INST_MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT : std_logic;
signal MSS_ADLIB_INST_SPI0_SCK_USBA_XCLK_OE               : std_logic;
signal MSS_ADLIB_INST_SPI0_SCK_USBA_XCLK_OUT              : std_logic;
signal MSS_ADLIB_INST_SPI0_SDO_USBA_STP_MGPIO6A_OE        : std_logic;
signal MSS_ADLIB_INST_SPI0_SDO_USBA_STP_MGPIO6A_OUT       : std_logic;
signal MSS_ADLIB_INST_SPI0_SS0_USBA_NXT_MGPIO7A_OE        : std_logic;
signal MSS_ADLIB_INST_SPI0_SS0_USBA_NXT_MGPIO7A_OUT       : std_logic;
signal MSS_ADLIB_INST_SPI0_SS1_USBA_DATA5_MGPIO8A_OE      : std_logic;
signal MSS_ADLIB_INST_SPI0_SS1_USBA_DATA5_MGPIO8A_OUT     : std_logic;
signal MSS_ADLIB_INST_SPI0_SS5_MGPIO20A_OUT               : std_logic;
signal MSS_ADLIB_INST_SPI1_SS4_MGPIO17A_OE                : std_logic;
signal MSS_ADLIB_INST_SPI1_SS4_MGPIO17A_OUT               : std_logic;
signal MSS_ADLIB_INST_SPI1_SS5_MGPIO18A_OE                : std_logic;
signal MSS_ADLIB_INST_SPI1_SS5_MGPIO18A_OUT               : std_logic;
signal MSS_RESET_N_M2F_net_0                              : std_logic;
signal SPI_0_CLK_PAD_Y                                    : std_logic;
signal SPI_0_DI_PAD_Y                                     : std_logic;
signal SPI_0_DO_net_0                                     : std_logic;
signal SPI_0_SS0_PAD_Y                                    : std_logic;
signal SPI_0_SS1_net_0                                    : std_logic;
signal SPI_1_CLK_M2F_net_0                                : std_logic;
signal SPI_1_DO_M2F_net_0                                 : std_logic;
signal SPI_1_SS0_M2F_net_0                                : std_logic;
signal SPI_1_SS0_M2F_OE_net_0                             : std_logic;
signal SPI_0_DO_net_1                                     : std_logic;
signal MMUART_1_TXD_net_1                                 : std_logic;
signal MAC_MII_TX_EN_net_1                                : std_logic;
signal MAC_MII_TX_ER_net_1                                : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_1                        : std_logic;
signal MDDR_CAS_N_net_1                                   : std_logic;
signal MDDR_CLK_net_1                                     : std_logic;
signal MDDR_CLK_N_net_1                                   : std_logic;
signal MDDR_CKE_net_1                                     : std_logic;
signal MDDR_CS_N_net_1                                    : std_logic;
signal MDDR_ODT_net_1                                     : std_logic;
signal MDDR_RAS_N_net_1                                   : std_logic;
signal MDDR_RESET_N_net_1                                 : std_logic;
signal MDDR_WE_N_net_1                                    : std_logic;
signal MSS_RESET_N_M2F_net_1                              : std_logic;
signal GPIO_1_M2F_net_1                                   : std_logic;
signal MAC_MII_MDC_net_1                                  : std_logic;
signal MAC_MII_MDO_EN_net_1                               : std_logic;
signal MAC_MII_MDO_net_1                                  : std_logic;
signal FIC_2_APB_M_PRESET_N_0_net_0                       : std_logic;
signal FIC_2_APB_M_PCLK_0_net_0                           : std_logic;
signal FIC_2_APB_MASTER_0_PWRITE_net_0                    : std_logic;
signal FIC_2_APB_MASTER_0_PENABLE_net_0                   : std_logic;
signal FIC_2_APB_MASTER_0_PSELx_net_0                     : std_logic;
signal MDDR_APB_SLAVE_PREADY_net_0                        : std_logic;
signal MDDR_APB_SLAVE_PSLVERR_net_0                       : std_logic;
signal FIC_0_APB_MASTER_PSELx_net_0                       : std_logic;
signal FIC_0_APB_MASTER_PWRITE_net_0                      : std_logic;
signal FIC_0_APB_MASTER_PENABLE_net_0                     : std_logic;
signal MMUART_0_TXD_M2F_net_1                             : std_logic;
signal GPIO_5_M2F_net_1                                   : std_logic;
signal GPIO_6_M2F_net_1                                   : std_logic;
signal GPIO_7_M2F_net_1                                   : std_logic;
signal GPIO_8_M2F_net_1                                   : std_logic;
signal GPIO_11_M2F_net_1                                  : std_logic;
signal GPIO_20_OUT_net_1                                  : std_logic;
signal GPIO_21_M2F_net_1                                  : std_logic;
signal GPIO_22_M2F_net_1                                  : std_logic;
signal GPIO_24_M2F_net_1                                  : std_logic;
signal GPIO_28_M2F_net_1                                  : std_logic;
signal SPI_0_SS1_net_1                                    : std_logic;
signal GPIO_1_M2F_OE_0_net_0                              : std_logic;
signal SPI_1_DO_M2F_net_1                                 : std_logic;
signal SPI_1_CLK_M2F_net_1                                : std_logic;
signal SPI_1_SS0_M2F_net_1                                : std_logic;
signal SPI_1_SS0_M2F_OE_net_1                             : std_logic;
signal GPIO_6_M2F_OE_net_1                                : std_logic;
signal GPIO_7_M2F_OE_net_1                                : std_logic;
signal MAC_MII_TXD_2_net_0                                : std_logic_vector(0 to 0);
signal MAC_MII_TXD_1_net_0                                : std_logic_vector(1 to 1);
signal MAC_MII_TXD_0_net_0                                : std_logic_vector(2 to 2);
signal MAC_MII_TXD_net_1                                  : std_logic_vector(3 to 3);
signal MDDR_ADDR_14_net_0                                 : std_logic_vector(0 to 0);
signal MDDR_ADDR_4_net_0                                  : std_logic_vector(10 to 10);
signal MDDR_ADDR_3_net_0                                  : std_logic_vector(11 to 11);
signal MDDR_ADDR_2_net_0                                  : std_logic_vector(12 to 12);
signal MDDR_ADDR_1_net_0                                  : std_logic_vector(13 to 13);
signal MDDR_ADDR_0_net_0                                  : std_logic_vector(14 to 14);
signal MDDR_ADDR_net_1                                    : std_logic_vector(15 to 15);
signal MDDR_ADDR_13_net_0                                 : std_logic_vector(1 to 1);
signal MDDR_ADDR_12_net_0                                 : std_logic_vector(2 to 2);
signal MDDR_ADDR_11_net_0                                 : std_logic_vector(3 to 3);
signal MDDR_ADDR_10_net_0                                 : std_logic_vector(4 to 4);
signal MDDR_ADDR_9_net_0                                  : std_logic_vector(5 to 5);
signal MDDR_ADDR_8_net_0                                  : std_logic_vector(6 to 6);
signal MDDR_ADDR_7_net_0                                  : std_logic_vector(7 to 7);
signal MDDR_ADDR_6_net_0                                  : std_logic_vector(8 to 8);
signal MDDR_ADDR_5_net_0                                  : std_logic_vector(9 to 9);
signal MDDR_BA_1_net_0                                    : std_logic_vector(0 to 0);
signal MDDR_BA_0_net_0                                    : std_logic_vector(1 to 1);
signal MDDR_BA_net_1                                      : std_logic_vector(2 to 2);
signal FIC_2_APB_MASTER_0_PADDR_net_0                     : std_logic_vector(15 downto 2);
signal FIC_2_APB_MASTER_0_PWDATA_net_0                    : std_logic_vector(31 downto 0);
signal MDDR_APB_SLAVE_PRDATA_net_0                        : std_logic_vector(15 downto 0);
signal FIC_0_APB_MASTER_PADDR_net_0                       : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PWDATA_net_0                      : std_logic_vector(31 downto 0);
signal TXDF_slice_0                                       : std_logic_vector(4 to 4);
signal TXDF_slice_1                                       : std_logic_vector(5 to 5);
signal TXDF_slice_2                                       : std_logic_vector(6 to 6);
signal TXDF_slice_3                                       : std_logic_vector(7 to 7);
signal DRAM_DM_RDQS_OUT_slice_0                           : std_logic_vector(2 to 2);
signal DRAM_DQ_OUT_slice_0                                : std_logic_vector(16 to 16);
signal DRAM_DQ_OUT_slice_1                                : std_logic_vector(17 to 17);
signal DRAM_DQS_OUT_slice_0                               : std_logic_vector(2 to 2);
signal DRAM_FIFO_WE_OUT_slice_0                           : std_logic_vector(1 to 1);
signal DM_OE_slice_0                                      : std_logic_vector(2 to 2);
signal DRAM_DQ_OE_slice_0                                 : std_logic_vector(16 to 16);
signal DRAM_DQ_OE_slice_1                                 : std_logic_vector(17 to 17);
signal DRAM_DQS_OE_slice_0                                : std_logic_vector(2 to 2);
signal RXDF_net_0                                         : std_logic_vector(7 downto 0);
signal TXDF_net_0                                         : std_logic_vector(7 downto 0);
signal DM_IN_net_0                                        : std_logic_vector(2 downto 0);
signal DRAM_DQ_IN_net_0                                   : std_logic_vector(17 downto 0);
signal DRAM_DQS_IN_net_0                                  : std_logic_vector(2 downto 0);
signal DRAM_FIFO_WE_IN_net_0                              : std_logic_vector(1 downto 0);
signal DRAM_ADDR_net_0                                    : std_logic_vector(15 downto 0);
signal DRAM_BA_net_0                                      : std_logic_vector(2 downto 0);
signal DRAM_DM_RDQS_OUT_net_0                             : std_logic_vector(2 downto 0);
signal DRAM_DQ_OUT_net_0                                  : std_logic_vector(17 downto 0);
signal DRAM_DQS_OUT_net_0                                 : std_logic_vector(2 downto 0);
signal DRAM_FIFO_WE_OUT_net_0                             : std_logic_vector(1 downto 0);
signal DM_OE_net_0                                        : std_logic_vector(2 downto 0);
signal DRAM_DQ_OE_net_0                                   : std_logic_vector(17 downto 0);
signal DRAM_DQS_OE_net_0                                  : std_logic_vector(2 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                                            : std_logic;
signal VCC_net                                            : std_logic;
signal F2_DMAREADY_const_net_0                            : std_logic_vector(1 downto 0);
signal F_DMAREADY_const_net_0                             : std_logic_vector(1 downto 0);
signal F_FM0_ADDR_const_net_0                             : std_logic_vector(31 downto 0);
signal F_FM0_SIZE_const_net_0                             : std_logic_vector(1 downto 0);
signal F_FM0_WDATA_const_net_0                            : std_logic_vector(31 downto 0);
signal FAB_LINESTATE_const_net_0                          : std_logic_vector(1 downto 0);
signal FAB_VSTATUS_const_net_0                            : std_logic_vector(7 downto 0);
signal FAB_XDATAIN_const_net_0                            : std_logic_vector(7 downto 0);
signal RCGF_const_net_0                                   : std_logic_vector(9 downto 0);
signal F_ARADDR_HADDR1_const_net_0                        : std_logic_vector(31 downto 0);
signal F_ARBURST_HTRANS1_const_net_0                      : std_logic_vector(1 downto 0);
signal F_ARID_HSEL1_const_net_0                           : std_logic_vector(3 downto 0);
signal F_ARLEN_HBURST1_const_net_0                        : std_logic_vector(3 downto 0);
signal F_ARLOCK_HMASTLOCK1_const_net_0                    : std_logic_vector(1 downto 0);
signal F_ARSIZE_HSIZE1_const_net_0                        : std_logic_vector(1 downto 0);
signal F_AWADDR_HADDR0_const_net_0                        : std_logic_vector(31 downto 0);
signal F_AWBURST_HTRANS0_const_net_0                      : std_logic_vector(1 downto 0);
signal F_AWID_HSEL0_const_net_0                           : std_logic_vector(3 downto 0);
signal F_AWLEN_HBURST0_const_net_0                        : std_logic_vector(3 downto 0);
signal F_AWLOCK_HMASTLOCK0_const_net_0                    : std_logic_vector(1 downto 0);
signal F_AWSIZE_HSIZE0_const_net_0                        : std_logic_vector(1 downto 0);
signal F_WDATA_HWDATA01_const_net_0                       : std_logic_vector(63 downto 0);
signal F_WID_HREADY01_const_net_0                         : std_logic_vector(3 downto 0);
signal F_WSTRB_const_net_0                                : std_logic_vector(7 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net                         <= '0';
 VCC_net                         <= '1';
 F2_DMAREADY_const_net_0         <= B"11";
 F_DMAREADY_const_net_0          <= B"11";
 F_FM0_ADDR_const_net_0          <= B"00000000000000000000000000000000";
 F_FM0_SIZE_const_net_0          <= B"00";
 F_FM0_WDATA_const_net_0         <= B"00000000000000000000000000000000";
 FAB_LINESTATE_const_net_0       <= B"11";
 FAB_VSTATUS_const_net_0         <= B"11111111";
 FAB_XDATAIN_const_net_0         <= B"11111111";
 RCGF_const_net_0                <= B"1111111111";
 F_ARADDR_HADDR1_const_net_0     <= B"11111111111111111111111111111111";
 F_ARBURST_HTRANS1_const_net_0   <= B"00";
 F_ARID_HSEL1_const_net_0        <= B"0000";
 F_ARLEN_HBURST1_const_net_0     <= B"0000";
 F_ARLOCK_HMASTLOCK1_const_net_0 <= B"00";
 F_ARSIZE_HSIZE1_const_net_0     <= B"00";
 F_AWADDR_HADDR0_const_net_0     <= B"11111111111111111111111111111111";
 F_AWBURST_HTRANS0_const_net_0   <= B"00";
 F_AWID_HSEL0_const_net_0        <= B"0000";
 F_AWLEN_HBURST0_const_net_0     <= B"0000";
 F_AWLOCK_HMASTLOCK0_const_net_0 <= B"00";
 F_AWSIZE_HSIZE0_const_net_0     <= B"00";
 F_WDATA_HWDATA01_const_net_0    <= B"1111111111111111111111111111111111111111111111111111111111111111";
 F_WID_HREADY01_const_net_0      <= B"0000";
 F_WSTRB_const_net_0             <= B"00000000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_0_DO_net_1                   <= SPI_0_DO_net_0;
 SPI_0_DO                         <= SPI_0_DO_net_1;
 MMUART_1_TXD_net_1               <= MMUART_1_TXD_net_0;
 MMUART_1_TXD                     <= MMUART_1_TXD_net_1;
 MAC_MII_TX_EN_net_1              <= MAC_MII_TX_EN_net_0;
 MAC_MII_TX_EN                    <= MAC_MII_TX_EN_net_1;
 MAC_MII_TX_ER_net_1              <= MAC_MII_TX_ER_net_0;
 MAC_MII_TX_ER                    <= MAC_MII_TX_ER_net_1;
 MDDR_DQS_TMATCH_0_OUT_net_1      <= MDDR_DQS_TMATCH_0_OUT_net_0;
 MDDR_DQS_TMATCH_0_OUT            <= MDDR_DQS_TMATCH_0_OUT_net_1;
 MDDR_CAS_N_net_1                 <= MDDR_CAS_N_net_0;
 MDDR_CAS_N                       <= MDDR_CAS_N_net_1;
 MDDR_CLK_net_1                   <= MDDR_CLK_net_0;
 MDDR_CLK                         <= MDDR_CLK_net_1;
 MDDR_CLK_N_net_1                 <= MDDR_CLK_N_net_0;
 MDDR_CLK_N                       <= MDDR_CLK_N_net_1;
 MDDR_CKE_net_1                   <= MDDR_CKE_net_0;
 MDDR_CKE                         <= MDDR_CKE_net_1;
 MDDR_CS_N_net_1                  <= MDDR_CS_N_net_0;
 MDDR_CS_N                        <= MDDR_CS_N_net_1;
 MDDR_ODT_net_1                   <= MDDR_ODT_net_0;
 MDDR_ODT                         <= MDDR_ODT_net_1;
 MDDR_RAS_N_net_1                 <= MDDR_RAS_N_net_0;
 MDDR_RAS_N                       <= MDDR_RAS_N_net_1;
 MDDR_RESET_N_net_1               <= MDDR_RESET_N_net_0;
 MDDR_RESET_N                     <= MDDR_RESET_N_net_1;
 MDDR_WE_N_net_1                  <= MDDR_WE_N_net_0;
 MDDR_WE_N                        <= MDDR_WE_N_net_1;
 MSS_RESET_N_M2F_net_1            <= MSS_RESET_N_M2F_net_0;
 MSS_RESET_N_M2F                  <= MSS_RESET_N_M2F_net_1;
 GPIO_1_M2F_net_1                 <= GPIO_1_M2F_net_0;
 GPIO_1_M2F                       <= GPIO_1_M2F_net_1;
 MAC_MII_MDC_net_1                <= MAC_MII_MDC_net_0;
 MAC_MII_MDC                      <= MAC_MII_MDC_net_1;
 MAC_MII_MDO_EN_net_1             <= MAC_MII_MDO_EN_net_0;
 MAC_MII_MDO_EN                   <= MAC_MII_MDO_EN_net_1;
 MAC_MII_MDO_net_1                <= MAC_MII_MDO_net_0;
 MAC_MII_MDO                      <= MAC_MII_MDO_net_1;
 FIC_2_APB_M_PRESET_N_0_net_0     <= FIC_2_APB_M_PRESET_N_0;
 FIC_2_APB_M_PRESET_N             <= FIC_2_APB_M_PRESET_N_0_net_0;
 FIC_2_APB_M_PCLK_0_net_0         <= FIC_2_APB_M_PCLK_0;
 FIC_2_APB_M_PCLK                 <= FIC_2_APB_M_PCLK_0_net_0;
 FIC_2_APB_MASTER_0_PWRITE_net_0  <= FIC_2_APB_MASTER_0_PWRITE;
 FIC_2_APB_M_PWRITE               <= FIC_2_APB_MASTER_0_PWRITE_net_0;
 FIC_2_APB_MASTER_0_PENABLE_net_0 <= FIC_2_APB_MASTER_0_PENABLE;
 FIC_2_APB_M_PENABLE              <= FIC_2_APB_MASTER_0_PENABLE_net_0;
 FIC_2_APB_MASTER_0_PSELx_net_0   <= FIC_2_APB_MASTER_0_PSELx;
 FIC_2_APB_M_PSEL                 <= FIC_2_APB_MASTER_0_PSELx_net_0;
 MDDR_APB_SLAVE_PREADY_net_0      <= MDDR_APB_SLAVE_PREADY;
 MDDR_APB_S_PREADY                <= MDDR_APB_SLAVE_PREADY_net_0;
 MDDR_APB_SLAVE_PSLVERR_net_0     <= MDDR_APB_SLAVE_PSLVERR;
 MDDR_APB_S_PSLVERR               <= MDDR_APB_SLAVE_PSLVERR_net_0;
 FIC_0_APB_MASTER_PSELx_net_0     <= FIC_0_APB_MASTER_PSELx;
 FIC_0_APB_M_PSEL                 <= FIC_0_APB_MASTER_PSELx_net_0;
 FIC_0_APB_MASTER_PWRITE_net_0    <= FIC_0_APB_MASTER_PWRITE;
 FIC_0_APB_M_PWRITE               <= FIC_0_APB_MASTER_PWRITE_net_0;
 FIC_0_APB_MASTER_PENABLE_net_0   <= FIC_0_APB_MASTER_PENABLE;
 FIC_0_APB_M_PENABLE              <= FIC_0_APB_MASTER_PENABLE_net_0;
 MMUART_0_TXD_M2F_net_1           <= MMUART_0_TXD_M2F_net_0;
 MMUART_0_TXD_M2F                 <= MMUART_0_TXD_M2F_net_1;
 GPIO_5_M2F_net_1                 <= GPIO_5_M2F_net_0;
 GPIO_5_M2F                       <= GPIO_5_M2F_net_1;
 GPIO_6_M2F_net_1                 <= GPIO_6_M2F_net_0;
 GPIO_6_M2F                       <= GPIO_6_M2F_net_1;
 GPIO_7_M2F_net_1                 <= GPIO_7_M2F_net_0;
 GPIO_7_M2F                       <= GPIO_7_M2F_net_1;
 GPIO_8_M2F_net_1                 <= GPIO_8_M2F_net_0;
 GPIO_8_M2F                       <= GPIO_8_M2F_net_1;
 GPIO_11_M2F_net_1                <= GPIO_11_M2F_net_0;
 GPIO_11_M2F                      <= GPIO_11_M2F_net_1;
 GPIO_20_OUT_net_1                <= GPIO_20_OUT_net_0;
 GPIO_20_OUT                      <= GPIO_20_OUT_net_1;
 GPIO_21_M2F_net_1                <= GPIO_21_M2F_net_0;
 GPIO_21_M2F                      <= GPIO_21_M2F_net_1;
 GPIO_22_M2F_net_1                <= GPIO_22_M2F_net_0;
 GPIO_22_M2F                      <= GPIO_22_M2F_net_1;
 GPIO_24_M2F_net_1                <= GPIO_24_M2F_net_0;
 GPIO_24_M2F                      <= GPIO_24_M2F_net_1;
 GPIO_28_M2F_net_1                <= GPIO_28_M2F_net_0;
 GPIO_28_M2F                      <= GPIO_28_M2F_net_1;
 SPI_0_SS1_net_1                  <= SPI_0_SS1_net_0;
 SPI_0_SS1                        <= SPI_0_SS1_net_1;
 GPIO_1_M2F_OE_0_net_0            <= GPIO_1_M2F_OE_0;
 GPIO_1_M2F_OE                    <= GPIO_1_M2F_OE_0_net_0;
 SPI_1_DO_M2F_net_1               <= SPI_1_DO_M2F_net_0;
 SPI_1_DO_M2F                     <= SPI_1_DO_M2F_net_1;
 SPI_1_CLK_M2F_net_1              <= SPI_1_CLK_M2F_net_0;
 SPI_1_CLK_M2F                    <= SPI_1_CLK_M2F_net_1;
 SPI_1_SS0_M2F_net_1              <= SPI_1_SS0_M2F_net_0;
 SPI_1_SS0_M2F                    <= SPI_1_SS0_M2F_net_1;
 SPI_1_SS0_M2F_OE_net_1           <= SPI_1_SS0_M2F_OE_net_0;
 SPI_1_SS0_M2F_OE                 <= SPI_1_SS0_M2F_OE_net_1;
 GPIO_6_M2F_OE_net_1              <= GPIO_6_M2F_OE_net_0;
 GPIO_6_M2F_OE                    <= GPIO_6_M2F_OE_net_1;
 GPIO_7_M2F_OE_net_1              <= GPIO_7_M2F_OE_net_0;
 GPIO_7_M2F_OE                    <= GPIO_7_M2F_OE_net_1;
 MAC_MII_TXD_2_net_0(0)           <= MAC_MII_TXD_2(0);
 MAC_MII_TXD(0)                   <= MAC_MII_TXD_2_net_0(0);
 MAC_MII_TXD_1_net_0(1)           <= MAC_MII_TXD_1(1);
 MAC_MII_TXD(1)                   <= MAC_MII_TXD_1_net_0(1);
 MAC_MII_TXD_0_net_0(2)           <= MAC_MII_TXD_0(2);
 MAC_MII_TXD(2)                   <= MAC_MII_TXD_0_net_0(2);
 MAC_MII_TXD_net_1(3)             <= MAC_MII_TXD_net_0(3);
 MAC_MII_TXD(3)                   <= MAC_MII_TXD_net_1(3);
 MDDR_ADDR_14_net_0(0)            <= MDDR_ADDR_14;
 MDDR_ADDR(0)                     <= MDDR_ADDR_14_net_0(0);
 MDDR_ADDR_4_net_0(10)            <= MDDR_ADDR_4;
 MDDR_ADDR(10)                    <= MDDR_ADDR_4_net_0(10);
 MDDR_ADDR_3_net_0(11)            <= MDDR_ADDR_3;
 MDDR_ADDR(11)                    <= MDDR_ADDR_3_net_0(11);
 MDDR_ADDR_2_net_0(12)            <= MDDR_ADDR_2;
 MDDR_ADDR(12)                    <= MDDR_ADDR_2_net_0(12);
 MDDR_ADDR_1_net_0(13)            <= MDDR_ADDR_1;
 MDDR_ADDR(13)                    <= MDDR_ADDR_1_net_0(13);
 MDDR_ADDR_0_net_0(14)            <= MDDR_ADDR_0;
 MDDR_ADDR(14)                    <= MDDR_ADDR_0_net_0(14);
 MDDR_ADDR_net_1(15)              <= MDDR_ADDR_net_0;
 MDDR_ADDR(15)                    <= MDDR_ADDR_net_1(15);
 MDDR_ADDR_13_net_0(1)            <= MDDR_ADDR_13;
 MDDR_ADDR(1)                     <= MDDR_ADDR_13_net_0(1);
 MDDR_ADDR_12_net_0(2)            <= MDDR_ADDR_12;
 MDDR_ADDR(2)                     <= MDDR_ADDR_12_net_0(2);
 MDDR_ADDR_11_net_0(3)            <= MDDR_ADDR_11;
 MDDR_ADDR(3)                     <= MDDR_ADDR_11_net_0(3);
 MDDR_ADDR_10_net_0(4)            <= MDDR_ADDR_10;
 MDDR_ADDR(4)                     <= MDDR_ADDR_10_net_0(4);
 MDDR_ADDR_9_net_0(5)             <= MDDR_ADDR_9;
 MDDR_ADDR(5)                     <= MDDR_ADDR_9_net_0(5);
 MDDR_ADDR_8_net_0(6)             <= MDDR_ADDR_8;
 MDDR_ADDR(6)                     <= MDDR_ADDR_8_net_0(6);
 MDDR_ADDR_7_net_0(7)             <= MDDR_ADDR_7;
 MDDR_ADDR(7)                     <= MDDR_ADDR_7_net_0(7);
 MDDR_ADDR_6_net_0(8)             <= MDDR_ADDR_6;
 MDDR_ADDR(8)                     <= MDDR_ADDR_6_net_0(8);
 MDDR_ADDR_5_net_0(9)             <= MDDR_ADDR_5;
 MDDR_ADDR(9)                     <= MDDR_ADDR_5_net_0(9);
 MDDR_BA_1_net_0(0)               <= MDDR_BA_1;
 MDDR_BA(0)                       <= MDDR_BA_1_net_0(0);
 MDDR_BA_0_net_0(1)               <= MDDR_BA_0;
 MDDR_BA(1)                       <= MDDR_BA_0_net_0(1);
 MDDR_BA_net_1(2)                 <= MDDR_BA_net_0;
 MDDR_BA(2)                       <= MDDR_BA_net_1(2);
 FIC_2_APB_MASTER_0_PADDR_net_0   <= FIC_2_APB_MASTER_0_PADDR;
 FIC_2_APB_M_PADDR(15 downto 2)   <= FIC_2_APB_MASTER_0_PADDR_net_0;
 FIC_2_APB_MASTER_0_PWDATA_net_0  <= FIC_2_APB_MASTER_0_PWDATA;
 FIC_2_APB_M_PWDATA(31 downto 0)  <= FIC_2_APB_MASTER_0_PWDATA_net_0;
 MDDR_APB_SLAVE_PRDATA_net_0      <= MDDR_APB_SLAVE_PRDATA;
 MDDR_APB_S_PRDATA(15 downto 0)   <= MDDR_APB_SLAVE_PRDATA_net_0;
 FIC_0_APB_MASTER_PADDR_net_0     <= FIC_0_APB_MASTER_PADDR;
 FIC_0_APB_M_PADDR(31 downto 0)   <= FIC_0_APB_MASTER_PADDR_net_0;
 FIC_0_APB_MASTER_PWDATA_net_0    <= FIC_0_APB_MASTER_PWDATA;
 FIC_0_APB_M_PWDATA(31 downto 0)  <= FIC_0_APB_MASTER_PWDATA_net_0;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 MAC_MII_RXD_slice_0(3)                 <= MAC_MII_RXD(3);
 MAC_MII_RXD_slice_1(2)                 <= MAC_MII_RXD(2);
 MAC_MII_RXD_slice_2(1)                 <= MAC_MII_RXD(1);
 MAC_MII_RXD_slice_3(0)                 <= MAC_MII_RXD(0);
 MAC_MII_TXD_net_0(3)                   <= TXDF_net_0(3);
 MAC_MII_TXD_0(2)                       <= TXDF_net_0(2);
 MAC_MII_TXD_1(1)                       <= TXDF_net_0(1);
 MAC_MII_TXD_2(0)                       <= TXDF_net_0(0);
 MSS_ADLIB_INST_DM_OE0to0(0)            <= DM_OE_net_0(0);
 MSS_ADLIB_INST_DM_OE1to1(1)            <= DM_OE_net_0(1);
 MSS_ADLIB_INST_DRAM_ADDR0to0(0)        <= DRAM_ADDR_net_0(0);
 MSS_ADLIB_INST_DRAM_ADDR1to1(1)        <= DRAM_ADDR_net_0(1);
 MSS_ADLIB_INST_DRAM_ADDR2to2(2)        <= DRAM_ADDR_net_0(2);
 MSS_ADLIB_INST_DRAM_ADDR3to3(3)        <= DRAM_ADDR_net_0(3);
 MSS_ADLIB_INST_DRAM_ADDR4to4(4)        <= DRAM_ADDR_net_0(4);
 MSS_ADLIB_INST_DRAM_ADDR5to5(5)        <= DRAM_ADDR_net_0(5);
 MSS_ADLIB_INST_DRAM_ADDR6to6(6)        <= DRAM_ADDR_net_0(6);
 MSS_ADLIB_INST_DRAM_ADDR7to7(7)        <= DRAM_ADDR_net_0(7);
 MSS_ADLIB_INST_DRAM_ADDR8to8(8)        <= DRAM_ADDR_net_0(8);
 MSS_ADLIB_INST_DRAM_ADDR9to9(9)        <= DRAM_ADDR_net_0(9);
 MSS_ADLIB_INST_DRAM_ADDR10to10(10)     <= DRAM_ADDR_net_0(10);
 MSS_ADLIB_INST_DRAM_ADDR11to11(11)     <= DRAM_ADDR_net_0(11);
 MSS_ADLIB_INST_DRAM_ADDR12to12(12)     <= DRAM_ADDR_net_0(12);
 MSS_ADLIB_INST_DRAM_ADDR13to13(13)     <= DRAM_ADDR_net_0(13);
 MSS_ADLIB_INST_DRAM_ADDR14to14(14)     <= DRAM_ADDR_net_0(14);
 MSS_ADLIB_INST_DRAM_ADDR15to15(15)     <= DRAM_ADDR_net_0(15);
 MSS_ADLIB_INST_DRAM_BA0to0(0)          <= DRAM_BA_net_0(0);
 MSS_ADLIB_INST_DRAM_BA1to1(1)          <= DRAM_BA_net_0(1);
 MSS_ADLIB_INST_DRAM_BA2to2(2)          <= DRAM_BA_net_0(2);
 MSS_ADLIB_INST_DRAM_DM_RDQS_OUT0to0(0) <= DRAM_DM_RDQS_OUT_net_0(0);
 MSS_ADLIB_INST_DRAM_DM_RDQS_OUT1to1(1) <= DRAM_DM_RDQS_OUT_net_0(1);
 MSS_ADLIB_INST_DRAM_DQ_OE0to0(0)       <= DRAM_DQ_OE_net_0(0);
 MSS_ADLIB_INST_DRAM_DQ_OE1to1(1)       <= DRAM_DQ_OE_net_0(1);
 MSS_ADLIB_INST_DRAM_DQ_OE2to2(2)       <= DRAM_DQ_OE_net_0(2);
 MSS_ADLIB_INST_DRAM_DQ_OE3to3(3)       <= DRAM_DQ_OE_net_0(3);
 MSS_ADLIB_INST_DRAM_DQ_OE4to4(4)       <= DRAM_DQ_OE_net_0(4);
 MSS_ADLIB_INST_DRAM_DQ_OE5to5(5)       <= DRAM_DQ_OE_net_0(5);
 MSS_ADLIB_INST_DRAM_DQ_OE6to6(6)       <= DRAM_DQ_OE_net_0(6);
 MSS_ADLIB_INST_DRAM_DQ_OE7to7(7)       <= DRAM_DQ_OE_net_0(7);
 MSS_ADLIB_INST_DRAM_DQ_OE8to8(8)       <= DRAM_DQ_OE_net_0(8);
 MSS_ADLIB_INST_DRAM_DQ_OE9to9(9)       <= DRAM_DQ_OE_net_0(9);
 MSS_ADLIB_INST_DRAM_DQ_OE10to10(10)    <= DRAM_DQ_OE_net_0(10);
 MSS_ADLIB_INST_DRAM_DQ_OE11to11(11)    <= DRAM_DQ_OE_net_0(11);
 MSS_ADLIB_INST_DRAM_DQ_OE12to12(12)    <= DRAM_DQ_OE_net_0(12);
 MSS_ADLIB_INST_DRAM_DQ_OE13to13(13)    <= DRAM_DQ_OE_net_0(13);
 MSS_ADLIB_INST_DRAM_DQ_OE14to14(14)    <= DRAM_DQ_OE_net_0(14);
 MSS_ADLIB_INST_DRAM_DQ_OE15to15(15)    <= DRAM_DQ_OE_net_0(15);
 MSS_ADLIB_INST_DRAM_DQ_OUT0to0(0)      <= DRAM_DQ_OUT_net_0(0);
 MSS_ADLIB_INST_DRAM_DQ_OUT1to1(1)      <= DRAM_DQ_OUT_net_0(1);
 MSS_ADLIB_INST_DRAM_DQ_OUT2to2(2)      <= DRAM_DQ_OUT_net_0(2);
 MSS_ADLIB_INST_DRAM_DQ_OUT3to3(3)      <= DRAM_DQ_OUT_net_0(3);
 MSS_ADLIB_INST_DRAM_DQ_OUT4to4(4)      <= DRAM_DQ_OUT_net_0(4);
 MSS_ADLIB_INST_DRAM_DQ_OUT5to5(5)      <= DRAM_DQ_OUT_net_0(5);
 MSS_ADLIB_INST_DRAM_DQ_OUT6to6(6)      <= DRAM_DQ_OUT_net_0(6);
 MSS_ADLIB_INST_DRAM_DQ_OUT7to7(7)      <= DRAM_DQ_OUT_net_0(7);
 MSS_ADLIB_INST_DRAM_DQ_OUT8to8(8)      <= DRAM_DQ_OUT_net_0(8);
 MSS_ADLIB_INST_DRAM_DQ_OUT9to9(9)      <= DRAM_DQ_OUT_net_0(9);
 MSS_ADLIB_INST_DRAM_DQ_OUT10to10(10)   <= DRAM_DQ_OUT_net_0(10);
 MSS_ADLIB_INST_DRAM_DQ_OUT11to11(11)   <= DRAM_DQ_OUT_net_0(11);
 MSS_ADLIB_INST_DRAM_DQ_OUT12to12(12)   <= DRAM_DQ_OUT_net_0(12);
 MSS_ADLIB_INST_DRAM_DQ_OUT13to13(13)   <= DRAM_DQ_OUT_net_0(13);
 MSS_ADLIB_INST_DRAM_DQ_OUT14to14(14)   <= DRAM_DQ_OUT_net_0(14);
 MSS_ADLIB_INST_DRAM_DQ_OUT15to15(15)   <= DRAM_DQ_OUT_net_0(15);
 MSS_ADLIB_INST_DRAM_DQS_OE0to0(0)      <= DRAM_DQS_OE_net_0(0);
 MSS_ADLIB_INST_DRAM_DQS_OE1to1(1)      <= DRAM_DQS_OE_net_0(1);
 MSS_ADLIB_INST_DRAM_DQS_OUT0to0(0)     <= DRAM_DQS_OUT_net_0(0);
 MSS_ADLIB_INST_DRAM_DQS_OUT1to1(1)     <= DRAM_DQS_OUT_net_0(1);
 MSS_ADLIB_INST_DRAM_FIFO_WE_OUT0to0(0) <= DRAM_FIFO_WE_OUT_net_0(0);
 TXDF_slice_0(4)                        <= TXDF_net_0(4);
 TXDF_slice_1(5)                        <= TXDF_net_0(5);
 TXDF_slice_2(6)                        <= TXDF_net_0(6);
 TXDF_slice_3(7)                        <= TXDF_net_0(7);
 DRAM_DM_RDQS_OUT_slice_0(2)            <= DRAM_DM_RDQS_OUT_net_0(2);
 DRAM_DQ_OUT_slice_0(16)                <= DRAM_DQ_OUT_net_0(16);
 DRAM_DQ_OUT_slice_1(17)                <= DRAM_DQ_OUT_net_0(17);
 DRAM_DQS_OUT_slice_0(2)                <= DRAM_DQS_OUT_net_0(2);
 DRAM_FIFO_WE_OUT_slice_0(1)            <= DRAM_FIFO_WE_OUT_net_0(1);
 DM_OE_slice_0(2)                       <= DM_OE_net_0(2);
 DRAM_DQ_OE_slice_0(16)                 <= DRAM_DQ_OE_net_0(16);
 DRAM_DQ_OE_slice_1(17)                 <= DRAM_DQ_OE_net_0(17);
 DRAM_DQS_OE_slice_0(2)                 <= DRAM_DQS_OE_net_0(2);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 RXDF_net_0            <= ( '1' & '1' & '1' & '1' & MAC_MII_RXD_slice_0(3) & MAC_MII_RXD_slice_1(2) & MAC_MII_RXD_slice_2(1) & MAC_MII_RXD_slice_3(0) );
 DM_IN_net_0           <= ( '0' & MDDR_DM_RDQS_1_PAD_Y & MDDR_DM_RDQS_0_PAD_Y );
 DRAM_DQ_IN_net_0      <= ( '0' & '0' & MDDR_DQ_15_PAD_Y & MDDR_DQ_14_PAD_Y & MDDR_DQ_13_PAD_Y & MDDR_DQ_12_PAD_Y & MDDR_DQ_11_PAD_Y & MDDR_DQ_10_PAD_Y & MDDR_DQ_9_PAD_Y & MDDR_DQ_8_PAD_Y & MDDR_DQ_7_PAD_Y & MDDR_DQ_6_PAD_Y & MDDR_DQ_5_PAD_Y & MDDR_DQ_4_PAD_Y & MDDR_DQ_3_PAD_Y & MDDR_DQ_2_PAD_Y & MDDR_DQ_1_PAD_Y & MDDR_DQ_0_PAD_Y );
 DRAM_DQS_IN_net_0     <= ( '0' & MDDR_DQS_1_PAD_Y & MDDR_DQS_0_PAD_Y );
 DRAM_FIFO_WE_IN_net_0 <= ( '0' & MDDR_DQS_TMATCH_0_IN_PAD_Y );
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- GPIO_GPIO_0_BI_PAD
GPIO_GPIO_0_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MGPIO0B_OUT,
        E   => MSS_ADLIB_INST_MGPIO0B_OE,
        -- Outputs
        Y   => GPIO_GPIO_0_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_0_BI 
        );
-- GPIO_GPIO_3_BI_PAD
GPIO_GPIO_3_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT,
        E   => MSS_ADLIB_INST_CAN_RXBUS_USBA_DATA1_MGPIO3A_OE,
        -- Outputs
        Y   => GPIO_GPIO_3_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_3_BI 
        );
-- GPIO_GPIO_4_BI_PAD
GPIO_GPIO_4_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT,
        E   => MSS_ADLIB_INST_CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE,
        -- Outputs
        Y   => GPIO_GPIO_4_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_4_BI 
        );
-- GPIO_GPIO_12_BI_PAD
GPIO_GPIO_12_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MMUART1_DTR_MGPIO12B_OUT,
        E   => MSS_ADLIB_INST_MMUART1_DTR_MGPIO12B_OE,
        -- Outputs
        Y   => GPIO_GPIO_12_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_12_BI 
        );
-- GPIO_GPIO_14_BI_PAD
GPIO_GPIO_14_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MMUART1_DSR_MGPIO14B_OUT,
        E   => MSS_ADLIB_INST_MMUART1_DSR_MGPIO14B_OE,
        -- Outputs
        Y   => GPIO_GPIO_14_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_14_BI 
        );
-- GPIO_GPIO_15_BI_PAD
GPIO_GPIO_15_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MMUART1_RI_MGPIO15B_OUT,
        E   => MSS_ADLIB_INST_MMUART1_RI_MGPIO15B_OE,
        -- Outputs
        Y   => GPIO_GPIO_15_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_15_BI 
        );
-- GPIO_GPIO_16_BI_PAD
GPIO_GPIO_16_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MMUART1_DCD_MGPIO16B_OUT,
        E   => MSS_ADLIB_INST_MMUART1_DCD_MGPIO16B_OE,
        -- Outputs
        Y   => GPIO_GPIO_16_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_16_BI 
        );
-- GPIO_GPIO_17_BI_PAD
GPIO_GPIO_17_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_SPI1_SS4_MGPIO17A_OUT,
        E   => MSS_ADLIB_INST_SPI1_SS4_MGPIO17A_OE,
        -- Outputs
        Y   => GPIO_GPIO_17_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_17_BI 
        );
-- GPIO_GPIO_18_BI_PAD
GPIO_GPIO_18_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_SPI1_SS5_MGPIO18A_OUT,
        E   => MSS_ADLIB_INST_SPI1_SS5_MGPIO18A_OE,
        -- Outputs
        Y   => GPIO_GPIO_18_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_18_BI 
        );
-- GPIO_GPIO_20_OUT_PAD
GPIO_GPIO_20_OUT_PAD : OUTBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_SPI0_SS5_MGPIO20A_OUT,
        -- Outputs
        PAD => GPIO_20_OUT_net_0 
        );
-- GPIO_GPIO_25_BI_PAD
GPIO_GPIO_25_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MGPIO25A_OUT,
        E   => MSS_ADLIB_INST_MGPIO25A_OE,
        -- Outputs
        Y   => GPIO_GPIO_25_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_25_BI 
        );
-- GPIO_GPIO_26_BI_PAD
GPIO_GPIO_26_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MGPIO26A_OUT,
        E   => MSS_ADLIB_INST_MGPIO26A_OE,
        -- Outputs
        Y   => GPIO_GPIO_26_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_26_BI 
        );
-- GPIO_GPIO_31_BI_PAD
GPIO_GPIO_31_BI_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MGPIO31A_OUT,
        E   => MSS_ADLIB_INST_MGPIO31A_OE,
        -- Outputs
        Y   => GPIO_GPIO_31_BI_PAD_Y,
        -- Inouts
        PAD => GPIO_31_BI 
        );
-- I2C_1_SCL_PAD
I2C_1_SCL_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_I2C1_SCL_USBA_DATA4_MGPIO1A_OUT,
        E   => MSS_ADLIB_INST_I2C1_SCL_USBA_DATA4_MGPIO1A_OE,
        -- Outputs
        Y   => I2C_1_SCL_PAD_Y,
        -- Inouts
        PAD => I2C_1_SCL 
        );
-- I2C_1_SDA_PAD
I2C_1_SDA_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OUT,
        E   => MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OE,
        -- Outputs
        Y   => I2C_1_SDA_PAD_Y,
        -- Inouts
        PAD => I2C_1_SDA 
        );
-- MDDR_ADDR_0_PAD
MDDR_ADDR_0_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR0to0(0),
        -- Outputs
        PAD => MDDR_ADDR_14 
        );
-- MDDR_ADDR_1_PAD
MDDR_ADDR_1_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR1to1(1),
        -- Outputs
        PAD => MDDR_ADDR_13 
        );
-- MDDR_ADDR_2_PAD
MDDR_ADDR_2_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR2to2(2),
        -- Outputs
        PAD => MDDR_ADDR_12 
        );
-- MDDR_ADDR_3_PAD
MDDR_ADDR_3_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR3to3(3),
        -- Outputs
        PAD => MDDR_ADDR_11 
        );
-- MDDR_ADDR_4_PAD
MDDR_ADDR_4_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR4to4(4),
        -- Outputs
        PAD => MDDR_ADDR_10 
        );
-- MDDR_ADDR_5_PAD
MDDR_ADDR_5_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR5to5(5),
        -- Outputs
        PAD => MDDR_ADDR_9 
        );
-- MDDR_ADDR_6_PAD
MDDR_ADDR_6_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR6to6(6),
        -- Outputs
        PAD => MDDR_ADDR_8 
        );
-- MDDR_ADDR_7_PAD
MDDR_ADDR_7_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR7to7(7),
        -- Outputs
        PAD => MDDR_ADDR_7 
        );
-- MDDR_ADDR_8_PAD
MDDR_ADDR_8_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR8to8(8),
        -- Outputs
        PAD => MDDR_ADDR_6 
        );
-- MDDR_ADDR_9_PAD
MDDR_ADDR_9_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR9to9(9),
        -- Outputs
        PAD => MDDR_ADDR_5 
        );
-- MDDR_ADDR_10_PAD
MDDR_ADDR_10_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR10to10(10),
        -- Outputs
        PAD => MDDR_ADDR_4 
        );
-- MDDR_ADDR_11_PAD
MDDR_ADDR_11_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR11to11(11),
        -- Outputs
        PAD => MDDR_ADDR_3 
        );
-- MDDR_ADDR_12_PAD
MDDR_ADDR_12_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR12to12(12),
        -- Outputs
        PAD => MDDR_ADDR_2 
        );
-- MDDR_ADDR_13_PAD
MDDR_ADDR_13_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR13to13(13),
        -- Outputs
        PAD => MDDR_ADDR_1 
        );
-- MDDR_ADDR_14_PAD
MDDR_ADDR_14_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR14to14(14),
        -- Outputs
        PAD => MDDR_ADDR_0 
        );
-- MDDR_ADDR_15_PAD
MDDR_ADDR_15_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ADDR15to15(15),
        -- Outputs
        PAD => MDDR_ADDR_net_0 
        );
-- MDDR_BA_0_PAD
MDDR_BA_0_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_BA0to0(0),
        -- Outputs
        PAD => MDDR_BA_1 
        );
-- MDDR_BA_1_PAD
MDDR_BA_1_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_BA1to1(1),
        -- Outputs
        PAD => MDDR_BA_0 
        );
-- MDDR_BA_2_PAD
MDDR_BA_2_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_BA2to2(2),
        -- Outputs
        PAD => MDDR_BA_net_0 
        );
-- MDDR_CAS_N_PAD
MDDR_CAS_N_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_CASN,
        -- Outputs
        PAD => MDDR_CAS_N_net_0 
        );
-- MDDR_CKE_PAD
MDDR_CKE_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_CKE,
        -- Outputs
        PAD => MDDR_CKE_net_0 
        );
-- MDDR_CLK_PAD
MDDR_CLK_PAD : OUTBUF_DIFF
    generic map( 
        IOSTD => ( "LPDDRI" )
        )
    port map( 
        -- Inputs
        D    => MSS_ADLIB_INST_DRAM_CLK,
        -- Outputs
        PADP => MDDR_CLK_net_0,
        PADN => MDDR_CLK_N_net_0 
        );
-- MDDR_CS_N_PAD
MDDR_CS_N_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_CSN,
        -- Outputs
        PAD => MDDR_CS_N_net_0 
        );
-- MDDR_DM_RDQS_0_PAD
MDDR_DM_RDQS_0_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DM_RDQS_OUT0to0(0),
        E   => MSS_ADLIB_INST_DM_OE0to0(0),
        -- Outputs
        Y   => MDDR_DM_RDQS_0_PAD_Y,
        -- Inouts
        PAD => MDDR_DM_RDQS(0) 
        );
-- MDDR_DM_RDQS_1_PAD
MDDR_DM_RDQS_1_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DM_RDQS_OUT1to1(1),
        E   => MSS_ADLIB_INST_DM_OE1to1(1),
        -- Outputs
        Y   => MDDR_DM_RDQS_1_PAD_Y,
        -- Inouts
        PAD => MDDR_DM_RDQS(1) 
        );
-- MDDR_DQ_0_PAD
MDDR_DQ_0_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT0to0(0),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE0to0(0),
        -- Outputs
        Y   => MDDR_DQ_0_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(0) 
        );
-- MDDR_DQ_1_PAD
MDDR_DQ_1_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT1to1(1),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE1to1(1),
        -- Outputs
        Y   => MDDR_DQ_1_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(1) 
        );
-- MDDR_DQ_2_PAD
MDDR_DQ_2_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT2to2(2),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE2to2(2),
        -- Outputs
        Y   => MDDR_DQ_2_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(2) 
        );
-- MDDR_DQ_3_PAD
MDDR_DQ_3_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT3to3(3),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE3to3(3),
        -- Outputs
        Y   => MDDR_DQ_3_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(3) 
        );
-- MDDR_DQ_4_PAD
MDDR_DQ_4_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT4to4(4),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE4to4(4),
        -- Outputs
        Y   => MDDR_DQ_4_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(4) 
        );
-- MDDR_DQ_5_PAD
MDDR_DQ_5_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT5to5(5),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE5to5(5),
        -- Outputs
        Y   => MDDR_DQ_5_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(5) 
        );
-- MDDR_DQ_6_PAD
MDDR_DQ_6_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT6to6(6),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE6to6(6),
        -- Outputs
        Y   => MDDR_DQ_6_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(6) 
        );
-- MDDR_DQ_7_PAD
MDDR_DQ_7_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT7to7(7),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE7to7(7),
        -- Outputs
        Y   => MDDR_DQ_7_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(7) 
        );
-- MDDR_DQ_8_PAD
MDDR_DQ_8_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT8to8(8),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE8to8(8),
        -- Outputs
        Y   => MDDR_DQ_8_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(8) 
        );
-- MDDR_DQ_9_PAD
MDDR_DQ_9_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT9to9(9),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE9to9(9),
        -- Outputs
        Y   => MDDR_DQ_9_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(9) 
        );
-- MDDR_DQ_10_PAD
MDDR_DQ_10_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT10to10(10),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE10to10(10),
        -- Outputs
        Y   => MDDR_DQ_10_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(10) 
        );
-- MDDR_DQ_11_PAD
MDDR_DQ_11_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT11to11(11),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE11to11(11),
        -- Outputs
        Y   => MDDR_DQ_11_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(11) 
        );
-- MDDR_DQ_12_PAD
MDDR_DQ_12_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT12to12(12),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE12to12(12),
        -- Outputs
        Y   => MDDR_DQ_12_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(12) 
        );
-- MDDR_DQ_13_PAD
MDDR_DQ_13_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT13to13(13),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE13to13(13),
        -- Outputs
        Y   => MDDR_DQ_13_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(13) 
        );
-- MDDR_DQ_14_PAD
MDDR_DQ_14_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT14to14(14),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE14to14(14),
        -- Outputs
        Y   => MDDR_DQ_14_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(14) 
        );
-- MDDR_DQ_15_PAD
MDDR_DQ_15_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQ_OUT15to15(15),
        E   => MSS_ADLIB_INST_DRAM_DQ_OE15to15(15),
        -- Outputs
        Y   => MDDR_DQ_15_PAD_Y,
        -- Inouts
        PAD => MDDR_DQ(15) 
        );
-- MDDR_DQS_0_PAD
MDDR_DQS_0_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQS_OUT0to0(0),
        E   => MSS_ADLIB_INST_DRAM_DQS_OE0to0(0),
        -- Outputs
        Y   => MDDR_DQS_0_PAD_Y,
        -- Inouts
        PAD => MDDR_DQS(0) 
        );
-- MDDR_DQS_1_PAD
MDDR_DQS_1_PAD : BIBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_DQS_OUT1to1(1),
        E   => MSS_ADLIB_INST_DRAM_DQS_OE1to1(1),
        -- Outputs
        Y   => MDDR_DQS_1_PAD_Y,
        -- Inouts
        PAD => MDDR_DQS(1) 
        );
-- MDDR_DQS_TMATCH_0_IN_PAD
MDDR_DQS_TMATCH_0_IN_PAD : INBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        PAD => MDDR_DQS_TMATCH_0_IN,
        -- Outputs
        Y   => MDDR_DQS_TMATCH_0_IN_PAD_Y 
        );
-- MDDR_DQS_TMATCH_0_OUT_PAD
MDDR_DQS_TMATCH_0_OUT_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_FIFO_WE_OUT0to0(0),
        -- Outputs
        PAD => MDDR_DQS_TMATCH_0_OUT_net_0 
        );
-- MDDR_ODT_PAD
MDDR_ODT_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_ODT,
        -- Outputs
        PAD => MDDR_ODT_net_0 
        );
-- MDDR_RAS_N_PAD
MDDR_RAS_N_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_RASN,
        -- Outputs
        PAD => MDDR_RAS_N_net_0 
        );
-- MDDR_RESET_N_PAD
MDDR_RESET_N_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_RSTN,
        -- Outputs
        PAD => MDDR_RESET_N_net_0 
        );
-- MDDR_WE_N_PAD
MDDR_WE_N_PAD : OUTBUF
    generic map( 
        IOSTD => ( "LVCMOS18" )
        )
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_DRAM_WEN,
        -- Outputs
        PAD => MDDR_WE_N_net_0 
        );
-- MMUART_1_RXD_PAD
MMUART_1_RXD_PAD : INBUF
    port map( 
        -- Inputs
        PAD => MMUART_1_RXD,
        -- Outputs
        Y   => MMUART_1_RXD_PAD_Y 
        );
-- MMUART_1_TXD_PAD
MMUART_1_TXD_PAD : TRIBUFF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT,
        E   => MSS_ADLIB_INST_MMUART1_TXD_USBC_DATA2_MGPIO24B_OE,
        -- Outputs
        PAD => MMUART_1_TXD_net_0 
        );
-- MSS_ADLIB_INST
MSS_ADLIB_INST : MSS_060
    generic map( 
        ACT_UBITS         => ( x"FFFFFFFFFFFFFF" ),
        DDR_CLK_FREQ      => ( 142.0 ),
        INIT              => ( "00" & x"000000000000030000000000000003610008090A4290800908000000090A42000000000C03000000009000000000200012036190A4200001004000000000000000000000000000000000000F000000000000000000000000000000007FFFFFFFB000001007C35C804248006090801041A3FFFFE400000000000846809D001F0F41C000000025A00010842108421000001FE34001FF8000000400000000020CD1007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" ),
        MEMORYFILE        => ( "ENVM_init.mem" ),
        RTC_MAIN_XTL_FREQ => ( 0.0 ),
        RTC_MAIN_XTL_MODE => ( "" )
        )
    port map( 
        -- Inputs
        CAN_RXBUS_F2H_SCP                       => VCC_net, -- tied to '1' from definition
        CAN_TX_EBL_F2H_SCP                      => VCC_net, -- tied to '1' from definition
        CAN_TXBUS_F2H_SCP                       => VCC_net, -- tied to '1' from definition
        COLF                                    => MAC_MII_COL,
        CRSF                                    => MAC_MII_CRS,
        F2_DMAREADY                             => F2_DMAREADY_const_net_0, -- tied to X"1" from definition
        F2H_INTERRUPT                           => MSS_INT_F2M,
        F2HCALIB                                => VCC_net, -- tied to '1' from definition
        F_DMAREADY                              => F_DMAREADY_const_net_0, -- tied to X"1" from definition
        F_FM0_ADDR                              => F_FM0_ADDR_const_net_0, -- tied to X"0" from definition
        F_FM0_ENABLE                            => GND_net, -- tied to '0' from definition
        F_FM0_MASTLOCK                          => GND_net, -- tied to '0' from definition
        F_FM0_READY                             => VCC_net, -- tied to '1' from definition
        F_FM0_SEL                               => GND_net, -- tied to '0' from definition
        F_FM0_SIZE                              => F_FM0_SIZE_const_net_0, -- tied to X"0" from definition
        F_FM0_TRANS1                            => GND_net, -- tied to '0' from definition
        F_FM0_WDATA                             => F_FM0_WDATA_const_net_0, -- tied to X"0" from definition
        F_FM0_WRITE                             => GND_net, -- tied to '0' from definition
        F_HM0_RDATA                             => FIC_0_APB_M_PRDATA,
        F_HM0_READY                             => FIC_0_APB_M_PREADY,
        F_HM0_RESP                              => FIC_0_APB_M_PSLVERR,
        FAB_AVALID                              => VCC_net, -- tied to '1' from definition
        FAB_HOSTDISCON                          => VCC_net, -- tied to '1' from definition
        FAB_IDDIG                               => VCC_net, -- tied to '1' from definition
        FAB_LINESTATE                           => FAB_LINESTATE_const_net_0, -- tied to X"1" from definition
        FAB_M3_RESET_N                          => M3_RESET_N,
        FAB_PLL_LOCK                            => MCCC_CLK_BASE_PLL_LOCK,
        FAB_RXACTIVE                            => VCC_net, -- tied to '1' from definition
        FAB_RXERROR                             => VCC_net, -- tied to '1' from definition
        FAB_RXVALID                             => VCC_net, -- tied to '1' from definition
        FAB_RXVALIDH                            => GND_net, -- tied to '0' from definition
        FAB_SESSEND                             => VCC_net, -- tied to '1' from definition
        FAB_TXREADY                             => VCC_net, -- tied to '1' from definition
        FAB_VBUSVALID                           => VCC_net, -- tied to '1' from definition
        FAB_VSTATUS                             => FAB_VSTATUS_const_net_0, -- tied to X"1" from definition
        FAB_XDATAIN                             => FAB_XDATAIN_const_net_0, -- tied to X"1" from definition
        GTX_CLKPF                               => VCC_net, -- tied to '1' from definition
        I2C0_BCLK                               => VCC_net, -- tied to '1' from definition
        I2C0_SCL_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        I2C0_SDA_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        I2C1_BCLK                               => VCC_net, -- tied to '1' from definition
        I2C1_SCL_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        I2C1_SDA_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        MDIF                                    => MAC_MII_MDI,
        MGPIO0A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO10A_F2H_GPIN                       => GPIO_10_F2M,
        MGPIO11A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO11B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO12A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO13A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO14A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO15A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO16A_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO17B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO18B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO19B_F2H_GPIN                       => GPIO_19_F2M,
        MGPIO1A_F2H_GPIN                        => GPIO_1_F2M,
        MGPIO20B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO21B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO22B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO24B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO25B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO26B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO27B_F2H_GPIN                       => GPIO_27_F2M,
        MGPIO28B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO29B_F2H_GPIN                       => GPIO_29_F2M,
        MGPIO2A_F2H_GPIN                        => GPIO_2_F2M,
        MGPIO30B_F2H_GPIN                       => GPIO_30_F2M,
        MGPIO31B_F2H_GPIN                       => VCC_net, -- tied to '1' from definition
        MGPIO3A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO4A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO5A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO6A_F2H_GPIN                        => GPIO_6_F2M,
        MGPIO7A_F2H_GPIN                        => GPIO_7_F2M,
        MGPIO8A_F2H_GPIN                        => VCC_net, -- tied to '1' from definition
        MGPIO9A_F2H_GPIN                        => GPIO_9_F2M,
        MMUART0_CTS_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_DCD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_DSR_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_DTR_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_RI_F2H_SCP                      => VCC_net, -- tied to '1' from definition
        MMUART0_RTS_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_RXD_F2H_SCP                     => MMUART_0_RXD_F2M,
        MMUART0_SCK_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART0_TXD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_CTS_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_DCD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_DSR_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_RI_F2H_SCP                      => VCC_net, -- tied to '1' from definition
        MMUART1_RTS_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_RXD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_SCK_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        MMUART1_TXD_F2H_SCP                     => VCC_net, -- tied to '1' from definition
        PER2_FABRIC_PRDATA                      => FIC_2_APB_M_PRDATA,
        PER2_FABRIC_PREADY                      => FIC_2_APB_M_PREADY,
        PER2_FABRIC_PSLVERR                     => FIC_2_APB_M_PSLVERR,
        RCGF                                    => RCGF_const_net_0, -- tied to X"1" from definition
        RX_CLKPF                                => MAC_MII_RX_CLK,
        RX_DVF                                  => MAC_MII_RX_DV,
        RX_ERRF                                 => MAC_MII_RX_ER,
        RX_EV                                   => VCC_net, -- tied to '1' from definition
        RXDF                                    => RXDF_net_0,
        SLEEPHOLDREQ                            => GND_net, -- tied to '0' from definition
        SMBALERT_NI0                            => VCC_net, -- tied to '1' from definition
        SMBALERT_NI1                            => VCC_net, -- tied to '1' from definition
        SMBSUS_NI0                              => VCC_net, -- tied to '1' from definition
        SMBSUS_NI1                              => VCC_net, -- tied to '1' from definition
        SPI0_CLK_IN                             => VCC_net, -- tied to '1' from definition
        SPI0_SDI_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI0_SDO_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI0_SS0_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI0_SS1_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI0_SS2_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI0_SS3_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_CLK_IN                             => SPI_1_CLK_F2M,
        SPI1_SDI_F2H_SCP                        => SPI_1_DI_F2M,
        SPI1_SDO_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_SS0_F2H_SCP                        => SPI_1_SS0_F2M,
        SPI1_SS1_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_SS2_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        SPI1_SS3_F2H_SCP                        => VCC_net, -- tied to '1' from definition
        TX_CLKPF                                => MAC_MII_TX_CLK,
        USER_MSS_GPIO_RESET_N                   => VCC_net, -- tied to '1' from definition
        USER_MSS_RESET_N                        => MSS_RESET_N_F2M,
        XCLK_FAB                                => VCC_net, -- tied to '1' from definition
        CLK_BASE                                => MCCC_CLK_BASE,
        CLK_MDDR_APB                            => MDDR_APB_S_PCLK,
        F_ARADDR_HADDR1                         => F_ARADDR_HADDR1_const_net_0, -- tied to X"1" from definition
        F_ARBURST_HTRANS1                       => F_ARBURST_HTRANS1_const_net_0, -- tied to X"0" from definition
        F_ARID_HSEL1                            => F_ARID_HSEL1_const_net_0, -- tied to X"0" from definition
        F_ARLEN_HBURST1                         => F_ARLEN_HBURST1_const_net_0, -- tied to X"0" from definition
        F_ARLOCK_HMASTLOCK1                     => F_ARLOCK_HMASTLOCK1_const_net_0, -- tied to X"0" from definition
        F_ARSIZE_HSIZE1                         => F_ARSIZE_HSIZE1_const_net_0, -- tied to X"0" from definition
        F_ARVALID_HWRITE1                       => GND_net, -- tied to '0' from definition
        F_AWADDR_HADDR0                         => F_AWADDR_HADDR0_const_net_0, -- tied to X"1" from definition
        F_AWBURST_HTRANS0                       => F_AWBURST_HTRANS0_const_net_0, -- tied to X"0" from definition
        F_AWID_HSEL0                            => F_AWID_HSEL0_const_net_0, -- tied to X"0" from definition
        F_AWLEN_HBURST0                         => F_AWLEN_HBURST0_const_net_0, -- tied to X"0" from definition
        F_AWLOCK_HMASTLOCK0                     => F_AWLOCK_HMASTLOCK0_const_net_0, -- tied to X"0" from definition
        F_AWSIZE_HSIZE0                         => F_AWSIZE_HSIZE0_const_net_0, -- tied to X"0" from definition
        F_AWVALID_HWRITE0                       => GND_net, -- tied to '0' from definition
        F_BREADY                                => GND_net, -- tied to '0' from definition
        F_RMW_AXI                               => GND_net, -- tied to '0' from definition
        F_RREADY                                => GND_net, -- tied to '0' from definition
        F_WDATA_HWDATA01                        => F_WDATA_HWDATA01_const_net_0, -- tied to X"1" from definition
        F_WID_HREADY01                          => F_WID_HREADY01_const_net_0, -- tied to X"0" from definition
        F_WLAST                                 => GND_net, -- tied to '0' from definition
        F_WSTRB                                 => F_WSTRB_const_net_0, -- tied to X"0" from definition
        F_WVALID                                => GND_net, -- tied to '0' from definition
        FPGA_MDDR_ARESET_N                      => VCC_net, -- tied to '1' from definition
        MDDR_FABRIC_PADDR                       => MDDR_APB_S_PADDR,
        MDDR_FABRIC_PENABLE                     => MDDR_APB_S_PENABLE,
        MDDR_FABRIC_PSEL                        => MDDR_APB_S_PSEL,
        MDDR_FABRIC_PWDATA                      => MDDR_APB_S_PWDATA,
        MDDR_FABRIC_PWRITE                      => MDDR_APB_S_PWRITE,
        PRESET_N                                => MDDR_APB_S_PRESET_N,
        CAN_RXBUS_USBA_DATA1_MGPIO3A_IN         => GPIO_GPIO_3_BI_PAD_Y,
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_IN        => GPIO_GPIO_4_BI_PAD_Y,
        CAN_TXBUS_USBA_DATA0_MGPIO2A_IN         => GND_net,
        DM_IN                                   => DM_IN_net_0,
        DRAM_DQ_IN                              => DRAM_DQ_IN_net_0,
        DRAM_DQS_IN                             => DRAM_DQS_IN_net_0,
        DRAM_FIFO_WE_IN                         => DRAM_FIFO_WE_IN_net_0,
        I2C0_SCL_USBC_DATA1_MGPIO31B_IN         => GND_net,
        I2C0_SDA_USBC_DATA0_MGPIO30B_IN         => GND_net,
        I2C1_SCL_USBA_DATA4_MGPIO1A_IN          => I2C_1_SCL_PAD_Y,
        I2C1_SDA_USBA_DATA3_MGPIO0A_IN          => I2C_1_SDA_PAD_Y,
        MGPIO0B_IN                              => GPIO_GPIO_0_BI_PAD_Y,
        MGPIO10B_IN                             => GND_net,
        MGPIO1B_IN                              => GND_net,
        MGPIO25A_IN                             => GPIO_GPIO_25_BI_PAD_Y,
        MGPIO26A_IN                             => GPIO_GPIO_26_BI_PAD_Y,
        MGPIO27A_IN                             => GND_net,
        MGPIO28A_IN                             => GND_net,
        MGPIO29A_IN                             => GND_net,
        MGPIO2B_IN                              => GND_net,
        MGPIO30A_IN                             => GND_net,
        MGPIO31A_IN                             => GPIO_GPIO_31_BI_PAD_Y,
        MGPIO3B_IN                              => GND_net,
        MGPIO4B_IN                              => GND_net,
        MGPIO5B_IN                              => GND_net,
        MGPIO6B_IN                              => GND_net,
        MGPIO7B_IN                              => GND_net,
        MGPIO8B_IN                              => GND_net,
        MGPIO9B_IN                              => GND_net,
        MMUART0_CTS_USBC_DATA7_MGPIO19B_IN      => GND_net,
        MMUART0_DCD_MGPIO22B_IN                 => GND_net,
        MMUART0_DSR_MGPIO20B_IN                 => GND_net,
        MMUART0_DTR_USBC_DATA6_MGPIO18B_IN      => GND_net,
        MMUART0_RI_MGPIO21B_IN                  => GND_net,
        MMUART0_RTS_USBC_DATA5_MGPIO17B_IN      => GND_net,
        MMUART0_RXD_USBC_STP_MGPIO28B_IN        => GND_net,
        MMUART0_SCK_USBC_NXT_MGPIO29B_IN        => GND_net,
        MMUART0_TXD_USBC_DIR_MGPIO27B_IN        => GND_net,
        MMUART1_CTS_MGPIO13B_IN                 => GND_net,
        MMUART1_DCD_MGPIO16B_IN                 => GPIO_GPIO_16_BI_PAD_Y,
        MMUART1_DSR_MGPIO14B_IN                 => GPIO_GPIO_14_BI_PAD_Y,
        MMUART1_DTR_MGPIO12B_IN                 => GPIO_GPIO_12_BI_PAD_Y,
        MMUART1_RI_MGPIO15B_IN                  => GPIO_GPIO_15_BI_PAD_Y,
        MMUART1_RTS_MGPIO11B_IN                 => GND_net,
        MMUART1_RXD_USBC_DATA3_MGPIO26B_IN      => MMUART_1_RXD_PAD_Y,
        MMUART1_SCK_USBC_DATA4_MGPIO25B_IN      => GND_net,
        MMUART1_TXD_USBC_DATA2_MGPIO24B_IN      => GND_net,
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_IN     => GND_net,
        RGMII_MDC_RMII_MDC_IN                   => GND_net,
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_IN      => GND_net,
        RGMII_RX_CLK_IN                         => GND_net,
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_IN  => GND_net,
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_IN      => GND_net,
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_IN      => GND_net,
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_IN     => GND_net,
        RGMII_RXD3_USBB_DATA4_IN                => GND_net,
        RGMII_TX_CLK_IN                         => GND_net,
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_IN     => GND_net,
        RGMII_TXD0_RMII_TXD0_USBB_DIR_IN        => GND_net,
        RGMII_TXD1_RMII_TXD1_USBB_STP_IN        => GND_net,
        RGMII_TXD2_USBB_DATA5_IN                => GND_net,
        RGMII_TXD3_USBB_DATA6_IN                => GND_net,
        SPI0_SCK_USBA_XCLK_IN                   => SPI_0_CLK_PAD_Y,
        SPI0_SDI_USBA_DIR_MGPIO5A_IN            => SPI_0_DI_PAD_Y,
        SPI0_SDO_USBA_STP_MGPIO6A_IN            => GND_net,
        SPI0_SS0_USBA_NXT_MGPIO7A_IN            => SPI_0_SS0_PAD_Y,
        SPI0_SS1_USBA_DATA5_MGPIO8A_IN          => GND_net,
        SPI0_SS2_USBA_DATA6_MGPIO9A_IN          => GND_net,
        SPI0_SS3_USBA_DATA7_MGPIO10A_IN         => GND_net,
        SPI0_SS4_MGPIO19A_IN                    => GND_net,
        SPI0_SS5_MGPIO20A_IN                    => GND_net,
        SPI0_SS6_MGPIO21A_IN                    => GND_net,
        SPI0_SS7_MGPIO22A_IN                    => GND_net,
        SPI1_SCK_IN                             => GND_net,
        SPI1_SDI_MGPIO11A_IN                    => GND_net,
        SPI1_SDO_MGPIO12A_IN                    => GND_net,
        SPI1_SS0_MGPIO13A_IN                    => GND_net,
        SPI1_SS1_MGPIO14A_IN                    => GND_net,
        SPI1_SS2_MGPIO15A_IN                    => GND_net,
        SPI1_SS3_MGPIO16A_IN                    => GND_net,
        SPI1_SS4_MGPIO17A_IN                    => GPIO_GPIO_17_BI_PAD_Y,
        SPI1_SS5_MGPIO18A_IN                    => GPIO_GPIO_18_BI_PAD_Y,
        SPI1_SS6_MGPIO23A_IN                    => GND_net,
        SPI1_SS7_MGPIO24A_IN                    => GND_net,
        USBC_XCLK_IN                            => GND_net,
        USBD_DATA0_IN                           => GND_net,
        USBD_DATA1_IN                           => GND_net,
        USBD_DATA2_IN                           => GND_net,
        USBD_DATA3_IN                           => GND_net,
        USBD_DATA4_IN                           => GND_net,
        USBD_DATA5_IN                           => GND_net,
        USBD_DATA6_IN                           => GND_net,
        USBD_DATA7_MGPIO23B_IN                  => GND_net,
        USBD_DIR_IN                             => GND_net,
        USBD_NXT_IN                             => GND_net,
        USBD_STP_IN                             => GND_net,
        USBD_XCLK_IN                            => GND_net,
        -- Outputs
        CAN_RXBUS_MGPIO3A_H2F_A                 => OPEN,
        CAN_RXBUS_MGPIO3A_H2F_B                 => OPEN,
        CAN_TX_EBL_MGPIO4A_H2F_A                => OPEN,
        CAN_TX_EBL_MGPIO4A_H2F_B                => OPEN,
        CAN_TXBUS_MGPIO2A_H2F_A                 => OPEN,
        CAN_TXBUS_MGPIO2A_H2F_B                 => OPEN,
        CLK_CONFIG_APB                          => FIC_2_APB_M_PCLK_0,
        COMMS_INT                               => OPEN,
        CONFIG_PRESET_N                         => FIC_2_APB_M_PRESET_N_0,
        EDAC_ERROR                              => OPEN,
        F_FM0_RDATA                             => OPEN,
        F_FM0_READYOUT                          => OPEN,
        F_FM0_RESP                              => OPEN,
        F_HM0_ADDR                              => FIC_0_APB_MASTER_PADDR,
        F_HM0_ENABLE                            => FIC_0_APB_MASTER_PENABLE,
        F_HM0_SEL                               => FIC_0_APB_MASTER_PSELx,
        F_HM0_SIZE                              => OPEN,
        F_HM0_TRANS1                            => OPEN,
        F_HM0_WDATA                             => FIC_0_APB_MASTER_PWDATA,
        F_HM0_WRITE                             => FIC_0_APB_MASTER_PWRITE,
        FAB_CHRGVBUS                            => OPEN,
        FAB_DISCHRGVBUS                         => OPEN,
        FAB_DMPULLDOWN                          => OPEN,
        FAB_DPPULLDOWN                          => OPEN,
        FAB_DRVVBUS                             => OPEN,
        FAB_IDPULLUP                            => OPEN,
        FAB_OPMODE                              => OPEN,
        FAB_SUSPENDM                            => OPEN,
        FAB_TERMSEL                             => OPEN,
        FAB_TXVALID                             => OPEN,
        FAB_VCONTROL                            => OPEN,
        FAB_VCONTROLLOADM                       => OPEN,
        FAB_XCVRSEL                             => OPEN,
        FAB_XDATAOUT                            => OPEN,
        FACC_GLMUX_SEL                          => OPEN,
        FIC32_0_MASTER                          => OPEN,
        FIC32_1_MASTER                          => OPEN,
        FPGA_RESET_N                            => MSS_RESET_N_M2F_net_0,
        GTX_CLK                                 => OPEN,
        H2F_INTERRUPT                           => OPEN,
        H2F_NMI                                 => OPEN,
        H2FCALIB                                => OPEN,
        I2C0_SCL_MGPIO31B_H2F_A                 => OPEN,
        I2C0_SCL_MGPIO31B_H2F_B                 => OPEN,
        I2C0_SDA_MGPIO30B_H2F_A                 => OPEN,
        I2C0_SDA_MGPIO30B_H2F_B                 => OPEN,
        I2C1_SCL_MGPIO1A_H2F_A                  => GPIO_1_M2F_OE_0,
        I2C1_SCL_MGPIO1A_H2F_B                  => GPIO_1_M2F_net_0,
        I2C1_SDA_MGPIO0A_H2F_A                  => OPEN,
        I2C1_SDA_MGPIO0A_H2F_B                  => OPEN,
        MDCF                                    => MAC_MII_MDC_net_0,
        MDOENF                                  => MAC_MII_MDO_EN_net_0,
        MDOF                                    => MAC_MII_MDO_net_0,
        MMUART0_CTS_MGPIO19B_H2F_A              => OPEN,
        MMUART0_CTS_MGPIO19B_H2F_B              => OPEN,
        MMUART0_DCD_MGPIO22B_H2F_A              => OPEN,
        MMUART0_DCD_MGPIO22B_H2F_B              => GPIO_22_M2F_net_0,
        MMUART0_DSR_MGPIO20B_H2F_A              => OPEN,
        MMUART0_DSR_MGPIO20B_H2F_B              => OPEN,
        MMUART0_DTR_MGPIO18B_H2F_A              => OPEN,
        MMUART0_DTR_MGPIO18B_H2F_B              => OPEN,
        MMUART0_RI_MGPIO21B_H2F_A               => OPEN,
        MMUART0_RI_MGPIO21B_H2F_B               => GPIO_21_M2F_net_0,
        MMUART0_RTS_MGPIO17B_H2F_A              => OPEN,
        MMUART0_RTS_MGPIO17B_H2F_B              => OPEN,
        MMUART0_RXD_MGPIO28B_H2F_A              => OPEN,
        MMUART0_RXD_MGPIO28B_H2F_B              => GPIO_28_M2F_net_0,
        MMUART0_SCK_MGPIO29B_H2F_A              => OPEN,
        MMUART0_SCK_MGPIO29B_H2F_B              => OPEN,
        MMUART0_TXD_MGPIO27B_H2F_A              => MMUART_0_TXD_M2F_net_0,
        MMUART0_TXD_MGPIO27B_H2F_B              => OPEN,
        MMUART1_DTR_MGPIO12B_H2F_A              => OPEN,
        MMUART1_RTS_MGPIO11B_H2F_A              => OPEN,
        MMUART1_RTS_MGPIO11B_H2F_B              => OPEN,
        MMUART1_RXD_MGPIO26B_H2F_A              => OPEN,
        MMUART1_RXD_MGPIO26B_H2F_B              => OPEN,
        MMUART1_SCK_MGPIO25B_H2F_A              => OPEN,
        MMUART1_SCK_MGPIO25B_H2F_B              => OPEN,
        MMUART1_TXD_MGPIO24B_H2F_A              => OPEN,
        MMUART1_TXD_MGPIO24B_H2F_B              => GPIO_24_M2F_net_0,
        MPLL_LOCK                               => OPEN,
        PER2_FABRIC_PADDR                       => FIC_2_APB_MASTER_0_PADDR,
        PER2_FABRIC_PENABLE                     => FIC_2_APB_MASTER_0_PENABLE,
        PER2_FABRIC_PSEL                        => FIC_2_APB_MASTER_0_PSELx,
        PER2_FABRIC_PWDATA                      => FIC_2_APB_MASTER_0_PWDATA,
        PER2_FABRIC_PWRITE                      => FIC_2_APB_MASTER_0_PWRITE,
        RTC_MATCH                               => OPEN,
        SLEEPDEEP                               => OPEN,
        SLEEPHOLDACK                            => OPEN,
        SLEEPING                                => OPEN,
        SMBALERT_NO0                            => OPEN,
        SMBALERT_NO1                            => OPEN,
        SMBSUS_NO0                              => OPEN,
        SMBSUS_NO1                              => OPEN,
        SPI0_CLK_OUT                            => OPEN,
        SPI0_SDI_MGPIO5A_H2F_A                  => OPEN,
        SPI0_SDI_MGPIO5A_H2F_B                  => GPIO_5_M2F_net_0,
        SPI0_SDO_MGPIO6A_H2F_A                  => GPIO_6_M2F_OE_net_0,
        SPI0_SDO_MGPIO6A_H2F_B                  => GPIO_6_M2F_net_0,
        SPI0_SS0_MGPIO7A_H2F_A                  => GPIO_7_M2F_OE_net_0,
        SPI0_SS0_MGPIO7A_H2F_B                  => GPIO_7_M2F_net_0,
        SPI0_SS1_MGPIO8A_H2F_A                  => OPEN,
        SPI0_SS1_MGPIO8A_H2F_B                  => GPIO_8_M2F_net_0,
        SPI0_SS2_MGPIO9A_H2F_A                  => OPEN,
        SPI0_SS2_MGPIO9A_H2F_B                  => OPEN,
        SPI0_SS3_MGPIO10A_H2F_A                 => OPEN,
        SPI0_SS3_MGPIO10A_H2F_B                 => OPEN,
        SPI0_SS4_MGPIO19A_H2F_A                 => OPEN,
        SPI0_SS5_MGPIO20A_H2F_A                 => OPEN,
        SPI0_SS6_MGPIO21A_H2F_A                 => OPEN,
        SPI0_SS7_MGPIO22A_H2F_A                 => OPEN,
        SPI1_CLK_OUT                            => SPI_1_CLK_M2F_net_0,
        SPI1_SDI_MGPIO11A_H2F_A                 => OPEN,
        SPI1_SDI_MGPIO11A_H2F_B                 => GPIO_11_M2F_net_0,
        SPI1_SDO_MGPIO12A_H2F_A                 => SPI_1_DO_M2F_net_0,
        SPI1_SDO_MGPIO12A_H2F_B                 => OPEN,
        SPI1_SS0_MGPIO13A_H2F_A                 => SPI_1_SS0_M2F_net_0,
        SPI1_SS0_MGPIO13A_H2F_B                 => SPI_1_SS0_M2F_OE_net_0,
        SPI1_SS1_MGPIO14A_H2F_A                 => OPEN,
        SPI1_SS1_MGPIO14A_H2F_B                 => OPEN,
        SPI1_SS2_MGPIO15A_H2F_A                 => OPEN,
        SPI1_SS2_MGPIO15A_H2F_B                 => OPEN,
        SPI1_SS3_MGPIO16A_H2F_A                 => OPEN,
        SPI1_SS3_MGPIO16A_H2F_B                 => OPEN,
        SPI1_SS4_MGPIO17A_H2F_A                 => OPEN,
        SPI1_SS5_MGPIO18A_H2F_A                 => OPEN,
        SPI1_SS6_MGPIO23A_H2F_A                 => OPEN,
        SPI1_SS7_MGPIO24A_H2F_A                 => OPEN,
        TCGF                                    => OPEN,
        TRACECLK                                => OPEN,
        TRACEDATA                               => OPEN,
        TX_CLK                                  => OPEN,
        TX_ENF                                  => MAC_MII_TX_EN_net_0,
        TX_ERRF                                 => MAC_MII_TX_ER_net_0,
        TXCTL_EN_RIF                            => OPEN,
        TXD_RIF                                 => OPEN,
        TXDF                                    => TXDF_net_0,
        TXEV                                    => OPEN,
        WDOGTIMEOUT                             => OPEN,
        F_ARREADY_HREADYOUT1                    => OPEN,
        F_AWREADY_HREADYOUT0                    => OPEN,
        F_BID                                   => OPEN,
        F_BRESP_HRESP0                          => OPEN,
        F_BVALID                                => OPEN,
        F_RDATA_HRDATA01                        => OPEN,
        F_RID                                   => OPEN,
        F_RLAST                                 => OPEN,
        F_RRESP_HRESP1                          => OPEN,
        F_RVALID                                => OPEN,
        F_WREADY                                => OPEN,
        MDDR_FABRIC_PRDATA                      => MDDR_APB_SLAVE_PRDATA,
        MDDR_FABRIC_PREADY                      => MDDR_APB_SLAVE_PREADY,
        MDDR_FABRIC_PSLVERR                     => MDDR_APB_SLAVE_PSLVERR,
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT        => MSS_ADLIB_INST_CAN_RXBUS_USBA_DATA1_MGPIO3A_OUT,
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT       => MSS_ADLIB_INST_CAN_TX_EBL_USBA_DATA2_MGPIO4A_OUT,
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OUT        => OPEN,
        DRAM_ADDR                               => DRAM_ADDR_net_0,
        DRAM_BA                                 => DRAM_BA_net_0,
        DRAM_CASN                               => MSS_ADLIB_INST_DRAM_CASN,
        DRAM_CKE                                => MSS_ADLIB_INST_DRAM_CKE,
        DRAM_CLK                                => MSS_ADLIB_INST_DRAM_CLK,
        DRAM_CSN                                => MSS_ADLIB_INST_DRAM_CSN,
        DRAM_DM_RDQS_OUT                        => DRAM_DM_RDQS_OUT_net_0,
        DRAM_DQ_OUT                             => DRAM_DQ_OUT_net_0,
        DRAM_DQS_OUT                            => DRAM_DQS_OUT_net_0,
        DRAM_FIFO_WE_OUT                        => DRAM_FIFO_WE_OUT_net_0,
        DRAM_ODT                                => MSS_ADLIB_INST_DRAM_ODT,
        DRAM_RASN                               => MSS_ADLIB_INST_DRAM_RASN,
        DRAM_RSTN                               => MSS_ADLIB_INST_DRAM_RSTN,
        DRAM_WEN                                => MSS_ADLIB_INST_DRAM_WEN,
        I2C0_SCL_USBC_DATA1_MGPIO31B_OUT        => OPEN,
        I2C0_SDA_USBC_DATA0_MGPIO30B_OUT        => OPEN,
        I2C1_SCL_USBA_DATA4_MGPIO1A_OUT         => MSS_ADLIB_INST_I2C1_SCL_USBA_DATA4_MGPIO1A_OUT,
        I2C1_SDA_USBA_DATA3_MGPIO0A_OUT         => MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OUT,
        MGPIO0B_OUT                             => MSS_ADLIB_INST_MGPIO0B_OUT,
        MGPIO10B_OUT                            => OPEN,
        MGPIO1B_OUT                             => OPEN,
        MGPIO25A_OUT                            => MSS_ADLIB_INST_MGPIO25A_OUT,
        MGPIO26A_OUT                            => MSS_ADLIB_INST_MGPIO26A_OUT,
        MGPIO27A_OUT                            => OPEN,
        MGPIO28A_OUT                            => OPEN,
        MGPIO29A_OUT                            => OPEN,
        MGPIO2B_OUT                             => OPEN,
        MGPIO30A_OUT                            => OPEN,
        MGPIO31A_OUT                            => MSS_ADLIB_INST_MGPIO31A_OUT,
        MGPIO3B_OUT                             => OPEN,
        MGPIO4B_OUT                             => OPEN,
        MGPIO5B_OUT                             => OPEN,
        MGPIO6B_OUT                             => OPEN,
        MGPIO7B_OUT                             => OPEN,
        MGPIO8B_OUT                             => OPEN,
        MGPIO9B_OUT                             => OPEN,
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OUT     => OPEN,
        MMUART0_DCD_MGPIO22B_OUT                => OPEN,
        MMUART0_DSR_MGPIO20B_OUT                => OPEN,
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OUT     => OPEN,
        MMUART0_RI_MGPIO21B_OUT                 => OPEN,
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OUT     => OPEN,
        MMUART0_RXD_USBC_STP_MGPIO28B_OUT       => OPEN,
        MMUART0_SCK_USBC_NXT_MGPIO29B_OUT       => OPEN,
        MMUART0_TXD_USBC_DIR_MGPIO27B_OUT       => OPEN,
        MMUART1_CTS_MGPIO13B_OUT                => OPEN,
        MMUART1_DCD_MGPIO16B_OUT                => MSS_ADLIB_INST_MMUART1_DCD_MGPIO16B_OUT,
        MMUART1_DSR_MGPIO14B_OUT                => MSS_ADLIB_INST_MMUART1_DSR_MGPIO14B_OUT,
        MMUART1_DTR_MGPIO12B_OUT                => MSS_ADLIB_INST_MMUART1_DTR_MGPIO12B_OUT,
        MMUART1_RI_MGPIO15B_OUT                 => MSS_ADLIB_INST_MMUART1_RI_MGPIO15B_OUT,
        MMUART1_RTS_MGPIO11B_OUT                => OPEN,
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OUT     => OPEN,
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OUT     => OPEN,
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT     => MSS_ADLIB_INST_MMUART1_TXD_USBC_DATA2_MGPIO24B_OUT,
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OUT    => OPEN,
        RGMII_MDC_RMII_MDC_OUT                  => OPEN,
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OUT     => OPEN,
        RGMII_RX_CLK_OUT                        => OPEN,
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OUT => OPEN,
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OUT     => OPEN,
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OUT     => OPEN,
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OUT    => OPEN,
        RGMII_RXD3_USBB_DATA4_OUT               => OPEN,
        RGMII_TX_CLK_OUT                        => OPEN,
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OUT    => OPEN,
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OUT       => OPEN,
        RGMII_TXD1_RMII_TXD1_USBB_STP_OUT       => OPEN,
        RGMII_TXD2_USBB_DATA5_OUT               => OPEN,
        RGMII_TXD3_USBB_DATA6_OUT               => OPEN,
        SPI0_SCK_USBA_XCLK_OUT                  => MSS_ADLIB_INST_SPI0_SCK_USBA_XCLK_OUT,
        SPI0_SDI_USBA_DIR_MGPIO5A_OUT           => OPEN,
        SPI0_SDO_USBA_STP_MGPIO6A_OUT           => MSS_ADLIB_INST_SPI0_SDO_USBA_STP_MGPIO6A_OUT,
        SPI0_SS0_USBA_NXT_MGPIO7A_OUT           => MSS_ADLIB_INST_SPI0_SS0_USBA_NXT_MGPIO7A_OUT,
        SPI0_SS1_USBA_DATA5_MGPIO8A_OUT         => MSS_ADLIB_INST_SPI0_SS1_USBA_DATA5_MGPIO8A_OUT,
        SPI0_SS2_USBA_DATA6_MGPIO9A_OUT         => OPEN,
        SPI0_SS3_USBA_DATA7_MGPIO10A_OUT        => OPEN,
        SPI0_SS4_MGPIO19A_OUT                   => OPEN,
        SPI0_SS5_MGPIO20A_OUT                   => MSS_ADLIB_INST_SPI0_SS5_MGPIO20A_OUT,
        SPI0_SS6_MGPIO21A_OUT                   => OPEN,
        SPI0_SS7_MGPIO22A_OUT                   => OPEN,
        SPI1_SCK_OUT                            => OPEN,
        SPI1_SDI_MGPIO11A_OUT                   => OPEN,
        SPI1_SDO_MGPIO12A_OUT                   => OPEN,
        SPI1_SS0_MGPIO13A_OUT                   => OPEN,
        SPI1_SS1_MGPIO14A_OUT                   => OPEN,
        SPI1_SS2_MGPIO15A_OUT                   => OPEN,
        SPI1_SS3_MGPIO16A_OUT                   => OPEN,
        SPI1_SS4_MGPIO17A_OUT                   => MSS_ADLIB_INST_SPI1_SS4_MGPIO17A_OUT,
        SPI1_SS5_MGPIO18A_OUT                   => MSS_ADLIB_INST_SPI1_SS5_MGPIO18A_OUT,
        SPI1_SS6_MGPIO23A_OUT                   => OPEN,
        SPI1_SS7_MGPIO24A_OUT                   => OPEN,
        USBC_XCLK_OUT                           => OPEN,
        USBD_DATA0_OUT                          => OPEN,
        USBD_DATA1_OUT                          => OPEN,
        USBD_DATA2_OUT                          => OPEN,
        USBD_DATA3_OUT                          => OPEN,
        USBD_DATA4_OUT                          => OPEN,
        USBD_DATA5_OUT                          => OPEN,
        USBD_DATA6_OUT                          => OPEN,
        USBD_DATA7_MGPIO23B_OUT                 => OPEN,
        USBD_DIR_OUT                            => OPEN,
        USBD_NXT_OUT                            => OPEN,
        USBD_STP_OUT                            => OPEN,
        USBD_XCLK_OUT                           => OPEN,
        CAN_RXBUS_USBA_DATA1_MGPIO3A_OE         => MSS_ADLIB_INST_CAN_RXBUS_USBA_DATA1_MGPIO3A_OE,
        CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE        => MSS_ADLIB_INST_CAN_TX_EBL_USBA_DATA2_MGPIO4A_OE,
        CAN_TXBUS_USBA_DATA0_MGPIO2A_OE         => OPEN,
        DM_OE                                   => DM_OE_net_0,
        DRAM_DQ_OE                              => DRAM_DQ_OE_net_0,
        DRAM_DQS_OE                             => DRAM_DQS_OE_net_0,
        I2C0_SCL_USBC_DATA1_MGPIO31B_OE         => OPEN,
        I2C0_SDA_USBC_DATA0_MGPIO30B_OE         => OPEN,
        I2C1_SCL_USBA_DATA4_MGPIO1A_OE          => MSS_ADLIB_INST_I2C1_SCL_USBA_DATA4_MGPIO1A_OE,
        I2C1_SDA_USBA_DATA3_MGPIO0A_OE          => MSS_ADLIB_INST_I2C1_SDA_USBA_DATA3_MGPIO0A_OE,
        MGPIO0B_OE                              => MSS_ADLIB_INST_MGPIO0B_OE,
        MGPIO10B_OE                             => OPEN,
        MGPIO1B_OE                              => OPEN,
        MGPIO25A_OE                             => MSS_ADLIB_INST_MGPIO25A_OE,
        MGPIO26A_OE                             => MSS_ADLIB_INST_MGPIO26A_OE,
        MGPIO27A_OE                             => OPEN,
        MGPIO28A_OE                             => OPEN,
        MGPIO29A_OE                             => OPEN,
        MGPIO2B_OE                              => OPEN,
        MGPIO30A_OE                             => OPEN,
        MGPIO31A_OE                             => MSS_ADLIB_INST_MGPIO31A_OE,
        MGPIO3B_OE                              => OPEN,
        MGPIO4B_OE                              => OPEN,
        MGPIO5B_OE                              => OPEN,
        MGPIO6B_OE                              => OPEN,
        MGPIO7B_OE                              => OPEN,
        MGPIO8B_OE                              => OPEN,
        MGPIO9B_OE                              => OPEN,
        MMUART0_CTS_USBC_DATA7_MGPIO19B_OE      => OPEN,
        MMUART0_DCD_MGPIO22B_OE                 => OPEN,
        MMUART0_DSR_MGPIO20B_OE                 => OPEN,
        MMUART0_DTR_USBC_DATA6_MGPIO18B_OE      => OPEN,
        MMUART0_RI_MGPIO21B_OE                  => OPEN,
        MMUART0_RTS_USBC_DATA5_MGPIO17B_OE      => OPEN,
        MMUART0_RXD_USBC_STP_MGPIO28B_OE        => OPEN,
        MMUART0_SCK_USBC_NXT_MGPIO29B_OE        => OPEN,
        MMUART0_TXD_USBC_DIR_MGPIO27B_OE        => OPEN,
        MMUART1_CTS_MGPIO13B_OE                 => OPEN,
        MMUART1_DCD_MGPIO16B_OE                 => MSS_ADLIB_INST_MMUART1_DCD_MGPIO16B_OE,
        MMUART1_DSR_MGPIO14B_OE                 => MSS_ADLIB_INST_MMUART1_DSR_MGPIO14B_OE,
        MMUART1_DTR_MGPIO12B_OE                 => MSS_ADLIB_INST_MMUART1_DTR_MGPIO12B_OE,
        MMUART1_RI_MGPIO15B_OE                  => MSS_ADLIB_INST_MMUART1_RI_MGPIO15B_OE,
        MMUART1_RTS_MGPIO11B_OE                 => OPEN,
        MMUART1_RXD_USBC_DATA3_MGPIO26B_OE      => OPEN,
        MMUART1_SCK_USBC_DATA4_MGPIO25B_OE      => OPEN,
        MMUART1_TXD_USBC_DATA2_MGPIO24B_OE      => MSS_ADLIB_INST_MMUART1_TXD_USBC_DATA2_MGPIO24B_OE,
        RGMII_GTX_CLK_RMII_CLK_USBB_XCLK_OE     => OPEN,
        RGMII_MDC_RMII_MDC_OE                   => OPEN,
        RGMII_MDIO_RMII_MDIO_USBB_DATA7_OE      => OPEN,
        RGMII_RX_CLK_OE                         => OPEN,
        RGMII_RX_CTL_RMII_CRS_DV_USBB_DATA2_OE  => OPEN,
        RGMII_RXD0_RMII_RXD0_USBB_DATA0_OE      => OPEN,
        RGMII_RXD1_RMII_RXD1_USBB_DATA1_OE      => OPEN,
        RGMII_RXD2_RMII_RX_ER_USBB_DATA3_OE     => OPEN,
        RGMII_RXD3_USBB_DATA4_OE                => OPEN,
        RGMII_TX_CLK_OE                         => OPEN,
        RGMII_TX_CTL_RMII_TX_EN_USBB_NXT_OE     => OPEN,
        RGMII_TXD0_RMII_TXD0_USBB_DIR_OE        => OPEN,
        RGMII_TXD1_RMII_TXD1_USBB_STP_OE        => OPEN,
        RGMII_TXD2_USBB_DATA5_OE                => OPEN,
        RGMII_TXD3_USBB_DATA6_OE                => OPEN,
        SPI0_SCK_USBA_XCLK_OE                   => MSS_ADLIB_INST_SPI0_SCK_USBA_XCLK_OE,
        SPI0_SDI_USBA_DIR_MGPIO5A_OE            => OPEN,
        SPI0_SDO_USBA_STP_MGPIO6A_OE            => MSS_ADLIB_INST_SPI0_SDO_USBA_STP_MGPIO6A_OE,
        SPI0_SS0_USBA_NXT_MGPIO7A_OE            => MSS_ADLIB_INST_SPI0_SS0_USBA_NXT_MGPIO7A_OE,
        SPI0_SS1_USBA_DATA5_MGPIO8A_OE          => MSS_ADLIB_INST_SPI0_SS1_USBA_DATA5_MGPIO8A_OE,
        SPI0_SS2_USBA_DATA6_MGPIO9A_OE          => OPEN,
        SPI0_SS3_USBA_DATA7_MGPIO10A_OE         => OPEN,
        SPI0_SS4_MGPIO19A_OE                    => OPEN,
        SPI0_SS5_MGPIO20A_OE                    => OPEN,
        SPI0_SS6_MGPIO21A_OE                    => OPEN,
        SPI0_SS7_MGPIO22A_OE                    => OPEN,
        SPI1_SCK_OE                             => OPEN,
        SPI1_SDI_MGPIO11A_OE                    => OPEN,
        SPI1_SDO_MGPIO12A_OE                    => OPEN,
        SPI1_SS0_MGPIO13A_OE                    => OPEN,
        SPI1_SS1_MGPIO14A_OE                    => OPEN,
        SPI1_SS2_MGPIO15A_OE                    => OPEN,
        SPI1_SS3_MGPIO16A_OE                    => OPEN,
        SPI1_SS4_MGPIO17A_OE                    => MSS_ADLIB_INST_SPI1_SS4_MGPIO17A_OE,
        SPI1_SS5_MGPIO18A_OE                    => MSS_ADLIB_INST_SPI1_SS5_MGPIO18A_OE,
        SPI1_SS6_MGPIO23A_OE                    => OPEN,
        SPI1_SS7_MGPIO24A_OE                    => OPEN,
        USBC_XCLK_OE                            => OPEN,
        USBD_DATA0_OE                           => OPEN,
        USBD_DATA1_OE                           => OPEN,
        USBD_DATA2_OE                           => OPEN,
        USBD_DATA3_OE                           => OPEN,
        USBD_DATA4_OE                           => OPEN,
        USBD_DATA5_OE                           => OPEN,
        USBD_DATA6_OE                           => OPEN,
        USBD_DATA7_MGPIO23B_OE                  => OPEN,
        USBD_DIR_OE                             => OPEN,
        USBD_NXT_OE                             => OPEN,
        USBD_STP_OE                             => OPEN,
        USBD_XCLK_OE                            => OPEN 
        );
-- SPI_0_CLK_PAD
SPI_0_CLK_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_SPI0_SCK_USBA_XCLK_OUT,
        E   => MSS_ADLIB_INST_SPI0_SCK_USBA_XCLK_OE,
        -- Outputs
        Y   => SPI_0_CLK_PAD_Y,
        -- Inouts
        PAD => SPI_0_CLK 
        );
-- SPI_0_DI_PAD
SPI_0_DI_PAD : INBUF
    port map( 
        -- Inputs
        PAD => SPI_0_DI,
        -- Outputs
        Y   => SPI_0_DI_PAD_Y 
        );
-- SPI_0_DO_PAD
SPI_0_DO_PAD : TRIBUFF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_SPI0_SDO_USBA_STP_MGPIO6A_OUT,
        E   => MSS_ADLIB_INST_SPI0_SDO_USBA_STP_MGPIO6A_OE,
        -- Outputs
        PAD => SPI_0_DO_net_0 
        );
-- SPI_0_SS0_PAD
SPI_0_SS0_PAD : BIBUF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_SPI0_SS0_USBA_NXT_MGPIO7A_OUT,
        E   => MSS_ADLIB_INST_SPI0_SS0_USBA_NXT_MGPIO7A_OE,
        -- Outputs
        Y   => SPI_0_SS0_PAD_Y,
        -- Inouts
        PAD => SPI_0_SS0 
        );
-- SPI_0_SS1_PAD
SPI_0_SS1_PAD : TRIBUFF
    port map( 
        -- Inputs
        D   => MSS_ADLIB_INST_SPI0_SS1_USBA_DATA5_MGPIO8A_OUT,
        E   => MSS_ADLIB_INST_SPI0_SS1_USBA_DATA5_MGPIO8A_OE,
        -- Outputs
        PAD => SPI_0_SS1_net_0 
        );

end RTL;
