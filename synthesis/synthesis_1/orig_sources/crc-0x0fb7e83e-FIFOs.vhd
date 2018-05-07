----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     17 August 2014 
-- Design Name:     Powered Rail Performance Tester 
-- Module Name:     FIFOs.vhd - Behavioral 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     
--     The FIFOs consist of both a Transmit FIFO and Receive FIFO.  The Transmit 
--     FIFO provides an 8-bit interface to the AMBA write data interface and an 
--     8-bit interface to the Transmit Packet Processor.  The Receive FIFO provides 
--     an 8-bit interface to the AMBA read data interface and an 8-bit interface 
--     to the Receive Packet Processor.  Both the Transmit FIFO and Receive FIFO 
--     are 2048 bytes in depth. 
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd
--                -- IdleLineDetector.vhd
--           -- CRC16_Generator.vhd
--      -- FIFOs.vhd                          <=
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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

library smartfusion2;
use smartfusion2.all;
library COREFIFO_LIB;
use COREFIFO_LIB.all;

entity FIFOs is
  Port (
    reset             : in  std_logic;
    DATA              : in  std_logic_vector(7 downto 0);
    TX_FIFO_wr_clk    : in  std_logic;
    TX_FIFO_rd_clk    : in  std_logic;
    TX_FIFO_wr_en     : in  std_logic;
    TX_FIFO_rd_en     : in  std_logic;
    TX_FIFO_DOUT      : out std_logic_vector(7 downto 0);
    TX_FIFO_AE        : out std_logic;
    TX_FIFO_Empty     : out std_logic;
    TX_FIFO_Full      : out std_logic;
    TX_FIFO_AF        : out std_logic;
    TX_FIFO_OVERFLOW  : out std_logic;
    TX_FIFO_UNDERRUN  : out std_logic;
    TX_FIFO_RST       : in  std_logic;
    RX_FIFO_wr_clk    : in  std_logic;
    RX_FIFO_rd_clk    : in  std_logic;
    RX_FIFO_wr_en     : in  std_logic;
    RX_FIFO_rd_en     : in  std_logic;
    RX_FIFO_DIN       : in  std_logic_vector(8 downto 0);
    RX_FIFO_DOUT      : out std_logic_vector(8 downto 0);
    RX_FIFO_Empty     : out std_logic;
    RX_FIFO_Full      : out std_logic;
    RX_FIFO_OVERFLOW  : out std_logic;
    RX_FIFO_UNDERRUN  : out std_logic;
    RX_FIFO_RST       : in  std_logic
  );
end FIFOs;

architecture Behavioral of FIFOs is

-- constants
  
-- signals
--  signal iTX_FIFO_DOUT          : std_logic_vector(7 downto 0);
  signal iTX_FIFO_Empty         : std_logic;
  signal itx_fifo_rst           : std_logic;
  signal irx_fifo_rst           : std_logic;
  signal RX_FIFO_AF             : std_logic;
  signal RX_FIFO_AE             : std_logic;
  
begin

  TX_FIFO_Empty <= iTX_FIFO_Empty;
  itx_fifo_rst  <= reset or TX_FIFO_RST;
  irx_fifo_rst  <= reset or RX_FIFO_RST;
  
--------------------------------------------------------------------------------
-- Transmit FIFO
---------1---------2---------3---------4---------5---------6---------7---------8    
-- The Transmit FIFO provides an 2048 byte, 8-bit interface to the AMBA write 
-- data interface and an 8-bit interface to the Transmit Packet Processor. 
---------1---------2---------3---------4---------5---------6---------7---------8 

  TRANSMIT_FIFO : entity work.FIFO_2Kx8
    port map (
      DATA              => DATA, 
      RCLOCK            => TX_FIFO_rd_clk, 
      RE                => TX_FIFO_rd_en,  
      RESET             => itx_fifo_rst, 
      WCLOCK            => TX_FIFO_wr_clk, 
      WE                => TX_FIFO_wr_en, 
      AEMPTY            => TX_FIFO_AE, 
      AFULL             => TX_FIFO_AF,
      EMPTY             => iTX_FIFO_Empty, 
      FULL              => TX_FIFO_Full, 
      Q                 => TX_FIFO_DOUT,
      OVERFLOW          => TX_FIFO_OVERFLOW,
      UNDERFLOW         => TX_FIFO_UNDERRUN
    );

--------------------------------------------------------------------------------
-- Receive FIFO
---------1---------2---------3---------4---------5---------6---------7---------8    
-- The Receive FIFO provides an 2048 byte, 8-bit interface to the AMBA write 
-- data interface and an 8-bit interface to the Receive Packet Processor. 
---------1---------2---------3---------4---------5---------6---------7---------8 
 
  RECEIVE_FIFO : entity work.FIFO_8Kx9
    port map (
      DATA              => RX_FIFO_DIN, 
      RCLOCK            => RX_FIFO_rd_clk, 
      RE                => RX_FIFO_rd_en,
      RESET             => irx_fifo_rst, 
      WCLOCK            => RX_FIFO_wr_clk, 
      WE                => RX_FIFO_wr_en,
      AEMPTY            => RX_FIFO_AE, 
      AFULL             => RX_FIFO_AF,
      EMPTY             => RX_FIFO_Empty, 
      FULL              => RX_FIFO_Full, 
      Q                 => RX_FIFO_DOUT,
      OVERFLOW          => RX_FIFO_OVERFLOW,
      UNDERFLOW         => RX_FIFO_UNDERRUN     
    );
    
end Behavioral;
