----------------------------------------------------------------------
-- Created by SmartDesign Wed Mar 07 16:06:28 2018
-- Version: v11.8 SP2 11.8.2.4
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
----------------------------------------------------------------------
-- TB_iRail entity declaration
----------------------------------------------------------------------
entity TB_iRail is
    -- Port list
    port(
        -- Inputs
        DEBOUNCE_IN : in  std_logic_vector(2 downto 0);
        DormantREQn : in  std_logic;
        EngageREQn  : in  std_logic;
        -- Outputs
        DRVR_EN     : out std_logic;
        RCVR_EN     : out std_logic
        );
end TB_iRail;
----------------------------------------------------------------------
-- TB_iRail architecture body
----------------------------------------------------------------------
architecture RTL of TB_iRail is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CLK_GEN   -   Actel:Simulation:CLK_GEN:1.0.1
component CLK_GEN
    generic( 
        CLK_PERIOD : integer := 50000 ;
        DUTY_CYCLE : integer := 50 
        );
    -- Port list
    port(
        -- Outputs
        CLK : out std_logic
        );
end component;
-- INV
component INV
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
-- m2s010_som
component m2s010_som
    -- Port list
    port(
        -- Inputs
        DEBOUNCE_IN                : in    std_logic_vector(2 downto 0);
        DEVRST_N                   : in    std_logic;
        D_COL                      : in    std_logic;
        D_CRS                      : in    std_logic;
        D_RXC                      : in    std_logic;
        D_RXD                      : in    std_logic_vector(3 downto 0);
        D_RXDV                     : in    std_logic;
        D_RXER                     : in    std_logic;
        D_TXC                      : in    std_logic;
        DormantREQn                : in    std_logic;
        EngageREQn                 : in    std_logic;
        GPIO_12_F2M_BUTn3          : in    std_logic;
        HOST_DETn                  : in    std_logic;
        H_MDC                      : in    std_logic;
        H_TXD                      : in    std_logic_vector(3 downto 0);
        I2C_0_SCL_F2M              : in    std_logic;
        I2C_0_SDA_F2M              : in    std_logic;
        MANCHESTER_IN              : in    std_logic;
        MDDR_DQS_TMATCH_0_IN       : in    std_logic;
        MII_DBG_PHYn               : in    std_logic;
        MMUART_0_RXD_F2M           : in    std_logic;
        MMUART_1_RXD               : in    std_logic;
        SPI_0_DI                   : in    std_logic;
        SPI_1_DI                   : in    std_logic;
        XTL                        : in    std_logic;
        -- Outputs
        DRVR_EN                    : out   std_logic;
        D_MDC                      : out   std_logic;
        D_TXD                      : out   std_logic_vector(3 downto 0);
        D_TXEN                     : out   std_logic;
        GPIO_10_M2F_GREEN          : out   std_logic;
        GPIO_11_M2F_SPI_FLASH_RSTn : out   std_logic;
        GPIO_88                    : out   std_logic;
        GPIO_8_M2F_BLUE            : out   std_logic;
        GPIO_9_M2F_RED             : out   std_logic;
        H_COL                      : out   std_logic;
        H_RXC                      : out   std_logic;
        H_RXER                     : out   std_logic;
        H_TXC                      : out   std_logic;
        I2C_0_SCL_M2F              : out   std_logic;
        I2C_0_SCL_M2F_OE           : out   std_logic;
        I2C_0_SDA_M2F              : out   std_logic;
        I2C_0_SDA_M2F_OE           : out   std_logic;
        MANCH_OUT_N                : out   std_logic;
        MANCH_OUT_P                : out   std_logic;
        MDDR_ADDR                  : out   std_logic_vector(15 downto 0);
        MDDR_BA                    : out   std_logic_vector(2 downto 0);
        MDDR_CAS_N                 : out   std_logic;
        MDDR_CKE                   : out   std_logic;
        MDDR_CLK                   : out   std_logic;
        MDDR_CLK_N                 : out   std_logic;
        MDDR_CS_N                  : out   std_logic;
        MDDR_DQS_TMATCH_0_OUT      : out   std_logic;
        MDDR_ODT                   : out   std_logic;
        MDDR_RAS_N                 : out   std_logic;
        MDDR_RESET_N               : out   std_logic;
        MDDR_WE_N                  : out   std_logic;
        MMUART_0_TXD_M2F           : out   std_logic;
        MMUART_1_TXD               : out   std_logic;
        RCVR_EN                    : out   std_logic;
        SPI_0_DO                   : out   std_logic;
        SPI_0_SS1                  : out   std_logic;
        SPI_1_DO                   : out   std_logic;
        SPI_FLASH_IO2              : out   std_logic;
        SPI_FLASH_IO3              : out   std_logic;
        nRESET_OUT                 : out   std_logic;
        -- Inouts
        D_MDIO                     : inout std_logic;
        GPIO_1_BIDI                : inout std_logic_vector(0 to 0);
        H_MDIO                     : inout std_logic;
        I2C_1_SCL                  : inout std_logic;
        I2C_1_SDA                  : inout std_logic;
        MDDR_DM_RDQS               : inout std_logic_vector(1 downto 0);
        MDDR_DQ                    : inout std_logic_vector(15 downto 0);
        MDDR_DQS                   : inout std_logic_vector(1 downto 0);
        SPI_0_CLK                  : inout std_logic;
        SPI_0_SS0                  : inout std_logic;
        SPI_1_CLK_0                : inout std_logic;
        SPI_1_SS0                  : inout std_logic
        );
end component;
-- MDIO_Master
component MDIO_Master
    -- Port list
    port(
        -- Outputs
        Add_Error    : out   std_logic;
        H_MDC        : out   std_logic;
        MII_DBG_PHYn : out   std_logic;
        -- Inouts
        H_MDIO       : inout std_logic
        );
end component;
-- RESET_GEN   -   Actel:Simulation:RESET_GEN:1.0.1
component RESET_GEN
    generic( 
        DELAY       : integer := 200 ;
        LOGIC_LEVEL : integer := 0 
        );
    -- Port list
    port(
        -- Outputs
        RESET : out std_logic
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
-- XOR2
component XOR2
    -- Port list
    port(
        -- Inputs
        A : in  std_logic;
        B : in  std_logic;
        -- Outputs
        Y : out std_logic
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal CLK_GEN_0_CLK                : std_logic;
signal DRVR_EN_net_0                : std_logic;
signal INV_0_Y                      : std_logic;
signal INV_1_Y                      : std_logic;
signal m2s010_som_0_H_COL           : std_logic;
signal m2s010_som_0_H_RXC           : std_logic;
signal m2s010_som_0_H_RXER          : std_logic;
signal m2s010_som_0_MANCH_OUT_P     : std_logic;
signal m2s010_som_0_MMUART_1_TXD    : std_logic;
signal MDIO_Master_0_Add_Error      : std_logic;
signal MDIO_Master_0_H_MDC          : std_logic;
signal MDIO_Master_0_MII_DBG_PHYn_0 : std_logic;
signal net_0                        : std_logic;
signal RCVR_EN_net_0                : std_logic;
signal RESET_GEN_0_RESET            : std_logic;
signal TRIBUFF_0_PAD                : std_logic;
signal XOR2_0_Y                     : std_logic;
signal RCVR_EN_net_1                : std_logic;
signal DRVR_EN_net_1                : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net                      : std_logic;
signal MDDR_DM_RDQS_const_net_0     : std_logic_vector(1 downto 0);
signal MDDR_DQ_const_net_0          : std_logic_vector(15 downto 0);
signal MDDR_DQS_const_net_0         : std_logic_vector(1 downto 0);
signal H_TXD_const_net_0            : std_logic_vector(3 downto 0);
signal D_RXD_const_net_0            : std_logic_vector(3 downto 0);
signal MDDR_DM_RDQS_const_net_1     : std_logic_vector(1 downto 0);
signal MDDR_DQ_const_net_1          : std_logic_vector(15 downto 0);
signal MDDR_DQS_const_net_1         : std_logic_vector(1 downto 0);
signal H_TXD_const_net_1            : std_logic_vector(3 downto 0);
signal D_RXD_const_net_1            : std_logic_vector(3 downto 0);
signal DEBOUNCE_IN_const_net_0      : std_logic_vector(2 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net                  <= '0';
 MDDR_DM_RDQS_const_net_0 <= B"00";
 MDDR_DQ_const_net_0      <= B"0000000000000000";
 MDDR_DQS_const_net_0     <= B"00";
 H_TXD_const_net_0        <= B"0000";
 D_RXD_const_net_0        <= B"0000";
 MDDR_DM_RDQS_const_net_1 <= B"00";
 MDDR_DQ_const_net_1      <= B"0000000000000000";
 MDDR_DQS_const_net_1     <= B"00";
 H_TXD_const_net_1        <= B"0000";
 D_RXD_const_net_1        <= B"0000";
 DEBOUNCE_IN_const_net_0  <= B"000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 RCVR_EN_net_1 <= RCVR_EN_net_0;
 RCVR_EN       <= RCVR_EN_net_1;
 DRVR_EN_net_1 <= DRVR_EN_net_0;
 DRVR_EN       <= DRVR_EN_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CLK_GEN_0   -   Actel:Simulation:CLK_GEN:1.0.1
CLK_GEN_0 : CLK_GEN
    generic map( 
        CLK_PERIOD => ( 50000 ),
        DUTY_CYCLE => ( 50 )
        )
    port map( 
        -- Outputs
        CLK => CLK_GEN_0_CLK 
        );
-- INV_0
INV_0 : INV
    port map( 
        -- Inputs
        A => MDIO_Master_0_MII_DBG_PHYn_0,
        -- Outputs
        Y => INV_0_Y 
        );
-- INV_1
INV_1 : INV
    port map( 
        -- Inputs
        A => TRIBUFF_0_PAD,
        -- Outputs
        Y => INV_1_Y 
        );
-- m2s010_som_0
m2s010_som_0 : m2s010_som
    port map( 
        -- Inputs
        SPI_0_DI                   => GND_net,
        MMUART_1_RXD               => m2s010_som_0_MMUART_1_TXD,
        MDDR_DQS_TMATCH_0_IN       => GND_net,
        XTL                        => CLK_GEN_0_CLK,
        DEVRST_N                   => RESET_GEN_0_RESET,
        SPI_1_DI                   => GND_net,
        H_MDC                      => MDIO_Master_0_H_MDC,
        DormantREQn                => DormantREQn,
        EngageREQn                 => EngageREQn,
        HOST_DETn                  => GND_net,
        D_TXC                      => m2s010_som_0_H_RXC,
        D_RXC                      => m2s010_som_0_H_RXC,
        D_RXDV                     => GND_net,
        D_RXER                     => m2s010_som_0_H_RXER,
        D_CRS                      => GND_net,
        D_COL                      => m2s010_som_0_H_COL,
        MANCHESTER_IN              => XOR2_0_Y,
        MII_DBG_PHYn               => MDIO_Master_0_MII_DBG_PHYn_0,
        GPIO_12_F2M_BUTn3          => GND_net,
        H_TXD                      => H_TXD_const_net_0,
        D_RXD                      => D_RXD_const_net_0,
        DEBOUNCE_IN                => DEBOUNCE_IN,
        MMUART_0_RXD_F2M           => GND_net,
        I2C_0_SDA_F2M              => GND_net,
        I2C_0_SCL_F2M              => GND_net,
        -- Outputs
        SPI_0_DO                   => OPEN,
        MMUART_1_TXD               => m2s010_som_0_MMUART_1_TXD,
        MDDR_DQS_TMATCH_0_OUT      => OPEN,
        MDDR_CAS_N                 => OPEN,
        MDDR_CLK                   => OPEN,
        MDDR_CLK_N                 => OPEN,
        MDDR_CKE                   => OPEN,
        MDDR_CS_N                  => OPEN,
        MDDR_ODT                   => OPEN,
        MDDR_RAS_N                 => OPEN,
        MDDR_RESET_N               => OPEN,
        MDDR_WE_N                  => OPEN,
        DRVR_EN                    => DRVR_EN_net_0,
        RCVR_EN                    => RCVR_EN_net_0,
        MANCH_OUT_P                => m2s010_som_0_MANCH_OUT_P,
        MANCH_OUT_N                => OPEN,
        SPI_1_DO                   => OPEN,
        H_TXC                      => OPEN,
        H_RXC                      => m2s010_som_0_H_RXC,
        H_RXER                     => m2s010_som_0_H_RXER,
        H_COL                      => m2s010_som_0_H_COL,
        SPI_FLASH_IO2              => OPEN,
        SPI_FLASH_IO3              => OPEN,
        D_MDC                      => OPEN,
        D_TXEN                     => OPEN,
        nRESET_OUT                 => OPEN,
        GPIO_88                    => OPEN,
        GPIO_8_M2F_BLUE            => OPEN,
        GPIO_9_M2F_RED             => OPEN,
        GPIO_10_M2F_GREEN          => OPEN,
        GPIO_11_M2F_SPI_FLASH_RSTn => OPEN,
        MDDR_ADDR                  => OPEN,
        MDDR_BA                    => OPEN,
        D_TXD                      => OPEN,
        MMUART_0_TXD_M2F           => OPEN,
        I2C_0_SDA_M2F              => OPEN,
        I2C_0_SDA_M2F_OE           => OPEN,
        I2C_0_SCL_M2F              => OPEN,
        I2C_0_SCL_M2F_OE           => OPEN,
        SPI_0_SS1                  => OPEN,
        -- Inouts
        I2C_1_SDA                  => OPEN,
        I2C_1_SCL                  => OPEN,
        SPI_0_CLK                  => GND_net,
        SPI_0_SS0                  => GND_net,
        SPI_1_CLK_0                => GND_net,
        SPI_1_SS0                  => GND_net,
        D_MDIO                     => GND_net,
        H_MDIO                     => net_0,
        MDDR_DM_RDQS               => MDDR_DM_RDQS_const_net_0,
        MDDR_DQ                    => MDDR_DQ_const_net_0,
        MDDR_DQS                   => MDDR_DQS_const_net_0,
        GPIO_1_BIDI(0)             => GND_net 
        );
-- m2s010_som_1
m2s010_som_1 : m2s010_som
    port map( 
        -- Inputs
        SPI_0_DI                   => GND_net,
        MMUART_1_RXD               => GND_net,
        MDDR_DQS_TMATCH_0_IN       => GND_net,
        XTL                        => CLK_GEN_0_CLK,
        DEVRST_N                   => RESET_GEN_0_RESET,
        SPI_1_DI                   => GND_net,
        H_MDC                      => GND_net,
        DormantREQn                => GND_net,
        EngageREQn                 => GND_net,
        HOST_DETn                  => GND_net,
        D_TXC                      => GND_net,
        D_RXC                      => GND_net,
        D_RXDV                     => GND_net,
        D_RXER                     => GND_net,
        D_CRS                      => GND_net,
        D_COL                      => GND_net,
        MANCHESTER_IN              => XOR2_0_Y,
        MII_DBG_PHYn               => INV_0_Y,
        GPIO_12_F2M_BUTn3          => GND_net,
        H_TXD                      => H_TXD_const_net_1,
        D_RXD                      => D_RXD_const_net_1,
        DEBOUNCE_IN                => DEBOUNCE_IN_const_net_0,
        MMUART_0_RXD_F2M           => GND_net,
        I2C_0_SDA_F2M              => GND_net,
        I2C_0_SCL_F2M              => GND_net,
        -- Outputs
        SPI_0_DO                   => OPEN,
        MMUART_1_TXD               => OPEN,
        MDDR_DQS_TMATCH_0_OUT      => OPEN,
        MDDR_CAS_N                 => OPEN,
        MDDR_CLK                   => OPEN,
        MDDR_CLK_N                 => OPEN,
        MDDR_CKE                   => OPEN,
        MDDR_CS_N                  => OPEN,
        MDDR_ODT                   => OPEN,
        MDDR_RAS_N                 => OPEN,
        MDDR_RESET_N               => OPEN,
        MDDR_WE_N                  => OPEN,
        DRVR_EN                    => OPEN,
        RCVR_EN                    => OPEN,
        MANCH_OUT_P                => OPEN,
        MANCH_OUT_N                => OPEN,
        SPI_1_DO                   => OPEN,
        H_TXC                      => OPEN,
        H_RXC                      => OPEN,
        H_RXER                     => OPEN,
        H_COL                      => OPEN,
        SPI_FLASH_IO2              => OPEN,
        SPI_FLASH_IO3              => OPEN,
        D_MDC                      => OPEN,
        D_TXEN                     => OPEN,
        nRESET_OUT                 => OPEN,
        GPIO_88                    => OPEN,
        GPIO_8_M2F_BLUE            => OPEN,
        GPIO_9_M2F_RED             => OPEN,
        GPIO_10_M2F_GREEN          => OPEN,
        GPIO_11_M2F_SPI_FLASH_RSTn => OPEN,
        MDDR_ADDR                  => OPEN,
        MDDR_BA                    => OPEN,
        D_TXD                      => OPEN,
        MMUART_0_TXD_M2F           => OPEN,
        I2C_0_SDA_M2F              => OPEN,
        I2C_0_SDA_M2F_OE           => OPEN,
        I2C_0_SCL_M2F              => OPEN,
        I2C_0_SCL_M2F_OE           => OPEN,
        SPI_0_SS1                  => OPEN,
        -- Inouts
        I2C_1_SDA                  => GND_net,
        I2C_1_SCL                  => OPEN,
        SPI_0_CLK                  => OPEN,
        SPI_0_SS0                  => OPEN,
        SPI_1_CLK_0                => GND_net,
        SPI_1_SS0                  => GND_net,
        D_MDIO                     => GND_net,
        H_MDIO                     => GND_net,
        MDDR_DM_RDQS               => MDDR_DM_RDQS_const_net_1,
        MDDR_DQ                    => MDDR_DQ_const_net_1,
        MDDR_DQS                   => MDDR_DQS_const_net_1,
        GPIO_1_BIDI(0)             => GND_net 
        );
-- MDIO_Master_0
MDIO_Master_0 : MDIO_Master
    port map( 
        -- Outputs
        H_MDC        => MDIO_Master_0_H_MDC,
        MII_DBG_PHYn => MDIO_Master_0_MII_DBG_PHYn_0,
        Add_Error    => MDIO_Master_0_Add_Error,
        -- Inouts
        H_MDIO       => net_0 
        );
-- RESET_GEN_0   -   Actel:Simulation:RESET_GEN:1.0.1
RESET_GEN_0 : RESET_GEN
    generic map( 
        DELAY       => ( 200 ),
        LOGIC_LEVEL => ( 0 )
        )
    port map( 
        -- Outputs
        RESET => RESET_GEN_0_RESET 
        );
-- TRIBUFF_0
TRIBUFF_0 : TRIBUFF
    port map( 
        -- Inputs
        D   => m2s010_som_0_MANCH_OUT_P,
        E   => DRVR_EN_net_0,
        -- Outputs
        PAD => TRIBUFF_0_PAD 
        );
-- XOR2_0
XOR2_0 : XOR2
    port map( 
        -- Inputs
        A => INV_1_Y,
        B => MDIO_Master_0_Add_Error,
        -- Outputs
        Y => XOR2_0_Y 
        );

end RTL;
