----------------------------------------------------------------------------------
-- Company:         Bluefin Innovations LLC
-- Create Date:     5 December 2-017
-- Module Name:     Phy_Mux.vhd 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     
--    The Bluefin Innovations FPGA Fabric supports both the transmission and 
--    reception of packets and resides between the AFE and processor MAC.
--
-- Structure:
--    CommsFPGA_top.vhd                 
--
-- Revision:  0.1
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--
entity Phy_Mux is
   port (
    Clk_25MHz          : in std_logic;
    -- Inputs from SoC MAC
    MII_MUX_control_reg: in std_logic_vector(7 downto 0);   
    MII_DBG_PHYn       : in std_logic;  -- 0=Sends SoC MAC signals to Debug Phy; 1=Sends SoC MAC signals to FPGA I-Rail PHY
    MAC_MII_MDC        : in std_logic;
    MAC_MII_MDO_EN     : in std_logic;
    MAC_MII_MDO        : in std_logic;
    --
    MAC_MII_TXD        : in std_logic_vector(3 downto 0);
    MAC_MII_TX_EN      : in std_logic;
    -- Outputs to SoC MAC
    MAC_MII_RXD        : out std_logic_vector(3 downto 0);
    MAC_MII_RX_ER      : out std_logic;
    MAC_MII_RX_DV      : out std_logic;
    MAC_MII_CRS        : out std_logic;
    MAC_MII_COL        : out std_logic;
    MAC_MII_RX_CLK     : out std_logic;
    MAC_MII_TX_CLK     : out std_logic;
    MAC_MII_MDI        : out std_logic;
    -- Inputs from FPGA I-Rail Phy
    F_MDO_EN           : in std_logic;
    F_MDO              : in std_logic;
    F_RXD              : in std_logic_vector(3 downto 0);
    F_RXER             : in std_logic;
    F_RXDV             : in std_logic;
    F_CRS              : in std_logic;
    F_COL              : in std_logic;
    F_RXC              : in std_logic;
    F_TXC              : in std_logic;
    -- Outputs to FPGA I-RAIL PHY
    F_TXD              : out std_logic_vector(3 downto 0);
    F_TXEN             : out std_logic;
    F_MDC              : out std_logic;
    F_MDI              : out std_logic;
    -- Inputs from Host MII
    H_TXD              : in std_logic_vector(3 downto 0);
    H_TXEN             : in std_logic;
    H_MDC              : in std_logic;
    H_MDI              : in std_logic;
	HOST_DETn          : in std_logic;
    -- Outputs to Host Phy
    H_RXD              : out std_logic_vector(3 downto 0);
    H_RXER             : out std_logic;
    H_RXDV             : out std_logic;
    H_CRS              : out std_logic;
    H_COL              : out std_logic;
    H_RXC              : out std_logic;
    H_TXC              : out std_logic;
    H_MDO_EN           : out std_logic;
    H_MDO              : out std_logic;
    -- Inputs from Debug PHY KSZ8081
    D_RXD              : in std_logic_vector(3 downto 0);
    D_RXER             : in std_logic;
    D_RXDV             : in std_logic;
    D_CRS              : in std_logic;
    D_COL              : in std_logic;
    D_RXC              : in std_logic;
    D_TXC              : in std_logic;
    D_MDI              : in std_logic;
    -- Outputs to Debug PHY KSZ8081
    D_TXD              : out std_logic_vector(3 downto 0);
    D_TXEN             : out std_logic;
    D_MDC              : out std_logic;
    D_MDO_EN           : out std_logic;
    D_MDO              : out std_logic;
    -- Inputs from Test Logic
    T_TXD              : in std_logic_vector(3 downto 0);
    T_TXEN             : in std_logic;
    -- Outputs to Test Logic
    T_RXD              : out std_logic_vector(3 downto 0);
    T_RXER             : out std_logic;
    T_RXDV             : out std_logic;
    T_CRS              : out std_logic;
    T_COL              : out std_logic;
    T_RXC              : out std_logic;
    T_TXC              : out std_logic
  );
end entity Phy_Mux;
--
architecture translated of Phy_Mux is

  -- constants
  constant xhdl_timescale            : time := 1 ns;
  -- Connects MAC_MII bus to Debug Bus AND FPGA PHY to Host
  constant CONNECT_DEBUGPHY_SOCMAC_C : std_logic_vector(2 downto 0) := "000";
  -- Connects MAC_MII bus to Debug Bus AND FPGA PHY to Host
  constant CONNECT_FPGAPHY_SOCMAC_C  : std_logic_vector(2 downto 0) := "001";
  -- Connects MAC_MII bus to Debug Bus AND FPGA PHY to Host
  constant CONNECT_FPGAPHY_HOSTMAC_C  : std_logic_vector(2 downto 0) := "011";
  -- Connects MAC_MII bus to Debug Bus AND FPGA PHY to Test Logic
  constant CONNECT_FPGAPHY_TESTER_C  : std_logic_vector(2 downto 0) := "010";

  -- signals
  signal F_mdo_qual_i                : std_logic;
  signal MAC_MII_mdo_qual_i          : std_logic;
  signal MII_MUX_control             : std_logic_vector(2 downto 0);
  signal HOST_DET          			 : std_logic;
  signal MII_DBG_PHY				 : std_logic;
  
begin

  --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1!!!!
  -- Enable below for processor control.
  --!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1!!!!  
  --MII_MUX_control     <= MII_MUX_control_reg(2 downto 0);
 
  HOST_DET		<= not HOST_DETn;
  MII_DBG_PHY	<= not MII_DBG_PHYn;
  MII_MUX_control <= '0' & HOST_DET & MII_DBG_PHYn;
  
-- 000	CONNECT_DEBUGPHY_SOCMAC_C
-- 001	CONNECT_FPGAPHY_SOCMAC_C
-- 010  CONNECT_DEBUGPHY_SOCMAC_C and CONNECT_FPGAPHY_HOSTMAC_C
-- 011	CONNECT_DEBUGPHY_SOCMAC_C and CONNECT_FPGAPHY_HOSTMAC_C
-- 100	CONNECT_FPGAPHY_TESTER_C
-- 101	CONNECT_FPGAPHY_TESTER_C
-- 110	CONNECT_FPGAPHY_TESTER_C
-- 111	CONNECT_FPGAPHY_TESTER_C
  
  F_mdo_qual_i        <= F_MDO_EN and F_MDO;
  MAC_MII_mdo_qual_i  <= MAC_MII_MDO_EN and MAC_MII_MDO;
    
--------------------------------------------------------------------------------  
  -- Host, SoC, FPGA and Debug Phy Mux
---------1---------2---------3---------4---------5---------6---------7---------8
    PHY_MUX_PROC: PROCESS 
         ( 
           MII_MUX_control, Clk_25MHz, F_mdo_qual_i, MAC_MII_mdo_qual_i,
           MAC_MII_TXD, MAC_MII_TX_EN, MAC_MII_MDC, MAC_MII_MDO_EN, MAC_MII_MDO,
           H_TXD,       H_TXEN,        H_MDC,       H_MDO_EN,       H_MDI, H_MDC,
           T_TXD,       T_TXEN, 
           D_TXC, D_RXC, D_RXD, D_RXDV, D_RXER, D_CRS, D_COL, D_MDI,
           F_TXC, F_RXC, F_RXD, F_RXDV, F_RXER, F_CRS, F_COL, F_MDO_EN, F_MDO,
		   HOST_DET, MII_DBG_PHY
         )
    begin
          CASE MII_MUX_control IS
            when CONNECT_DEBUGPHY_SOCMAC_C =>
                D_TXD           <= MAC_MII_TXD;
                D_TXEN          <= MAC_MII_TX_EN;
                MAC_MII_RXD     <= D_RXD;
                MAC_MII_RX_ER   <= D_RXER;
                MAC_MII_RX_DV   <= D_RXDV;
                MAC_MII_CRS     <= D_CRS;
                MAC_MII_COL     <= D_COL;
                MAC_MII_TX_CLK  <= D_TXC;
                MAC_MII_RX_CLK  <= D_RXC;
                --
                F_TXD           <= H_TXD;
                F_TXEN          <= H_TXEN;
                H_TXC           <= F_TXC;
                H_RXC           <= F_RXC;
                H_RXD           <= F_RXD;
                H_RXDV          <= F_RXDV;
                H_CRS           <= F_CRS;
                H_COL           <= F_COL;
                -- MDIO and Clock Logic           
                D_MDC           <= MAC_MII_MDC;    
                F_MDC           <= MAC_MII_MDC; -- H_MDC;
                D_MDO_EN        <= MAC_MII_MDO_EN;
                D_MDO           <= MAC_MII_MDO;
                H_MDO_EN        <= F_MDO_EN;
                H_MDO           <= F_MDO;
                MAC_MII_MDI     <= F_mdo_qual_i; -- D_MDI;
                F_MDI           <= MAC_MII_MDO_EN and MAC_MII_MDO;

            when CONNECT_FPGAPHY_SOCMAC_C =>
                D_TXD           <= H_TXD;
                D_TXEN          <= H_TXEN;
                MAC_MII_RXD     <= F_RXD;
                MAC_MII_RX_ER   <= '0';--F_RXER;
                MAC_MII_RX_DV   <= F_RXDV;
                MAC_MII_CRS     <= '0';--F_CRS;
                MAC_MII_COL     <= '0';--F_COL;
                MAC_MII_RX_CLK  <= F_RXC;
                MAC_MII_TX_CLK  <= F_TXC;
                --
                F_TXD           <= MAC_MII_TXD;
                F_TXEN          <= MAC_MII_TX_EN;
                H_TXC           <= D_TXC;
                H_RXC           <= D_RXC;
                H_RXD           <= D_RXD;
                H_RXDV          <= D_RXDV;
                H_CRS           <= D_CRS;
                H_COL           <= D_COL;
                -- MDIO and Clock Logic           
                D_MDC           <= H_MDC;    
                F_MDC           <= MAC_MII_MDC;
                D_MDO_EN        <= '0';       -- H_MDO_EN;
                D_MDO           <= '0';
                H_MDO_EN        <= '0';
                H_MDO           <= '0';
                MAC_MII_MDI     <= F_mdo_qual_i;
                F_MDI           <= MAC_MII_mdo_qual_i;
				
            when CONNECT_FPGAPHY_HOSTMAC_C =>
                D_TXD           <= MAC_MII_TXD;
                D_TXEN          <= MAC_MII_TX_EN;
                MAC_MII_RXD     <= D_RXD;
                MAC_MII_RX_ER   <= '0';--D_RXER;
                MAC_MII_RX_DV   <= D_RXDV;
                MAC_MII_CRS     <= D_CRS;
                MAC_MII_COL     <= '0';--D_COL;
                MAC_MII_TX_CLK  <= D_TXC;
                MAC_MII_RX_CLK  <= D_RXC;
                --
                F_TXD           <= H_TXD;
                F_TXEN          <= H_TXEN;
                H_TXC           <= F_TXC;
                H_RXC           <= F_RXC;
                H_RXD           <= F_RXD;
                H_RXDV          <= F_RXDV;
                H_CRS           <= F_CRS;
                H_COL           <= F_COL;
				H_RXER		    <= F_RXER;
                -- MDIO and Clock Logic           
                D_MDC           <= MAC_MII_MDC;    
                F_MDC           <= MAC_MII_MDC; -- H_MDC;
                D_MDO_EN        <= MAC_MII_MDO_EN;
                D_MDO           <= MAC_MII_MDO;
                H_MDO_EN        <= F_MDO_EN;
                H_MDO           <= F_MDO;
                MAC_MII_MDI     <= F_mdo_qual_i; -- D_MDI;
                F_MDI           <= MAC_MII_MDO_EN and MAC_MII_MDO;
				
            when CONNECT_FPGAPHY_TESTER_C =>
                D_TXD           <= MAC_MII_TXD;
                D_TXEN          <= MAC_MII_TX_EN;
                MAC_MII_RXD     <= D_RXD;
                MAC_MII_RX_ER   <= D_RXER;
                MAC_MII_RX_DV   <= D_RXDV;
                MAC_MII_CRS     <= D_CRS;
                MAC_MII_COL     <= D_COL;
                MAC_MII_TX_CLK  <= D_TXC;
                MAC_MII_RX_CLK  <= D_RXC;              
                --
                F_TXD           <= T_TXD;
                F_TXEN          <= T_TXEN;
                T_TXC           <= F_TXC;
                T_RXC           <= F_RXC;
                T_RXD           <= F_RXD;
                T_RXDV          <= F_RXDV;
                T_RXER          <= F_RXER;
                T_CRS           <= F_CRS;
                T_COL           <= F_COL;
                -- MDIO and Clock Logic           
                D_MDC           <= MAC_MII_MDC;    
                F_MDC           <= H_MDC;
                D_MDO_EN        <= MAC_MII_MDO_EN;
                D_MDO           <= MAC_MII_MDO;
                H_MDO_EN        <= F_MDO_EN;
                H_MDO           <= F_MDO;
                MAC_MII_MDI     <= D_MDI;
                F_MDI           <= H_MDI;

            when others =>
              null;
          end case;
    end process;
   
end ARCHITECTURE translated;