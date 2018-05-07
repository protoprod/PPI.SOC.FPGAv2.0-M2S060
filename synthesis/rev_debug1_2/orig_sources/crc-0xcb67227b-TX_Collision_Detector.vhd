----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     01 December 2015
-- Module Name:     TX_Collision_Detector.vhd 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     This module detects when there is a collision while
--                  transmitting.  It does so by comparing the TX data to the
--                  RX data.
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd
--                -- TX_Collision_Detector.vhd         <=
--           -- CRC16_Generator.vhd
--      -- FIFOs.vhd
--           -- FIFO_1Kx8.vhd
--      -- ManchesDecoder.vhd 
--           -- AFE_RX_SM.vhd
--           -- ReadFIFO_Write_SM.vhd
--                -- CRC16_Generator.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd         <=
--   
-- Revision:  0.1
--
----------------------------------------------------------------------------------

---------1---------2---------3---------4---------5---------6---------7---------8

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TX_Collision_Detector is 
  Port (
    reset                 : in  std_logic;
    RX_FIFO_wr_clk        : in  std_logic; 
    RX_FIFO_wr_en         : in  std_logic;
    RX_FIFO_DIN_pipe      : in  std_logic_vector(7 downto 0);
    TX_FIFO_rd_clk        : in  std_logic; 
    p2s_data              : in  std_logic_vector(7 downto 0);
    TX_Enable             : in  std_logic;
    byte_clk_en           : in  std_logic;
    tx_packet_complt      : in  std_logic;
    internal_loopback     : in  std_logic;
    external_loopback     : in  std_logic;
    tx_col_detect_en      : out std_logic;
    TX_collision_detect   : out std_logic
  );   
end TX_Collision_Detector;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of TX_Collision_Detector is

-- Constants 

-- Signals
  signal RX_FIFO_wr_en_d              : std_logic_vector(7 downto 0); 
  signal RX_FIFO_DIN_pipe_d1          : std_logic_vector(7 downto 0);
  signal TX_FIFO_DOUT_d1              : std_logic_vector(7 downto 0);
  signal TX_FIFO_DOUT_d2              : std_logic_vector(7 downto 0);
  signal TX_FIFO_DOUT_d3              : std_logic_vector(7 downto 0);
  signal TX_FIFO_DOUT_d4              : std_logic_vector(7 downto 0);
  signal TX_FIFO_DOUT_d5              : std_logic_vector(7 downto 0);
  signal TX_FIFO_DOUT_d5_sync2RX      : std_logic_vector(7 downto 0);
  signal TX_FIFO_DOUT_d5_syncCompare  : std_logic_vector(7 downto 0); 
  signal loopback                     : std_logic;
  signal RX_FIFO_wr_en_d5             : std_logic;
  signal RX_FIFO_wr_en_d7             : std_logic;
  signal Sync2RxClk_tx_packet_complt  : std_logic_vector(1 downto 0);
  signal Sync2RxClk_TX_Enable         : std_logic_vector(1 downto 0);
  signal Sync2TxClk_loopback          : std_logic_vector(1 downto 0);
    
---------1---------2---------3---------4---------5---------6---------7---------8
begin
  
  loopback         <= internal_loopback or external_loopback;
  RX_FIFO_wr_en_d5 <= RX_FIFO_wr_en_d(5);
  RX_FIFO_wr_en_d7 <= RX_FIFO_wr_en_d(7);
  
--------------------------------------------------------------------------------		
--------------------------------------------------------------------------------		
-- TX FIFO Clock Domain
--------------------------------------------------------------------------------		
---------1---------2---------3---------4---------5---------6---------7---------8  

--------------------------------------------------------------------------------		
-- Sychronize to TRANSMIT Clock Domain
---------1---------2---------3---------4---------5---------6---------7---------8  
  TRANSMIT_CLOCK_DOMAIN_SYNC_PROC : process(TX_FIFO_rd_clk, reset)
  begin
    if(reset = '1' ) then
      Sync2TxClk_loopback <= (others => '0');
    elsif ( rising_edge(TX_FIFO_rd_clk) ) then
      Sync2TxClk_loopback <= Sync2TxClk_loopback(0) & loopback;
    end if;
  end process;
  
--------------------------------------------------------------------------------		
--------------------------------------------------------------------------------		
-- TX FIFO Clock Domain - Delay Data
--------------------------------------------------------------------------------		
---------1---------2---------3---------4---------5---------6---------7---------8  
  TX_FIFO_DELAY_PROC : process(TX_FIFO_rd_clk, reset)
  begin
    if(reset = '1' ) then
      TX_FIFO_DOUT_d1    <= (others => '0');
      TX_FIFO_DOUT_d2    <= (others => '0');
      TX_FIFO_DOUT_d3    <= (others => '0');
      TX_FIFO_DOUT_d4    <= (others => '0');
      TX_FIFO_DOUT_d5    <= (others => '0');
    elsif ( rising_edge(TX_FIFO_rd_clk)  ) then
      if ( tx_packet_complt = '1' or TX_Enable = '0' 
           or Sync2TxClk_loopback(1) ='1' ) then 
        TX_FIFO_DOUT_d1  <= (others => '0');
        TX_FIFO_DOUT_d2  <= (others => '0');
        TX_FIFO_DOUT_d3  <= (others => '0');
        TX_FIFO_DOUT_d4  <= (others => '0');
        TX_FIFO_DOUT_d5  <= (others => '0');
      elsif ( TX_Enable = '1' and byte_clk_en = '1' ) then 
        TX_FIFO_DOUT_d1  <= p2s_data; 
        TX_FIFO_DOUT_d2  <= TX_FIFO_DOUT_d1; 
        TX_FIFO_DOUT_d3  <= TX_FIFO_DOUT_d2;
        TX_FIFO_DOUT_d4  <= TX_FIFO_DOUT_d3;
        TX_FIFO_DOUT_d5  <= TX_FIFO_DOUT_d4;
      else
        TX_FIFO_DOUT_d1  <= TX_FIFO_DOUT_d1; 
        TX_FIFO_DOUT_d2  <= TX_FIFO_DOUT_d2; 
        TX_FIFO_DOUT_d3  <= TX_FIFO_DOUT_d3;
        TX_FIFO_DOUT_d4  <= TX_FIFO_DOUT_d4;
        TX_FIFO_DOUT_d5  <= TX_FIFO_DOUT_d5;      
      end if;
    end if;
  end process;
    
--------------------------------------------------------------------------------		
--------------------------------------------------------------------------------		
-- RX FIFO Clock Domain
--------------------------------------------------------------------------------		
---------1---------2---------3---------4---------5---------6---------7---------8  
  
-------------------------------------------------------------------------------
  -- Synchronizer to clk16x
---------1---------2---------3---------4---------5---------6---------7---------8
  SYNCH_PROC: PROCESS (RX_FIFO_wr_clk, reset, loopback)
  begin
    if (rising_edge( RX_FIFO_wr_clk ) ) then
      if ( reset = '1' or loopback = '1' ) then
        tx_col_detect_en            <= '0';
        Sync2RxClk_tx_packet_complt <= (others => '0');
        Sync2RxClk_TX_Enable        <= (others => '0');
      else
        tx_col_detect_en <= TX_Enable and not loopback;
        Sync2RxClk_tx_packet_complt <= Sync2RxClk_tx_packet_complt(0) 
                                       & tx_packet_complt; 
        Sync2RxClk_TX_Enable        <= Sync2RxClk_TX_Enable(0)
                                       & TX_Enable;
      end if;
    end if;  
  end process;
  
--------------------------------------------------------------------------------		
-- RX FIFO Clock Domain - Delay and Synchronization
--------------------------------------------------------------------------------		
  RX_SYNC_PROC : process(RX_FIFO_wr_clk, reset, loopback)
  begin
    if(reset = '1' or loopback = '1' ) then
      RX_FIFO_wr_en_d           <= (others => '0');
      TX_FIFO_DOUT_d5_sync2RX   <= (others => '0');
    elsif ( rising_edge(RX_FIFO_wr_clk) ) then
      if ( Sync2RxClk_tx_packet_complt(1) = '1' or Sync2RxClk_TX_Enable(1) = '0' ) then
        RX_FIFO_wr_en_d           <= (others => '0');
        TX_FIFO_DOUT_d5_sync2RX   <= (others => '0');
      else
        RX_FIFO_wr_en_d           <= RX_FIFO_wr_en_d(6 downto 0) & RX_FIFO_wr_en;
        TX_FIFO_DOUT_d5_sync2RX   <= TX_FIFO_DOUT_d5;     
      end if;
    end if;
  end process;
  
--------------------------------------------------------------------------------		
-- RX FIFO Clock Domain - RX Data Write Enable Synchronization
-- Sample on RX_FIFO_wr_en
---------1---------2---------3---------4---------5---------6---------7---------8  
  RX_FIFO_DELAY_PROC : process(RX_FIFO_wr_clk, reset, loopback)
  begin
    if(reset = '1' or loopback = '1' ) then 			   
      RX_FIFO_DIN_pipe_d1  <= (others => '0');
    elsif ( rising_edge(RX_FIFO_wr_clk) ) then
      if ( Sync2RxClk_tx_packet_complt(1) = '1' or Sync2RxClk_TX_Enable(1) = '0' ) then
        RX_FIFO_DIN_pipe_d1  <= (others => '0');
      elsif (RX_FIFO_wr_en = '1') then
        RX_FIFO_DIN_pipe_d1  <= RX_FIFO_DIN_pipe;      
      else
        RX_FIFO_DIN_pipe_d1  <= RX_FIFO_DIN_pipe_d1;      
      end if;
    end if;
  end process;
 
--------------------------------------------------------------------------------		
-- RX FIFO Clock Domain - TX Data Write Enable Synchronization
-- Sample on RX_FIFO_wr_en_d(5)
---------1---------2---------3---------4---------5---------6---------7---------8  
  TX2RX_FIFO_DELAY_PROC : process(RX_FIFO_wr_clk, reset, loopback)
  begin
    if(reset = '1' or loopback = '1' ) then
      TX_FIFO_DOUT_d5_syncCompare <= (others => '0');
    elsif ( rising_edge(RX_FIFO_wr_clk) ) then
      if ( Sync2RxClk_tx_packet_complt(1) = '1' or Sync2RxClk_TX_Enable(1) = '0' ) then
        TX_FIFO_DOUT_d5_syncCompare <= (others => '0');     
      else
        TX_FIFO_DOUT_d5_syncCompare <= TX_FIFO_DOUT_d5_sync2RX;
      end if;
    end if;
  end process;

--------------------------------------------------------------------------------		
-- RX FIFO Clock Domain - Collision Detection
-- Compare on RX_FIFO_wr_en_d(7)
---------1---------2---------3---------4---------5---------6---------7---------8  
  COLLISION_DETECT_PROC : process(RX_FIFO_wr_clk, reset, loopback)
  begin
    if( reset = '1' or loopback = '1' ) then
      TX_collision_detect <= '0';
    elsif ( rising_edge(RX_FIFO_wr_clk) ) then        
      if ( Sync2RxClk_tx_packet_complt(1) = '1' or Sync2RxClk_TX_Enable(1) = '0' ) then     
        TX_collision_detect <= '0';           
      elsif ( (RX_FIFO_DIN_pipe_d1 /= TX_FIFO_DOUT_d5_syncCompare) 
               and RX_FIFO_wr_en_d(7) = '1' ) then
        TX_collision_detect <= '1';
      else
        TX_collision_detect <= '0';
      end if;
    end if;
  end process;

end Behavioral;