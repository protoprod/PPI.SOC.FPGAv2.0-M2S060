-------------------------------------------------------------------------------
-- Copyright (C) 2009 OutputLogic.com
-- This source file may be used and distributed without restriction
-- provided that this copyright statement is not removed from the file
-- and that any derivative work contains the original copyright notice
-- and the associated disclaimer.
-- 
-- THIS SOURCE FILE IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS
-- OR IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
-- WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
-------------------------------------------------------------------------------
-- CRC module for data(3:0)
--   lfsr(15:0)=1+x^2+x^15+x^16;
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity CRC16x4_Generator is
  port ( 
    rst     : in std_logic; 
    clk     : in std_logic;
    clk_en  : in std_logic;
    data_in : in std_logic_vector (3 downto 0);
    crc_en  : in std_logic; 
    crc_out : out std_logic_vector (15 downto 0));
end CRC16x4_Generator;

architecture imp_crc of CRC16x4_Generator is
  signal lfsr_q: std_logic_vector (15 downto 0);
  signal lfsr_c: std_logic_vector (15 downto 0);
begin
    crc_out <= lfsr_q;

    lfsr_c(0) <= lfsr_q(12) xor lfsr_q(13) xor lfsr_q(14) xor lfsr_q(15) xor data_in(0) xor data_in(1) xor data_in(2) xor data_in(3);
    lfsr_c(1) <= lfsr_q(13) xor lfsr_q(14) xor lfsr_q(15) xor data_in(1) xor data_in(2) xor data_in(3);
    lfsr_c(2) <= lfsr_q(12) xor lfsr_q(13) xor data_in(0) xor data_in(1);
    lfsr_c(3) <= lfsr_q(13) xor lfsr_q(14) xor data_in(1) xor data_in(2);
    lfsr_c(4) <= lfsr_q(0) xor lfsr_q(14) xor lfsr_q(15) xor data_in(2) xor data_in(3);
    lfsr_c(5) <= lfsr_q(1) xor lfsr_q(15) xor data_in(3);
    lfsr_c(6) <= lfsr_q(2);
    lfsr_c(7) <= lfsr_q(3);
    lfsr_c(8) <= lfsr_q(4);
    lfsr_c(9) <= lfsr_q(5);
    lfsr_c(10) <= lfsr_q(6);
    lfsr_c(11) <= lfsr_q(7);
    lfsr_c(12) <= lfsr_q(8);
    lfsr_c(13) <= lfsr_q(9);
    lfsr_c(14) <= lfsr_q(10);
    lfsr_c(15) <= lfsr_q(11) xor lfsr_q(12) xor lfsr_q(13) xor lfsr_q(14) xor lfsr_q(15) xor data_in(0) xor data_in(1) xor data_in(2) xor data_in(3);


    process (clk,clk_en, rst) begin
      if (rst = '1') then
        lfsr_q <= b"1111111111111111";
      elsif ( rising_edge(clk) and clk_en = '1' ) then
        if (crc_en = '1') then
          lfsr_q <= lfsr_c;
        end if;
      end if;
    end process;
end architecture imp_crc; 