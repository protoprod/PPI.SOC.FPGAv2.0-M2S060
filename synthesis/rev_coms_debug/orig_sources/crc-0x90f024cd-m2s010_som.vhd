----------------------------------------------------------------------
-- Created by SmartDesign Fri Dec 28 12:37:41 2018
-- Version: v11.8 SP2 11.8.2.4
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
library COREAPB3_LIB;
use COREAPB3_LIB.all;
use COREAPB3_LIB.components.all;
----------------------------------------------------------------------
-- m2s010_som entity declaration
----------------------------------------------------------------------
entity m2s010_som is
    -- Port list
    port(
        -- Inputs
        DEBOUNCE_IN           : in    std_logic_vector(2 downto 0);
        DEVRST_N              : in    std_logic;
        D_COL                 : in    std_logic;
        D_CRS                 : in    std_logic;
        D_RXC                 : in    std_logic;
        D_RXD                 : in    std_logic_vector(3 downto 0);
        D_RXDV                : in    std_logic;
        D_RXER                : in    std_logic;
        D_TXC                 : in    std_logic;
        DormantREQn           : in    std_logic;
        EngageREQn            : in    std_logic;
        GPIO_0_F2M            : in    std_logic;
        GPIO_10_IN            : in    std_logic;
        GPIO_11_F2M           : in    std_logic;
        GPIO_19_IN            : in    std_logic;
        GPIO_9_IN             : in    std_logic;
        H_MDC                 : in    std_logic;
        H_TXD                 : in    std_logic_vector(3 downto 0);
        MANCHESTER_IN         : in    std_logic;
        MDDR_DQS_TMATCH_0_IN  : in    std_logic;
        MMUART_0_RXD_F2M      : in    std_logic;
        MMUART_1_RXD          : in    std_logic;
        SPI_0_DI              : in    std_logic;
        XTL                   : in    std_logic;
        -- Outputs
        DRVR_EN               : out   std_logic;
        D_MDC                 : out   std_logic;
        D_TXD                 : out   std_logic_vector(3 downto 0);
        D_TXEN                : out   std_logic;
        GPIO_14_M2F           : out   std_logic;
        GPIO_17_OUT           : out   std_logic;
        GPIO_18_OUT           : out   std_logic;
        GPIO_1_M2F            : out   std_logic;
        GPIO_20_M2F           : out   std_logic;
        GPIO_21_M2F           : out   std_logic;
        GPIO_24_M2F           : out   std_logic;
        GPIO_28_M2F           : out   std_logic;
        GPIO_5_M2F            : out   std_logic;
        GPIO_6_M2F            : out   std_logic;
        GPIO_7_M2F            : out   std_logic;
        GPIO_88               : out   std_logic;
        H_COL                 : out   std_logic;
        H_RXC                 : out   std_logic;
        H_RXER                : out   std_logic;
        H_TXC                 : out   std_logic;
        LED_BLUE_F3           : out   std_logic;
        LED_GREEN_G1          : out   std_logic;
        LED_RED_F2            : out   std_logic;
        MANCH_OUT_N           : out   std_logic;
        MANCH_OUT_P           : out   std_logic;
        MDDR_ADDR             : out   std_logic_vector(15 downto 0);
        MDDR_BA               : out   std_logic_vector(2 downto 0);
        MDDR_CAS_N            : out   std_logic;
        MDDR_CKE              : out   std_logic;
        MDDR_CLK              : out   std_logic;
        MDDR_CLK_N            : out   std_logic;
        MDDR_CS_N             : out   std_logic;
        MDDR_DQS_TMATCH_0_OUT : out   std_logic;
        MDDR_ODT              : out   std_logic;
        MDDR_RAS_N            : out   std_logic;
        MDDR_RESET_N          : out   std_logic;
        MDDR_WE_N             : out   std_logic;
        MMUART_0_TXD_M2F      : out   std_logic;
        MMUART_1_TXD          : out   std_logic;
        RCVR_EN               : out   std_logic;
        RTC_MATCH             : out   std_logic;
        SPI_0_DO              : out   std_logic;
        SPI_0_SS1             : out   std_logic;
        SPI_1_DO_M2F          : out   std_logic;
        SPI_FLASH_IO2         : out   std_logic;
        SPI_FLASH_IO3         : out   std_logic;
        nRESET_OUT            : out   std_logic;
        -- Inouts
        D_MDIO                : inout std_logic;
        GPIO_1_BIDI           : inout std_logic_vector(0 to 0);
        GPIO_25_BI            : inout std_logic;
        GPIO_26_BI            : inout std_logic;
        H_MDIO                : inout std_logic;
        I2C_1_SCL             : inout std_logic;
        I2C_1_SDA             : inout std_logic;
        MDDR_DM_RDQS          : inout std_logic_vector(1 downto 0);
        MDDR_DQ               : inout std_logic_vector(15 downto 0);
        MDDR_DQS              : inout std_logic_vector(1 downto 0);
        SPI_0_CLK             : inout std_logic;
        SPI_0_SS0             : inout std_logic;
        SPI_1_CLK             : inout std_logic;
        SPI_1_SS0             : inout std_logic
        );
end m2s010_som;
----------------------------------------------------------------------
-- m2s010_som architecture body
----------------------------------------------------------------------
architecture RTL of m2s010_som is
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
-- m2s010_som_CommsFPGA_CCC_0_FCCC   -   Actel:SgCore:FCCC:2.0.200
component m2s010_som_CommsFPGA_CCC_0_FCCC
    -- Port list
    port(
        -- Inputs
        XTLOSC : in  std_logic;
        -- Outputs
        GL0    : out std_logic;
        GL1    : out std_logic;
        GL2    : out std_logic;
        LOCK   : out std_logic
        );
end component;
-- CommsFPGA_top
-- using entity instantiation for component CommsFPGA_top
-- CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.1.100
-- using entity instantiation for component CoreAPB3
-- m2s010_som_sb
component m2s010_som_sb
    -- Port list
    port(
        -- Inputs
        DEVRST_N              : in    std_logic;
        FIC_0_APB_M_PRDATA    : in    std_logic_vector(31 downto 0);
        FIC_0_APB_M_PREADY    : in    std_logic;
        FIC_0_APB_M_PSLVERR   : in    std_logic;
        GPIO_0_F2M            : in    std_logic;
        GPIO_10_IN            : in    std_logic;
        GPIO_11_F2M           : in    std_logic;
        GPIO_12_F2M           : in    std_logic;
        GPIO_19_IN            : in    std_logic;
        GPIO_27_F2M           : in    std_logic;
        GPIO_2_F2M_0          : in    std_logic;
        GPIO_3_F2M            : in    std_logic;
        GPIO_4_F2M            : in    std_logic;
        GPIO_9_IN             : in    std_logic;
        MAC_MII_COL           : in    std_logic;
        MAC_MII_CRS           : in    std_logic;
        MAC_MII_MDI           : in    std_logic;
        MAC_MII_RXD           : in    std_logic_vector(3 downto 0);
        MAC_MII_RX_CLK        : in    std_logic;
        MAC_MII_RX_DV         : in    std_logic;
        MAC_MII_RX_ER         : in    std_logic;
        MAC_MII_TX_CLK        : in    std_logic;
        MDDR_DQS_TMATCH_0_IN  : in    std_logic;
        MMUART_0_RXD_F2M      : in    std_logic;
        MMUART_1_RXD          : in    std_logic;
        MSS_INT_F2M           : in    std_logic;
        SPI_0_DI              : in    std_logic;
        SPI_1_DI_F2M          : in    std_logic;
        XTL                   : in    std_logic;
        -- Outputs
        CCC_71MHz             : out   std_logic;
        FIC_0_APB_M_PADDR     : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PENABLE   : out   std_logic;
        FIC_0_APB_M_PSEL      : out   std_logic;
        FIC_0_APB_M_PWDATA    : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PWRITE    : out   std_logic;
        GPIO_14_M2F           : out   std_logic;
        GPIO_17_OUT           : out   std_logic;
        GPIO_18_OUT           : out   std_logic;
        GPIO_1_M2F            : out   std_logic;
        GPIO_20_M2F           : out   std_logic;
        GPIO_21_M2F           : out   std_logic;
        GPIO_24_M2F           : out   std_logic;
        GPIO_28_M2F           : out   std_logic;
        GPIO_29_GREEN         : out   std_logic;
        GPIO_30_RED           : out   std_logic;
        GPIO_31_BLUE          : out   std_logic;
        GPIO_5_M2F            : out   std_logic;
        GPIO_6_M2F            : out   std_logic;
        GPIO_7_M2F            : out   std_logic;
        GPIO_8_LED_CNTL       : out   std_logic;
        MAC_MII_MDC           : out   std_logic;
        MAC_MII_MDO           : out   std_logic;
        MAC_MII_MDO_EN        : out   std_logic;
        MAC_MII_TXD           : out   std_logic_vector(3 downto 0);
        MAC_MII_TX_EN         : out   std_logic;
        MDDR_ADDR             : out   std_logic_vector(15 downto 0);
        MDDR_BA               : out   std_logic_vector(2 downto 0);
        MDDR_CAS_N            : out   std_logic;
        MDDR_CKE              : out   std_logic;
        MDDR_CLK              : out   std_logic;
        MDDR_CLK_N            : out   std_logic;
        MDDR_CS_N             : out   std_logic;
        MDDR_DQS_TMATCH_0_OUT : out   std_logic;
        MDDR_ODT              : out   std_logic;
        MDDR_RAS_N            : out   std_logic;
        MDDR_RESET_N          : out   std_logic;
        MDDR_WE_N             : out   std_logic;
        MMUART_0_TXD_M2F      : out   std_logic;
        MMUART_1_TXD          : out   std_logic;
        POWER_ON_RESET_N      : out   std_logic;
        RTC_MATCH             : out   std_logic;
        SPI_0_DO              : out   std_logic;
        SPI_0_SS1             : out   std_logic;
        SPI_1_DO_M2F          : out   std_logic;
        XTLOSC_CCC            : out   std_logic;
        -- Inouts
        GPIO_25_BI            : inout std_logic;
        GPIO_26_BI            : inout std_logic;
        I2C_1_SCL             : inout std_logic;
        I2C_1_SDA             : inout std_logic;
        MDDR_DM_RDQS          : inout std_logic_vector(1 downto 0);
        MDDR_DQ               : inout std_logic_vector(15 downto 0);
        MDDR_DQS              : inout std_logic_vector(1 downto 0);
        SPI_0_CLK             : inout std_logic;
        SPI_0_SS0             : inout std_logic;
        SPI_1_CLK             : inout std_logic;
        SPI_1_SS0             : inout std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal BIBUF_0_Y                                 : std_logic;
signal BIBUF_1_Y                                 : std_logic;
signal CommsFPGA_CCC_0_GL0                       : std_logic;
signal CommsFPGA_CCC_0_GL1                       : std_logic;
signal CommsFPGA_CCC_0_GL2                       : std_logic;
signal CommsFPGA_CCC_0_LOCK                      : std_logic;
signal CommsFPGA_top_0_D_MDO                     : std_logic;
signal CommsFPGA_top_0_D_MDO_EN                  : std_logic;
signal CommsFPGA_top_0_DEBOUNCE_OUT0             : std_logic;
signal CommsFPGA_top_0_DEBOUNCE_OUT1             : std_logic;
signal CommsFPGA_top_0_DEBOUNCE_OUT2             : std_logic;
signal CommsFPGA_top_0_H_MDO                     : std_logic;
signal CommsFPGA_top_0_H_MDO_EN                  : std_logic;
signal CommsFPGA_top_0_INT                       : std_logic;
signal CommsFPGA_top_0_MAC_MII_COL               : std_logic;
signal CommsFPGA_top_0_MAC_MII_CRS               : std_logic;
signal CommsFPGA_top_0_MAC_MII_MDI               : std_logic;
signal CommsFPGA_top_0_MAC_MII_RX_CLK            : std_logic;
signal CommsFPGA_top_0_MAC_MII_RX_DV             : std_logic;
signal CommsFPGA_top_0_MAC_MII_RX_ER             : std_logic;
signal CommsFPGA_top_0_MAC_MII_RXD               : std_logic_vector(3 downto 0);
signal CommsFPGA_top_0_MAC_MII_TX_CLK            : std_logic;
signal CoreAPB3_0_APBmslave0_PENABLE             : std_logic;
signal CoreAPB3_0_APBmslave0_PREADY              : std_logic;
signal CoreAPB3_0_APBmslave0_PSELx               : std_logic;
signal CoreAPB3_0_APBmslave0_PWRITE              : std_logic;
signal D_MDC_net_0                               : std_logic;
signal D_TXD_net_0                               : std_logic_vector(3 downto 0);
signal D_TXEN_net_0                              : std_logic;
signal DRVR_EN_net_0                             : std_logic;
signal GPIO_1_M2F_1                              : std_logic;
signal GPIO_5_M2F_0                              : std_logic;
signal GPIO_6_M2F_0                              : std_logic;
signal GPIO_7_M2F_0                              : std_logic;
signal GPIO_14_M2F_net_0                         : std_logic;
signal GPIO_17_OUT_net_0                         : std_logic;
signal GPIO_18_OUT_net_0                         : std_logic;
signal GPIO_20_M2F_net_0                         : std_logic;
signal GPIO_21_M2F_0                             : std_logic;
signal GPIO_24_M2F_0                             : std_logic;
signal GPIO_28_M2F_net_0                         : std_logic;
signal H_COL_net_0                               : std_logic;
signal H_RXER_net_0                              : std_logic;
signal H_TXC_net_0                               : std_logic;
signal LED_BLUE_F3_net_0                         : std_logic;
signal LED_GREEN_G1_net_0                        : std_logic;
signal LED_RED_F2_net_0                          : std_logic;
signal m2s010_som_sb_0_CCC_71MHz                 : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PADDR    : std_logic_vector(31 downto 0);
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PENABLE  : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PRDATA   : std_logic_vector(31 downto 0);
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PREADY   : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PSELx    : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PSLVERR  : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PWDATA   : std_logic_vector(31 downto 0);
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PWRITE   : std_logic;
signal m2s010_som_sb_0_GPIO_8_LED_CNTL           : std_logic;
signal m2s010_som_sb_0_GPIO_29_GREEN             : std_logic;
signal m2s010_som_sb_0_GPIO_30_RED               : std_logic;
signal m2s010_som_sb_0_GPIO_31_BLUE              : std_logic;
signal m2s010_som_sb_0_MAC_MII_MDC               : std_logic;
signal m2s010_som_sb_0_MAC_MII_MDO               : std_logic;
signal m2s010_som_sb_0_MAC_MII_MDO_EN            : std_logic;
signal m2s010_som_sb_0_MAC_MII_TX_EN             : std_logic;
signal m2s010_som_sb_0_MAC_MII_TXD               : std_logic_vector(3 downto 0);
signal m2s010_som_sb_0_POWER_ON_RESET_N          : std_logic;
signal m2s010_som_sb_0_XTLOSC_CCC_OUT_XTLOSC_CCC : std_logic;
signal MANCH_OUT_N_net_0                         : std_logic;
signal MANCH_OUT_P_net_0                         : std_logic;
signal MDDR_ADDR_net_0                           : std_logic_vector(15 downto 0);
signal MDDR_BA_net_0                             : std_logic_vector(2 downto 0);
signal MDDR_CAS_N_net_0                          : std_logic;
signal MDDR_CKE_net_0                            : std_logic;
signal MDDR_CLK_net_0                            : std_logic;
signal MDDR_CLK_N_net_0                          : std_logic;
signal MDDR_CS_N_net_0                           : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_0               : std_logic;
signal MDDR_ODT_net_0                            : std_logic;
signal MDDR_RAS_N_net_0                          : std_logic;
signal MDDR_RESET_N_net_0                        : std_logic;
signal MDDR_WE_N_net_0                           : std_logic;
signal MMUART_0_TXD_M2F_0                        : std_logic;
signal MMUART_1_TXD_net_0                        : std_logic;
signal nRESET_OUT_net_0                          : std_logic;
signal RCVR_EN_net_0                             : std_logic;
signal RTC_MATCH_net_0                           : std_logic;
signal SPI_0_DO_net_0                            : std_logic;
signal SPI_0_SS1_0                               : std_logic;
signal SPI_1_DO_M2F_net_0                        : std_logic;
signal SPI_FLASH_IO2_net_0                       : std_logic;
signal SPI_FLASH_IO3_net_0                       : std_logic;
signal SPI_0_DO_net_1                            : std_logic;
signal MMUART_1_TXD_net_1                        : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_1               : std_logic;
signal MDDR_CAS_N_net_1                          : std_logic;
signal MDDR_CLK_net_1                            : std_logic;
signal MDDR_CLK_N_net_1                          : std_logic;
signal MDDR_CKE_net_1                            : std_logic;
signal MDDR_CS_N_net_1                           : std_logic;
signal MDDR_ODT_net_1                            : std_logic;
signal MDDR_RAS_N_net_1                          : std_logic;
signal MDDR_RESET_N_net_1                        : std_logic;
signal MDDR_WE_N_net_1                           : std_logic;
signal DRVR_EN_net_1                             : std_logic;
signal RCVR_EN_net_1                             : std_logic;
signal MANCH_OUT_P_net_1                         : std_logic;
signal MANCH_OUT_N_net_1                         : std_logic;
signal H_TXC_net_1                               : std_logic;
signal H_RXER_net_1                              : std_logic;
signal H_COL_net_1                               : std_logic;
signal SPI_FLASH_IO2_net_1                       : std_logic;
signal SPI_FLASH_IO3_net_1                       : std_logic;
signal D_MDC_net_1                               : std_logic;
signal D_TXEN_net_1                              : std_logic;
signal nRESET_OUT_net_1                          : std_logic;
signal MMUART_0_TXD_M2F_0_net_0                  : std_logic;
signal SPI_0_SS1_0_net_0                         : std_logic;
signal SPI_1_DO_M2F_net_1                        : std_logic;
signal GPIO_5_M2F_0_net_0                        : std_logic;
signal GPIO_21_M2F_0_net_0                       : std_logic;
signal GPIO_24_M2F_0_net_0                       : std_logic;
signal GPIO_28_M2F_net_1                         : std_logic;
signal LED_GREEN_G1_net_1                        : std_logic;
signal LED_BLUE_F3_net_1                         : std_logic;
signal LED_RED_F2_net_1                          : std_logic;
signal RTC_MATCH_net_1                           : std_logic;
signal GPIO_6_M2F_0_net_0                        : std_logic;
signal GPIO_7_M2F_0_net_0                        : std_logic;
signal GPIO_20_M2F_net_1                         : std_logic;
signal GPIO_1_M2F_1_net_0                        : std_logic;
signal GPIO_17_OUT_net_1                         : std_logic;
signal GPIO_18_OUT_net_1                         : std_logic;
signal MDDR_ADDR_net_1                           : std_logic_vector(15 downto 0);
signal MDDR_BA_net_1                             : std_logic_vector(2 downto 0);
signal D_TXD_net_1                               : std_logic_vector(3 downto 0);
signal GPIO_14_M2F_net_1                         : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                   : std_logic;
signal GND_net                                   : std_logic;
signal PADDR_const_net_0                         : std_logic_vector(7 downto 2);
signal PWDATA_const_net_0                        : std_logic_vector(7 downto 0);
signal IADDR_const_net_0                         : std_logic_vector(31 downto 0);
signal PRDATAS1_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS2_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS3_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS4_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS5_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS6_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS7_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS8_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS9_const_net_0                      : std_logic_vector(31 downto 0);
signal PRDATAS10_const_net_0                     : std_logic_vector(31 downto 0);
signal PRDATAS11_const_net_0                     : std_logic_vector(31 downto 0);
signal PRDATAS12_const_net_0                     : std_logic_vector(31 downto 0);
signal PRDATAS13_const_net_0                     : std_logic_vector(31 downto 0);
signal PRDATAS14_const_net_0                     : std_logic_vector(31 downto 0);
signal PRDATAS15_const_net_0                     : std_logic_vector(31 downto 0);
signal PRDATAS16_const_net_0                     : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal CoreAPB3_0_APBmslave0_PADDR_0_7to0        : std_logic_vector(7 downto 0);
signal CoreAPB3_0_APBmslave0_PADDR_0             : std_logic_vector(7 downto 0);
signal CoreAPB3_0_APBmslave0_PADDR               : std_logic_vector(31 downto 0);

signal CoreAPB3_0_APBmslave0_PRDATA              : std_logic_vector(7 downto 0);
signal CoreAPB3_0_APBmslave0_PRDATA_0_31to8      : std_logic_vector(31 downto 8);
signal CoreAPB3_0_APBmslave0_PRDATA_0_7to0       : std_logic_vector(7 downto 0);
signal CoreAPB3_0_APBmslave0_PRDATA_0            : std_logic_vector(31 downto 0);

signal CoreAPB3_0_APBmslave0_PWDATA_0_7to0       : std_logic_vector(7 downto 0);
signal CoreAPB3_0_APBmslave0_PWDATA_0            : std_logic_vector(7 downto 0);
signal CoreAPB3_0_APBmslave0_PWDATA              : std_logic_vector(31 downto 0);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net               <= '1';
 GND_net               <= '0';
 PADDR_const_net_0     <= B"000000";
 PWDATA_const_net_0    <= B"00000000";
 IADDR_const_net_0     <= B"00000000000000000000000000000000";
 PRDATAS1_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS2_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS3_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS4_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS5_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS6_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS7_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS8_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS9_const_net_0  <= B"00000000000000000000000000000000";
 PRDATAS10_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS11_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS12_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS13_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS14_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS15_const_net_0 <= B"00000000000000000000000000000000";
 PRDATAS16_const_net_0 <= B"00000000000000000000000000000000";
----------------------------------------------------------------------
-- TieOff assignments
----------------------------------------------------------------------
 H_RXC                       <= '1';
 GPIO_88                     <= '1';
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_0_DO_net_1              <= SPI_0_DO_net_0;
 SPI_0_DO                    <= SPI_0_DO_net_1;
 MMUART_1_TXD_net_1          <= MMUART_1_TXD_net_0;
 MMUART_1_TXD                <= MMUART_1_TXD_net_1;
 MDDR_DQS_TMATCH_0_OUT_net_1 <= MDDR_DQS_TMATCH_0_OUT_net_0;
 MDDR_DQS_TMATCH_0_OUT       <= MDDR_DQS_TMATCH_0_OUT_net_1;
 MDDR_CAS_N_net_1            <= MDDR_CAS_N_net_0;
 MDDR_CAS_N                  <= MDDR_CAS_N_net_1;
 MDDR_CLK_net_1              <= MDDR_CLK_net_0;
 MDDR_CLK                    <= MDDR_CLK_net_1;
 MDDR_CLK_N_net_1            <= MDDR_CLK_N_net_0;
 MDDR_CLK_N                  <= MDDR_CLK_N_net_1;
 MDDR_CKE_net_1              <= MDDR_CKE_net_0;
 MDDR_CKE                    <= MDDR_CKE_net_1;
 MDDR_CS_N_net_1             <= MDDR_CS_N_net_0;
 MDDR_CS_N                   <= MDDR_CS_N_net_1;
 MDDR_ODT_net_1              <= MDDR_ODT_net_0;
 MDDR_ODT                    <= MDDR_ODT_net_1;
 MDDR_RAS_N_net_1            <= MDDR_RAS_N_net_0;
 MDDR_RAS_N                  <= MDDR_RAS_N_net_1;
 MDDR_RESET_N_net_1          <= MDDR_RESET_N_net_0;
 MDDR_RESET_N                <= MDDR_RESET_N_net_1;
 MDDR_WE_N_net_1             <= MDDR_WE_N_net_0;
 MDDR_WE_N                   <= MDDR_WE_N_net_1;
 DRVR_EN_net_1               <= DRVR_EN_net_0;
 DRVR_EN                     <= DRVR_EN_net_1;
 RCVR_EN_net_1               <= RCVR_EN_net_0;
 RCVR_EN                     <= RCVR_EN_net_1;
 MANCH_OUT_P_net_1           <= MANCH_OUT_P_net_0;
 MANCH_OUT_P                 <= MANCH_OUT_P_net_1;
 MANCH_OUT_N_net_1           <= MANCH_OUT_N_net_0;
 MANCH_OUT_N                 <= MANCH_OUT_N_net_1;
 H_TXC_net_1                 <= H_TXC_net_0;
 H_TXC                       <= H_TXC_net_1;
 H_RXER_net_1                <= H_RXER_net_0;
 H_RXER                      <= H_RXER_net_1;
 H_COL_net_1                 <= H_COL_net_0;
 H_COL                       <= H_COL_net_1;
 SPI_FLASH_IO2_net_1         <= SPI_FLASH_IO2_net_0;
 SPI_FLASH_IO2               <= SPI_FLASH_IO2_net_1;
 SPI_FLASH_IO3_net_1         <= SPI_FLASH_IO3_net_0;
 SPI_FLASH_IO3               <= SPI_FLASH_IO3_net_1;
 D_MDC_net_1                 <= D_MDC_net_0;
 D_MDC                       <= D_MDC_net_1;
 D_TXEN_net_1                <= D_TXEN_net_0;
 D_TXEN                      <= D_TXEN_net_1;
 nRESET_OUT_net_1            <= nRESET_OUT_net_0;
 nRESET_OUT                  <= nRESET_OUT_net_1;
 MMUART_0_TXD_M2F_0_net_0    <= MMUART_0_TXD_M2F_0;
 MMUART_0_TXD_M2F            <= MMUART_0_TXD_M2F_0_net_0;
 SPI_0_SS1_0_net_0           <= SPI_0_SS1_0;
 SPI_0_SS1                   <= SPI_0_SS1_0_net_0;
 SPI_1_DO_M2F_net_1          <= SPI_1_DO_M2F_net_0;
 SPI_1_DO_M2F                <= SPI_1_DO_M2F_net_1;
 GPIO_5_M2F_0_net_0          <= GPIO_5_M2F_0;
 GPIO_5_M2F                  <= GPIO_5_M2F_0_net_0;
 GPIO_21_M2F_0_net_0         <= GPIO_21_M2F_0;
 GPIO_21_M2F                 <= GPIO_21_M2F_0_net_0;
 GPIO_24_M2F_0_net_0         <= GPIO_24_M2F_0;
 GPIO_24_M2F                 <= GPIO_24_M2F_0_net_0;
 GPIO_28_M2F_net_1           <= GPIO_28_M2F_net_0;
 GPIO_28_M2F                 <= GPIO_28_M2F_net_1;
 LED_GREEN_G1_net_1          <= LED_GREEN_G1_net_0;
 LED_GREEN_G1                <= LED_GREEN_G1_net_1;
 LED_BLUE_F3_net_1           <= LED_BLUE_F3_net_0;
 LED_BLUE_F3                 <= LED_BLUE_F3_net_1;
 LED_RED_F2_net_1            <= LED_RED_F2_net_0;
 LED_RED_F2                  <= LED_RED_F2_net_1;
 RTC_MATCH_net_1             <= RTC_MATCH_net_0;
 RTC_MATCH                   <= RTC_MATCH_net_1;
 GPIO_6_M2F_0_net_0          <= GPIO_6_M2F_0;
 GPIO_6_M2F                  <= GPIO_6_M2F_0_net_0;
 GPIO_7_M2F_0_net_0          <= GPIO_7_M2F_0;
 GPIO_7_M2F                  <= GPIO_7_M2F_0_net_0;
 GPIO_20_M2F_net_1           <= GPIO_20_M2F_net_0;
 GPIO_20_M2F                 <= GPIO_20_M2F_net_1;
 GPIO_1_M2F_1_net_0          <= GPIO_1_M2F_1;
 GPIO_1_M2F                  <= GPIO_1_M2F_1_net_0;
 GPIO_17_OUT_net_1           <= GPIO_17_OUT_net_0;
 GPIO_17_OUT                 <= GPIO_17_OUT_net_1;
 GPIO_18_OUT_net_1           <= GPIO_18_OUT_net_0;
 GPIO_18_OUT                 <= GPIO_18_OUT_net_1;
 MDDR_ADDR_net_1             <= MDDR_ADDR_net_0;
 MDDR_ADDR(15 downto 0)      <= MDDR_ADDR_net_1;
 MDDR_BA_net_1               <= MDDR_BA_net_0;
 MDDR_BA(2 downto 0)         <= MDDR_BA_net_1;
 D_TXD_net_1                 <= D_TXD_net_0;
 D_TXD(3 downto 0)           <= D_TXD_net_1;
 GPIO_14_M2F_net_1           <= GPIO_14_M2F_net_0;
 GPIO_14_M2F                 <= GPIO_14_M2F_net_1;
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 CoreAPB3_0_APBmslave0_PADDR_0_7to0(7 downto 0) <= CoreAPB3_0_APBmslave0_PADDR(7 downto 0);
 CoreAPB3_0_APBmslave0_PADDR_0 <= ( CoreAPB3_0_APBmslave0_PADDR_0_7to0(7 downto 0) );

 CoreAPB3_0_APBmslave0_PRDATA_0_31to8(31 downto 8) <= B"000000000000000000000000";
 CoreAPB3_0_APBmslave0_PRDATA_0_7to0(7 downto 0) <= CoreAPB3_0_APBmslave0_PRDATA(7 downto 0);
 CoreAPB3_0_APBmslave0_PRDATA_0 <= ( CoreAPB3_0_APBmslave0_PRDATA_0_31to8(31 downto 8) & CoreAPB3_0_APBmslave0_PRDATA_0_7to0(7 downto 0) );

 CoreAPB3_0_APBmslave0_PWDATA_0_7to0(7 downto 0) <= CoreAPB3_0_APBmslave0_PWDATA(7 downto 0);
 CoreAPB3_0_APBmslave0_PWDATA_0 <= ( CoreAPB3_0_APBmslave0_PWDATA_0_7to0(7 downto 0) );

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- BIBUF_0
BIBUF_0 : BIBUF
    port map( 
        -- Inputs
        D   => CommsFPGA_top_0_D_MDO,
        E   => CommsFPGA_top_0_D_MDO_EN,
        -- Outputs
        Y   => BIBUF_0_Y,
        -- Inouts
        PAD => D_MDIO 
        );
-- BIBUF_1
BIBUF_1 : BIBUF
    port map( 
        -- Inputs
        D   => CommsFPGA_top_0_H_MDO,
        E   => CommsFPGA_top_0_H_MDO_EN,
        -- Outputs
        Y   => BIBUF_1_Y,
        -- Inouts
        PAD => H_MDIO 
        );
-- CommsFPGA_CCC_0   -   Actel:SgCore:FCCC:2.0.200
CommsFPGA_CCC_0 : m2s010_som_CommsFPGA_CCC_0_FCCC
    port map( 
        -- Inputs
        XTLOSC => m2s010_som_sb_0_XTLOSC_CCC_OUT_XTLOSC_CCC,
        -- Outputs
        GL0    => CommsFPGA_CCC_0_GL0,
        GL1    => CommsFPGA_CCC_0_GL1,
        GL2    => CommsFPGA_CCC_0_GL2,
        LOCK   => CommsFPGA_CCC_0_LOCK 
        );
-- CommsFPGA_top_0
CommsFPGA_top_0 : entity work.CommsFPGA_top
    port map( 
        -- Inputs
        clk16x                    => CommsFPGA_CCC_0_GL0,
        bit_clk2x                 => CommsFPGA_CCC_0_GL1,
        Clk_25MHz                 => CommsFPGA_CCC_0_GL2,
        SW_RESET                  => GND_net,
        BD_RESETn                 => m2s010_som_sb_0_POWER_ON_RESET_N,
        LOCK                      => CommsFPGA_CCC_0_LOCK,
        APB3_CLK                  => m2s010_som_sb_0_CCC_71MHz,
        APB3_SEL                  => CoreAPB3_0_APBmslave0_PSELx,
        APB3_ENABLE               => CoreAPB3_0_APBmslave0_PENABLE,
        APB3_WRITE                => CoreAPB3_0_APBmslave0_PWRITE,
        MANCHESTER_IN             => MANCHESTER_IN,
        H_MDI                     => BIBUF_1_Y,
        H_MDC                     => H_MDC,
        H_TXEN                    => GND_net,
        DormantREQn               => DormantREQn,
        EngageREQn                => EngageREQn,
        HOST_DETn                 => VCC_net,
        uSD_DETLVR                => GND_net,
        uSD_DETSW                 => GND_net,
        MAC_MII_MDC               => m2s010_som_sb_0_MAC_MII_MDC,
        MII_DBG_PHYn              => VCC_net,
        MAC_MII_TX_EN             => m2s010_som_sb_0_MAC_MII_TX_EN,
        MAC_MII_MDO_EN            => m2s010_som_sb_0_MAC_MII_MDO_EN,
        MAC_MII_MDO               => m2s010_som_sb_0_MAC_MII_MDO,
        D_MDI                     => BIBUF_0_Y,
        D_TXC                     => D_TXC,
        D_RXC                     => D_RXC,
        D_RXDV                    => D_RXDV,
        D_RXER                    => D_RXER,
        D_CRS                     => D_CRS,
        D_COL                     => D_COL,
        THOs_AFE                  => GND_net,
        GPIO8_M2F                 => m2s010_som_sb_0_GPIO_8_LED_CNTL,
        GPIO29_GREEN              => m2s010_som_sb_0_GPIO_29_GREEN,
        GPIO30_RED                => m2s010_som_sb_0_GPIO_30_RED,
        GPIO31_BLUE               => m2s010_som_sb_0_GPIO_31_BLUE,
        APB3_ADDR                 => CoreAPB3_0_APBmslave0_PADDR_0,
        APB3_WDATA                => CoreAPB3_0_APBmslave0_PWDATA_0,
        DEBOUNCE_IN               => DEBOUNCE_IN,
        H_TXD                     => H_TXD,
        MAC_MII_TXD               => m2s010_som_sb_0_MAC_MII_TXD,
        D_RXD                     => D_RXD,
        -- Outputs
        SIMOnly_idle_line         => OPEN,
        SIMOnly_rx_packet_end_all => OPEN,
        SIMonly_start_tx          => OPEN,
        SIMonly_force_jabber      => OPEN,
        RESET_OUTn                => nRESET_OUT_net_0,
        APB3_READY                => CoreAPB3_0_APBmslave0_PREADY,
        DEBOUNCE_OUT0             => CommsFPGA_top_0_DEBOUNCE_OUT0,
        DEBOUNCE_OUT1             => CommsFPGA_top_0_DEBOUNCE_OUT1,
        DEBOUNCE_OUT2             => CommsFPGA_top_0_DEBOUNCE_OUT2,
        DRVR_EN                   => DRVR_EN_net_0,
        RCVR_EN                   => RCVR_EN_net_0,
        MANCH_OUT_P               => MANCH_OUT_P_net_0,
        MANCH_OUT_N               => MANCH_OUT_N_net_0,
        INT                       => CommsFPGA_top_0_INT,
        H_MDO                     => CommsFPGA_top_0_H_MDO,
        H_MDO_EN                  => CommsFPGA_top_0_H_MDO_EN,
        H_TXC                     => H_TXC_net_0,
        H_RXC                     => OPEN,
        H_RXDV                    => OPEN,
        H_RXER                    => H_RXER_net_0,
        H_CRS                     => OPEN,
        H_COL                     => H_COL_net_0,
        SPI_FLASH_RSTn            => OPEN,
        SPI_FLASH_IO2             => SPI_FLASH_IO2_net_0,
        SPI_FLASH_IO3             => SPI_FLASH_IO3_net_0,
        MAC_MII_RX_ER             => CommsFPGA_top_0_MAC_MII_RX_ER,
        MAC_MII_RX_DV             => CommsFPGA_top_0_MAC_MII_RX_DV,
        MAC_MII_CRS               => CommsFPGA_top_0_MAC_MII_CRS,
        MAC_MII_COL               => CommsFPGA_top_0_MAC_MII_COL,
        MAC_MII_RX_CLK            => CommsFPGA_top_0_MAC_MII_RX_CLK,
        MAC_MII_TX_CLK            => CommsFPGA_top_0_MAC_MII_TX_CLK,
        MAC_MII_MDI               => CommsFPGA_top_0_MAC_MII_MDI,
        D_MDO_EN                  => CommsFPGA_top_0_D_MDO_EN,
        D_MDO                     => CommsFPGA_top_0_D_MDO,
        D_MDC                     => D_MDC_net_0,
        D_TXEN                    => D_TXEN_net_0,
        MII_RX_D_fail_reg         => OPEN,
        LED_GREEN                 => LED_GREEN_G1_net_0,
        LED_BLUE                  => LED_BLUE_F3_net_0,
        LED_RED                   => LED_RED_F2_net_0,
        APB3_RDATA                => CoreAPB3_0_APBmslave0_PRDATA,
        H_RXD                     => OPEN,
        MAC_MII_RXD               => CommsFPGA_top_0_MAC_MII_RXD,
        D_TXD                     => D_TXD_net_0 
        );
-- CoreAPB3_0   -   Actel:DirectCore:CoreAPB3:4.1.100
CoreAPB3_0 : entity COREAPB3_LIB.CoreAPB3
    generic map( 
        APB_DWIDTH      => ( 32 ),
        APBSLOT0ENABLE  => ( 1 ),
        APBSLOT1ENABLE  => ( 0 ),
        APBSLOT2ENABLE  => ( 0 ),
        APBSLOT3ENABLE  => ( 0 ),
        APBSLOT4ENABLE  => ( 0 ),
        APBSLOT5ENABLE  => ( 0 ),
        APBSLOT6ENABLE  => ( 0 ),
        APBSLOT7ENABLE  => ( 0 ),
        APBSLOT8ENABLE  => ( 0 ),
        APBSLOT9ENABLE  => ( 0 ),
        APBSLOT10ENABLE => ( 0 ),
        APBSLOT11ENABLE => ( 0 ),
        APBSLOT12ENABLE => ( 0 ),
        APBSLOT13ENABLE => ( 0 ),
        APBSLOT14ENABLE => ( 0 ),
        APBSLOT15ENABLE => ( 0 ),
        FAMILY          => ( 19 ),
        IADDR_OPTION    => ( 0 ),
        MADDR_BITS      => ( 16 ),
        SC_0            => ( 0 ),
        SC_1            => ( 0 ),
        SC_2            => ( 0 ),
        SC_3            => ( 0 ),
        SC_4            => ( 0 ),
        SC_5            => ( 0 ),
        SC_6            => ( 0 ),
        SC_7            => ( 0 ),
        SC_8            => ( 0 ),
        SC_9            => ( 0 ),
        SC_10           => ( 0 ),
        SC_11           => ( 0 ),
        SC_12           => ( 0 ),
        SC_13           => ( 0 ),
        SC_14           => ( 0 ),
        SC_15           => ( 0 ),
        UPR_NIBBLE_POSN => ( 3 )
        )
    port map( 
        -- Inputs
        PRESETN    => GND_net, -- tied to '0' from definition
        PCLK       => GND_net, -- tied to '0' from definition
        PWRITE     => m2s010_som_sb_0_FIC_0_APB_MASTER_PWRITE,
        PENABLE    => m2s010_som_sb_0_FIC_0_APB_MASTER_PENABLE,
        PSEL       => m2s010_som_sb_0_FIC_0_APB_MASTER_PSELx,
        PREADYS0   => CoreAPB3_0_APBmslave0_PREADY,
        PSLVERRS0  => GND_net, -- tied to '0' from definition
        PREADYS1   => VCC_net, -- tied to '1' from definition
        PSLVERRS1  => GND_net, -- tied to '0' from definition
        PREADYS2   => VCC_net, -- tied to '1' from definition
        PSLVERRS2  => GND_net, -- tied to '0' from definition
        PREADYS3   => VCC_net, -- tied to '1' from definition
        PSLVERRS3  => GND_net, -- tied to '0' from definition
        PREADYS4   => VCC_net, -- tied to '1' from definition
        PSLVERRS4  => GND_net, -- tied to '0' from definition
        PREADYS5   => VCC_net, -- tied to '1' from definition
        PSLVERRS5  => GND_net, -- tied to '0' from definition
        PREADYS6   => VCC_net, -- tied to '1' from definition
        PSLVERRS6  => GND_net, -- tied to '0' from definition
        PREADYS7   => VCC_net, -- tied to '1' from definition
        PSLVERRS7  => GND_net, -- tied to '0' from definition
        PREADYS8   => VCC_net, -- tied to '1' from definition
        PSLVERRS8  => GND_net, -- tied to '0' from definition
        PREADYS9   => VCC_net, -- tied to '1' from definition
        PSLVERRS9  => GND_net, -- tied to '0' from definition
        PREADYS10  => VCC_net, -- tied to '1' from definition
        PSLVERRS10 => GND_net, -- tied to '0' from definition
        PREADYS11  => VCC_net, -- tied to '1' from definition
        PSLVERRS11 => GND_net, -- tied to '0' from definition
        PREADYS12  => VCC_net, -- tied to '1' from definition
        PSLVERRS12 => GND_net, -- tied to '0' from definition
        PREADYS13  => VCC_net, -- tied to '1' from definition
        PSLVERRS13 => GND_net, -- tied to '0' from definition
        PREADYS14  => VCC_net, -- tied to '1' from definition
        PSLVERRS14 => GND_net, -- tied to '0' from definition
        PREADYS15  => VCC_net, -- tied to '1' from definition
        PSLVERRS15 => GND_net, -- tied to '0' from definition
        PREADYS16  => VCC_net, -- tied to '1' from definition
        PSLVERRS16 => GND_net, -- tied to '0' from definition
        PADDR      => m2s010_som_sb_0_FIC_0_APB_MASTER_PADDR,
        PWDATA     => m2s010_som_sb_0_FIC_0_APB_MASTER_PWDATA,
        PRDATAS0   => CoreAPB3_0_APBmslave0_PRDATA_0,
        PRDATAS1   => PRDATAS1_const_net_0, -- tied to X"0" from definition
        PRDATAS2   => PRDATAS2_const_net_0, -- tied to X"0" from definition
        PRDATAS3   => PRDATAS3_const_net_0, -- tied to X"0" from definition
        PRDATAS4   => PRDATAS4_const_net_0, -- tied to X"0" from definition
        PRDATAS5   => PRDATAS5_const_net_0, -- tied to X"0" from definition
        PRDATAS6   => PRDATAS6_const_net_0, -- tied to X"0" from definition
        PRDATAS7   => PRDATAS7_const_net_0, -- tied to X"0" from definition
        PRDATAS8   => PRDATAS8_const_net_0, -- tied to X"0" from definition
        PRDATAS9   => PRDATAS9_const_net_0, -- tied to X"0" from definition
        PRDATAS10  => PRDATAS10_const_net_0, -- tied to X"0" from definition
        PRDATAS11  => PRDATAS11_const_net_0, -- tied to X"0" from definition
        PRDATAS12  => PRDATAS12_const_net_0, -- tied to X"0" from definition
        PRDATAS13  => PRDATAS13_const_net_0, -- tied to X"0" from definition
        PRDATAS14  => PRDATAS14_const_net_0, -- tied to X"0" from definition
        PRDATAS15  => PRDATAS15_const_net_0, -- tied to X"0" from definition
        PRDATAS16  => PRDATAS16_const_net_0, -- tied to X"0" from definition
        IADDR      => IADDR_const_net_0, -- tied to X"0" from definition
        -- Outputs
        PREADY     => m2s010_som_sb_0_FIC_0_APB_MASTER_PREADY,
        PSLVERR    => m2s010_som_sb_0_FIC_0_APB_MASTER_PSLVERR,
        PWRITES    => CoreAPB3_0_APBmslave0_PWRITE,
        PENABLES   => CoreAPB3_0_APBmslave0_PENABLE,
        PSELS0     => CoreAPB3_0_APBmslave0_PSELx,
        PSELS1     => OPEN,
        PSELS2     => OPEN,
        PSELS3     => OPEN,
        PSELS4     => OPEN,
        PSELS5     => OPEN,
        PSELS6     => OPEN,
        PSELS7     => OPEN,
        PSELS8     => OPEN,
        PSELS9     => OPEN,
        PSELS10    => OPEN,
        PSELS11    => OPEN,
        PSELS12    => OPEN,
        PSELS13    => OPEN,
        PSELS14    => OPEN,
        PSELS15    => OPEN,
        PSELS16    => OPEN,
        PRDATA     => m2s010_som_sb_0_FIC_0_APB_MASTER_PRDATA,
        PADDRS     => CoreAPB3_0_APBmslave0_PADDR,
        PWDATAS    => CoreAPB3_0_APBmslave0_PWDATA 
        );
-- m2s010_som_sb_0
m2s010_som_sb_0 : m2s010_som_sb
    port map( 
        -- Inputs
        SPI_0_DI              => SPI_0_DI,
        MMUART_1_RXD          => MMUART_1_RXD,
        MDDR_DQS_TMATCH_0_IN  => MDDR_DQS_TMATCH_0_IN,
        XTL                   => XTL,
        DEVRST_N              => DEVRST_N,
        MAC_MII_RX_ER         => CommsFPGA_top_0_MAC_MII_RX_ER,
        MAC_MII_RX_DV         => CommsFPGA_top_0_MAC_MII_RX_DV,
        MAC_MII_CRS           => CommsFPGA_top_0_MAC_MII_CRS,
        MAC_MII_COL           => CommsFPGA_top_0_MAC_MII_COL,
        MAC_MII_RX_CLK        => CommsFPGA_top_0_MAC_MII_RX_CLK,
        MAC_MII_TX_CLK        => CommsFPGA_top_0_MAC_MII_TX_CLK,
        MSS_INT_F2M           => CommsFPGA_top_0_INT,
        MAC_MII_MDI           => CommsFPGA_top_0_MAC_MII_MDI,
        MMUART_0_RXD_F2M      => MMUART_0_RXD_F2M,
        SPI_1_DI_F2M          => GND_net,
        GPIO_27_F2M           => GND_net,
        GPIO_2_F2M_0          => CommsFPGA_top_0_DEBOUNCE_OUT0,
        GPIO_3_F2M            => CommsFPGA_top_0_DEBOUNCE_OUT1,
        GPIO_12_F2M           => GND_net,
        GPIO_4_F2M            => CommsFPGA_top_0_DEBOUNCE_OUT2,
        GPIO_0_F2M            => GPIO_0_F2M,
        GPIO_9_IN             => GPIO_9_IN,
        GPIO_10_IN            => GPIO_10_IN,
        GPIO_19_IN            => GPIO_19_IN,
        GPIO_11_F2M           => GPIO_11_F2M,
        MAC_MII_RXD           => CommsFPGA_top_0_MAC_MII_RXD,
        FIC_0_APB_M_PRDATA    => m2s010_som_sb_0_FIC_0_APB_MASTER_PRDATA,
        FIC_0_APB_M_PREADY    => m2s010_som_sb_0_FIC_0_APB_MASTER_PREADY,
        FIC_0_APB_M_PSLVERR   => m2s010_som_sb_0_FIC_0_APB_MASTER_PSLVERR,
        -- Outputs
        SPI_0_DO              => SPI_0_DO_net_0,
        MMUART_1_TXD          => MMUART_1_TXD_net_0,
        MDDR_DQS_TMATCH_0_OUT => MDDR_DQS_TMATCH_0_OUT_net_0,
        MDDR_CAS_N            => MDDR_CAS_N_net_0,
        MDDR_CLK              => MDDR_CLK_net_0,
        MDDR_CLK_N            => MDDR_CLK_N_net_0,
        MDDR_CKE              => MDDR_CKE_net_0,
        MDDR_CS_N             => MDDR_CS_N_net_0,
        MDDR_ODT              => MDDR_ODT_net_0,
        MDDR_RAS_N            => MDDR_RAS_N_net_0,
        MDDR_RESET_N          => MDDR_RESET_N_net_0,
        MDDR_WE_N             => MDDR_WE_N_net_0,
        MAC_MII_TX_EN         => m2s010_som_sb_0_MAC_MII_TX_EN,
        MAC_MII_MDC           => m2s010_som_sb_0_MAC_MII_MDC,
        POWER_ON_RESET_N      => m2s010_som_sb_0_POWER_ON_RESET_N,
        CCC_71MHz             => m2s010_som_sb_0_CCC_71MHz,
        XTLOSC_CCC            => m2s010_som_sb_0_XTLOSC_CCC_OUT_XTLOSC_CCC,
        MAC_MII_MDO           => m2s010_som_sb_0_MAC_MII_MDO,
        MAC_MII_MDO_EN        => m2s010_som_sb_0_MAC_MII_MDO_EN,
        MMUART_0_TXD_M2F      => MMUART_0_TXD_M2F_0,
        SPI_0_SS1             => SPI_0_SS1_0,
        SPI_1_DO_M2F          => SPI_1_DO_M2F_net_0,
        GPIO_5_M2F            => GPIO_5_M2F_0,
        GPIO_21_M2F           => GPIO_21_M2F_0,
        GPIO_24_M2F           => GPIO_24_M2F_0,
        GPIO_28_M2F           => GPIO_28_M2F_net_0,
        GPIO_29_GREEN         => m2s010_som_sb_0_GPIO_29_GREEN,
        GPIO_30_RED           => m2s010_som_sb_0_GPIO_30_RED,
        RTC_MATCH             => RTC_MATCH_net_0,
        GPIO_8_LED_CNTL       => m2s010_som_sb_0_GPIO_8_LED_CNTL,
        GPIO_31_BLUE          => m2s010_som_sb_0_GPIO_31_BLUE,
        GPIO_6_M2F            => GPIO_6_M2F_0,
        GPIO_7_M2F            => GPIO_7_M2F_0,
        GPIO_20_M2F           => GPIO_20_M2F_net_0,
        GPIO_1_M2F            => GPIO_1_M2F_1,
        GPIO_17_OUT           => GPIO_17_OUT_net_0,
        GPIO_18_OUT           => GPIO_18_OUT_net_0,
        MDDR_ADDR             => MDDR_ADDR_net_0,
        MDDR_BA               => MDDR_BA_net_0,
        MAC_MII_TXD           => m2s010_som_sb_0_MAC_MII_TXD,
        FIC_0_APB_M_PADDR     => m2s010_som_sb_0_FIC_0_APB_MASTER_PADDR,
        FIC_0_APB_M_PSEL      => m2s010_som_sb_0_FIC_0_APB_MASTER_PSELx,
        FIC_0_APB_M_PENABLE   => m2s010_som_sb_0_FIC_0_APB_MASTER_PENABLE,
        FIC_0_APB_M_PWRITE    => m2s010_som_sb_0_FIC_0_APB_MASTER_PWRITE,
        FIC_0_APB_M_PWDATA    => m2s010_som_sb_0_FIC_0_APB_MASTER_PWDATA,
        GPIO_14_M2F           => GPIO_14_M2F_net_0,
        -- Inouts
        I2C_1_SDA             => I2C_1_SDA,
        I2C_1_SCL             => I2C_1_SCL,
        SPI_0_CLK             => SPI_0_CLK,
        SPI_0_SS0             => SPI_0_SS0,
        GPIO_25_BI            => GPIO_25_BI,
        GPIO_26_BI            => GPIO_26_BI,
        SPI_1_SS0             => SPI_1_SS0,
        SPI_1_CLK             => SPI_1_CLK,
        MDDR_DM_RDQS          => MDDR_DM_RDQS,
        MDDR_DQ               => MDDR_DQ,
        MDDR_DQS              => MDDR_DQS 
        );

end RTL;
