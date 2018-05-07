----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     24 December 2017
-- Module Name:     MII_DataGen.vhd - Behavioral
-- Project Name:    Powered Rail Performance Tester
-- Description:     PACKET SIZE IS INCREMENTED BY '1' AFTER EACH TRANSFER
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

entity MII_DataGen is
  Generic (
    START_BYTE_SYMBOL   : std_logic_vector(7 downto 0) := x"5D"; -- 802.3 = x"D5"
    PREABLE_PATTERN     : std_logic_vector(7 downto 0) := x"55"
  );
  Port (
    reset                   : in  std_logic;
    count_clr               : in  std_logic;
    Consumer_Address        : in  std_logic_vector(9 downto 0);
    PacketStart             : in  std_logic;
    Increment_Packet_Count  : in  std_logic;
    force_jabber            : in  std_logic;
    MII_TX_CLK              : in  std_logic;
    MII_TX_EN               : out std_logic;
    MII_TX_D                : out std_logic_vector(3 downto 0)
  );
end MII_DataGen;

architecture Behavioral of MII_DataGen is

  -- constants
  constant PREAMBLE_LENGTH          : std_logic_vector( 3 downto 0) := "1110";
  constant SYNC_NIBBLE_LENGTH       : std_logic_vector( 1 downto 0) := "10";
  constant OLD_ADDR_END_NIBBLE      : std_logic_vector(10 downto 0) := "00000010011";
  constant OLD_LENGTH_END_NIBBLE    : std_logic_vector(10 downto 0) := "00000010111";
--  constant PREABLE_NIBBLE_PATTERN   : std_logic_vector( 3 downto 0) := x"5";  -- 802.3 = x"5";
  constant PACKET_LENGTH_JABBER_NUM : std_logic_vector(15 downto 0) := x"8000";

  -- signals
  signal PacketLength_nibble        : std_logic_vector(10 downto 0);
  signal nibble_cntr                : std_logic_vector(10 downto 0);
  signal byte_cntr                  : std_logic_vector( 9 downto 0);
  signal field_nibble_cntr          : std_logic_vector( 3 downto 0);
  signal PacketLength_bytes         : std_logic_vector( 9 downto 0) := "0000000111"; 
                                    
  signal i_MII_TX_EN                : std_logic;
  signal i_MII_TX_D                 : std_logic_vector( 3 downto 0);
  signal crc_gen_reset              : std_logic;
  signal crc_gen                    : std_logic;
  signal crc_data                   : std_logic_vector(15 downto 0);
  
  signal preable_nibble_pattern     : std_logic_vector( 3 downto 0);

  -- state machine state defintions
  type   MII_DATAGEN_STATE_TYPE is (
              IDLE, PREAMBLE_ST, SYNC_BYTE1_ST, SYNC_BYTE2_ST, OLD_ADDR_ST, 
              OLD_LENGTH_ST, DATA_ST, CRC_ST);

  signal MII_DATAGEN_STATE         : MII_DATAGEN_STATE_TYPE;
     		

begin
 
  MII_TX_EN           <= i_MII_TX_EN;
  MII_TX_D            <= i_MII_TX_D;

                       -- Packet Length in nibbles
  PacketLength_nibble <= (PacketLength_bytes & '0') + (PREAMBLE_LENGTH + '1')
                          + (SYNC_NIBBLE_LENGTH + '1');
                          
  preable_nibble_pattern <= PREABLE_PATTERN(3 downto 0);

  ------------------------------------------------------------------------------
  -- CRC Generater
  -------1---------2---------3---------4---------5---------6---------7---------8
  CRC_GEN_INST : entity work.CRC16x4_Generator
    port map(
      rst           => crc_gen_reset,
      clk           => MII_TX_CLK,
      clk_en        => i_MII_TX_EN,
      data_in       => i_MII_TX_D,
      crc_en        => crc_gen,
      crc_out       => crc_data
    );

  ------------------------------------------------------------------------------
  -- Packet Length Incrementor
  -------1---------2---------3---------4---------5---------6---------7---------8
  PACKET_LENGTH_INCREMENTOR_PROC : process(Increment_Packet_Count, reset, count_clr)
  begin
    if (reset = '1' or count_clr = '1') then
        PacketLength_bytes <= "0000000111";
    else
      if ( falling_edge(Increment_Packet_Count) ) then
        PacketLength_bytes <= PacketLength_bytes; -- + '1';
      end if;
    end if;
  end process;

-----------------------------------------------------------------------------
-- Main state machine
---------1---------2---------3---------4---------5---------6---------7---------8
  MII_DATAGEN_SM : PROCESS (MII_TX_CLK, reset)
  VARIABLE xhdl_initial : BOOLEAN := TRUE;
  begin
      if ( reset = '1' ) then
        MII_DATAGEN_STATE     <= IDLE;
        nibble_cntr           <= (others => '0');
        byte_cntr             <= (others => '0');
        field_nibble_cntr     <= (others => '0');
        i_MII_TX_EN           <= '0';
        i_MII_TX_D            <= "0000";
        crc_gen_reset         <= '1';
        crc_gen               <= '0';
      elsif ( rising_edge(MII_TX_CLK) ) then
        CASE MII_DATAGEN_STATE    IS

        ------------------------ IDLE ----------------------------------------
          when IDLE =>
            IF (xhdl_initial and PacketStart = '1' ) then
              MII_DATAGEN_STATE     <= PREAMBLE_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= field_nibble_cntr + '1';
              i_MII_TX_EN           <= '1';
              i_MII_TX_D            <= preable_nibble_pattern;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
            else
              MII_DATAGEN_STATE     <= IDLE;
              nibble_cntr           <= (others => '0');
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '0';
              i_MII_TX_D            <= (others => '0');
              crc_gen_reset         <= '1';
              crc_gen               <= '0';
            end if;

        --------------------- PREAMBLE_ST ----------------------------------
          when PREAMBLE_ST =>
            if ( nibble_cntr <= (PREAMBLE_LENGTH - 2) ) then
              MII_DATAGEN_STATE     <= PREAMBLE_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= field_nibble_cntr + '1';
              i_MII_TX_EN           <= '1';
              i_MII_TX_D            <= preable_nibble_pattern;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
            else
              MII_DATAGEN_STATE     <= SYNC_BYTE1_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '1';
              i_MII_TX_D            <= preable_nibble_pattern;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
            end if;

        --------------------- SYNC_BYTE1_ST ----------------------------------
          when SYNC_BYTE1_ST =>
              MII_DATAGEN_STATE     <= SYNC_BYTE2_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '1';
              i_MII_TX_D            <= START_BYTE_SYMBOL(7 downto 4);
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
            
        --------------------- SYNC_BYTE2_ST ----------------------------------
          when SYNC_BYTE2_ST => 
              MII_DATAGEN_STATE     <= OLD_ADDR_ST;                                              
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '1';
              i_MII_TX_D            <= START_BYTE_SYMBOL(3 downto 0);
              crc_gen_reset         <= '0';
              crc_gen               <= '0';

        --------------------- OLD_ADDR_ST ----------------------------------
          when OLD_ADDR_ST =>
            if ( nibble_cntr <= OLD_ADDR_END_NIBBLE ) then
              MII_DATAGEN_STATE     <= OLD_ADDR_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= field_nibble_cntr + '1';
              i_MII_TX_EN           <= '1';
              crc_gen_reset         <= '0';
              crc_gen               <= '1';
              CASE field_nibble_cntr IS
                when x"0" =>
                  i_MII_TX_D        <= x"0";
                when x"1" =>
                  i_MII_TX_D        <= "00" & Consumer_Address(9 downto  8);
                when x"2" =>
                  i_MII_TX_D        <= Consumer_Address(7 downto 4);
                when x"3" =>
                  i_MII_TX_D        <= Consumer_Address(3 downto 0);
                when others =>
                  null;
              end case;
            else
              MII_DATAGEN_STATE     <= OLD_LENGTH_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '1';
              i_MII_TX_D        <= "0000";
              crc_gen_reset         <= '0';
              crc_gen               <= '1';
            end if;

        --------------------- OLD_LENGTH_ST ----------------------------------
          when OLD_LENGTH_ST =>
            if ( nibble_cntr <= OLD_LENGTH_END_NIBBLE ) then
              MII_DATAGEN_STATE     <= OLD_LENGTH_ST;
              nibble_cntr           <= nibble_cntr + '1';
              field_nibble_cntr     <= field_nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              i_MII_TX_EN           <= '1';
              crc_gen_reset         <= '0';
              crc_gen               <= '1';
              CASE field_nibble_cntr IS
                when x"0" =>
                  i_MII_TX_D        <= "0" & PacketLength_nibble(10 downto 8);
                when x"1" =>
                  i_MII_TX_D        <= PacketLength_bytes(7 downto 4);
                when x"2" =>
                  i_MII_TX_D        <= PacketLength_bytes(3 downto 0);
                when others =>
                  null;
              end case;
            else
              MII_DATAGEN_STATE     <= DATA_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= byte_cntr + '1';
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '1';
              i_MII_TX_D            <= byte_cntr(8 downto 5);
              crc_gen_reset         <= '0';
              crc_gen               <= '1';
            end if;

        --------------------- DATA_ST ----------------------------------
          when DATA_ST =>
            if   ( force_jabber = '0'
                    and nibble_cntr <= (PacketLength_nibble - "101") ) then
              MII_DATAGEN_STATE     <= DATA_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= byte_cntr + '1';
              field_nibble_cntr     <= field_nibble_cntr + '1';
              i_MII_TX_EN           <= '1';
              crc_gen_reset         <= '0';
              crc_gen               <= '1';
              CASE byte_cntr(0) IS
                when '0' =>
                  i_MII_TX_D        <= byte_cntr(8 downto 5);
                when '1' =>
                  i_MII_TX_D        <= byte_cntr(4 downto 1);
                when others =>
                  null;
              end case;
            -- Test Purposes only
            elsif ( force_jabber = '1'
                    and nibble_cntr <= (PACKET_LENGTH_JABBER_NUM - "101") ) then
              MII_DATAGEN_STATE     <= DATA_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= byte_cntr + '1';
              field_nibble_cntr     <= field_nibble_cntr + '1';
              i_MII_TX_EN           <= '1';
              crc_gen_reset         <= '0';
              crc_gen               <= '1';
              CASE byte_cntr(0) IS
                when '0' =>
                  i_MII_TX_D        <= byte_cntr(8 downto 5);
                when '1' =>
                  i_MII_TX_D        <= byte_cntr(4 downto 1);
                when others =>
                  null;
              end case; 
            else
              MII_DATAGEN_STATE     <= CRC_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '1';
              i_MII_TX_D            <= x"C";
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
            end if;

        --------------------- CRC_ST ----------------------------------
          when CRC_ST =>
            if ( nibble_cntr <= (PacketLength_nibble - '1') ) then
              MII_DATAGEN_STATE     <= CRC_ST;
              nibble_cntr           <= nibble_cntr + '1';
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= field_nibble_cntr + '1';
              i_MII_TX_EN           <= '1';
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
              CASE field_nibble_cntr(1 downto 0) IS
                when "00" =>
                  i_MII_TX_D        <= x"8";
                when "01" =>
                  i_MII_TX_D        <= x"1";
                when "10" =>
                  i_MII_TX_D        <= x"5";
                when others =>
                  null;
              end case;
            else
              MII_DATAGEN_STATE     <= IDLE;
              nibble_cntr           <= (others => '0');
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '0';
              i_MII_TX_D            <= "0000";
              crc_gen_reset         <= '1';
              crc_gen               <= '0';
--			  xhdl_initial := FALSE;
            end if;

         ----------------------- OTHERS ---------------------------------------
          when others =>
              MII_DATAGEN_STATE     <= IDLE;
              nibble_cntr           <= (others => '0');
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_TX_EN           <= '0';
              i_MII_TX_D            <= "0000";
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
        end case;
      end if;
  end process;

end Behavioral;
