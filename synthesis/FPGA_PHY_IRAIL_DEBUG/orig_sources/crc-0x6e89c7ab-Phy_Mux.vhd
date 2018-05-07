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
		Clk_25MHz			: in std_logic;
		-- Inputs from SoC MAC
		MII_DBG_PHYn        : in std_logic;		-- 0=Sends SoC MAC signals to Debug Phy; 1=Sends SoC MAC signals to FPGA I-Rail PHY
		MAC_MII_TXD			: in std_logic_vector(3 downto 0);
		MAC_MII_TX_EN       : in std_logic;
		MAC_MII_MDC			: in std_logic;
		MAC_MII_MDO_EN		: in std_logic;
		MAC_MII_MDO			: in std_logic;
		-- Inputs from FPGA I-Rail Phy
		F_MDO_EN			: in std_logic;
		F_MDO				: in std_logic;
		F_RXD				: in std_logic_vector(3 downto 0);
		F_RXER				: in std_logic;
		F_RXDV				: in std_logic;
		F_CRS				: in std_logic;
		F_COL				: in std_logic;
		F_RXC				: in std_logic;
		F_TXC				: in std_logic;
		-- Inputs from Host MII
		H_TXD				: in std_logic_vector(3 downto 0);
		H_TXEN				: in std_logic;
		H_MDC				: in std_logic;
		H_MDI				: in std_logic;
		-- Inputs from Debug PHY KSZ8081
		D_RXD				: in std_logic_vector(3 downto 0);
		D_RXER				: in std_logic;
		D_RXDV				: in std_logic;
		D_CRS				: in std_logic;
		D_COL				: in std_logic;
		D_RXC				: in std_logic;
		D_TXC				: in std_logic;
		D_MDI				: in std_logic;
		-- Outputs to SoC MAC
		MAC_MII_RXD			: out std_logic_vector(3 downto 0);
		MAC_MII_RX_ER		: out std_logic;
		MAC_MII_RX_DV		: out std_logic;
		MAC_MII_CRS			: out std_logic;
		MAC_MII_COL			: out std_logic;
		MAC_MII_RX_CLK		: out std_logic;
		MAC_MII_TX_CLK		: out std_logic;
		MAC_MII_MDI			: out std_logic;
		-- Outputs to FPGA I-RAIL PHY
		F_TXD				: out std_logic_vector(3 downto 0);
		F_TXEN				: out std_logic;
		F_MDC				: out std_logic;
		F_MDI				: out std_logic;
		-- Outputs to Debug PHY KSZ8081
		D_TXD				: out std_logic_vector(3 downto 0);
		D_TXEN				: out std_logic;
		D_MDC				: out std_logic;
		D_MDO_EN			: out std_logic;
		D_MDO				: out std_logic;
		-- Outputs to Host Phy
		H_RXD				: out std_logic_vector(3 downto 0);
		H_RXER				: out std_logic;
		H_RXDV				: out std_logic;
		H_CRS				: out std_logic;
		H_COL				: out std_logic;
		H_RXC				: out std_logic;
		H_TXC				: out std_logic;
		H_MDO_EN			: out std_logic;
		H_MDO				: out std_logic
		);
end entity Phy_Mux;
--
architecture translated of Phy_Mux is

	constant xhdl_timescale         : time := 1 ns;
	
 begin
	
--------------------------------------------------------------------------------  
 -- Host, SoC, FPGA and Debug Phy Mux
---------1---------2---------3---------4---------5---------6---------7---------8
	
	D_TXD		<= MAC_MII_TXD 	when (MII_DBG_PHYn = '0') else H_TXD;
	D_TXEN		<= MAC_MII_TX_EN when (MII_DBG_PHYn = '0') else H_TXEN;
	
	MAC_MII_RXD		<= D_RXD when (MII_DBG_PHYn = '0') else F_RXD;
	MAC_MII_RX_ER	<= D_RXER when (MII_DBG_PHYn = '0') else F_RXER;
	MAC_MII_RX_DV	<= D_RXDV when (MII_DBG_PHYn = '0') else F_RXDV;
	MAC_MII_CRS		<= D_CRS when (MII_DBG_PHYn = '0') else F_CRS;
	MAC_MII_COL		<= D_COL when (MII_DBG_PHYn = '0') else '0';-- 1-24-18 F_COL;
	MAC_MII_RX_CLK	<= D_RXC when (MII_DBG_PHYn = '0') else Clk_25MHz; -- F_RXC;
	MAC_MII_TX_CLK	<= D_TXC when (MII_DBG_PHYn = '0') else Clk_25MHz; -- F_TXC;
	
	F_TXD	<= MAC_MII_TXD when (MII_DBG_PHYn = '1') else H_TXD;
	F_TXEN	<= MAC_MII_TX_EN when (MII_DBG_PHYn = '1') else H_TXEN;
	
	H_TXC	<= D_TXC when (MII_DBG_PHYn = '1') else F_TXC;
	H_RXC	<= D_RXC when (MII_DBG_PHYn = '1') else F_RXC;
	H_RXD	<= D_RXD when (MII_DBG_PHYn = '1') else F_RXD;
	H_RXDV	<= D_RXDV when (MII_DBG_PHYn = '1') else F_RXDV;
	H_CRS	<= D_CRS when (MII_DBG_PHYn = '1') else F_CRS;
	H_COL	<= D_COL when (MII_DBG_PHYn = '1') else F_COL;
	
	
	
/*		
	-- internal FPGA Phy signal stubs
	F_RXD	<= b"1010";
	F_RXER	<= '0';
	F_RXDV	<= '0';
	F_CRS	<= '0';
	F_COL	<= '0';
	F_RXC	<= '0';
	F_TXC	<= '0';
	
	-- Host Output Phy signal stubs
	H_RXD	<= b"0101";
	H_RXER	<= '0';
	H_RXDV	<= '0';
	H_CRS	<= '0';
	H_COL	<= '0';
	H_RXC	<= '0';
	H_TXC	<= '0';
*/	
	-- MDIO and Clock Logic
	D_MDC		<= MAC_MII_MDC when (MII_DBG_PHYn = '0') else H_MDC;	
	F_MDC		<= H_MDC when (MII_DBG_PHYn = '0') else MAC_MII_MDC;
	
	D_MDO_EN	<= MAC_MII_MDO_EN when (MII_DBG_PHYn = '0') else '0'; -- H_MDO_EN;  Libero will not allow connection between host and debug
	D_MDO	 	<= MAC_MII_MDO when (MII_DBG_PHYn = '0') else '0';
	
	H_MDO_EN <= F_MDO_EN when (MII_DBG_PHYn = '0') else '0';
	H_MDO	 <= F_MDO when (MII_DBG_PHYn = '0') else '0';	
			
	MAC_MII_MDI <= D_MDI when (MII_DBG_PHYn = '0') else (F_MDO_EN and F_MDO);
	F_MDI	<= H_MDI when (MII_DBG_PHYn = '0') else (MAC_MII_MDO_EN and MAC_MII_MDO);
   
end ARCHITECTURE translated;
