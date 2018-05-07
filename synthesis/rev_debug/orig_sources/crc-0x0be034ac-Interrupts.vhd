----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     17 August 2014 
-- Design Name:     Powered Rail Performance Tester 
-- Module Name:     Interrupts.vhd - Behavioral 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     The Interrupt into the MSS is level sensitive, active high.
--                  Interrupts are cleared by writing a logi 1 to the bit to be 
--                  cleared.
--                  The sources of interrupts are the following:
-- * Transmit FIFO OverFlow
-- * Transmit FIFO Underrun
-- * Receive FIFO OverFlow
-- * Receive FIFO Underrun
-- * Transmit Complete
-- * Receiver Packet Available
-- * Receiver CRC Error
-- * Collision Detected
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd               <=
--      -- ManchesterEncoder.vhd
--           -- TX_SM.vhd
--                -- IdleLineDetector.vhd
--           -- CRC16_Generator.vhd
--      -- FIFOs.vhd
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


entity Interrupts is
  Port (
    rst                    : in  std_logic;
    clk16x                 : in  std_logic;
    APB3_RESET             : in  std_logic;
    APB3_CLK               : in  std_logic;
    APB3_ADDR              : in  std_logic_vector(7 downto 0);
    APB3_WDATA             : in  std_logic_vector(7 downto 0);
    write_reg_en           : in  std_logic; 
    tx_packet_complt       : in  std_logic;
    RX_packet_depth_status : in  std_logic;
    TX_FIFO_UNDERRUN       : in  std_logic;
    TX_FIFO_OVERFLOW       : in  std_logic;
    RX_FIFO_UNDERRUN       : in  std_logic;
    RX_FIFO_OVERFLOW       : in  std_logic;
    col_detect             : in  std_logic;
    rx_CRC_error           : in  std_logic;
    int_mask_reg           : in  std_logic_vector(7 downto 0);
    int_reg                : out std_logic_vector(7 downto 0);
    INT                    : out std_logic;
	rx_packet_avail_int	   : out std_logic;
	up_EOP                 : in std_logic
  );
end Interrupts;

architecture Behavioral of Interrupts is

-- constants
  constant INTR_REG_C          : std_logic_vector(7 downto 0) := "00010100";
  
-- signals
  signal tx_packet_complt_int      : std_logic;
  signal tx_FIFO_UNDERRUN_int      : std_logic;
  signal tx_FIFO_OVERFLOW_int      : std_logic;
  signal rx_FIFO_UNDERRUN_int      : std_logic;
  signal rx_FIFO_OVERFLOW_int      : std_logic;
  signal col_detect_int            : std_logic;  
  signal int_reg_clr               : std_logic;
  signal rx_CRC_error_int          : std_logic;
  signal tx_packet_complt_d        : std_logic_vector(7 downto 0);
  signal up_EOP_del	    		   : std_logic_vector(5 downto 0);		-- gwc
  signal tx_packet_complt_to_APB3_CLK : std_logic;
  signal irx_packet_avail_int      : std_logic;
  signal block_int_until_rd		   : std_logic;	-- 080417 gwc
  
  -- reclock signals when crossing from 163MHz to ABP domain
  signal rx_FIFO_underrun_d		   : std_logic_vector(2 downto 0);	--3 stage regs to sync 163MHz clock domain to APB domain
  signal RX_FIFO_UNDERRUN_c		   : std_logic;  
  signal col_detect_d			   : std_logic_vector(2 downto 0);
  signal col_detect_c			   : std_logic;
  signal rx_CRC_error_d 		   : std_logic_vector(2 downto 0);
  signal rx_CRC_error_c 		   : std_logic;
  signal RX_FIFO_OVERFLOW_d		   : std_logic_vector(2 downto 0);
  signal RX_FIFO_OVERFLOW_c		   : std_logic;
  signal TX_FIFO_UNDERRUN_d		   : std_logic_vector(2 downto 0);
  signal TX_FIFO_UNDERRUN_c		   : std_logic;
  signal TX_FIFO_OVERFLOW_d		   : std_logic_vector(2 downto 0);
  signal TX_FIFO_OVERFLOW_c		   : std_logic;
  signal tx_FIFO_UNDERRUN_int_d    : std_logic_vector(2 downto 0);
  signal tx_FIFO_UNDERRUN_int_c	   : std_logic;
  signal col_detect_int_d  		   : std_logic_vector(2 downto 0);
  signal col_detect_int_c  		   : std_logic;
  signal rx_CRC_error_int_d		   : std_logic_vector(2 downto 0);
  signal rx_CRC_error_int_c 	   : std_logic;
  signal rx_FIFO_OVERFLOW_int_d	   : std_logic_vector(2 downto 0);
  signal rx_FIFO_OVERFLOW_int_c	   : std_logic;
  signal rx_FIFO_UNDERRUN_int_d	   : std_logic_vector(2 downto 0);
  signal rx_FIFO_UNDERRUN_int_c	   : std_logic;
   
  
  begin

  rx_packet_avail_int <= irx_packet_avail_int;
  INT      <=     ( tx_packet_complt_int and not int_mask_reg(7) ) 
               or ( irx_packet_avail_int and not int_mask_reg(6) )
               or ( tx_FIFO_UNDERRUN_int and not int_mask_reg(5) ) 
               or ( tx_FIFO_OVERFLOW_int and not int_mask_reg(4) )
               or ( rx_FIFO_UNDERRUN_int and not int_mask_reg(3) ) 
               or ( rx_FIFO_OVERFLOW_int and not int_mask_reg(2) )
               or ( rx_CRC_error_int     and not int_mask_reg(1) ) 
               or ( col_detect_int       and not int_mask_reg(0) );
                  
  int_reg  <=     ( tx_packet_complt_int and not int_mask_reg(7) ) 
                & ( irx_packet_avail_int  and not int_mask_reg(6) )
                & ( tx_FIFO_UNDERRUN_int and not int_mask_reg(5) ) 
                & ( tx_FIFO_OVERFLOW_int and not int_mask_reg(4) )
                & ( rx_FIFO_UNDERRUN_int and not int_mask_reg(3) ) 
                & ( rx_FIFO_OVERFLOW_int and not int_mask_reg(2) )
                & ( rx_CRC_error_int     and not int_mask_reg(1) )   
                & ( col_detect_int       and not int_mask_reg(0) );
			
--------------------------------------------------------------------------------
--   Sync across clock domains - 163MHz to APB 
---------1---------2---------3---------4---------5---------6---------7---------8 
				
  RX_FIFO_UNDERRUN_c <= rx_FIFO_underrun_d(2) and rx_FIFO_underrun_d(1);	-- cross timing domain signals - "AND" 2nd and 3rd stage to eliminate any glitchs
  col_detect_c <= col_detect_d(2) and col_detect_d(1);		
  rx_CRC_error_c <= rx_CRC_error_d(2) and rx_CRC_error_d(1);
  tx_FIFO_UNDERRUN_int_c <= tx_FIFO_UNDERRUN_int_d(2) and tx_FIFO_UNDERRUN_int_d(1);
  col_detect_int_c <= col_detect_int_d(2) and col_detect_int_d(1);
  rx_CRC_error_int_c <= rx_CRC_error_int_d(2) and rx_CRC_error_int_d(1);
  rx_FIFO_OVERFLOW_int_c <= rx_FIFO_OVERFLOW_int_d(2) and rx_FIFO_OVERFLOW_int_d(1);
  rx_FIFO_UNDERRUN_int_c <= rx_FIFO_UNDERRUN_int_d(2) and rx_FIFO_UNDERRUN_int_d(1);
 
 				
--------------------------------------------------------------------------------
-- Delay / Synchroizer @ clk16x
---------1---------2---------3---------4---------5---------6---------7---------8 
  DELAY_SYNC_PROC : process (rst, APB3_CLK)
  begin
    if (rst = '1') then
      tx_packet_complt_d <= (others => '0');
    elsif (rising_edge(APB3_CLK)) then 
      tx_packet_complt_d <= tx_packet_complt_d(6 downto 0) & tx_packet_complt;
    end if ;
  end process;
  
  tx_packet_complt_to_APB3_CLK <= not tx_packet_complt_d(7) 
                               and tx_packet_complt_d(6);

--------------------------------------------------------------------------------
-- Generate qualifying signal for write of interrupt register.
---------1---------2---------3---------4---------5---------6---------7---------8 
  REGISTER_CLEAR_INST : process (APB3_RESET, APB3_CLK)
    begin
      if ( APB3_RESET = '1' ) then
        int_reg_clr  <= '0';
	  elsif (rising_edge (APB3_CLK)) then
        if (write_reg_en = '1' and (INTR_REG_C = APB3_ADDR)) then
          int_reg_clr  <= '1';
        else
          int_reg_clr  <= '0';
		end if;
      end if;
    end process;

--------------------------------------------------------------------------------
-- Transmit Packet Complete Interrupt Generation: Set on Transmit Complete
-- cleared on write with data bit 7 set ("1xxxxxxx")
---------1---------2---------3---------4---------5---------6---------7---------8 
  TX_PACKET_COMPLETE_INTR : process (APB3_RESET, rst, APB3_CLK)
    begin
      if ( APB3_RESET = '1' or rst = '1') then
        tx_packet_complt_int  <= '0';
      elsif (rising_edge (APB3_CLK)) then
        if (int_reg_clr = '1' and APB3_WDATA(7) = '1') then
          tx_packet_complt_int  <= '0';
		elsif (tx_packet_complt_to_APB3_CLK = '1') then
          tx_packet_complt_int  <= '1';
		elsif (tx_FIFO_UNDERRUN_int_c = '1' or col_detect_int_c = '1' ) then
		  tx_packet_complt_int  <= '0';
		else
          tx_packet_complt_int  <= tx_packet_complt_int;
        end if;
      else
        tx_packet_complt_int  <= tx_packet_complt_int;
      end if;
	
    end process;

--------------------------------------------------------------------------------
-- Receive Packet Available Interrupt Generation: Set on Packet Complete,
-- cleared on write with data bit 6 set ("x1xxxxxx")
---------1---------2---------3---------4---------5---------6---------7---------8 
   RX_PACKET_AVAILABLE_INTR : process (APB3_RESET, rst, APB3_CLK, 
                                      RX_packet_depth_status, rx_CRC_error_int, 
                                      rx_FIFO_OVERFLOW_int, rx_FIFO_UNDERRUN_int)
    begin
      if (APB3_RESET = '1' or rst = '1') then
        irx_packet_avail_int  <= '0';
		block_int_until_rd <= '0';
      elsif (rising_edge (APB3_CLK)) then
		if (int_reg_clr = '1' and APB3_WDATA(6) = '1' and block_int_until_rd = '1') then
          irx_packet_avail_int  <= '0';    
		  block_int_until_rd <= '1';
		elsif (up_EOP_del(5) = '1' and block_int_until_rd = '1') then		-- gwc
		  block_int_until_rd <= '0';
          irx_packet_avail_int  <= '0';
		elsif (RX_packet_depth_status = '1' and block_int_until_rd = '0' and irx_packet_avail_int = '0') then
		  irx_packet_avail_int  <= '1';
		  block_int_until_rd <= '1';
		elsif (rx_CRC_error_int_c = '1' or rx_FIFO_OVERFLOW_int_c = '1' or rx_FIFO_UNDERRUN_int_c = '1') then
          irx_packet_avail_int  <= '0';
		  block_int_until_rd <= '0';
		else 
		  irx_packet_avail_int  <= irx_packet_avail_int;    
		  block_int_until_rd <= block_int_until_rd;
		end if;
	  else 
		irx_packet_avail_int  <= irx_packet_avail_int;    
		block_int_until_rd <= block_int_until_rd;
      end if;
    end process;
	
--------------------------------------------------------------------------------
-- Delay to allow FIFO read pointer to update on EOP sync signals
-- 
---------1---------2---------3---------4---------5---------6---------7---------8    
  Delay_for_Rx_FIFO_ptr : process (APB3_RESET, rst, APB3_CLK)
    begin
      if (APB3_RESET = '1' or rst = '1') then
        up_EOP_del  <= (others => '0');
      elsif (rising_edge ( APB3_CLK )) then
        up_EOP_del(5 downto 0) <= up_EOP_del(4 downto 0) & up_EOP;
      end if;
    end process;
     
--------------------------------------------------------------------------------
-- Transmit FIFO Underrun Interrupt Generation: Set on TX FIFO Underrun,
-- cleared on on write with data bit 5 set ("xx1xxxxx")
---------1---------2---------3---------4---------5---------6---------7---------8    
  TX_FIFO_UNDERRUN_INTR : process (APB3_RESET, rst, APB3_CLK)
    begin
      if ( APB3_RESET = '1' or rst = '1' ) then
        tx_FIFO_UNDERRUN_int  <= '0';
      elsif (rising_edge ( APB3_CLK )) then
        if (int_reg_clr = '1' and APB3_WDATA(5) = '1') then
          tx_FIFO_UNDERRUN_int  <= '0';
		elsif (TX_FIFO_UNDERRUN_c = '1') then
          tx_FIFO_UNDERRUN_int  <= '1';
		else 
		  tx_FIFO_UNDERRUN_int  <= tx_FIFO_UNDERRUN_int;		
        end if;
      else
        tx_FIFO_UNDERRUN_int  <= tx_FIFO_UNDERRUN_int;
      end if;
    end process;
    
--------------------------------------------------------------------------------
-- Transmit FIFO Overflow Interrupt Generation: Set on overflow, 
-- cleared on on write with data bit 4 set ("xxx1xxxx")
---------1---------2---------3---------4---------5---------6---------7---------8 
  TX_FIFO_OVERFLOW_INTR : process (APB3_RESET, rst, APB3_CLK)
    begin
      if ( APB3_RESET = '1' or rst = '1') then
        tx_FIFO_OVERFLOW_int  <= '0';
      elsif (rising_edge ( APB3_CLK )) then
        if (int_reg_clr = '1' and APB3_WDATA(4) = '1') then
          tx_FIFO_OVERFLOW_int  <= '0';
		elsif (TX_FIFO_OVERFLOW_c = '1') then
          tx_FIFO_OVERFLOW_int  <= '1';
		else
          tx_FIFO_OVERFLOW_int  <= tx_FIFO_OVERFLOW_int;
        end if;
      else
        tx_FIFO_OVERFLOW_int  <= tx_FIFO_OVERFLOW_int;
      end if;
    end process;

--------------------------------------------------------------------------------
-- Receive FIFO Underrun Interrupt Generation: Set on RX FIFO Underfun, 
-- cleared on write with data bit 3 set ("xxxx1xxx")
---------1---------2---------3---------4---------5---------6---------7---------8    
  RX_FIFO_UNDERRUN_INTR : process (APB3_RESET, rst, APB3_CLK)
    begin
      if (APB3_RESET = '1' or rst = '1') then
        rx_FIFO_UNDERRUN_int  <= '0';
      elsif (rising_edge ( APB3_CLK )) then
        if (int_reg_clr = '1' and APB3_WDATA(3) = '1' ) then
          rx_FIFO_UNDERRUN_int  <= '0';
		elsif (RX_FIFO_UNDERRUN_c = '1') then
          rx_FIFO_UNDERRUN_int  <= '1';
		else 
		  rx_FIFO_UNDERRUN_int  <= rx_FIFO_UNDERRUN_int;
        end if;
      else
        rx_FIFO_UNDERRUN_int  <= rx_FIFO_UNDERRUN_int;
      end if;
    end process;
    
--------------------------------------------------------------------------------
-- Receive FIFO Overflow Interrupt Generation: Set on RX FIFO Overflow, 
-- cleared on write with data bit 2 set ("xxxxx1xx")
---------1---------2---------3---------4---------5---------6---------7---------8 
  RX_FIFO_OVERFLOW_INTR : process (APB3_RESET, rst, APB3_CLK)
    begin
      if (APB3_RESET = '1' or rst = '1') then
        rx_FIFO_OVERFLOW_int  <= '0';
      elsif (rising_edge ( APB3_CLK )) then
        if (int_reg_clr = '1' and APB3_WDATA(2) = '1') then
          rx_FIFO_OVERFLOW_int  <= '0';
		elsif (RX_FIFO_OVERFLOW_c = '1') then
          rx_FIFO_OVERFLOW_int  <= '1';
		else
          rx_FIFO_OVERFLOW_int  <= rx_FIFO_OVERFLOW_int;
        end if;
      else
        rx_FIFO_OVERFLOW_int  <= rx_FIFO_OVERFLOW_int;
      end if;
    end process;

--------------------------------------------------------------------------------
-- Receive CRC Error Interrupt: Set on CRC Error, 
-- cleared on write with data bit 1 set ("xxxxxx1x")
---------1---------2---------3---------4---------5---------6---------7---------8 
  RX_CRC_ERROR_INTR : process (APB3_RESET, rst, APB3_CLK)
    begin
      if (APB3_RESET = '1' or rst = '1') then
        rx_CRC_error_int  <= '0';
      elsif (rising_edge ( APB3_CLK )) then
        if (int_reg_clr = '1' and APB3_WDATA(1) = '1') then
          rx_CRC_error_int  <= '0';
		elsif (rx_CRC_error_c = '1') then
          rx_CRC_error_int  <= '1';
		else 
		  rx_CRC_error_int  <= rx_CRC_error_int;
        end if;
      else
        rx_CRC_error_int  <= rx_CRC_error_int;
      end if;
    end process;
    
--------------------------------------------------------------------------------
-- Collision Detection Interrupt: Set on a collision, 
-- cleared on write with data bit 0 set ("xxxxxxx1")
---------1---------2---------3---------4---------5---------6---------7---------8 
  COLLISION_DETECTION_INTR : process (APB3_RESET, rst, APB3_CLK)
    begin
      if (APB3_RESET = '1' or rst = '1') then
        col_detect_int  <= '0';
      elsif (rising_edge ( APB3_CLK )) then
        if (int_reg_clr = '1' and APB3_WDATA(0) = '1') then
          col_detect_int  <= '0';
		elsif ( col_detect_c = '1' ) then
          col_detect_int  <= '1';
		else 
		  col_detect_int  <= col_detect_int;
        end if;
      else
        col_detect_int  <= col_detect_int;
      end if;
    end process;
 
   
--------------------------------------------------------------------------------
-- Synchronize the 163MHz clock domain signals to APB/Core domain using 3 FF stages. 
-- Triple clock and 'AND' last stage. 
---------1---------2---------3---------4---------5---------6---------7---------8 
  SYNC_TO_APB_DOMAIN : process (APB3_RESET, rst, APB3_CLK)
    begin
      if (APB3_RESET = '1' or rst = '1') then
        rx_FIFO_underrun_d  <= (others => '0');
		col_detect_d <= (others => '0');
		rx_CRC_error_d <= (others => '0');
		RX_FIFO_OVERFLOW_d <= (others => '0');
		TX_FIFO_UNDERRUN_d <= (others => '0');
		TX_FIFO_OVERFLOW_d <= (others => '0');
		rx_CRC_error_int_d <= (others => '0');
		rx_FIFO_OVERFLOW_int_d <= (others => '0');
		rx_FIFO_UNDERRUN_int_d <= (others => '0');
      elsif (rising_edge ( APB3_CLK )) then
	    rx_FIFO_underrun_d <= rx_FIFO_underrun_d(1 downto 0) & RX_FIFO_UNDERRUN;  
		col_detect_d <= col_detect_d(1 downto 0) & col_detect;
		rx_CRC_error_d <= rx_CRC_error_d(1 downto 0) & rx_CRC_error;
		RX_FIFO_OVERFLOW_d <= RX_FIFO_OVERFLOW_d(1 downto 0) & RX_FIFO_OVERFLOW;
		TX_FIFO_UNDERRUN_d <= TX_FIFO_UNDERRUN_d(1 downto 0) & TX_FIFO_UNDERRUN;
		TX_FIFO_OVERFLOW_d <= TX_FIFO_OVERFLOW_d(1 downto 0) & TX_FIFO_OVERFLOW;
		tx_FIFO_UNDERRUN_int_d <= tx_FIFO_UNDERRUN_int_d(1 downto 0) & tx_FIFO_UNDERRUN_int;
		col_detect_int_d <= col_detect_int_d(1 downto 0) & col_detect_int;
		rx_CRC_error_int_d <= rx_CRC_error_int_d(1 downto 0) & rx_CRC_error_int;
		rx_FIFO_OVERFLOW_int_d <= rx_FIFO_OVERFLOW_int_d(1 downto 0) & rx_FIFO_OVERFLOW_int;
		rx_FIFO_UNDERRUN_int_d <= rx_FIFO_UNDERRUN_int_d(1 downto 0) & rx_FIFO_UNDERRUN_int;
	  end if;
	end process;
	
  end Behavioral;