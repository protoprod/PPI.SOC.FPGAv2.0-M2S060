----------------------------------------------------------------------
-- Created by SmartDesign Tue Feb 21 13:44:23 2017
-- Version: v11.6 SP1 11.6.1.6
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
        ID_RES                : in    std_logic_vector(3 downto 0);
        MAC_MII_COL           : in    std_logic;
        MAC_MII_CRS           : in    std_logic;
        MAC_MII_RXD           : in    std_logic_vector(3 downto 0);
        MAC_MII_RX_CLK        : in    std_logic;
        MAC_MII_RX_DV         : in    std_logic;
        MAC_MII_RX_ER         : in    std_logic;
        MAC_MII_TX_CLK        : in    std_logic;
        MANCHESTER_IN         : in    std_logic;
        MDDR_DQS_TMATCH_0_IN  : in    std_logic;
        MMUART_0_RXD_F2M      : in    std_logic;
        MMUART_1_RXD          : in    std_logic;
        PULLDOWN_R9           : in    std_logic;
        SPI_0_DI              : in    std_logic;
        SPI_1_DI_CAM          : in    std_logic;
        SPI_1_DI_OTH          : in    std_logic;
        XTL                   : in    std_logic;
        -- Outputs
        DEBOUNCE_OUT_1        : out   std_logic;
        DEBOUNCE_OUT_2        : out   std_logic;
        DRVR_EN               : out   std_logic;
        Data_FAIL             : out   std_logic;
        GPIO_11_M2F           : out   std_logic;
        GPIO_20_OUT           : out   std_logic;
        GPIO_21_M2F           : out   std_logic;
        GPIO_22_M2F           : out   std_logic;
        GPIO_24_M2F           : out   std_logic;
        GPIO_5_M2F            : out   std_logic;
        GPIO_7_M2F            : out   std_logic;
        GPIO_8_M2F            : out   std_logic;
        MAC_MII_MDC           : out   std_logic;
        MAC_MII_TXD           : out   std_logic_vector(3 downto 0);
        MAC_MII_TX_EN         : out   std_logic;
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
        SPI_0_DO              : out   std_logic;
        SPI_0_SS1             : out   std_logic;
        SPI_1_DO_CAM          : out   std_logic;
        SPI_1_DO_OTH          : out   std_logic;
        -- Inouts
        GPIO_0_BI             : inout std_logic;
        GPIO_12_BI            : inout std_logic;
        GPIO_14_BI            : inout std_logic;
        GPIO_15_BI            : inout std_logic;
        GPIO_16_BI            : inout std_logic;
        GPIO_17_BI            : inout std_logic;
        GPIO_18_BI            : inout std_logic;
        GPIO_1_BI             : inout std_logic_vector(0 to 0);
        GPIO_1_BIDI           : inout std_logic_vector(0 to 0);
        GPIO_25_BI            : inout std_logic;
        GPIO_26_BI            : inout std_logic;
        GPIO_31_BI            : inout std_logic;
        GPIO_3_BI             : inout std_logic;
        GPIO_4_BI             : inout std_logic;
        GPIO_6_PAD            : inout std_logic_vector(0 to 0);
        I2C_1_SCL             : inout std_logic;
        I2C_1_SDA             : inout std_logic;
        MAC_MII_MDIO          : inout std_logic;
        MDDR_DM_RDQS          : inout std_logic_vector(1 downto 0);
        MDDR_DQ               : inout std_logic_vector(15 downto 0);
        MDDR_DQS              : inout std_logic_vector(1 downto 0);
        SPI_0_CLK             : inout std_logic;
        SPI_0_SS0             : inout std_logic;
        SPI_1_CLK             : inout std_logic_vector(0 to 0);
        SPI_1_SS0_CAM         : inout std_logic_vector(0 to 0);
        SPI_1_SS0_OTH         : inout std_logic_vector(0 to 0)
        );
end m2s010_som;
----------------------------------------------------------------------
-- m2s010_som architecture body
----------------------------------------------------------------------
architecture RTL of m2s010_som is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- m2s010_som_CommsFPGA_CCC_0_FCCC   -   Actel:SgCore:FCCC:2.0.200
component m2s010_som_CommsFPGA_CCC_0_FCCC
    -- Port list
    port(
        -- Inputs
        XTLOSC : in  std_logic;
        -- Outputs
        GL0    : out std_logic;
        GL1    : out std_logic;
        LOCK   : out std_logic
        );
end component;
-- CommsFPGA_top
-- using entity instantiation for component CommsFPGA_top
-- CoreAPB3   -   Actel:DirectCore:CoreAPB3:4.1.100
-- using entity instantiation for component CoreAPB3
-- m2s010_som_ID_RES_0_IO   -   Actel:SgCore:IO:1.0.101
component m2s010_som_ID_RES_0_IO
    -- Port list
    port(
        -- Inputs
        PAD_IN : in  std_logic_vector(3 downto 0);
        -- Outputs
        Y      : out std_logic_vector(3 downto 0)
        );
end component;
-- m2s010_som_sb
component m2s010_som_sb
    -- Port list
    port(
        -- Inputs
        CAMERA_NODE           : in    std_logic;
        DEBOUNCE_OUT0         : in    std_logic;
        DEBOUNCE_OUT1         : in    std_logic;
        DEBOUNCE_OUT2         : in    std_logic;
        DEVRST_N              : in    std_logic;
        FIC_0_APB_M_PRDATA    : in    std_logic_vector(31 downto 0);
        FIC_0_APB_M_PREADY    : in    std_logic;
        FIC_0_APB_M_PSLVERR   : in    std_logic;
        ID_RES0               : in    std_logic;
        ID_RES1               : in    std_logic;
        ID_RES2               : in    std_logic;
        ID_RES3               : in    std_logic;
        MAC_MII_COL           : in    std_logic;
        MAC_MII_CRS           : in    std_logic;
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
        SPI_1_DI_CAM          : in    std_logic;
        SPI_1_DI_OTH          : in    std_logic;
        XTL                   : in    std_logic;
        -- Outputs
        CCC_71MHz             : out   std_logic;
        FIC_0_APB_M_PADDR     : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PENABLE   : out   std_logic;
        FIC_0_APB_M_PSEL      : out   std_logic;
        FIC_0_APB_M_PWDATA    : out   std_logic_vector(31 downto 0);
        FIC_0_APB_M_PWRITE    : out   std_logic;
        GPIO_11_M2F           : out   std_logic;
        GPIO_20_OUT           : out   std_logic;
        GPIO_21_M2F           : out   std_logic;
        GPIO_22_M2F           : out   std_logic;
        GPIO_24_M2F           : out   std_logic;
        GPIO_28_SW_RESET      : out   std_logic;
        GPIO_5_M2F            : out   std_logic;
        GPIO_7_M2F            : out   std_logic;
        GPIO_8_M2F            : out   std_logic;
        MAC_MII_MDC           : out   std_logic;
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
        SPI_0_DO              : out   std_logic;
        SPI_0_SS1             : out   std_logic;
        SPI_1_DO_CAM          : out   std_logic;
        SPI_1_DO_OTH          : out   std_logic;
        XTLOSC_CCC            : out   std_logic;
        -- Inouts
        GPIO_0_BI             : inout std_logic;
        GPIO_12_BI            : inout std_logic;
        GPIO_14_BI            : inout std_logic;
        GPIO_15_BI            : inout std_logic;
        GPIO_16_BI            : inout std_logic;
        GPIO_17_BI            : inout std_logic;
        GPIO_18_BI            : inout std_logic;
        GPIO_1_BI             : inout std_logic_vector(0 to 0);
        GPIO_25_BI            : inout std_logic;
        GPIO_26_BI            : inout std_logic;
        GPIO_31_BI            : inout std_logic;
        GPIO_3_BI             : inout std_logic;
        GPIO_4_BI             : inout std_logic;
        GPIO_6_PAD            : inout std_logic_vector(0 to 0);
        I2C_1_SCL             : inout std_logic;
        I2C_1_SDA             : inout std_logic;
        MAC_MII_MDIO          : inout std_logic;
        MDDR_DM_RDQS          : inout std_logic_vector(1 downto 0);
        MDDR_DQ               : inout std_logic_vector(15 downto 0);
        MDDR_DQS              : inout std_logic_vector(1 downto 0);
        SPI_0_CLK             : inout std_logic;
        SPI_0_SS0             : inout std_logic;
        SPI_1_CLK             : inout std_logic_vector(0 to 0);
        SPI_1_SS0_CAM         : inout std_logic_vector(0 to 0);
        SPI_1_SS0_OTH         : inout std_logic_vector(0 to 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CommsFPGA_CCC_0_GL0                       : std_logic;
signal CommsFPGA_CCC_0_GL1                       : std_logic;
signal CommsFPGA_CCC_0_LOCK                      : std_logic;
signal CommsFPGA_top_0_CAMERA_NODE               : std_logic;
signal CommsFPGA_top_0_DEBOUNCE_OUT0to0          : std_logic_vector(0 to 0);
signal CommsFPGA_top_0_INT                       : std_logic;
signal CoreAPB3_0_APBmslave0_PENABLE             : std_logic;
signal CoreAPB3_0_APBmslave0_PREADY              : std_logic;
signal CoreAPB3_0_APBmslave0_PSELx               : std_logic;
signal CoreAPB3_0_APBmslave0_PWRITE              : std_logic;
signal Data_FAIL_net_0                           : std_logic;
signal DEBOUNCE_OUT_1_net_0                      : std_logic_vector(1 to 1);
signal DEBOUNCE_OUT_3                            : std_logic_vector(2 to 2);
signal DRVR_EN_net_0                             : std_logic;
signal GPIO_5_M2F_net_0                          : std_logic;
signal GPIO_7_M2F_net_0                          : std_logic;
signal GPIO_8_M2F_net_0                          : std_logic;
signal GPIO_11_M2F_net_0                         : std_logic;
signal GPIO_20_OUT_net_0                         : std_logic;
signal GPIO_21_M2F_net_0                         : std_logic;
signal GPIO_22_M2F_net_0                         : std_logic;
signal GPIO_24_M2F_net_0                         : std_logic;
signal ID_RES0                                   : std_logic_vector(0 to 0);
signal ID_RES1                                   : std_logic_vector(1 to 1);
signal ID_RES2                                   : std_logic_vector(2 to 2);
signal ID_RES3                                   : std_logic_vector(3 to 3);
signal m2s010_som_sb_0_CCC_71MHz                 : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PADDR    : std_logic_vector(31 downto 0);
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PENABLE  : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PRDATA   : std_logic_vector(31 downto 0);
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PREADY   : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PSELx    : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PSLVERR  : std_logic;
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PWDATA   : std_logic_vector(31 downto 0);
signal m2s010_som_sb_0_FIC_0_APB_MASTER_PWRITE   : std_logic;
signal m2s010_som_sb_0_GPIO_28_SW_RESET          : std_logic;
signal m2s010_som_sb_0_POWER_ON_RESET_N          : std_logic;
signal m2s010_som_sb_0_XTLOSC_CCC_OUT_XTLOSC_CCC : std_logic;
signal MAC_MII_MDC_net_0                         : std_logic;
signal MAC_MII_TX_EN_net_0                       : std_logic;
signal MAC_MII_TXD_net_0                         : std_logic_vector(3 downto 0);
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
signal MMUART_0_TXD_M2F_net_0                    : std_logic;
signal MMUART_1_TXD_net_0                        : std_logic;
signal RCVR_EN_net_0                             : std_logic;
signal SPI_0_DO_net_0                            : std_logic;
signal SPI_0_SS1_net_0                           : std_logic;
signal SPI_1_DO_CAM_net_0                        : std_logic;
signal SPI_1_DO_OTH_net_0                        : std_logic;
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
signal MAC_MII_TX_EN_net_1                       : std_logic;
signal MAC_MII_MDC_net_1                         : std_logic;
signal DRVR_EN_net_1                             : std_logic;
signal RCVR_EN_net_1                             : std_logic;
signal MANCH_OUT_P_net_1                         : std_logic;
signal MANCH_OUT_N_net_1                         : std_logic;
signal Data_FAIL_net_1                           : std_logic;
signal MMUART_0_TXD_M2F_net_1                    : std_logic;
signal GPIO_20_OUT_net_1                         : std_logic;
signal GPIO_5_M2F_net_1                          : std_logic;
signal GPIO_7_M2F_net_1                          : std_logic;
signal GPIO_8_M2F_net_1                          : std_logic;
signal GPIO_11_M2F_net_1                         : std_logic;
signal GPIO_21_M2F_net_1                         : std_logic;
signal GPIO_22_M2F_net_1                         : std_logic;
signal GPIO_24_M2F_net_1                         : std_logic;
signal DEBOUNCE_OUT_1_net_1                      : std_logic;
signal DEBOUNCE_OUT_3_net_0                      : std_logic;
signal SPI_0_SS1_net_1                           : std_logic;
signal SPI_1_DO_CAM_net_1                        : std_logic;
signal SPI_1_DO_OTH_net_1                        : std_logic;
signal MDDR_ADDR_net_1                           : std_logic_vector(15 downto 0);
signal MDDR_BA_net_1                             : std_logic_vector(2 downto 0);
signal MAC_MII_TXD_net_1                         : std_logic_vector(3 downto 0);
signal ID_RES_net_0                              : std_logic_vector(3 downto 0);
signal DEBOUNCE_OUT_net_0                        : std_logic_vector(2 downto 0);
signal Y_net_0                                   : std_logic_vector(3 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                                   : std_logic;
signal PADDR_const_net_0                         : std_logic_vector(7 downto 2);
signal PWDATA_const_net_0                        : std_logic_vector(7 downto 0);
signal VCC_net                                   : std_logic;
signal IADDR_const_net_0                         : std_logic_vector(31 downto 0);
signal PAD_BI_const_net_0                        : std_logic_vector(3 downto 0);
signal PADP_IN_const_net_0                       : std_logic_vector(3 downto 0);
signal PADP_BI_const_net_0                       : std_logic_vector(3 downto 0);
signal PADN_IN_const_net_0                       : std_logic_vector(3 downto 0);
signal PADN_BI_const_net_0                       : std_logic_vector(3 downto 0);
signal D_const_net_0                             : std_logic_vector(3 downto 0);
signal E_const_net_0                             : std_logic_vector(3 downto 0);
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

signal CoreAPB3_0_APBmslave0_PRDATA_0_31to8      : std_logic_vector(31 downto 8);
signal CoreAPB3_0_APBmslave0_PRDATA_0_7to0       : std_logic_vector(7 downto 0);
signal CoreAPB3_0_APBmslave0_PRDATA_0            : std_logic_vector(31 downto 0);
signal CoreAPB3_0_APBmslave0_PRDATA              : std_logic_vector(7 downto 0);

signal CoreAPB3_0_APBmslave0_PWDATA              : std_logic_vector(31 downto 0);
signal CoreAPB3_0_APBmslave0_PWDATA_0_7to0       : std_logic_vector(7 downto 0);
signal CoreAPB3_0_APBmslave0_PWDATA_0            : std_logic_vector(7 downto 0);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net               <= '0';
 PADDR_const_net_0     <= B"000000";
 PWDATA_const_net_0    <= B"00000000";
 VCC_net               <= '1';
 IADDR_const_net_0     <= B"00000000000000000000000000000000";
 PAD_BI_const_net_0    <= B"0000";
 PADP_IN_const_net_0   <= B"0000";
 PADP_BI_const_net_0   <= B"0000";
 PADN_IN_const_net_0   <= B"0000";
 PADN_BI_const_net_0   <= B"0000";
 D_const_net_0         <= B"0000";
 E_const_net_0         <= B"0000";
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
 MAC_MII_TX_EN_net_1         <= MAC_MII_TX_EN_net_0;
 MAC_MII_TX_EN               <= MAC_MII_TX_EN_net_1;
 MAC_MII_MDC_net_1           <= MAC_MII_MDC_net_0;
 MAC_MII_MDC                 <= MAC_MII_MDC_net_1;
 DRVR_EN_net_1               <= DRVR_EN_net_0;
 DRVR_EN                     <= DRVR_EN_net_1;
 RCVR_EN_net_1               <= RCVR_EN_net_0;
 RCVR_EN                     <= RCVR_EN_net_1;
 MANCH_OUT_P_net_1           <= MANCH_OUT_P_net_0;
 MANCH_OUT_P                 <= MANCH_OUT_P_net_1;
 MANCH_OUT_N_net_1           <= MANCH_OUT_N_net_0;
 MANCH_OUT_N                 <= MANCH_OUT_N_net_1;
 Data_FAIL_net_1             <= Data_FAIL_net_0;
 Data_FAIL                   <= Data_FAIL_net_1;
 MMUART_0_TXD_M2F_net_1      <= MMUART_0_TXD_M2F_net_0;
 MMUART_0_TXD_M2F            <= MMUART_0_TXD_M2F_net_1;
 GPIO_20_OUT_net_1           <= GPIO_20_OUT_net_0;
 GPIO_20_OUT                 <= GPIO_20_OUT_net_1;
 GPIO_5_M2F_net_1            <= GPIO_5_M2F_net_0;
 GPIO_5_M2F                  <= GPIO_5_M2F_net_1;
 GPIO_7_M2F_net_1            <= GPIO_7_M2F_net_0;
 GPIO_7_M2F                  <= GPIO_7_M2F_net_1;
 GPIO_8_M2F_net_1            <= GPIO_8_M2F_net_0;
 GPIO_8_M2F                  <= GPIO_8_M2F_net_1;
 GPIO_11_M2F_net_1           <= GPIO_11_M2F_net_0;
 GPIO_11_M2F                 <= GPIO_11_M2F_net_1;
 GPIO_21_M2F_net_1           <= GPIO_21_M2F_net_0;
 GPIO_21_M2F                 <= GPIO_21_M2F_net_1;
 GPIO_22_M2F_net_1           <= GPIO_22_M2F_net_0;
 GPIO_22_M2F                 <= GPIO_22_M2F_net_1;
 GPIO_24_M2F_net_1           <= GPIO_24_M2F_net_0;
 GPIO_24_M2F                 <= GPIO_24_M2F_net_1;
 DEBOUNCE_OUT_1_net_1        <= DEBOUNCE_OUT_1_net_0(1);
 DEBOUNCE_OUT_1              <= DEBOUNCE_OUT_1_net_1;
 DEBOUNCE_OUT_3_net_0        <= DEBOUNCE_OUT_3(2);
 DEBOUNCE_OUT_2              <= DEBOUNCE_OUT_3_net_0;
 SPI_0_SS1_net_1             <= SPI_0_SS1_net_0;
 SPI_0_SS1                   <= SPI_0_SS1_net_1;
 SPI_1_DO_CAM_net_1          <= SPI_1_DO_CAM_net_0;
 SPI_1_DO_CAM                <= SPI_1_DO_CAM_net_1;
 SPI_1_DO_OTH_net_1          <= SPI_1_DO_OTH_net_0;
 SPI_1_DO_OTH                <= SPI_1_DO_OTH_net_1;
 MDDR_ADDR_net_1             <= MDDR_ADDR_net_0;
 MDDR_ADDR(15 downto 0)      <= MDDR_ADDR_net_1;
 MDDR_BA_net_1               <= MDDR_BA_net_0;
 MDDR_BA(2 downto 0)         <= MDDR_BA_net_1;
 MAC_MII_TXD_net_1           <= MAC_MII_TXD_net_0;
 MAC_MII_TXD(3 downto 0)     <= MAC_MII_TXD_net_1;
----------------------------------------------------------------------
-- Slices assignments
----------------------------------------------------------------------
 CommsFPGA_top_0_DEBOUNCE_OUT0to0(0) <= DEBOUNCE_OUT_net_0(0);
 DEBOUNCE_OUT_1_net_0(1)             <= DEBOUNCE_OUT_net_0(1);
 DEBOUNCE_OUT_3(2)                   <= DEBOUNCE_OUT_net_0(2);
 ID_RES0(0)                          <= Y_net_0(0);
 ID_RES1(1)                          <= Y_net_0(1);
 ID_RES2(2)                          <= Y_net_0(2);
 ID_RES3(3)                          <= Y_net_0(3);
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 ID_RES_net_0 <= ( ID_RES3(3) & ID_RES2(2) & ID_RES1(1) & ID_RES0(0) );
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
-- CommsFPGA_CCC_0   -   Actel:SgCore:FCCC:2.0.200
CommsFPGA_CCC_0 : m2s010_som_CommsFPGA_CCC_0_FCCC
    port map( 
        -- Inputs
        XTLOSC => m2s010_som_sb_0_XTLOSC_CCC_OUT_XTLOSC_CCC,
        -- Outputs
        GL0    => CommsFPGA_CCC_0_GL0,
        GL1    => CommsFPGA_CCC_0_GL1,
        LOCK   => CommsFPGA_CCC_0_LOCK 
        );
-- CommsFPGA_top_0
CommsFPGA_top_0 : entity work.CommsFPGA_top
    generic map( 
        POSTAMBLE_LENGTH => ( 3 ),
        PREAMBLE_LENGTH  => ( 4 )
        )
    port map( 
        -- Inputs
        CLK             => CommsFPGA_CCC_0_GL0,
        CLK_2xBIT_10MHz => CommsFPGA_CCC_0_GL1,
        SW_RESET        => m2s010_som_sb_0_GPIO_28_SW_RESET,
        BD_RESETn       => m2s010_som_sb_0_POWER_ON_RESET_N,
        LOCK            => CommsFPGA_CCC_0_LOCK,
        APB3_CLK        => m2s010_som_sb_0_CCC_71MHz,
        APB3_SEL        => CoreAPB3_0_APBmslave0_PSELx,
        APB3_ENABLE     => CoreAPB3_0_APBmslave0_PENABLE,
        APB3_WRITE      => CoreAPB3_0_APBmslave0_PWRITE,
        MANCHESTER_IN   => MANCHESTER_IN,
        PULLDOWN_R9     => PULLDOWN_R9,
        APB3_ADDR       => CoreAPB3_0_APBmslave0_PADDR_0,
        APB3_WDATA      => CoreAPB3_0_APBmslave0_PWDATA_0,
        ID_RES          => ID_RES_net_0,
        DEBOUNCE_IN     => DEBOUNCE_IN,
        -- Outputs
        APB3_READY      => CoreAPB3_0_APBmslave0_PREADY,
        CAMERA_NODE     => CommsFPGA_top_0_CAMERA_NODE,
        OTHERS_NODE     => OPEN,
        DRVR_EN         => DRVR_EN_net_0,
        RCVR_EN         => RCVR_EN_net_0,
        MANCH_OUT_P     => MANCH_OUT_P_net_0,
        MANCH_OUT_N     => MANCH_OUT_N_net_0,
        INT             => CommsFPGA_top_0_INT,
        Data_FAIL       => Data_FAIL_net_0,
        TEST_TX         => OPEN,
        APB3_RDATA      => CoreAPB3_0_APBmslave0_PRDATA,
        DEBOUNCE_OUT    => DEBOUNCE_OUT_net_0 
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
-- ID_RES_0   -   Actel:SgCore:IO:1.0.101
ID_RES_0 : m2s010_som_ID_RES_0_IO
    port map( 
        -- Inputs
        PAD_IN => ID_RES,
        -- Outputs
        Y      => Y_net_0 
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
        MAC_MII_RX_ER         => MAC_MII_RX_ER,
        MAC_MII_RX_DV         => MAC_MII_RX_DV,
        MAC_MII_CRS           => MAC_MII_CRS,
        MAC_MII_COL           => MAC_MII_COL,
        MAC_MII_RX_CLK        => MAC_MII_RX_CLK,
        MAC_MII_TX_CLK        => MAC_MII_TX_CLK,
        FIC_0_APB_M_PREADY    => m2s010_som_sb_0_FIC_0_APB_MASTER_PREADY,
        FIC_0_APB_M_PSLVERR   => m2s010_som_sb_0_FIC_0_APB_MASTER_PSLVERR,
        MSS_INT_F2M           => CommsFPGA_top_0_INT,
        MMUART_0_RXD_F2M      => MMUART_0_RXD_F2M,
        DEBOUNCE_OUT1         => DEBOUNCE_OUT_1_net_0(1),
        DEBOUNCE_OUT2         => DEBOUNCE_OUT_3(2),
        DEBOUNCE_OUT0         => CommsFPGA_top_0_DEBOUNCE_OUT0to0(0),
        SPI_1_DI_CAM          => SPI_1_DI_CAM,
        ID_RES3               => ID_RES3(3),
        ID_RES0               => ID_RES0(0),
        ID_RES2               => ID_RES2(2),
        ID_RES1               => ID_RES1(1),
        CAMERA_NODE           => CommsFPGA_top_0_CAMERA_NODE,
        SPI_1_DI_OTH          => SPI_1_DI_OTH,
        MAC_MII_RXD           => MAC_MII_RXD,
        FIC_0_APB_M_PRDATA    => m2s010_som_sb_0_FIC_0_APB_MASTER_PRDATA,
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
        MAC_MII_TX_EN         => MAC_MII_TX_EN_net_0,
        MAC_MII_MDC           => MAC_MII_MDC_net_0,
        XTLOSC_CCC            => m2s010_som_sb_0_XTLOSC_CCC_OUT_XTLOSC_CCC,
        POWER_ON_RESET_N      => m2s010_som_sb_0_POWER_ON_RESET_N,
        FIC_0_APB_M_PSEL      => m2s010_som_sb_0_FIC_0_APB_MASTER_PSELx,
        FIC_0_APB_M_PENABLE   => m2s010_som_sb_0_FIC_0_APB_MASTER_PENABLE,
        FIC_0_APB_M_PWRITE    => m2s010_som_sb_0_FIC_0_APB_MASTER_PWRITE,
        CCC_71MHz             => m2s010_som_sb_0_CCC_71MHz,
        MMUART_0_TXD_M2F      => MMUART_0_TXD_M2F_net_0,
        GPIO_20_OUT           => GPIO_20_OUT_net_0,
        GPIO_5_M2F            => GPIO_5_M2F_net_0,
        GPIO_7_M2F            => GPIO_7_M2F_net_0,
        GPIO_8_M2F            => GPIO_8_M2F_net_0,
        GPIO_11_M2F           => GPIO_11_M2F_net_0,
        GPIO_21_M2F           => GPIO_21_M2F_net_0,
        GPIO_22_M2F           => GPIO_22_M2F_net_0,
        GPIO_24_M2F           => GPIO_24_M2F_net_0,
        GPIO_28_SW_RESET      => m2s010_som_sb_0_GPIO_28_SW_RESET,
        SPI_0_SS1             => SPI_0_SS1_net_0,
        SPI_1_DO_CAM          => SPI_1_DO_CAM_net_0,
        SPI_1_DO_OTH          => SPI_1_DO_OTH_net_0,
        MDDR_ADDR             => MDDR_ADDR_net_0,
        MDDR_BA               => MDDR_BA_net_0,
        MAC_MII_TXD           => MAC_MII_TXD_net_0,
        FIC_0_APB_M_PADDR     => m2s010_som_sb_0_FIC_0_APB_MASTER_PADDR,
        FIC_0_APB_M_PWDATA    => m2s010_som_sb_0_FIC_0_APB_MASTER_PWDATA,
        -- Inouts
        I2C_1_SDA             => I2C_1_SDA,
        I2C_1_SCL             => I2C_1_SCL,
        SPI_0_CLK             => SPI_0_CLK,
        SPI_0_SS0             => SPI_0_SS0,
        MAC_MII_MDIO          => MAC_MII_MDIO,
        GPIO_0_BI             => GPIO_0_BI,
        GPIO_3_BI             => GPIO_3_BI,
        GPIO_4_BI             => GPIO_4_BI,
        GPIO_12_BI            => GPIO_12_BI,
        GPIO_14_BI            => GPIO_14_BI,
        GPIO_15_BI            => GPIO_15_BI,
        GPIO_16_BI            => GPIO_16_BI,
        GPIO_17_BI            => GPIO_17_BI,
        GPIO_18_BI            => GPIO_18_BI,
        GPIO_25_BI            => GPIO_25_BI,
        GPIO_26_BI            => GPIO_26_BI,
        GPIO_31_BI            => GPIO_31_BI,
        MDDR_DM_RDQS          => MDDR_DM_RDQS,
        MDDR_DQ               => MDDR_DQ,
        MDDR_DQS              => MDDR_DQS,
        GPIO_1_BI             => GPIO_1_BI,
        SPI_1_SS0_CAM         => SPI_1_SS0_CAM,
        SPI_1_CLK             => SPI_1_CLK,
        SPI_1_SS0_OTH         => SPI_1_SS0_OTH,
        GPIO_6_PAD            => GPIO_6_PAD 
        );

end RTL;
