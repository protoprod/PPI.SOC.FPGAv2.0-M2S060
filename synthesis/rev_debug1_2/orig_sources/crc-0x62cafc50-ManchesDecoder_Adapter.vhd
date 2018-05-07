----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
-- 
-- Create Date:     16 September 2014 
-- Module Name:     ManchesDecoder_Adapter.vhd 
-- Project Name:    Powered Rail Performance Tester
-- Target Devices:  TBD
-- Description:     
--     Since there is no common clock distributed along the iRail, it is possible 
--     to have data errors due to these clock differences between devices.  This 
--     situation is overcome by oversampling the data by a little more the 16 times 
--     clock, or 81.25 MHz and determining when the receive data is about to slip 
--     past the sampling point.  When this occurs, the receiver is told to “skip” 
--     one of the 81.25 MHz clocks, thus realigning the data and sampling point. 
-- Structure:
--    CommsFPGA_top.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
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
--           -- ManchesDecoder_Adapter.vhd      <=
--                -- IdleLineDetector.vhd
--   
-- Revision:  0.1
--
----------------------------------------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ManchesDecoder_Adapter is
  Generic (
    RX_IDLE_LINE_CNTR_MAX  : std_logic_vector(15 downto 0) := x"0600"	--gwc intergap packet 
  );
  Port (
    rst                    : in  std_logic;
    clk16x                 : in  std_logic;
    clk1x_enable           : in  std_logic;
    rx_packet_end_all      : in  std_logic;
    MANCHESTER_IN          : in  std_logic;
    internal_loopback      : in  std_logic;
    MANCH_OUT_P            : in  std_logic;
    manches_in_dly         : out std_logic_vector(1 downto 0);
    sampler_clk1x_en       : out std_logic;
    rx_center_sample       : out std_logic;
    idle_line              : out std_logic;
    RX_FIFO_DIN            : out std_logic_vector(7 downto 0)
  );
end ManchesDecoder_Adapter;

architecture v1 of ManchesDecoder_Adapter is

-- Constants 
  constant PREAMBLE_LENGTH     : natural range 0 to 4095 := 2;  -- # of Bytes

-- Signals
  signal manches_in_s         : std_logic;
  signal manches_in           : std_logic;
  signal imanches_in_dly      : std_logic_vector(1 downto 0);
  signal iidle_line           : std_logic;
  signal clkdiv               : std_logic_vector(3 downto 0);
  signal isampler_clk1x_en    : std_logic;
  signal irx_center_sample    : std_logic;
  signal iNRZ_data            : std_logic;
  signal idle_line_cntr       : std_logic_vector(5 downto 0);
  signal s2p_data             : std_logic_vector(7 downto 0);
  signal manches_ShiftReg     : std_logic_vector(7 downto 0);
  signal manches_Transition   : std_logic;
  signal decoder_ShiftReg     : std_logic_vector(7 downto 0);
  signal decoder_Transition   : std_logic;
  signal decoder_Transition_d : std_logic_vector(3 downto 0);
  signal manches_Transition_d : std_logic_vector(3 downto 0);
  signal clock_adjust         : std_logic;
  
  signal MANCHESTER_IN_d : std_logic_vector(1 downto 0);
  signal imanches_in           : std_logic;   
	
begin
  
  RX_FIFO_DIN      <= s2p_data;
  manches_in_dly   <= imanches_in_dly;
  rx_center_sample <= irx_center_sample;
  idle_line        <= iidle_line;
  sampler_clk1x_en <= isampler_clk1x_en ;

--------------------------------------------------------------------------------
-- Transition Detection - Shift Register
---------1---------2---------3---------4---------5---------6---------7---------8 
  TRANISTION_DETECT_SHIFTREG_PROC: process (rst, rx_packet_end_all, clk16x)
  begin
    if ( (rst = '1') or (rx_packet_end_all = '1') )then
      manches_ShiftReg     <= (others => '0');
      decoder_ShiftReg     <= (others => '0');
      decoder_Transition_d <= (others => '0'); 
      manches_Transition_d <= (others => '0'); 
    elsif (rising_edge(clk16x)) then
     if clk1x_enable = '1' then
      manches_ShiftReg     <= manches_ShiftReg(6 downto 0) & imanches_in_dly(1);
      decoder_ShiftReg     <= decoder_ShiftReg(6 downto 0) & clkdiv(3);
      decoder_Transition_d <= decoder_Transition_d(2 downto 0) & decoder_Transition;
      manches_Transition_d <= manches_Transition_d(2 downto 0) & manches_Transition;
     end if ;
    end if ;
  end process ;     

-------------------------------------------------------------------------------
-- Transition Detection - Detect if there was a transition on MANCHESTER input.
---------1---------2---------3---------4---------5---------6---------7---------8 
  TRANISTION_DETECT_PROC: process (rst, rx_packet_end_all, clk16x)
  begin
    if ( (rst = '1') or (rx_packet_end_all = '1') )then
      manches_Transition <= '0';
    elsif (rising_edge(clk16x)) then
      if ( clk1x_enable = '1' ) then
--       if ( manches_ShiftReg(1) /= manches_ShiftReg(0) ) then		-- gwc why ?
        if ( manches_ShiftReg(0) /= imanches_in_dly(1) ) then
          manches_Transition <= '1';
        else
          manches_Transition <= '0';
        end if;
      end if ;
    end if ;
  end process ;     

--------------------------------------------------------------------------------
-- Transition Detection - Detect if there was a transition on DECODER input.
---------1---------2---------3---------4---------5---------6---------7---------8 
  TRANISTION_DETECTION_PROC: process (rst, rx_packet_end_all, clk16x)
  begin
    if ( (rst = '1') or (rx_packet_end_all = '1') )then
      decoder_Transition <= '0';
    elsif (rising_edge(clk16x)) then
     if ( clk1x_enable = '1' ) then
       if ( decoder_ShiftReg(0) /= clkdiv(3) ) then
         decoder_Transition <= '1';
       else
         decoder_Transition <= '0';
       end if;
     end if ;
    end if ;
  end process ;     

--------------------------------------------------------------------------------
-- Adjust the Clock
---------1---------2---------3---------4---------5---------6---------7---------8 
  CLOCK_ADJUST_PROC: process (rst, rx_packet_end_all, clk16x)
  begin
    if ( (rst = '1') or (rx_packet_end_all = '1') )then
      clock_adjust <= '0';
    elsif (rising_edge(clk16x)) then
     if ( clk1x_enable = '1' ) then
       if ( (decoder_Transition_d(2) = '1') and (manches_Transition = '1')) then
         clock_adjust <= '1';
       else
         clock_adjust <= '0';
       end if;
     end if ;
    end if ;
  end process ;     

--------------------------------------------------------------------------------  
 -- Internal Loopback Process
---------1---------2---------3---------4---------5---------6---------7---------8  
  manches_in_s  <= ( (internal_loopback and MANCH_OUT_P) 
                  or  (not internal_loopback and not MANCHESTER_IN_d(1)) );

--------------------------------------------------------------------------------	
-- Detect FIRST edge of Manchester data input
---------1---------2---------3---------4---------5---------6---------7---------8 
  MANCHESTER_INPUT_DETECT_PROC: process (rst,clk16x)
  begin
    if rst = '1' then
      imanches_in_dly(0) <= '1';
      imanches_in_dly(1) <= '1';
	  manches_in <= '1';
	  MANCHESTER_IN_d(1 downto 0) <= "11";
    elsif ( rising_edge(clk16x) ) then 
	  MANCHESTER_IN_d <= MANCHESTER_IN_d(0) & MANCHESTER_IN;
	  manches_in <= manches_in_s;
      imanches_in_dly(1) <= imanches_in_dly(0);
      imanches_in_dly(0) <= manches_in;
    end if;
  end process;  

--------------------------------------------------------------------------------
-- Idle Line Detection
---------1---------2---------3---------4---------5---------6---------7---------8
  RX_IDLE_LINE_DETECTOR : entity work.IdleLineDetector
    Generic Map(
      IDLE_LINE_CNTR_MAX  => RX_IDLE_LINE_CNTR_MAX
    )
    Port Map(
      reset               => rst,
      clk                 => clk16x,
      manches_in_dly      => imanches_in_dly,
      idle_line           => iidle_line,
	  TX_Enable			  => '0'
    ); 

--------------------------------------------------------------------------------
-- Increment the 1x clock
---------1---------2---------3---------4---------5---------6---------7---------8 
  process (rst, clk16x)
  begin
    if ( rst = '1'  )then		
      clkdiv <= "1000" ;	
    elsif (rising_edge(clk16x) and (clock_adjust = '0') ) then
	  if ((iidle_line = '1') or (rx_packet_end_all = '1') ) then  
	    clkdiv <= "1000" ;		-- gwc hack to start clock on the proper phase
      elsif clk1x_enable = '1' then
        clkdiv <= clkdiv + "0001";
      end if ;
    end if ;
  end process ;     

  
--------------------------------------------------------------------------------
-- Manchester encoded center sample data at 1/4 and 3/4 points in data cell
---------1---------2---------3---------4---------5---------6---------7---------8 
  SAMPLE_CLK1X_EN_PROC : process (clk16x, rst)
  begin
    if (rst = '1') then
      isampler_clk1x_en <= '0' ;
    elsif ( rising_edge(clk16x)  and (clock_adjust = '0') ) then
      isampler_clk1x_en <= ((not clkdiv(3)) and clkdiv(2) and clkdiv(1) and (not clkdiv(0)));
    end if;
  end process;
          
--------------------------------------------------------------------------------
-- Manchester encoded center sample data at 1/4 and 3/4 points in data cell
---------1---------2---------3---------4---------5---------6---------7---------8 
  RX_CENTER_SAMPLE_PROC : process (clk16x, rst)
  begin
    if (rst = '1') then
      irx_center_sample <= '0' ;
    elsif ( rising_edge(clk16x)  and (clock_adjust = '0') ) then
      irx_center_sample <= ((not clkdiv(3)) and (not clkdiv(2)) and clkdiv(1) and clkdiv(0)) 
                  or (clkdiv(3) and (not clkdiv(2)) and  clkdiv(1) and clkdiv(0));
    end if ;
  end process ;
  
--------------------------------------------------------------------------------
-- Decode Manchester data into NRZ
---------1---------2---------3---------4---------5---------6---------7---------8 
  NRZ_DATA_PROC : process (rst, iidle_line, clk16x)
  begin
    if ( rst = '1' or iidle_line = '1') then
      iNRZ_data <= '1' ;
    elsif ( rising_edge(clk16x) ) then	
      if ( irx_center_sample = '1' ) then   
       iNRZ_data <= imanches_in_dly(1) xor clkdiv(3);	-- gwc not always Guaranteed this clock alignment on data
      end if ;
    end if ;
  end process; 

--------------------------------------------------------------------------------
-- Serial to Parallel Conversion
---------1---------2---------3---------4---------5---------6---------7---------8 
  SERIAL_2_PARALLEL_PROC : process (clk16x, rst)
  begin
    if rst = '1' then
      s2p_data  <= (others => '0');
    elsif rising_edge(clk16x) then
	  if (isampler_clk1x_en = '1' ) then		
        s2p_data <= s2p_data(6 downto 0) & iNRZ_data;	
	  end if;
    end if ;
  end process;

end;

