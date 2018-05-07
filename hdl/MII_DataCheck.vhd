----------------------------------------------------------------------------------
-- Company:         Prototype Performance Incorporated
-- Engineer:        Scott Walker
--
-- Create Date:     24 December 2017
-- Module Name:     MII_DataCheck.vhd - Behavioral
-- Project Name:    Powered Rail Performance Tester
-- Description:     PACKET SIZE IS INCREMENTED BY '1' AFTER EACH TRANSFER
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_MISC.ALL;

entity MII_DataCheck is
  Generic (
    START_BYTE_SYMBOL     : std_logic_vector( 7 downto 0) := x"5D"
  );
  Port (
    reset               : in  std_logic;
    count_clr           : in  std_logic;
    Consumer_Address    : in  std_logic_vector(9 downto 0);
    PacketStart         : in  std_logic;
    rx_packet_end_all   : in  std_logic;
    idle_line           : in  std_logic;
    MII_RX_CLK          : in  std_logic;
    MII_RX_EN           : in  std_logic;
    MII_RX_D            : in  std_logic_vector(3 downto 0);
    MII_RX_D_fail       : out std_logic
  );
end MII_DataCheck;

architecture Behavioral of MII_DataCheck is

  -- constants
  constant OLD_ADDR_END_NIBBLE   : std_logic_vector(10 downto 0) := "00000000011";
  constant OLD_LENGTH_END_NIBBLE : std_logic_vector(10 downto 0) := "00000000111";

  -- signals
  signal PacketLength_nibble     : std_logic_vector(10 downto 0);
  signal nibble_cntr             : std_logic_vector(10 downto 0);
  signal byte_cntr               : std_logic_vector( 9 downto 0);
  signal field_nibble_cntr       : std_logic_vector( 3 downto 0);
  signal Compare_nibble          : std_logic_vector( 3 downto 0);

  signal crc_gen_reset           : std_logic;
  signal crc_gen                 : std_logic;
  signal crc_data                : std_logic_vector(15 downto 0);
  signal i_MII_RX_D_fail         : std_logic;
  signal PacketLength_bytes      : std_logic_vector(9 downto 0);

  -- state machine state defintions
  type   MII_DATACHECK_STATE_TYPE is (
              IDLE, SYNC_BYTE_DETECT_ST1, SYNC_BYTE_DETECT_ST2, OLD_ADDR_ST, 
              OLD_LENGTH_ST, DATA_ST, CRC_ST, WAIT_FOR_LINE_IDLE_ST);

  signal MII_DATACHECK_STATE    : MII_DATACHECK_STATE_TYPE;

begin

  MII_RX_D_fail       <= i_MII_RX_D_fail;

                       -- Packet Length in nibbles
  PacketLength_nibble <= (PacketLength_bytes & '0');

--------------------------------------------------------------------------------
  -- CRC Generater
---------1---------2---------3---------4---------5---------6---------7---------8
  CRC_GEN_INST : entity work.CRC16x4_Generator
    port map(
      rst           => crc_gen_reset,
      clk           => MII_RX_CLK,
      clk_en        => MII_RX_EN,
      data_in       => MII_RX_D,
      crc_en        => crc_gen,
      crc_out       => crc_data
    );

  -----------------------------------------------------------------------------
  -- Packet Length Incrementor
  -------1---------2---------3---------4---------5---------6---------7---------8
  PACKET_LENGTH_INCREMENTOR_PROC : process(rx_packet_end_all, reset, count_clr)
  begin
    if (reset = '1' or count_clr = '1') then
        PacketLength_bytes <= "0000000111";
    else
      if ( rising_edge(rx_packet_end_all) ) then
        PacketLength_bytes <= PacketLength_bytes; -- + '1';
      end if;
    end if;
  end process;

-----------------------------------------------------------------------------
-- Main state machine
---------1---------2---------3---------4---------5---------6---------7---------8
  MII_DATAGEN_SM : PROCESS (MII_RX_CLK, reset, count_clr)
  begin
      if ( reset = '1'  or count_clr = '1') then
        MII_DATACHECK_STATE   <= IDLE;
        Compare_nibble        <= (others => '0');
        nibble_cntr           <= (others => '0');
        byte_cntr             <= (others => '0');
        field_nibble_cntr     <= (others => '0');
        i_MII_RX_D_fail       <= '0';
        crc_gen_reset         <= '1';
        crc_gen               <= '0';
      elsif ( rising_edge(MII_RX_CLK) ) then
        CASE MII_DATACHECK_STATE    IS

        ------------------------ IDLE ----------------------------------------
          when IDLE =>
            if ( PacketStart = '1' ) then
              MII_DATACHECK_STATE   <= SYNC_BYTE_DETECT_ST1;
              Compare_nibble        <= (others => '0');
              nibble_cntr           <= (others => '0');
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_RX_D_fail       <= '0';
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
            else
              MII_DATACHECK_STATE   <= IDLE;
              Compare_nibble        <= (others => '0');
              nibble_cntr           <= (others => '0');
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_RX_D_fail       <= '0';
              crc_gen_reset         <= '1';
              crc_gen               <= '0';
            end if;

        --------------------- SYNC_BYTE_DETECT_ST1 ----------------------------------
          when SYNC_BYTE_DETECT_ST1 =>
            if (MII_RX_EN = '1') then
               MII_DATACHECK_STATE   <= SYNC_BYTE_DETECT_ST2;
               nibble_cntr           <= (others => '0');
               byte_cntr             <= (others => '0');
               field_nibble_cntr     <= (others => '0');
               crc_gen_reset         <= '0';
               crc_gen               <= '0';
               Compare_nibble  <= START_BYTE_SYMBOL(7 downto 4);
               if ( MII_RX_D   /= START_BYTE_SYMBOL(7 downto 4) ) then 
                 i_MII_RX_D_fail <= '1';
               else
                 i_MII_RX_D_fail <= '0';
               end if;
            else
              MII_DATACHECK_STATE   <= SYNC_BYTE_DETECT_ST1;
              Compare_nibble        <= Compare_nibble;
              nibble_cntr           <= nibble_cntr;
              byte_cntr             <= byte_cntr;
              field_nibble_cntr     <= field_nibble_cntr;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
              i_MII_RX_D_fail       <= i_MII_RX_D_fail;
            end if;

        --------------------- SYNC_BYTE_DETECT_ST2 ----------------------------------
          when SYNC_BYTE_DETECT_ST2 =>
            if (MII_RX_EN = '1') then
               MII_DATACHECK_STATE   <= OLD_ADDR_ST;
               nibble_cntr           <= (others => '0');
               byte_cntr             <= (others => '0');
               field_nibble_cntr     <= (others => '0');
               crc_gen_reset         <= '0';
               crc_gen               <= '0';
               Compare_nibble  <= START_BYTE_SYMBOL(3 downto 0);
               if ( MII_RX_D   /= START_BYTE_SYMBOL(3 downto 0) ) then 
                 i_MII_RX_D_fail <= '1';
               else
                 i_MII_RX_D_fail <= '0';
               end if;
            else
              MII_DATACHECK_STATE   <= SYNC_BYTE_DETECT_ST2;
              Compare_nibble        <= Compare_nibble;
              nibble_cntr           <= nibble_cntr;
              byte_cntr             <= byte_cntr;
              field_nibble_cntr     <= field_nibble_cntr;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
              i_MII_RX_D_fail       <= i_MII_RX_D_fail;
            end if;

        --------------------- OLD_ADDR_ST ----------------------------------
          when OLD_ADDR_ST =>
            if (MII_RX_EN = '1') then
                if ( nibble_cntr < OLD_ADDR_END_NIBBLE ) then
                  MII_DATACHECK_STATE   <= OLD_ADDR_ST;
                  nibble_cntr           <= nibble_cntr + '1';
                  byte_cntr             <= (others => '0');
                  field_nibble_cntr     <= field_nibble_cntr + '1';
                  crc_gen_reset         <= '0';
                  crc_gen               <= '1';
                  CASE field_nibble_cntr IS
                    when x"0" =>
                      Compare_nibble    <= x"0"; 
                      if ( MII_RX_D     /= x"0" ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when x"1" =>
                      Compare_nibble    <= "00" & Consumer_Address(9 downto 8);
                      if ( MII_RX_D     /= "00" & Consumer_Address(9 downto 8) ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when x"2" =>
                      Compare_nibble    <= Consumer_Address(7 downto 4);
                      if ( MII_RX_D     /= Consumer_Address(7 downto 4) ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when others =>
                      null;
                  end case;
                else
                  MII_DATACHECK_STATE   <= OLD_LENGTH_ST;
                  nibble_cntr           <= nibble_cntr + '1';
                  byte_cntr             <= (others => '0');
                  field_nibble_cntr     <= (others => '0');
                  Compare_nibble  <= Consumer_Address(3 downto 0);
                  if ( MII_RX_D    /= Consumer_Address(3 downto 0) ) then
                    i_MII_RX_D_fail <= '1';
                  else
                    i_MII_RX_D_fail <= '0';
                  end if;
                  crc_gen_reset         <= '0';
                  crc_gen               <= '1';
                end if;
            else
              Compare_nibble        <= Compare_nibble;
              nibble_cntr           <= nibble_cntr;
              byte_cntr             <= byte_cntr;
              field_nibble_cntr     <= field_nibble_cntr;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
              i_MII_RX_D_fail       <= i_MII_RX_D_fail;
            end if;

        --------------------- OLD_LENGTH_ST ----------------------------------
          when OLD_LENGTH_ST =>
            if (MII_RX_EN = '1') then
                if ( nibble_cntr < OLD_LENGTH_END_NIBBLE ) then
                  MII_DATACHECK_STATE   <= OLD_LENGTH_ST;
                  nibble_cntr           <= nibble_cntr + '1';
                  field_nibble_cntr     <= field_nibble_cntr + '1';
                  byte_cntr             <= (others => '0');
                  crc_gen_reset         <= '0';
                  crc_gen               <= '1';
                  CASE field_nibble_cntr IS
                    when x"0" =>
                      Compare_nibble    <= "0000" ;
                      if ( MII_RX_D         /= "0000" ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when x"1" =>
                      Compare_nibble        <= "00" & PacketLength_bytes(9 downto 8);
                      if (MII_RX_D          /= "00" & PacketLength_bytes(9 downto 8) ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when x"2" =>
                      Compare_nibble    <= PacketLength_bytes(7 downto 4);
                      if ( MII_RX_D     /= PacketLength_bytes(7 downto 4) ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when others =>
                      null;
                  end case;
                else
                  MII_DATACHECK_STATE   <= DATA_ST;
                  nibble_cntr           <= nibble_cntr + '1';
                  byte_cntr             <= byte_cntr;
                  field_nibble_cntr     <= (others => '0');
                  Compare_nibble    <= PacketLength_bytes(3 downto 0);
                  if ( MII_RX_D     /= PacketLength_bytes(3 downto 0) ) then
                    i_MII_RX_D_fail <= '1';
                  else
                    i_MII_RX_D_fail <= '0';
                  end if;
                  crc_gen_reset         <= '0';
                  crc_gen               <= '1';
              end if;
            else
              MII_DATACHECK_STATE   <= OLD_LENGTH_ST;
              Compare_nibble        <= Compare_nibble;
              nibble_cntr           <= nibble_cntr;
              byte_cntr             <= byte_cntr;
              field_nibble_cntr     <= field_nibble_cntr;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
              i_MII_RX_D_fail       <= i_MII_RX_D_fail;
            end if;

        --------------------- DATA_ST ----------------------------------
          when DATA_ST =>
            if (MII_RX_EN = '1') then
                if ( nibble_cntr <= (PacketLength_nibble - "100") ) then
                  MII_DATACHECK_STATE   <= DATA_ST;
                  nibble_cntr           <= nibble_cntr + '1';
                  byte_cntr             <= byte_cntr + '1';
                  field_nibble_cntr     <= field_nibble_cntr + '1';
                  crc_gen_reset         <= '0';
                  crc_gen               <= '1';
                  CASE field_nibble_cntr(0) IS
                    when '0' =>
                      Compare_nibble    <= byte_cntr(8 downto 5);
                      if ( MII_RX_D     /= byte_cntr(8 downto 5) ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when '1' =>
                      Compare_nibble    <= byte_cntr(4 downto 1);
                      if ( MII_RX_D     /= byte_cntr(4 downto 1)) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when others =>
                      null;
                  end case;
                else
                  MII_DATACHECK_STATE   <= CRC_ST;
                  Compare_nibble        <= Compare_nibble;
                  nibble_cntr           <= nibble_cntr + '1';
                  byte_cntr             <= (others => '0');
                  field_nibble_cntr     <= (others => '0');
                      Compare_nibble    <= byte_cntr(4 downto 1);
                      if ( MII_RX_D     /= byte_cntr(4 downto 1) ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                  crc_gen_reset         <= '0';
                  crc_gen               <= '0';
                end if;
            else
              Compare_nibble        <= (others => '0');
              nibble_cntr           <= nibble_cntr;
              byte_cntr             <= byte_cntr;
              field_nibble_cntr     <= field_nibble_cntr;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
              i_MII_RX_D_fail       <= i_MII_RX_D_fail;
            end if;

        --------------------- CRC_ST ----------------------------------
          when CRC_ST =>
            if (MII_RX_EN = '1') then
                if ( nibble_cntr <= (PacketLength_nibble - '1') ) then
                  MII_DATACHECK_STATE   <= CRC_ST;
                  Compare_nibble        <= (others => '0');
                  nibble_cntr           <= nibble_cntr + '1';
                  byte_cntr             <= (others => '0');
                  field_nibble_cntr     <= field_nibble_cntr + '1';
                  crc_gen_reset         <= '0';
                  crc_gen               <= '0';
                  i_MII_RX_D_fail       <= i_MII_RX_D_fail;
                  CASE field_nibble_cntr(1 downto 0) IS
                    when "00" =>
                      if ( MII_RX_D /= x"C" ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when "01" =>
                      if ( MII_RX_D /= x"8" ) then
                        i_MII_RX_D_fail <= '1';
                       else
                         i_MII_RX_D_fail <= '0';
                      end if;
                    when "10" =>
                      if ( MII_RX_D /= x"1" ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when "11" =>
                      if ( MII_RX_D /= x"5" ) then
                        i_MII_RX_D_fail <= '1';
                      else
                        i_MII_RX_D_fail <= '0';
                      end if;
                    when others =>
                      null;
                  end case;
                else
                  MII_DATACHECK_STATE   <= WAIT_FOR_LINE_IDLE_ST;
                  Compare_nibble        <= (others => '0');
                  nibble_cntr           <= (others => '0');
                  byte_cntr             <= (others => '0');
                  i_MII_RX_D_fail       <= i_MII_RX_D_fail;
                  field_nibble_cntr     <= (others => '0');
                  crc_gen_reset         <= '1';
                  crc_gen               <= '0';
                end if;
            else
              Compare_nibble        <= (others => '0');
              nibble_cntr           <= nibble_cntr;
              byte_cntr             <= byte_cntr;
              field_nibble_cntr     <= field_nibble_cntr;
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
              i_MII_RX_D_fail       <= i_MII_RX_D_fail;
            end if;

        --------------------- WAIT_FOR_LINE_IDLE_ST ----------------------------------
          when WAIT_FOR_LINE_IDLE_ST =>
            if ( idle_line = '1' ) then
              MII_DATACHECK_STATE   <= IDLE;
              Compare_nibble        <= (others => '0');
              nibble_cntr           <= (others => '0');
              byte_cntr             <= (others => '0');
              field_nibble_cntr     <= (others => '0');
              i_MII_RX_D_fail       <= i_MII_RX_D_fail;
              crc_gen_reset         <= '1';
              crc_gen               <= '0';
            else
              MII_DATACHECK_STATE   <= WAIT_FOR_LINE_IDLE_ST;
              Compare_nibble        <= (others => '0');
              nibble_cntr           <= (others => '0');
              byte_cntr             <= (others => '0');
              i_MII_RX_D_fail       <= i_MII_RX_D_fail;
              field_nibble_cntr     <= (others => '0');
              crc_gen_reset         <= '1';
              crc_gen               <= '0';
            end if;

         ----------------------- OTHERS ---------------------------------------
          when others =>
              MII_DATACHECK_STATE   <= IDLE;
              Compare_nibble        <= (others => '0');
              nibble_cntr           <= (others => '0');
              byte_cntr             <= (others => '0');
              i_MII_RX_D_fail       <= '0';
              field_nibble_cntr     <= (others => '0');
              crc_gen_reset         <= '0';
              crc_gen               <= '0';
        end case;
      end if;
  end process;

end Behavioral;
