----------------------------------------------------------------------
-- Created by SmartDesign Tue Aug 22 13:59:51 2017
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
-- m2s010_som_sb entity declaration
----------------------------------------------------------------------
entity m2s010_som_sb is
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
        GPIO_7_PADI           : inout std_logic_vector(0 to 0);
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
end m2s010_som_sb;
----------------------------------------------------------------------
-- m2s010_som_sb architecture body
----------------------------------------------------------------------
architecture RTL of m2s010_som_sb is
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
-- m2s010_som_sb_CAM_SPI_1_CLK_IO   -   Actel:SgCore:IO:1.0.101
component m2s010_som_sb_CAM_SPI_1_CLK_IO
    -- Port list
    port(
        -- Inputs
        D      : in    std_logic_vector(0 to 0);
        E      : in    std_logic_vector(0 to 0);
        -- Outputs
        Y      : out   std_logic_vector(0 to 0);
        -- Inouts
        PAD_BI : inout std_logic_vector(0 to 0)
        );
end component;
-- m2s010_som_sb_CAM_SPI_1_SS0_IO   -   Actel:SgCore:IO:1.0.101
component m2s010_som_sb_CAM_SPI_1_SS0_IO
    -- Port list
    port(
        -- Inputs
        D      : in    std_logic_vector(0 to 0);
        E      : in    std_logic_vector(0 to 0);
        -- Outputs
        Y      : out   std_logic_vector(0 to 0);
        -- Inouts
        PAD_BI : inout std_logic_vector(0 to 0)
        );
end component;
-- m2s010_som_sb_CCC_0_FCCC   -   Actel:SgCore:FCCC:2.0.200
component m2s010_som_sb_CCC_0_FCCC
    -- Port list
    port(
        -- Inputs
        XTLOSC : in  std_logic;
        -- Outputs
        GL0    : out std_logic;
        LOCK   : out std_logic
        );
end component;
-- CoreConfigP   -   Actel:DirectCore:CoreConfigP:7.0.105
component CoreConfigP
    generic( 
        DEVICE_090         : integer := 0 ;
        ENABLE_SOFT_RESETS : integer := 0 ;
        FDDR_IN_USE        : integer := 0 ;
        MDDR_IN_USE        : integer := 1 ;
        SDIF0_IN_USE       : integer := 0 ;
        SDIF0_PCIE         : integer := 0 ;
        SDIF1_IN_USE       : integer := 0 ;
        SDIF1_PCIE         : integer := 0 ;
        SDIF2_IN_USE       : integer := 0 ;
        SDIF2_PCIE         : integer := 0 ;
        SDIF3_IN_USE       : integer := 0 ;
        SDIF3_PCIE         : integer := 0 
        );
    -- Port list
    port(
        -- Inputs
        FDDR_PRDATA                    : in  std_logic_vector(31 downto 0);
        FDDR_PREADY                    : in  std_logic;
        FDDR_PSLVERR                   : in  std_logic;
        FIC_2_APB_M_PADDR              : in  std_logic_vector(16 downto 2);
        FIC_2_APB_M_PCLK               : in  std_logic;
        FIC_2_APB_M_PENABLE            : in  std_logic;
        FIC_2_APB_M_PRESET_N           : in  std_logic;
        FIC_2_APB_M_PSEL               : in  std_logic;
        FIC_2_APB_M_PWDATA             : in  std_logic_vector(31 downto 0);
        FIC_2_APB_M_PWRITE             : in  std_logic;
        INIT_DONE                      : in  std_logic;
        MDDR_PRDATA                    : in  std_logic_vector(31 downto 0);
        MDDR_PREADY                    : in  std_logic;
        MDDR_PSLVERR                   : in  std_logic;
        SDIF0_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF0_PREADY                   : in  std_logic;
        SDIF0_PSLVERR                  : in  std_logic;
        SDIF1_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF1_PREADY                   : in  std_logic;
        SDIF1_PSLVERR                  : in  std_logic;
        SDIF2_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF2_PREADY                   : in  std_logic;
        SDIF2_PSLVERR                  : in  std_logic;
        SDIF3_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF3_PREADY                   : in  std_logic;
        SDIF3_PSLVERR                  : in  std_logic;
        SDIF_RELEASED                  : in  std_logic;
        -- Outputs
        APB_S_PCLK                     : out std_logic;
        APB_S_PRESET_N                 : out std_logic;
        CONFIG1_DONE                   : out std_logic;
        CONFIG2_DONE                   : out std_logic;
        FDDR_PADDR                     : out std_logic_vector(15 downto 2);
        FDDR_PENABLE                   : out std_logic;
        FDDR_PSEL                      : out std_logic;
        FDDR_PWDATA                    : out std_logic_vector(31 downto 0);
        FDDR_PWRITE                    : out std_logic;
        FIC_2_APB_M_PRDATA             : out std_logic_vector(31 downto 0);
        FIC_2_APB_M_PREADY             : out std_logic;
        FIC_2_APB_M_PSLVERR            : out std_logic;
        MDDR_PADDR                     : out std_logic_vector(15 downto 2);
        MDDR_PENABLE                   : out std_logic;
        MDDR_PSEL                      : out std_logic;
        MDDR_PWDATA                    : out std_logic_vector(31 downto 0);
        MDDR_PWRITE                    : out std_logic;
        R_SDIF0_PRDATA                 : out std_logic_vector(31 downto 0);
        R_SDIF0_PSEL                   : out std_logic;
        R_SDIF0_PWRITE                 : out std_logic;
        R_SDIF1_PRDATA                 : out std_logic_vector(31 downto 0);
        R_SDIF1_PSEL                   : out std_logic;
        R_SDIF1_PWRITE                 : out std_logic;
        R_SDIF2_PRDATA                 : out std_logic_vector(31 downto 0);
        R_SDIF2_PSEL                   : out std_logic;
        R_SDIF2_PWRITE                 : out std_logic;
        R_SDIF3_PRDATA                 : out std_logic_vector(31 downto 0);
        R_SDIF3_PSEL                   : out std_logic;
        R_SDIF3_PWRITE                 : out std_logic;
        SDIF0_PADDR                    : out std_logic_vector(15 downto 2);
        SDIF0_PENABLE                  : out std_logic;
        SDIF0_PSEL                     : out std_logic;
        SDIF0_PWDATA                   : out std_logic_vector(31 downto 0);
        SDIF0_PWRITE                   : out std_logic;
        SDIF1_PADDR                    : out std_logic_vector(15 downto 2);
        SDIF1_PENABLE                  : out std_logic;
        SDIF1_PSEL                     : out std_logic;
        SDIF1_PWDATA                   : out std_logic_vector(31 downto 0);
        SDIF1_PWRITE                   : out std_logic;
        SDIF2_PADDR                    : out std_logic_vector(15 downto 2);
        SDIF2_PENABLE                  : out std_logic;
        SDIF2_PSEL                     : out std_logic;
        SDIF2_PWDATA                   : out std_logic_vector(31 downto 0);
        SDIF2_PWRITE                   : out std_logic;
        SDIF3_PADDR                    : out std_logic_vector(15 downto 2);
        SDIF3_PENABLE                  : out std_logic;
        SDIF3_PSEL                     : out std_logic;
        SDIF3_PWDATA                   : out std_logic_vector(31 downto 0);
        SDIF3_PWRITE                   : out std_logic;
        SOFT_EXT_RESET_OUT             : out std_logic;
        SOFT_FDDR_CORE_RESET           : out std_logic;
        SOFT_M3_RESET                  : out std_logic;
        SOFT_MDDR_DDR_AXI_S_CORE_RESET : out std_logic;
        SOFT_RESET_F2M                 : out std_logic;
        SOFT_SDIF0_0_CORE_RESET        : out std_logic;
        SOFT_SDIF0_1_CORE_RESET        : out std_logic;
        SOFT_SDIF0_CORE_RESET          : out std_logic;
        SOFT_SDIF0_PHY_RESET           : out std_logic;
        SOFT_SDIF1_CORE_RESET          : out std_logic;
        SOFT_SDIF1_PHY_RESET           : out std_logic;
        SOFT_SDIF2_CORE_RESET          : out std_logic;
        SOFT_SDIF2_PHY_RESET           : out std_logic;
        SOFT_SDIF3_CORE_RESET          : out std_logic;
        SOFT_SDIF3_PHY_RESET           : out std_logic
        );
end component;
-- CoreResetP   -   Actel:DirectCore:CoreResetP:7.0.104
component CoreResetP
    generic( 
        DDR_WAIT            : integer := 200 ;
        DEVICE_090          : integer := 0 ;
        DEVICE_VOLTAGE      : integer := 2 ;
        ENABLE_SOFT_RESETS  : integer := 0 ;
        EXT_RESET_CFG       : integer := 3 ;
        FDDR_IN_USE         : integer := 0 ;
        MDDR_IN_USE         : integer := 1 ;
        SDIF0_IN_USE        : integer := 0 ;
        SDIF0_PCIE          : integer := 0 ;
        SDIF0_PCIE_HOTRESET : integer := 1 ;
        SDIF0_PCIE_L2P2     : integer := 1 ;
        SDIF1_IN_USE        : integer := 0 ;
        SDIF1_PCIE          : integer := 0 ;
        SDIF1_PCIE_HOTRESET : integer := 1 ;
        SDIF1_PCIE_L2P2     : integer := 1 ;
        SDIF2_IN_USE        : integer := 0 ;
        SDIF2_PCIE          : integer := 0 ;
        SDIF2_PCIE_HOTRESET : integer := 1 ;
        SDIF2_PCIE_L2P2     : integer := 1 ;
        SDIF3_IN_USE        : integer := 0 ;
        SDIF3_PCIE          : integer := 0 ;
        SDIF3_PCIE_HOTRESET : integer := 1 ;
        SDIF3_PCIE_L2P2     : integer := 1 
        );
    -- Port list
    port(
        -- Inputs
        CLK_BASE                       : in  std_logic;
        CLK_LTSSM                      : in  std_logic;
        CONFIG1_DONE                   : in  std_logic;
        CONFIG2_DONE                   : in  std_logic;
        FAB_RESET_N                    : in  std_logic;
        FIC_2_APB_M_PRESET_N           : in  std_logic;
        FPLL_LOCK                      : in  std_logic;
        POWER_ON_RESET_N               : in  std_logic;
        RCOSC_25_50MHZ                 : in  std_logic;
        RESET_N_M2F                    : in  std_logic;
        SDIF0_PERST_N                  : in  std_logic;
        SDIF0_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF0_PSEL                     : in  std_logic;
        SDIF0_PWRITE                   : in  std_logic;
        SDIF0_SPLL_LOCK                : in  std_logic;
        SDIF1_PERST_N                  : in  std_logic;
        SDIF1_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF1_PSEL                     : in  std_logic;
        SDIF1_PWRITE                   : in  std_logic;
        SDIF1_SPLL_LOCK                : in  std_logic;
        SDIF2_PERST_N                  : in  std_logic;
        SDIF2_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF2_PSEL                     : in  std_logic;
        SDIF2_PWRITE                   : in  std_logic;
        SDIF2_SPLL_LOCK                : in  std_logic;
        SDIF3_PERST_N                  : in  std_logic;
        SDIF3_PRDATA                   : in  std_logic_vector(31 downto 0);
        SDIF3_PSEL                     : in  std_logic;
        SDIF3_PWRITE                   : in  std_logic;
        SDIF3_SPLL_LOCK                : in  std_logic;
        SOFT_EXT_RESET_OUT             : in  std_logic;
        SOFT_FDDR_CORE_RESET           : in  std_logic;
        SOFT_M3_RESET                  : in  std_logic;
        SOFT_MDDR_DDR_AXI_S_CORE_RESET : in  std_logic;
        SOFT_RESET_F2M                 : in  std_logic;
        SOFT_SDIF0_0_CORE_RESET        : in  std_logic;
        SOFT_SDIF0_1_CORE_RESET        : in  std_logic;
        SOFT_SDIF0_CORE_RESET          : in  std_logic;
        SOFT_SDIF0_PHY_RESET           : in  std_logic;
        SOFT_SDIF1_CORE_RESET          : in  std_logic;
        SOFT_SDIF1_PHY_RESET           : in  std_logic;
        SOFT_SDIF2_CORE_RESET          : in  std_logic;
        SOFT_SDIF2_PHY_RESET           : in  std_logic;
        SOFT_SDIF3_CORE_RESET          : in  std_logic;
        SOFT_SDIF3_PHY_RESET           : in  std_logic;
        -- Outputs
        DDR_READY                      : out std_logic;
        EXT_RESET_OUT                  : out std_logic;
        FDDR_CORE_RESET_N              : out std_logic;
        INIT_DONE                      : out std_logic;
        M3_RESET_N                     : out std_logic;
        MDDR_DDR_AXI_S_CORE_RESET_N    : out std_logic;
        MSS_HPMS_READY                 : out std_logic;
        RESET_N_F2M                    : out std_logic;
        SDIF0_0_CORE_RESET_N           : out std_logic;
        SDIF0_1_CORE_RESET_N           : out std_logic;
        SDIF0_CORE_RESET_N             : out std_logic;
        SDIF0_PHY_RESET_N              : out std_logic;
        SDIF1_CORE_RESET_N             : out std_logic;
        SDIF1_PHY_RESET_N              : out std_logic;
        SDIF2_CORE_RESET_N             : out std_logic;
        SDIF2_PHY_RESET_N              : out std_logic;
        SDIF3_CORE_RESET_N             : out std_logic;
        SDIF3_PHY_RESET_N              : out std_logic;
        SDIF_READY                     : out std_logic;
        SDIF_RELEASED                  : out std_logic
        );
end component;
-- m2s010_som_sb_FABOSC_0_OSC   -   Actel:SgCore:OSC:2.0.101
component m2s010_som_sb_FABOSC_0_OSC
    -- Port list
    port(
        -- Inputs
        XTL                : in  std_logic;
        -- Outputs
        RCOSC_1MHZ_CCC     : out std_logic;
        RCOSC_1MHZ_O2F     : out std_logic;
        RCOSC_25_50MHZ_CCC : out std_logic;
        RCOSC_25_50MHZ_O2F : out std_logic;
        XTLOSC_CCC         : out std_logic;
        XTLOSC_O2F         : out std_logic
        );
end component;
-- m2s010_som_sb_GPIO_1_IO   -   Actel:SgCore:IO:1.0.101
component m2s010_som_sb_GPIO_1_IO
    -- Port list
    port(
        -- Inputs
        D      : in    std_logic_vector(0 to 0);
        E      : in    std_logic_vector(0 to 0);
        -- Outputs
        Y      : out   std_logic_vector(0 to 0);
        -- Inouts
        PAD_BI : inout std_logic_vector(0 to 0)
        );
end component;
-- m2s010_som_sb_GPIO_6_IO   -   Actel:SgCore:IO:1.0.101
component m2s010_som_sb_GPIO_6_IO
    -- Port list
    port(
        -- Inputs
        D      : in    std_logic_vector(0 to 0);
        E      : in    std_logic_vector(0 to 0);
        -- Outputs
        Y      : out   std_logic_vector(0 to 0);
        -- Inouts
        PAD_BI : inout std_logic_vector(0 to 0)
        );
end component;
-- m2s010_som_sb_GPIO_7_IO   -   Actel:SgCore:IO:1.0.101
component m2s010_som_sb_GPIO_7_IO
    -- Port list
    port(
        -- Inputs
        D      : in    std_logic_vector(0 to 0);
        E      : in    std_logic_vector(0 to 0);
        -- Outputs
        Y      : out   std_logic_vector(0 to 0);
        -- Inouts
        PAD_BI : inout std_logic_vector(0 to 0)
        );
end component;
-- m2s010_som_sb_MSS
component m2s010_som_sb_MSS
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
end component;
-- m2s010_som_sb_OTH_SPI_1_SS0_IO   -   Actel:SgCore:IO:1.0.101
component m2s010_som_sb_OTH_SPI_1_SS0_IO
    -- Port list
    port(
        -- Inputs
        D      : in    std_logic_vector(0 to 0);
        E      : in    std_logic_vector(0 to 0);
        -- Outputs
        Y      : out   std_logic_vector(0 to 0);
        -- Inouts
        PAD_BI : inout std_logic_vector(0 to 0)
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
-- MX2
component MX2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        S : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- SYSRESET
component SYSRESET
    -- Port list
    port(
        -- Inputs
        DEVRST_N         : in  std_logic;
        -- Outputs
        POWER_ON_RESET_N : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal BIBUF_0_Y                                        : std_logic;
signal CAM_SPI_1_CLK_Y                                  : std_logic_vector(0 to 0);
signal CAM_SPI_1_SS0_Y                                  : std_logic_vector(0 to 0);
signal CCC_71MHz_net_0                                  : std_logic;
signal CORECONFIGP_0_APB_S_PCLK                         : std_logic;
signal CORECONFIGP_0_APB_S_PRESET_N                     : std_logic;
signal CORECONFIGP_0_CONFIG1_DONE                       : std_logic;
signal CORECONFIGP_0_CONFIG2_DONE                       : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PENABLE             : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PREADY              : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PSELx               : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PSLVERR             : std_logic;
signal CORECONFIGP_0_MDDR_APBmslave_PWRITE              : std_logic;
signal CORERESETP_0_M3_RESET_N                          : std_logic;
signal CORERESETP_0_RESET_N_F2M                         : std_logic;
signal FAB_CCC_LOCK                                     : std_logic;
signal FABOSC_0_RCOSC_25_50MHZ_O2F                      : std_logic;
signal FIC_0_APB_MASTER_PADDR                           : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PENABLE                         : std_logic;
signal FIC_0_APB_MASTER_PSELx                           : std_logic;
signal FIC_0_APB_MASTER_PWDATA                          : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PWRITE                          : std_logic;
signal GPIO_1_in                                        : std_logic_vector(0 to 0);
signal GPIO_1_M2F                                       : std_logic;
signal GPIO_5_M2F_net_0                                 : std_logic;
signal GPIO_6_Y                                         : std_logic_vector(0 to 0);
signal GPIO_7_Y                                         : std_logic_vector(0 to 0);
signal GPIO_8_M2F_net_0                                 : std_logic;
signal GPIO_11_M2F_net_0                                : std_logic;
signal GPIO_20_OUT_net_0                                : std_logic;
signal GPIO_21_M2F_net_0                                : std_logic;
signal GPIO_22_M2F_net_0                                : std_logic;
signal GPIO_24_M2F_net_0                                : std_logic;
signal GPIO_28_SW_RESET_net_0                           : std_logic;
signal INIT_DONE                                        : std_logic;
signal m2s010_som_sb_MSS_0_GPIO_1_M2F_OE                : std_logic;
signal m2s010_som_sb_MSS_0_GPIO_6_M2F                   : std_logic;
signal m2s010_som_sb_MSS_0_GPIO_6_M2F_OE                : std_logic;
signal m2s010_som_sb_MSS_0_GPIO_7_M2F                   : std_logic;
signal m2s010_som_sb_MSS_0_GPIO_7_M2F_OE                : std_logic;
signal m2s010_som_sb_MSS_0_MAC_MII_MDO                  : std_logic;
signal m2s010_som_sb_MSS_0_MAC_MII_MDO_EN               : std_logic;
signal m2s010_som_sb_MSS_0_SPI_1_CLK_M2F                : std_logic;
signal m2s010_som_sb_MSS_0_SPI_1_SS0_M2F                : std_logic;
signal m2s010_som_sb_MSS_0_SPI_1_SS0_M2F_OE             : std_logic;
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_M_PCLK         : std_logic;
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N     : std_logic;
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PENABLE : std_logic;
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PRDATA  : std_logic_vector(31 downto 0);
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PREADY  : std_logic;
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSELx   : std_logic;
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSLVERR : std_logic;
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWDATA  : std_logic_vector(31 downto 0);
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWRITE  : std_logic;
signal m2s010_som_sb_MSS_TMP_0_MSS_RESET_N_M2F          : std_logic;
signal MAC_MII_MDC_net_0                                : std_logic;
signal MAC_MII_TX_EN_net_0                              : std_logic;
signal MAC_MII_TXD_net_0                                : std_logic_vector(3 downto 0);
signal MDDR_ADDR_net_0                                  : std_logic_vector(15 downto 0);
signal MDDR_BA_net_0                                    : std_logic_vector(2 downto 0);
signal MDDR_CAS_N_net_0                                 : std_logic;
signal MDDR_CKE_net_0                                   : std_logic;
signal MDDR_CLK_net_0                                   : std_logic;
signal MDDR_CLK_N_net_0                                 : std_logic;
signal MDDR_CS_N_net_0                                  : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_0                      : std_logic;
signal MDDR_ODT_net_0                                   : std_logic;
signal MDDR_RAS_N_net_0                                 : std_logic;
signal MDDR_RESET_N_net_0                               : std_logic;
signal MDDR_WE_N_net_0                                  : std_logic;
signal MMUART_0_TXD_M2F_net_0                           : std_logic;
signal MMUART_1_TXD_net_0                               : std_logic;
signal OTH_SPI_1_SS0_Y                                  : std_logic_vector(0 to 0);
signal POWER_ON_RESET_N_net_0                           : std_logic;
signal SPI_0_DO_net_0                                   : std_logic;
signal SPI_0_SS1_net_0                                  : std_logic;
signal SPI_1_DI                                         : std_logic;
signal SPI_1_DO_CAM_net_0                               : std_logic;
signal SPI_1_DO_OTH_net_0                               : std_logic;
signal SPI_1_SS0_MX_Y                                   : std_logic;
signal XTLOSC_CCC_OUT_2_XTLOSC_CCC                      : std_logic;
signal SPI_0_DO_net_1                                   : std_logic;
signal MMUART_1_TXD_net_1                               : std_logic;
signal MDDR_DQS_TMATCH_0_OUT_net_1                      : std_logic;
signal MDDR_CAS_N_net_1                                 : std_logic;
signal MDDR_CLK_net_1                                   : std_logic;
signal MDDR_CLK_N_net_1                                 : std_logic;
signal MDDR_CKE_net_1                                   : std_logic;
signal MDDR_CS_N_net_1                                  : std_logic;
signal MDDR_ODT_net_1                                   : std_logic;
signal MDDR_RAS_N_net_1                                 : std_logic;
signal MDDR_RESET_N_net_1                               : std_logic;
signal MDDR_WE_N_net_1                                  : std_logic;
signal MAC_MII_TX_EN_net_1                              : std_logic;
signal MAC_MII_MDC_net_1                                : std_logic;
signal POWER_ON_RESET_N_net_1                           : std_logic;
signal FIC_0_APB_MASTER_PSELx_net_0                     : std_logic;
signal FIC_0_APB_MASTER_PENABLE_net_0                   : std_logic;
signal FIC_0_APB_MASTER_PWRITE_net_0                    : std_logic;
signal CCC_71MHz_net_1                                  : std_logic;
signal MMUART_0_TXD_M2F_net_1                           : std_logic;
signal GPIO_20_OUT_net_1                                : std_logic;
signal GPIO_5_M2F_net_1                                 : std_logic;
signal GPIO_8_M2F_net_1                                 : std_logic;
signal GPIO_11_M2F_net_1                                : std_logic;
signal GPIO_21_M2F_net_1                                : std_logic;
signal GPIO_22_M2F_net_1                                : std_logic;
signal GPIO_24_M2F_net_1                                : std_logic;
signal GPIO_28_SW_RESET_net_1                           : std_logic;
signal SPI_0_SS1_net_1                                  : std_logic;
signal SPI_1_DO_CAM_net_1                               : std_logic;
signal SPI_1_DO_OTH_net_1                               : std_logic;
signal MDDR_ADDR_net_1                                  : std_logic_vector(15 downto 0);
signal MDDR_BA_net_1                                    : std_logic_vector(2 downto 0);
signal MAC_MII_TXD_net_1                                : std_logic_vector(3 downto 0);
signal FIC_0_APB_MASTER_PADDR_net_0                     : std_logic_vector(31 downto 0);
signal FIC_0_APB_MASTER_PWDATA_net_0                    : std_logic_vector(31 downto 0);
signal XTLOSC_CCC_OUT_2_XTLOSC_CCC_net_0                : std_logic;
signal MSS_INT_F2M_net_0                                : std_logic_vector(15 downto 0);
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal VCC_net                                          : std_logic;
signal GND_net                                          : std_logic;
signal PADDR_const_net_0                                : std_logic_vector(7 downto 2);
signal PWDATA_const_net_0                               : std_logic_vector(7 downto 0);
signal FDDR_PRDATA_const_net_0                          : std_logic_vector(31 downto 0);
signal SDIF0_PRDATA_const_net_0                         : std_logic_vector(31 downto 0);
signal SDIF1_PRDATA_const_net_0                         : std_logic_vector(31 downto 0);
signal SDIF2_PRDATA_const_net_0                         : std_logic_vector(31 downto 0);
signal SDIF3_PRDATA_const_net_0                         : std_logic_vector(31 downto 0);
signal SDIF0_PRDATA_const_net_1                         : std_logic_vector(31 downto 0);
signal SDIF1_PRDATA_const_net_1                         : std_logic_vector(31 downto 0);
signal SDIF2_PRDATA_const_net_1                         : std_logic_vector(31 downto 0);
signal SDIF3_PRDATA_const_net_1                         : std_logic_vector(31 downto 0);
----------------------------------------------------------------------
-- Bus Interface Nets Declarations - Unequal Pin Widths
----------------------------------------------------------------------
signal CORECONFIGP_0_MDDR_APBmslave_PADDR               : std_logic_vector(15 downto 2);
signal CORECONFIGP_0_MDDR_APBmslave_PADDR_0_10to2       : std_logic_vector(10 downto 2);
signal CORECONFIGP_0_MDDR_APBmslave_PADDR_0             : std_logic_vector(10 downto 2);

signal CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_31to16     : std_logic_vector(31 downto 16);
signal CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_15to0      : std_logic_vector(15 downto 0);
signal CORECONFIGP_0_MDDR_APBmslave_PRDATA_0            : std_logic_vector(31 downto 0);
signal CORECONFIGP_0_MDDR_APBmslave_PRDATA              : std_logic_vector(15 downto 0);

signal CORECONFIGP_0_MDDR_APBmslave_PWDATA              : std_logic_vector(31 downto 0);
signal CORECONFIGP_0_MDDR_APBmslave_PWDATA_0_15to0      : std_logic_vector(15 downto 0);
signal CORECONFIGP_0_MDDR_APBmslave_PWDATA_0            : std_logic_vector(15 downto 0);

signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_16to16: std_logic_vector(16 to 16);
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_15to2: std_logic_vector(15 downto 2);
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0 : std_logic_vector(16 downto 2);
signal m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR   : std_logic_vector(15 downto 2);


begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 VCC_net                  <= '1';
 GND_net                  <= '0';
 PADDR_const_net_0        <= B"000000";
 PWDATA_const_net_0       <= B"00000000";
 FDDR_PRDATA_const_net_0  <= B"00000000000000000000000000000000";
 SDIF0_PRDATA_const_net_0 <= B"00000000000000000000000000000000";
 SDIF1_PRDATA_const_net_0 <= B"00000000000000000000000000000000";
 SDIF2_PRDATA_const_net_0 <= B"00000000000000000000000000000000";
 SDIF3_PRDATA_const_net_0 <= B"00000000000000000000000000000000";
 SDIF0_PRDATA_const_net_1 <= B"00000000000000000000000000000000";
 SDIF1_PRDATA_const_net_1 <= B"00000000000000000000000000000000";
 SDIF2_PRDATA_const_net_1 <= B"00000000000000000000000000000000";
 SDIF3_PRDATA_const_net_1 <= B"00000000000000000000000000000000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 SPI_0_DO_net_1                    <= SPI_0_DO_net_0;
 SPI_0_DO                          <= SPI_0_DO_net_1;
 MMUART_1_TXD_net_1                <= MMUART_1_TXD_net_0;
 MMUART_1_TXD                      <= MMUART_1_TXD_net_1;
 MDDR_DQS_TMATCH_0_OUT_net_1       <= MDDR_DQS_TMATCH_0_OUT_net_0;
 MDDR_DQS_TMATCH_0_OUT             <= MDDR_DQS_TMATCH_0_OUT_net_1;
 MDDR_CAS_N_net_1                  <= MDDR_CAS_N_net_0;
 MDDR_CAS_N                        <= MDDR_CAS_N_net_1;
 MDDR_CLK_net_1                    <= MDDR_CLK_net_0;
 MDDR_CLK                          <= MDDR_CLK_net_1;
 MDDR_CLK_N_net_1                  <= MDDR_CLK_N_net_0;
 MDDR_CLK_N                        <= MDDR_CLK_N_net_1;
 MDDR_CKE_net_1                    <= MDDR_CKE_net_0;
 MDDR_CKE                          <= MDDR_CKE_net_1;
 MDDR_CS_N_net_1                   <= MDDR_CS_N_net_0;
 MDDR_CS_N                         <= MDDR_CS_N_net_1;
 MDDR_ODT_net_1                    <= MDDR_ODT_net_0;
 MDDR_ODT                          <= MDDR_ODT_net_1;
 MDDR_RAS_N_net_1                  <= MDDR_RAS_N_net_0;
 MDDR_RAS_N                        <= MDDR_RAS_N_net_1;
 MDDR_RESET_N_net_1                <= MDDR_RESET_N_net_0;
 MDDR_RESET_N                      <= MDDR_RESET_N_net_1;
 MDDR_WE_N_net_1                   <= MDDR_WE_N_net_0;
 MDDR_WE_N                         <= MDDR_WE_N_net_1;
 MAC_MII_TX_EN_net_1               <= MAC_MII_TX_EN_net_0;
 MAC_MII_TX_EN                     <= MAC_MII_TX_EN_net_1;
 MAC_MII_MDC_net_1                 <= MAC_MII_MDC_net_0;
 MAC_MII_MDC                       <= MAC_MII_MDC_net_1;
 POWER_ON_RESET_N_net_1            <= POWER_ON_RESET_N_net_0;
 POWER_ON_RESET_N                  <= POWER_ON_RESET_N_net_1;
 FIC_0_APB_MASTER_PSELx_net_0      <= FIC_0_APB_MASTER_PSELx;
 FIC_0_APB_M_PSEL                  <= FIC_0_APB_MASTER_PSELx_net_0;
 FIC_0_APB_MASTER_PENABLE_net_0    <= FIC_0_APB_MASTER_PENABLE;
 FIC_0_APB_M_PENABLE               <= FIC_0_APB_MASTER_PENABLE_net_0;
 FIC_0_APB_MASTER_PWRITE_net_0     <= FIC_0_APB_MASTER_PWRITE;
 FIC_0_APB_M_PWRITE                <= FIC_0_APB_MASTER_PWRITE_net_0;
 CCC_71MHz_net_1                   <= CCC_71MHz_net_0;
 CCC_71MHz                         <= CCC_71MHz_net_1;
 MMUART_0_TXD_M2F_net_1            <= MMUART_0_TXD_M2F_net_0;
 MMUART_0_TXD_M2F                  <= MMUART_0_TXD_M2F_net_1;
 GPIO_20_OUT_net_1                 <= GPIO_20_OUT_net_0;
 GPIO_20_OUT                       <= GPIO_20_OUT_net_1;
 GPIO_5_M2F_net_1                  <= GPIO_5_M2F_net_0;
 GPIO_5_M2F                        <= GPIO_5_M2F_net_1;
 GPIO_8_M2F_net_1                  <= GPIO_8_M2F_net_0;
 GPIO_8_M2F                        <= GPIO_8_M2F_net_1;
 GPIO_11_M2F_net_1                 <= GPIO_11_M2F_net_0;
 GPIO_11_M2F                       <= GPIO_11_M2F_net_1;
 GPIO_21_M2F_net_1                 <= GPIO_21_M2F_net_0;
 GPIO_21_M2F                       <= GPIO_21_M2F_net_1;
 GPIO_22_M2F_net_1                 <= GPIO_22_M2F_net_0;
 GPIO_22_M2F                       <= GPIO_22_M2F_net_1;
 GPIO_24_M2F_net_1                 <= GPIO_24_M2F_net_0;
 GPIO_24_M2F                       <= GPIO_24_M2F_net_1;
 GPIO_28_SW_RESET_net_1            <= GPIO_28_SW_RESET_net_0;
 GPIO_28_SW_RESET                  <= GPIO_28_SW_RESET_net_1;
 SPI_0_SS1_net_1                   <= SPI_0_SS1_net_0;
 SPI_0_SS1                         <= SPI_0_SS1_net_1;
 SPI_1_DO_CAM_net_1                <= SPI_1_DO_CAM_net_0;
 SPI_1_DO_CAM                      <= SPI_1_DO_CAM_net_1;
 SPI_1_DO_OTH_net_1                <= SPI_1_DO_OTH_net_0;
 SPI_1_DO_OTH                      <= SPI_1_DO_OTH_net_1;
 MDDR_ADDR_net_1                   <= MDDR_ADDR_net_0;
 MDDR_ADDR(15 downto 0)            <= MDDR_ADDR_net_1;
 MDDR_BA_net_1                     <= MDDR_BA_net_0;
 MDDR_BA(2 downto 0)               <= MDDR_BA_net_1;
 MAC_MII_TXD_net_1                 <= MAC_MII_TXD_net_0;
 MAC_MII_TXD(3 downto 0)           <= MAC_MII_TXD_net_1;
 FIC_0_APB_MASTER_PADDR_net_0      <= FIC_0_APB_MASTER_PADDR;
 FIC_0_APB_M_PADDR(31 downto 0)    <= FIC_0_APB_MASTER_PADDR_net_0;
 FIC_0_APB_MASTER_PWDATA_net_0     <= FIC_0_APB_MASTER_PWDATA;
 FIC_0_APB_M_PWDATA(31 downto 0)   <= FIC_0_APB_MASTER_PWDATA_net_0;
 XTLOSC_CCC_OUT_2_XTLOSC_CCC_net_0 <= XTLOSC_CCC_OUT_2_XTLOSC_CCC;
 XTLOSC_CCC                        <= XTLOSC_CCC_OUT_2_XTLOSC_CCC_net_0;
----------------------------------------------------------------------
-- Concatenation assignments
----------------------------------------------------------------------
 MSS_INT_F2M_net_0 <= ( '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & '0' & MSS_INT_F2M );
----------------------------------------------------------------------
-- Bus Interface Nets Assignments - Unequal Pin Widths
----------------------------------------------------------------------
 CORECONFIGP_0_MDDR_APBmslave_PADDR_0_10to2(10 downto 2) <= CORECONFIGP_0_MDDR_APBmslave_PADDR(10 downto 2);
 CORECONFIGP_0_MDDR_APBmslave_PADDR_0 <= ( CORECONFIGP_0_MDDR_APBmslave_PADDR_0_10to2(10 downto 2) );

 CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_31to16(31 downto 16) <= B"0000000000000000";
 CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_15to0(15 downto 0) <= CORECONFIGP_0_MDDR_APBmslave_PRDATA(15 downto 0);
 CORECONFIGP_0_MDDR_APBmslave_PRDATA_0 <= ( CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_31to16(31 downto 16) & CORECONFIGP_0_MDDR_APBmslave_PRDATA_0_15to0(15 downto 0) );

 CORECONFIGP_0_MDDR_APBmslave_PWDATA_0_15to0(15 downto 0) <= CORECONFIGP_0_MDDR_APBmslave_PWDATA(15 downto 0);
 CORECONFIGP_0_MDDR_APBmslave_PWDATA_0 <= ( CORECONFIGP_0_MDDR_APBmslave_PWDATA_0_15to0(15 downto 0) );

 m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_16to16(16) <= '0';
 m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_15to2(15 downto 2) <= m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR(15 downto 2);
 m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0 <= ( m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_16to16(16) & m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0_15to2(15 downto 2) );

----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- BIBUF_0
BIBUF_0 : BIBUF
    port map( 
        -- Inputs
        D   => m2s010_som_sb_MSS_0_MAC_MII_MDO,
        E   => m2s010_som_sb_MSS_0_MAC_MII_MDO_EN,
        -- Outputs
        Y   => BIBUF_0_Y,
        -- Inouts
        PAD => MAC_MII_MDIO 
        );
-- CAM_SPI_1_CLK   -   Actel:SgCore:IO:1.0.101
CAM_SPI_1_CLK : m2s010_som_sb_CAM_SPI_1_CLK_IO
    port map( 
        -- Inputs
        D(0)   => m2s010_som_sb_MSS_0_SPI_1_CLK_M2F,
        E(0)   => m2s010_som_sb_MSS_0_SPI_1_SS0_M2F_OE,
        -- Outputs
        Y      => CAM_SPI_1_CLK_Y,
        -- Inouts
        PAD_BI => SPI_1_CLK 
        );
-- CAM_SPI_1_SS0   -   Actel:SgCore:IO:1.0.101
CAM_SPI_1_SS0 : m2s010_som_sb_CAM_SPI_1_SS0_IO
    port map( 
        -- Inputs
        D(0)   => m2s010_som_sb_MSS_0_SPI_1_SS0_M2F,
        E(0)   => m2s010_som_sb_MSS_0_SPI_1_SS0_M2F_OE,
        -- Outputs
        Y      => CAM_SPI_1_SS0_Y,
        -- Inouts
        PAD_BI => SPI_1_SS0_CAM 
        );
-- CCC_0   -   Actel:SgCore:FCCC:2.0.200
CCC_0 : m2s010_som_sb_CCC_0_FCCC
    port map( 
        -- Inputs
        XTLOSC => XTLOSC_CCC_OUT_2_XTLOSC_CCC,
        -- Outputs
        GL0    => CCC_71MHz_net_0,
        LOCK   => FAB_CCC_LOCK 
        );
-- CORECONFIGP_0   -   Actel:DirectCore:CoreConfigP:7.0.105
CORECONFIGP_0 : CoreConfigP
    generic map( 
        DEVICE_090         => ( 0 ),
        ENABLE_SOFT_RESETS => ( 0 ),
        FDDR_IN_USE        => ( 0 ),
        MDDR_IN_USE        => ( 1 ),
        SDIF0_IN_USE       => ( 0 ),
        SDIF0_PCIE         => ( 0 ),
        SDIF1_IN_USE       => ( 0 ),
        SDIF1_PCIE         => ( 0 ),
        SDIF2_IN_USE       => ( 0 ),
        SDIF2_PCIE         => ( 0 ),
        SDIF3_IN_USE       => ( 0 ),
        SDIF3_PCIE         => ( 0 )
        )
    port map( 
        -- Inputs
        FIC_2_APB_M_PRESET_N           => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N,
        FIC_2_APB_M_PCLK               => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_M_PCLK,
        SDIF_RELEASED                  => GND_net, -- tied to '0' from definition
        INIT_DONE                      => INIT_DONE,
        FIC_2_APB_M_PSEL               => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSELx,
        FIC_2_APB_M_PENABLE            => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PENABLE,
        FIC_2_APB_M_PWRITE             => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWRITE,
        MDDR_PREADY                    => CORECONFIGP_0_MDDR_APBmslave_PREADY,
        MDDR_PSLVERR                   => CORECONFIGP_0_MDDR_APBmslave_PSLVERR,
        FDDR_PREADY                    => VCC_net, -- tied to '1' from definition
        FDDR_PSLVERR                   => GND_net, -- tied to '0' from definition
        SDIF0_PREADY                   => VCC_net, -- tied to '1' from definition
        SDIF0_PSLVERR                  => GND_net, -- tied to '0' from definition
        SDIF1_PREADY                   => VCC_net, -- tied to '1' from definition
        SDIF1_PSLVERR                  => GND_net, -- tied to '0' from definition
        SDIF2_PREADY                   => VCC_net, -- tied to '1' from definition
        SDIF2_PSLVERR                  => GND_net, -- tied to '0' from definition
        SDIF3_PREADY                   => VCC_net, -- tied to '1' from definition
        SDIF3_PSLVERR                  => GND_net, -- tied to '0' from definition
        FIC_2_APB_M_PADDR              => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR_0,
        FIC_2_APB_M_PWDATA             => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWDATA,
        MDDR_PRDATA                    => CORECONFIGP_0_MDDR_APBmslave_PRDATA_0,
        FDDR_PRDATA                    => FDDR_PRDATA_const_net_0, -- tied to X"0" from definition
        SDIF0_PRDATA                   => SDIF0_PRDATA_const_net_0, -- tied to X"0" from definition
        SDIF1_PRDATA                   => SDIF1_PRDATA_const_net_0, -- tied to X"0" from definition
        SDIF2_PRDATA                   => SDIF2_PRDATA_const_net_0, -- tied to X"0" from definition
        SDIF3_PRDATA                   => SDIF3_PRDATA_const_net_0, -- tied to X"0" from definition
        -- Outputs
        APB_S_PCLK                     => CORECONFIGP_0_APB_S_PCLK,
        APB_S_PRESET_N                 => CORECONFIGP_0_APB_S_PRESET_N,
        CONFIG1_DONE                   => CORECONFIGP_0_CONFIG1_DONE,
        CONFIG2_DONE                   => CORECONFIGP_0_CONFIG2_DONE,
        FIC_2_APB_M_PREADY             => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PREADY,
        FIC_2_APB_M_PSLVERR            => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSLVERR,
        MDDR_PSEL                      => CORECONFIGP_0_MDDR_APBmslave_PSELx,
        MDDR_PENABLE                   => CORECONFIGP_0_MDDR_APBmslave_PENABLE,
        MDDR_PWRITE                    => CORECONFIGP_0_MDDR_APBmslave_PWRITE,
        FDDR_PSEL                      => OPEN,
        FDDR_PENABLE                   => OPEN,
        FDDR_PWRITE                    => OPEN,
        SDIF0_PSEL                     => OPEN,
        SDIF0_PENABLE                  => OPEN,
        SDIF0_PWRITE                   => OPEN,
        SDIF1_PSEL                     => OPEN,
        SDIF1_PENABLE                  => OPEN,
        SDIF1_PWRITE                   => OPEN,
        SDIF2_PSEL                     => OPEN,
        SDIF2_PENABLE                  => OPEN,
        SDIF2_PWRITE                   => OPEN,
        SDIF3_PSEL                     => OPEN,
        SDIF3_PENABLE                  => OPEN,
        SDIF3_PWRITE                   => OPEN,
        SOFT_EXT_RESET_OUT             => OPEN,
        SOFT_RESET_F2M                 => OPEN,
        SOFT_M3_RESET                  => OPEN,
        SOFT_MDDR_DDR_AXI_S_CORE_RESET => OPEN,
        SOFT_FDDR_CORE_RESET           => OPEN,
        SOFT_SDIF0_PHY_RESET           => OPEN,
        SOFT_SDIF0_CORE_RESET          => OPEN,
        SOFT_SDIF0_0_CORE_RESET        => OPEN,
        SOFT_SDIF0_1_CORE_RESET        => OPEN,
        SOFT_SDIF1_PHY_RESET           => OPEN,
        SOFT_SDIF1_CORE_RESET          => OPEN,
        SOFT_SDIF2_PHY_RESET           => OPEN,
        SOFT_SDIF2_CORE_RESET          => OPEN,
        SOFT_SDIF3_PHY_RESET           => OPEN,
        SOFT_SDIF3_CORE_RESET          => OPEN,
        R_SDIF0_PSEL                   => OPEN,
        R_SDIF0_PWRITE                 => OPEN,
        R_SDIF1_PSEL                   => OPEN,
        R_SDIF1_PWRITE                 => OPEN,
        R_SDIF2_PSEL                   => OPEN,
        R_SDIF2_PWRITE                 => OPEN,
        R_SDIF3_PSEL                   => OPEN,
        R_SDIF3_PWRITE                 => OPEN,
        FIC_2_APB_M_PRDATA             => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PRDATA,
        MDDR_PADDR                     => CORECONFIGP_0_MDDR_APBmslave_PADDR,
        MDDR_PWDATA                    => CORECONFIGP_0_MDDR_APBmslave_PWDATA,
        FDDR_PADDR                     => OPEN,
        FDDR_PWDATA                    => OPEN,
        SDIF0_PADDR                    => OPEN,
        SDIF0_PWDATA                   => OPEN,
        SDIF1_PADDR                    => OPEN,
        SDIF1_PWDATA                   => OPEN,
        SDIF2_PADDR                    => OPEN,
        SDIF2_PWDATA                   => OPEN,
        SDIF3_PADDR                    => OPEN,
        SDIF3_PWDATA                   => OPEN,
        R_SDIF0_PRDATA                 => OPEN,
        R_SDIF1_PRDATA                 => OPEN,
        R_SDIF2_PRDATA                 => OPEN,
        R_SDIF3_PRDATA                 => OPEN 
        );
-- CORERESETP_0   -   Actel:DirectCore:CoreResetP:7.0.104
CORERESETP_0 : CoreResetP
    generic map( 
        DDR_WAIT            => ( 200 ),
        DEVICE_090          => ( 0 ),
        DEVICE_VOLTAGE      => ( 2 ),
        ENABLE_SOFT_RESETS  => ( 0 ),
        EXT_RESET_CFG       => ( 3 ),
        FDDR_IN_USE         => ( 0 ),
        MDDR_IN_USE         => ( 1 ),
        SDIF0_IN_USE        => ( 0 ),
        SDIF0_PCIE          => ( 0 ),
        SDIF0_PCIE_HOTRESET => ( 1 ),
        SDIF0_PCIE_L2P2     => ( 1 ),
        SDIF1_IN_USE        => ( 0 ),
        SDIF1_PCIE          => ( 0 ),
        SDIF1_PCIE_HOTRESET => ( 1 ),
        SDIF1_PCIE_L2P2     => ( 1 ),
        SDIF2_IN_USE        => ( 0 ),
        SDIF2_PCIE          => ( 0 ),
        SDIF2_PCIE_HOTRESET => ( 1 ),
        SDIF2_PCIE_L2P2     => ( 1 ),
        SDIF3_IN_USE        => ( 0 ),
        SDIF3_PCIE          => ( 0 ),
        SDIF3_PCIE_HOTRESET => ( 1 ),
        SDIF3_PCIE_L2P2     => ( 1 )
        )
    port map( 
        -- Inputs
        RESET_N_M2F                    => m2s010_som_sb_MSS_TMP_0_MSS_RESET_N_M2F,
        FIC_2_APB_M_PRESET_N           => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N,
        POWER_ON_RESET_N               => POWER_ON_RESET_N_net_0,
        FAB_RESET_N                    => VCC_net,
        RCOSC_25_50MHZ                 => FABOSC_0_RCOSC_25_50MHZ_O2F,
        CLK_BASE                       => CCC_71MHz_net_0,
        CLK_LTSSM                      => GND_net, -- tied to '0' from definition
        FPLL_LOCK                      => VCC_net, -- tied to '1' from definition
        SDIF0_SPLL_LOCK                => VCC_net, -- tied to '1' from definition
        SDIF1_SPLL_LOCK                => VCC_net, -- tied to '1' from definition
        SDIF2_SPLL_LOCK                => VCC_net, -- tied to '1' from definition
        SDIF3_SPLL_LOCK                => VCC_net, -- tied to '1' from definition
        CONFIG1_DONE                   => CORECONFIGP_0_CONFIG1_DONE,
        CONFIG2_DONE                   => CORECONFIGP_0_CONFIG2_DONE,
        SDIF0_PERST_N                  => VCC_net, -- tied to '1' from definition
        SDIF1_PERST_N                  => VCC_net, -- tied to '1' from definition
        SDIF2_PERST_N                  => VCC_net, -- tied to '1' from definition
        SDIF3_PERST_N                  => VCC_net, -- tied to '1' from definition
        SDIF0_PSEL                     => GND_net, -- tied to '0' from definition
        SDIF0_PWRITE                   => VCC_net, -- tied to '1' from definition
        SDIF1_PSEL                     => GND_net, -- tied to '0' from definition
        SDIF1_PWRITE                   => VCC_net, -- tied to '1' from definition
        SDIF2_PSEL                     => GND_net, -- tied to '0' from definition
        SDIF2_PWRITE                   => VCC_net, -- tied to '1' from definition
        SDIF3_PSEL                     => GND_net, -- tied to '0' from definition
        SDIF3_PWRITE                   => VCC_net, -- tied to '1' from definition
        SOFT_EXT_RESET_OUT             => GND_net, -- tied to '0' from definition
        SOFT_RESET_F2M                 => GND_net, -- tied to '0' from definition
        SOFT_M3_RESET                  => GND_net, -- tied to '0' from definition
        SOFT_MDDR_DDR_AXI_S_CORE_RESET => GND_net, -- tied to '0' from definition
        SOFT_FDDR_CORE_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF0_PHY_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF0_CORE_RESET          => GND_net, -- tied to '0' from definition
        SOFT_SDIF0_0_CORE_RESET        => GND_net, -- tied to '0' from definition
        SOFT_SDIF0_1_CORE_RESET        => GND_net, -- tied to '0' from definition
        SOFT_SDIF1_PHY_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF1_CORE_RESET          => GND_net, -- tied to '0' from definition
        SOFT_SDIF2_PHY_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF2_CORE_RESET          => GND_net, -- tied to '0' from definition
        SOFT_SDIF3_PHY_RESET           => GND_net, -- tied to '0' from definition
        SOFT_SDIF3_CORE_RESET          => GND_net, -- tied to '0' from definition
        SDIF0_PRDATA                   => SDIF0_PRDATA_const_net_1, -- tied to X"0" from definition
        SDIF1_PRDATA                   => SDIF1_PRDATA_const_net_1, -- tied to X"0" from definition
        SDIF2_PRDATA                   => SDIF2_PRDATA_const_net_1, -- tied to X"0" from definition
        SDIF3_PRDATA                   => SDIF3_PRDATA_const_net_1, -- tied to X"0" from definition
        -- Outputs
        MSS_HPMS_READY                 => OPEN,
        DDR_READY                      => OPEN,
        SDIF_READY                     => OPEN,
        RESET_N_F2M                    => CORERESETP_0_RESET_N_F2M,
        M3_RESET_N                     => CORERESETP_0_M3_RESET_N,
        EXT_RESET_OUT                  => OPEN,
        MDDR_DDR_AXI_S_CORE_RESET_N    => OPEN,
        FDDR_CORE_RESET_N              => OPEN,
        SDIF0_CORE_RESET_N             => OPEN,
        SDIF0_0_CORE_RESET_N           => OPEN,
        SDIF0_1_CORE_RESET_N           => OPEN,
        SDIF0_PHY_RESET_N              => OPEN,
        SDIF1_CORE_RESET_N             => OPEN,
        SDIF1_PHY_RESET_N              => OPEN,
        SDIF2_CORE_RESET_N             => OPEN,
        SDIF2_PHY_RESET_N              => OPEN,
        SDIF3_CORE_RESET_N             => OPEN,
        SDIF3_PHY_RESET_N              => OPEN,
        SDIF_RELEASED                  => OPEN,
        INIT_DONE                      => INIT_DONE 
        );
-- FABOSC_0   -   Actel:SgCore:OSC:2.0.101
FABOSC_0 : m2s010_som_sb_FABOSC_0_OSC
    port map( 
        -- Inputs
        XTL                => XTL,
        -- Outputs
        RCOSC_25_50MHZ_CCC => OPEN,
        RCOSC_25_50MHZ_O2F => FABOSC_0_RCOSC_25_50MHZ_O2F,
        RCOSC_1MHZ_CCC     => OPEN,
        RCOSC_1MHZ_O2F     => OPEN,
        XTLOSC_CCC         => XTLOSC_CCC_OUT_2_XTLOSC_CCC,
        XTLOSC_O2F         => OPEN 
        );
-- GPIO_1   -   Actel:SgCore:IO:1.0.101
GPIO_1 : m2s010_som_sb_GPIO_1_IO
    port map( 
        -- Inputs
        D(0)   => GPIO_1_M2F,
        E(0)   => m2s010_som_sb_MSS_0_GPIO_1_M2F_OE,
        -- Outputs
        Y      => GPIO_1_in,
        -- Inouts
        PAD_BI => GPIO_1_BI 
        );
-- GPIO_6   -   Actel:SgCore:IO:1.0.101
GPIO_6 : m2s010_som_sb_GPIO_6_IO
    port map( 
        -- Inputs
        D(0)   => m2s010_som_sb_MSS_0_GPIO_6_M2F,
        E(0)   => m2s010_som_sb_MSS_0_GPIO_6_M2F_OE,
        -- Outputs
        Y      => GPIO_6_Y,
        -- Inouts
        PAD_BI => GPIO_6_PAD 
        );
-- GPIO_7   -   Actel:SgCore:IO:1.0.101
GPIO_7 : m2s010_som_sb_GPIO_7_IO
    port map( 
        -- Inputs
        D(0)   => m2s010_som_sb_MSS_0_GPIO_7_M2F,
        E(0)   => m2s010_som_sb_MSS_0_GPIO_7_M2F_OE,
        -- Outputs
        Y      => GPIO_7_Y,
        -- Inouts
        PAD_BI => GPIO_7_PADI 
        );
-- m2s010_som_sb_MSS_0
m2s010_som_sb_MSS_0 : m2s010_som_sb_MSS
    port map( 
        -- Inputs
        SPI_0_DI               => SPI_0_DI,
        MCCC_CLK_BASE          => CCC_71MHz_net_0,
        MMUART_1_RXD           => MMUART_1_RXD,
        MAC_MII_RX_ER          => MAC_MII_RX_ER,
        MAC_MII_RX_DV          => MAC_MII_RX_DV,
        MAC_MII_CRS            => MAC_MII_CRS,
        MAC_MII_COL            => MAC_MII_COL,
        MAC_MII_RX_CLK         => MAC_MII_RX_CLK,
        MAC_MII_TX_CLK         => MAC_MII_TX_CLK,
        MDDR_DQS_TMATCH_0_IN   => MDDR_DQS_TMATCH_0_IN,
        MCCC_CLK_BASE_PLL_LOCK => FAB_CCC_LOCK,
        MAC_MII_MDI            => BIBUF_0_Y,
        MDDR_APB_S_PRESET_N    => CORECONFIGP_0_APB_S_PRESET_N,
        MDDR_APB_S_PCLK        => CORECONFIGP_0_APB_S_PCLK,
        FIC_2_APB_M_PREADY     => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PREADY,
        FIC_2_APB_M_PSLVERR    => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSLVERR,
        MDDR_APB_S_PWRITE      => CORECONFIGP_0_MDDR_APBmslave_PWRITE,
        MDDR_APB_S_PENABLE     => CORECONFIGP_0_MDDR_APBmslave_PENABLE,
        MDDR_APB_S_PSEL        => CORECONFIGP_0_MDDR_APBmslave_PSELx,
        MSS_RESET_N_F2M        => CORERESETP_0_RESET_N_F2M,
        M3_RESET_N             => CORERESETP_0_M3_RESET_N,
        FIC_0_APB_M_PREADY     => FIC_0_APB_M_PREADY,
        FIC_0_APB_M_PSLVERR    => FIC_0_APB_M_PSLVERR,
        MMUART_0_RXD_F2M       => MMUART_0_RXD_F2M,
        GPIO_27_F2M            => DEBOUNCE_OUT1,
        GPIO_29_F2M            => DEBOUNCE_OUT2,
        GPIO_30_F2M            => DEBOUNCE_OUT0,
        GPIO_1_F2M             => GPIO_1_in(0),
        SPI_1_DI_F2M           => SPI_1_DI,
        SPI_1_CLK_F2M          => CAM_SPI_1_CLK_Y(0),
        SPI_1_SS0_F2M          => SPI_1_SS0_MX_Y,
        GPIO_2_F2M             => ID_RES2,
        GPIO_9_F2M             => ID_RES0,
        GPIO_10_F2M            => ID_RES3,
        GPIO_19_F2M            => ID_RES1,
        GPIO_6_F2M             => GPIO_6_Y(0),
        GPIO_7_F2M             => GPIO_7_Y(0),
        MAC_MII_RXD            => MAC_MII_RXD,
        FIC_2_APB_M_PRDATA     => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PRDATA,
        MDDR_APB_S_PWDATA      => CORECONFIGP_0_MDDR_APBmslave_PWDATA_0,
        MDDR_APB_S_PADDR       => CORECONFIGP_0_MDDR_APBmslave_PADDR_0,
        FIC_0_APB_M_PRDATA     => FIC_0_APB_M_PRDATA,
        MSS_INT_F2M            => MSS_INT_F2M_net_0,
        -- Outputs
        SPI_0_DO               => SPI_0_DO_net_0,
        MMUART_1_TXD           => MMUART_1_TXD_net_0,
        MAC_MII_TX_EN          => MAC_MII_TX_EN_net_0,
        MAC_MII_TX_ER          => OPEN,
        MDDR_DQS_TMATCH_0_OUT  => MDDR_DQS_TMATCH_0_OUT_net_0,
        MDDR_CAS_N             => MDDR_CAS_N_net_0,
        MDDR_CLK               => MDDR_CLK_net_0,
        MDDR_CLK_N             => MDDR_CLK_N_net_0,
        MDDR_CKE               => MDDR_CKE_net_0,
        MDDR_CS_N              => MDDR_CS_N_net_0,
        MDDR_ODT               => MDDR_ODT_net_0,
        MDDR_RAS_N             => MDDR_RAS_N_net_0,
        MDDR_RESET_N           => MDDR_RESET_N_net_0,
        MDDR_WE_N              => MDDR_WE_N_net_0,
        MSS_RESET_N_M2F        => m2s010_som_sb_MSS_TMP_0_MSS_RESET_N_M2F,
        GPIO_1_M2F             => GPIO_1_M2F,
        MAC_MII_MDC            => MAC_MII_MDC_net_0,
        MAC_MII_MDO_EN         => m2s010_som_sb_MSS_0_MAC_MII_MDO_EN,
        MAC_MII_MDO            => m2s010_som_sb_MSS_0_MAC_MII_MDO,
        FIC_2_APB_M_PRESET_N   => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_M_PRESET_N,
        FIC_2_APB_M_PCLK       => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_M_PCLK,
        FIC_2_APB_M_PWRITE     => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWRITE,
        FIC_2_APB_M_PENABLE    => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PENABLE,
        FIC_2_APB_M_PSEL       => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PSELx,
        MDDR_APB_S_PREADY      => CORECONFIGP_0_MDDR_APBmslave_PREADY,
        MDDR_APB_S_PSLVERR     => CORECONFIGP_0_MDDR_APBmslave_PSLVERR,
        FIC_0_APB_M_PSEL       => FIC_0_APB_MASTER_PSELx,
        FIC_0_APB_M_PWRITE     => FIC_0_APB_MASTER_PWRITE,
        FIC_0_APB_M_PENABLE    => FIC_0_APB_MASTER_PENABLE,
        MMUART_0_TXD_M2F       => MMUART_0_TXD_M2F_net_0,
        GPIO_5_M2F             => GPIO_5_M2F_net_0,
        GPIO_6_M2F             => m2s010_som_sb_MSS_0_GPIO_6_M2F,
        GPIO_7_M2F             => m2s010_som_sb_MSS_0_GPIO_7_M2F,
        GPIO_8_M2F             => GPIO_8_M2F_net_0,
        GPIO_11_M2F            => GPIO_11_M2F_net_0,
        GPIO_20_OUT            => GPIO_20_OUT_net_0,
        GPIO_21_M2F            => GPIO_21_M2F_net_0,
        GPIO_22_M2F            => GPIO_22_M2F_net_0,
        GPIO_24_M2F            => GPIO_24_M2F_net_0,
        GPIO_28_M2F            => GPIO_28_SW_RESET_net_0,
        SPI_0_SS1              => SPI_0_SS1_net_0,
        GPIO_1_M2F_OE          => m2s010_som_sb_MSS_0_GPIO_1_M2F_OE,
        SPI_1_DO_M2F           => SPI_1_DO_CAM_net_0,
        SPI_1_CLK_M2F          => m2s010_som_sb_MSS_0_SPI_1_CLK_M2F,
        SPI_1_SS0_M2F          => m2s010_som_sb_MSS_0_SPI_1_SS0_M2F,
        SPI_1_SS0_M2F_OE       => m2s010_som_sb_MSS_0_SPI_1_SS0_M2F_OE,
        GPIO_6_M2F_OE          => m2s010_som_sb_MSS_0_GPIO_6_M2F_OE,
        GPIO_7_M2F_OE          => m2s010_som_sb_MSS_0_GPIO_7_M2F_OE,
        MAC_MII_TXD            => MAC_MII_TXD_net_0,
        MDDR_ADDR              => MDDR_ADDR_net_0,
        MDDR_BA                => MDDR_BA_net_0,
        FIC_2_APB_M_PADDR      => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PADDR,
        FIC_2_APB_M_PWDATA     => m2s010_som_sb_MSS_TMP_0_FIC_2_APB_MASTER_PWDATA,
        MDDR_APB_S_PRDATA      => CORECONFIGP_0_MDDR_APBmslave_PRDATA,
        FIC_0_APB_M_PADDR      => FIC_0_APB_MASTER_PADDR,
        FIC_0_APB_M_PWDATA     => FIC_0_APB_MASTER_PWDATA,
        -- Inouts
        I2C_1_SDA              => I2C_1_SDA,
        I2C_1_SCL              => I2C_1_SCL,
        SPI_0_CLK              => SPI_0_CLK,
        SPI_0_SS0              => SPI_0_SS0,
        GPIO_0_BI              => GPIO_0_BI,
        GPIO_3_BI              => GPIO_3_BI,
        GPIO_4_BI              => GPIO_4_BI,
        GPIO_12_BI             => GPIO_12_BI,
        GPIO_14_BI             => GPIO_14_BI,
        GPIO_15_BI             => GPIO_15_BI,
        GPIO_16_BI             => GPIO_16_BI,
        GPIO_17_BI             => GPIO_17_BI,
        GPIO_18_BI             => GPIO_18_BI,
        GPIO_25_BI             => GPIO_25_BI,
        GPIO_26_BI             => GPIO_26_BI,
        GPIO_31_BI             => GPIO_31_BI,
        MDDR_DM_RDQS           => MDDR_DM_RDQS,
        MDDR_DQ                => MDDR_DQ,
        MDDR_DQS               => MDDR_DQS 
        );
-- OTH_SPI_1_SS0   -   Actel:SgCore:IO:1.0.101
OTH_SPI_1_SS0 : m2s010_som_sb_OTH_SPI_1_SS0_IO
    port map( 
        -- Inputs
        D(0)   => m2s010_som_sb_MSS_0_SPI_1_SS0_M2F,
        E(0)   => m2s010_som_sb_MSS_0_SPI_1_SS0_M2F_OE,
        -- Outputs
        Y      => OTH_SPI_1_SS0_Y,
        -- Inouts
        PAD_BI => SPI_1_SS0_OTH 
        );
-- SPI_1_D0_OUT
SPI_1_D0_OUT : OUTBUF
    port map( 
        -- Inputs
        D   => SPI_1_DO_CAM_net_0,
        -- Outputs
        PAD => SPI_1_DO_OTH_net_0 
        );
-- SPI_1_DI_MX
SPI_1_DI_MX : MX2
    port map( 
        -- Inputs
        A => SPI_1_DI_OTH,
        B => SPI_1_DI_CAM,
        S => CAMERA_NODE,
        -- Outputs
        Y => SPI_1_DI 
        );
-- SPI_1_SS0_MX
SPI_1_SS0_MX : MX2
    port map( 
        -- Inputs
        A => OTH_SPI_1_SS0_Y(0),
        B => CAM_SPI_1_SS0_Y(0),
        S => CAMERA_NODE,
        -- Outputs
        Y => SPI_1_SS0_MX_Y 
        );
-- SYSRESET_POR
SYSRESET_POR : SYSRESET
    port map( 
        -- Inputs
        DEVRST_N         => DEVRST_N,
        -- Outputs
        POWER_ON_RESET_N => POWER_ON_RESET_N_net_0 
        );

end RTL;
