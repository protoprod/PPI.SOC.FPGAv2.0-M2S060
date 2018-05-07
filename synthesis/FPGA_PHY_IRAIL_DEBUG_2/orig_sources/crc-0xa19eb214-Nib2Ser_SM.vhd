--------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     16 September 2014
-- Module Name:     Nib2Ser_SM.vhd
-- Project Name:    Powered Rail
-- Target Devices:  TBD
-- Description:
--      The Transmit State Machine is responsible for moving data to
--      the TX AFE Interface during the appropriate transmission window.
--      In addition, it handles error conditions and interrupts to the
--      processor.  Transmit data is loaded into the Transmit FIFO by the
--      processor.  The data loaded by the processor includes the Header and
--      Data but not the CRC.  The Transmit State Machine provides control
--      to the following functions and discussed in subsequent sections.
-------------------------------------------------------------------------------
--
-- Structure:
--    CommsFPGA_top.vhd
--      -- TX_Collision_Detector2.vhd
--      -- IdleLineDetector.vhd
--      -- uP_if.vhd
--           -- Interrupts.vhd
--              -- Edge_Detect.vhd
--      -- ManchesterEncoder2.vhd
--           -- Nib2Ser_SM.vhd                 <=
--           -- Jabber_SM.vhd
--           -- Edge_Detect.vhd
--      -- ManchesDecoder2.vhd
--           -- RX_SM.vhd
--           -- CLOCK_DOMAIN_BUFFER.vhd
--           -- ManchesDecoder_Adapter.vhd
--                -- IdleLineDetector.vhd
--           -- BitDector.vhd
--
-------------------------------------------------------------------------------
-- This revision history is a PPI history
--
-- v 1.0 PPI 2/17/2015 original release
--
---------1---------2---------3---------4---------5---------6---------7---------8

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Nib2Ser_SM is
  Port (
    reset                     : in  std_logic;
    bit_clk                   : in  std_logic;
    idle_line                 : in  std_logic;
    mii_tx_d_d1               : in  std_logic_vector(3 downto 0); 
    mii_tx_en_d1              : in  std_logic;
    collision_detect_s        : in  std_logic;
    Jabber_TX_Disable         : in  std_logic;
    TX_Enable                 : out std_logic;
    p2s_data                  : out std_logic_vector(3 downto 0)
  );
end Nib2Ser_SM;

---------1---------2---------3---------4---------5---------6---------7---------8
architecture Behavioral of Nib2Ser_SM is

  -- Constants
  constant JAM_CNTR_SIZE_64        : std_logic_vector(11 downto 0) := x"040";
  constant JAM_CNTR_SIZE_2048      : std_logic_vector(11 downto 0) := x"800"; -- Greater than 1 packet
  
  -- Signals
  signal nibble_cntr          : std_logic_vector(11 downto 0);  
  signal field_cntr           : std_logic_vector( 1 downto 0);  
  signal Jam_cntr             : std_logic_vector(11 downto 0);
  signal i_p2s_data           : std_logic_vector( 3 downto 0);
  signal IPG_cntr			  : std_logic_vector( 7 downto 0);	

  -- state machine state defintions
  type   TX_STATE_TYPE is (IDLE, TX_NIBBLE_LOAD_ST, JAM_ST, JAM_END_ST, JABBER_ST, IPG_ST);
  signal TX_STATE             : TX_STATE_TYPE;

---------1---------2---------3---------4---------5---------6---------7---------8
begin

  p2s_data    <= i_p2s_data;

  ---------------------------------------------------------------------------
  -- Main state machine
  -------1---------2---------3---------4---------5---------6---------7---------8
  Nib2Ser_SM : PROCESS (bit_clk, reset)
  begin
    if (rising_edge(bit_clk) ) then
      if ( reset = '1' ) then
        TX_STATE           <= IDLE;
        nibble_cntr        <= (others => '0');
        field_cntr         <= (others => '0');
        Jam_cntr           <= (others => '0');
        TX_Enable          <= '0';
        i_p2s_data         <= (others => '0');
		IPG_cntr			 <= (others => '0');
      else
        CASE TX_STATE    IS

        ------------------------ IDLE ----------------------------------------
          when IDLE =>
            if ( mii_tx_en_d1 = '1' ) then
              TX_STATE           <= TX_NIBBLE_LOAD_ST;
              nibble_cntr        <= nibble_cntr + '1';
              field_cntr         <= (others => '0');
              Jam_cntr           <= (others => '0');
              TX_Enable          <= '0';
              i_p2s_data         <= mii_tx_d_d1;
            else
              TX_STATE           <= IDLE;
              nibble_cntr        <= (others => '0');
              field_cntr         <= (others => '0');
              Jam_cntr           <= (others => '0');
              TX_Enable          <= '0';
              i_p2s_data         <= (others => '0');
			  IPG_cntr			 <= (others => '0');
            end if;

        --------------------- TX_NIBBLE_LOAD_ST ----------------------------------
          when TX_NIBBLE_LOAD_ST =>
            if (collision_detect_s = '1') then
              TX_STATE           <= JAM_ST;
              nibble_cntr        <= nibble_cntr + '1';
              field_cntr         <= field_cntr  + '1';
              Jam_cntr           <= Jam_cntr    + '1';
              TX_Enable          <= '1';
              i_p2s_data         <= x"F";            
            elsif (Jabber_TX_Disable = '1') then
              TX_STATE           <= JABBER_ST;
              nibble_cntr        <= nibble_cntr + '1';
              field_cntr         <= field_cntr  + '1';
              Jam_cntr           <= Jam_cntr    + '1';
              TX_Enable          <= '1';
              i_p2s_data         <= (others => '0');   
            else          
              if ( mii_tx_en_d1 = '1' and (field_cntr  /= "11") ) then
                TX_STATE         <= TX_NIBBLE_LOAD_ST;
                nibble_cntr      <= nibble_cntr + '1';
                field_cntr       <= field_cntr  + '1';
                Jam_cntr         <= (others => '0');
                TX_Enable        <= '1';
                i_p2s_data       <= i_p2s_data(2 downto 0) & '0';
              elsif ( mii_tx_en_d1 = '1' ) then
                TX_STATE         <= TX_NIBBLE_LOAD_ST;
                nibble_cntr      <= nibble_cntr + '1';
                field_cntr       <= (others => '0');
                Jam_cntr         <= (others => '0');
                TX_Enable        <= '1';
                i_p2s_data       <= mii_tx_d_d1;
              else
                TX_STATE         <= IPG_ST;
                nibble_cntr      <= (others => '0');
                field_cntr       <= (others => '0');
                Jam_cntr         <= (others => '0');
                TX_Enable        <= '1';
                i_p2s_data       <= (others => '0');
			    IPG_cntr		 <= (others => '0');
              end if;
            end if;
			
        ------------------------ IPG_ST ----------------------------------------
          when IPG_ST =>									-- interpacket gap = 12 x 8 bits = 96
            if ( IPG_cntr = x"60" ) then
              TX_STATE           <= IDLE;
              nibble_cntr        <= (others => '0');
              field_cntr         <= (others => '0');
              Jam_cntr           <= (others => '0');
              TX_Enable          <= '0';
              i_p2s_data         <= (others => '0');
			  IPG_cntr			 <= (others => '0');
            else
              TX_STATE           <= IPG_ST;
              nibble_cntr        <= (others => '0');
              field_cntr         <= (others => '0');
              Jam_cntr           <= (others => '0');
              TX_Enable          <= '0';
              i_p2s_data         <= (others => '0');
			  IPG_cntr			 <= IPG_cntr + '1';
            end if;

        ------------------------ JAM_ST ----------------------------------------
          when JAM_ST =>
            if ( Jam_cntr = JAM_CNTR_SIZE_64 ) then
              TX_STATE           <= JAM_END_ST;
              nibble_cntr        <= (others => '0');
              field_cntr         <= (others => '0');
              Jam_cntr           <= (others => '0');
              TX_Enable          <= '0';
              i_p2s_data         <= x"F";
            else
              TX_STATE           <= JAM_ST;
              nibble_cntr        <= (others => '0');
              field_cntr         <= field_cntr + '1';
              Jam_cntr           <= Jam_cntr   + '1';
              TX_Enable          <= '1';
              i_p2s_data         <= x"F";
            end if;

        ------------------------ JAM_END_ST ----------------------------------------
          when JAM_END_ST =>
            TX_STATE           <= IDLE;
            nibble_cntr        <= (others => '0');
            field_cntr         <= (others => '0');
            Jam_cntr           <= (others => '0');
            TX_Enable          <= '0';
            i_p2s_data         <= x"F";

        ------------------------ JABBER_ST ----------------------------------------
          when JABBER_ST =>
            if ( Jabber_TX_Disable = '0' ) then
              TX_STATE           <= JABBER_ST;
              nibble_cntr        <= (others => '0');
              field_cntr         <= (others => '0');
              Jam_cntr           <= (others => '0');
              TX_Enable          <= '0';
              i_p2s_data         <= (others => '0');
            else
              TX_STATE           <= IDLE;
              nibble_cntr        <= (others => '0');
              field_cntr         <= (others => '0');
              Jam_cntr           <= (others => '0');
              TX_Enable          <= '0';
              i_p2s_data         <= (others => '0');
            end if;

         ----------------------- OTHERS ---------------------------------------
          when others =>
            null;
        end case;
      end if;
    end if;
  end process;

end Behavioral;