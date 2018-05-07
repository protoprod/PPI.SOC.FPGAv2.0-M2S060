-- Version: v11.7 SP3 11.7.3.8

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity AFE_RX_SM is

    port( RX_FIFO_DIN       : in    std_logic_vector(7 downto 0);
          manches_in_dly    : in    std_logic_vector(1 downto 0);
          reset             : in    std_logic;
          clk               : in    std_logic;
          RX_FIFO_Empty     : in    std_logic;
          sample            : in    std_logic;
          idle_line         : in    std_logic;
          rx_packet_end     : in    std_logic;
          clk1x_enable      : out   std_logic;
          packet_avail      : out   std_logic;
          rx_packet_avail   : out   std_logic;
          rx_packet_end_all : out   std_logic;
          RX_EarlyTerm      : in    std_logic
        );

end AFE_RX_SM;

architecture DEF_ARCH of AFE_RX_SM is 

  component CFG4
    generic (INIT:std_logic_vector(15 downto 0) := x"0000");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          D : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CFG3
    generic (INIT:std_logic_vector(7 downto 0) := x"00");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          C : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component SLE
    port( D   : in    std_logic := 'U';
          CLK : in    std_logic := 'U';
          EN  : in    std_logic := 'U';
          ALn : in    std_logic := 'U';
          ADn : in    std_logic := 'U';
          SLn : in    std_logic := 'U';
          SD  : in    std_logic := 'U';
          LAT : in    std_logic := 'U';
          Q   : out   std_logic
        );
  end component;

  component INBUF
    generic (IOSTD:string := "");

    port( PAD : in    std_logic := 'U';
          Y   : out   std_logic
        );
  end component;

  component CFG2
    generic (INIT:std_logic_vector(3 downto 0) := x"0");

    port( A : in    std_logic := 'U';
          B : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component CLKINT
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component VCC
    port( Y : out   std_logic
        );
  end component;

  component OUTBUF
    generic (IOSTD:string := "");

    port( D   : in    std_logic := 'U';
          PAD : out   std_logic
        );
  end component;

  component GND
    port( Y : out   std_logic
        );
  end component;

  component CFG1
    generic (INIT:std_logic_vector(1 downto 0) := "00");

    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

    signal \start_bit_cntr[2]_net_1\, \start_bit_cntr[3]_net_1\, 
        \start_bit_mask\, VCC_net_1, GND_net_1, \RX_EarlyTerm_s\, 
        \AFE_RX_STATE[2]_net_1\, \AFE_RX_STATE[0]_net_1\, 
        \AFE_RX_STATE[3]_net_1\, \AFE_RX_STATE[4]_net_1\, 
        \start_bit_cntr[0]_net_1\, \start_bit_cntr[1]_net_1\, 
        \AFE_RX_SM.un1_rx_fifo_din_net_1\, 
        \AFE_RX_SM.clk1x_enable_6\, \AFE_RX_STATE_ns[2]_net_1\, 
        \AFE_RX_STATE_ns[4]_net_1\, 
        \AFE_RX_SM.irx_packet_end_all_4\, \AFE_RX_STATE_ns[1]\, 
        \AFE_RX_STATE_ns[3]\, N_89, N_100, reset_c, clk_c, 
        \RX_FIFO_DIN_c[0]\, \RX_FIFO_DIN_c[1]\, 
        \RX_FIFO_DIN_c[2]\, \RX_FIFO_DIN_c[3]\, 
        \RX_FIFO_DIN_c[4]\, \RX_FIFO_DIN_c[5]\, 
        \RX_FIFO_DIN_c[6]\, \RX_FIFO_DIN_c[7]\, 
        \manches_in_dly_c[0]\, \manches_in_dly_c[1]\, sample_c, 
        idle_line_c, RX_EarlyTerm_c, clk1x_enable_c, 
        packet_avail_c, rx_packet_avail_c, rx_packet_end_all_c, 
        N_17, N_19, N_20, \AFE_RX_STATE_ns_i_a4_0_0[0]\, 
        start_bit_masks, \AFE_RX_SM.un1_rx_fifo_din_4_net_1\, 
        \AFE_RX_SM.un1_rx_fifo_din_5_net_1\, 
        \start_bit_cntrc_0_1\, start_bit_cntrc_i_0, 
        start_bit_cntrc_0_i_0, start_bit_cntrc_1_i_0, 
        start_bit_cntrc_2_i_0, N_84_i_0, N_78_i_0, reset_c_i, 
        \clk_ibuf\ : std_logic;

begin 


    start_bit_cntrc_i : CFG4
      generic map(INIT => x"2223")

      port map(A => N_17, B => \start_bit_cntrc_0_1\, C => 
        \start_bit_cntr[3]_net_1\, D => \start_bit_cntr[2]_net_1\, 
        Y => start_bit_cntrc_i_0);
    
    \AFE_RX_SM.clk1x_enable_6_0_o4\ : CFG3
      generic map(INIT => x"FE")

      port map(A => \AFE_RX_STATE[2]_net_1\, B => packet_avail_c, 
        C => \AFE_RX_STATE[3]_net_1\, Y => N_89);
    
    \start_bit_cntr_0_i_o2_0[3]\ : CFG3
      generic map(INIT => x"7F")

      port map(A => \start_bit_cntr[0]_net_1\, B => sample_c, C
         => \start_bit_cntr[1]_net_1\, Y => N_17);
    
    \start_bit_cntr_0_i_o2[0]\ : CFG3
      generic map(INIT => x"FB")

      port map(A => \start_bit_cntr[2]_net_1\, B => 
        \start_bit_cntr[1]_net_1\, C => \start_bit_cntr[3]_net_1\, 
        Y => N_19);
    
    \start_bit_cntr[2]\ : SLE
      port map(D => start_bit_cntrc_0_i_0, CLK => clk_c, EN => 
        VCC_net_1, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        reset_c_i, SD => GND_net_1, LAT => GND_net_1, Q => 
        \start_bit_cntr[2]_net_1\);
    
    \manches_in_dly_ibuf[1]\ : INBUF
      port map(PAD => manches_in_dly(1), Y => 
        \manches_in_dly_c[1]\);
    
    \manches_in_dly_ibuf[0]\ : INBUF
      port map(PAD => manches_in_dly(0), Y => 
        \manches_in_dly_c[0]\);
    
    \AFE_RX_STATE[3]\ : SLE
      port map(D => \AFE_RX_STATE_ns[1]\, CLK => clk_c, EN => 
        VCC_net_1, ALn => reset_c_i, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \AFE_RX_STATE[3]_net_1\);
    
    \RX_FIFO_DIN_ibuf[1]\ : INBUF
      port map(PAD => RX_FIFO_DIN(1), Y => \RX_FIFO_DIN_c[1]\);
    
    \AFE_RX_SM.clk1x_enable_6_0_a4_0_0\ : CFG2
      generic map(INIT => x"2")

      port map(A => \manches_in_dly_c[0]\, B => 
        \manches_in_dly_c[1]\, Y => \AFE_RX_STATE_ns_i_a4_0_0[0]\);
    
    start_bit_cntrc_2_i : CFG4
      generic map(INIT => x"006E")

      port map(A => \start_bit_cntr[0]_net_1\, B => sample_c, C
         => N_19, D => rx_packet_end_all_c, Y => 
        start_bit_cntrc_2_i_0);
    
    clk_ibuf_RNIVTI2 : CLKINT
      port map(A => \clk_ibuf\, Y => clk_c);
    
    RX_EarlyTerm_ibuf : INBUF
      port map(PAD => RX_EarlyTerm, Y => RX_EarlyTerm_c);
    
    rx_packet_avail_RNO : CFG3
      generic map(INIT => x"E0")

      port map(A => \AFE_RX_STATE[2]_net_1\, B => packet_avail_c, 
        C => idle_line_c, Y => N_84_i_0);
    
    \AFE_RX_STATE_ns[2]\ : CFG4
      generic map(INIT => x"4454")

      port map(A => idle_line_c, B => \AFE_RX_STATE[3]_net_1\, C
         => \AFE_RX_STATE[2]_net_1\, D => 
        \AFE_RX_SM.un1_rx_fifo_din_net_1\, Y => 
        \AFE_RX_STATE_ns[2]_net_1\);
    
    \AFE_RX_SM.un1_rx_fifo_din_4\ : CFG4
      generic map(INIT => x"0200")

      port map(A => \RX_FIFO_DIN_c[7]\, B => \RX_FIFO_DIN_c[2]\, 
        C => \RX_FIFO_DIN_c[1]\, D => \RX_FIFO_DIN_c[0]\, Y => 
        \AFE_RX_SM.un1_rx_fifo_din_4_net_1\);
    
    \RX_FIFO_DIN_ibuf[3]\ : INBUF
      port map(PAD => RX_FIFO_DIN(3), Y => \RX_FIFO_DIN_c[3]\);
    
    \AFE_RX_STATE_ns_a4[3]\ : CFG4
      generic map(INIT => x"3230")

      port map(A => \AFE_RX_STATE[2]_net_1\, B => idle_line_c, C
         => N_100, D => \AFE_RX_SM.un1_rx_fifo_din_net_1\, Y => 
        \AFE_RX_STATE_ns[3]\);
    
    start_bit_cntrc_1_i : CFG4
      generic map(INIT => x"0A06")

      port map(A => \start_bit_cntr[3]_net_1\, B => 
        \start_bit_cntr[2]_net_1\, C => rx_packet_end_all_c, D
         => N_17, Y => start_bit_cntrc_1_i_0);
    
    \VCC\ : VCC
      port map(Y => VCC_net_1);
    
    \AFE_RX_SM.irx_packet_end_all_4_0_a4\ : CFG2
      generic map(INIT => x"4")

      port map(A => \AFE_RX_STATE[4]_net_1\, B => idle_line_c, Y
         => \AFE_RX_SM.irx_packet_end_all_4\);
    
    \START_BIT_COUNTER_PROC.un1_sample_i_a2\ : CFG4
      generic map(INIT => x"1000")

      port map(A => \start_bit_cntr[2]_net_1\, B => 
        \start_bit_cntr[3]_net_1\, C => \start_bit_cntr[1]_net_1\, 
        D => \start_bit_cntr[0]_net_1\, Y => N_20);
    
    \RX_FIFO_DIN_ibuf[7]\ : INBUF
      port map(PAD => RX_FIFO_DIN(7), Y => \RX_FIFO_DIN_c[7]\);
    
    \start_bit_cntr[3]\ : SLE
      port map(D => start_bit_cntrc_1_i_0, CLK => clk_c, EN => 
        VCC_net_1, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        reset_c_i, SD => GND_net_1, LAT => GND_net_1, Q => 
        \start_bit_cntr[3]_net_1\);
    
    idle_line_ibuf : INBUF
      port map(PAD => idle_line, Y => idle_line_c);
    
    sample_ibuf : INBUF
      port map(PAD => sample, Y => sample_c);
    
    \AFE_RX_STATE_ns_a3[3]\ : CFG2
      generic map(INIT => x"2")

      port map(A => packet_avail_c, B => \RX_EarlyTerm_s\, Y => 
        N_100);
    
    \AFE_RX_STATE[1]\ : SLE
      port map(D => \AFE_RX_STATE_ns[3]\, CLK => clk_c, EN => 
        VCC_net_1, ALn => reset_c_i, ADn => VCC_net_1, SLn => 
        VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        packet_avail_c);
    
    \rx_packet_avail\ : SLE
      port map(D => N_84_i_0, CLK => clk_c, EN => VCC_net_1, ALn
         => reset_c_i, ADn => VCC_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => rx_packet_avail_c);
    
    \RX_FIFO_DIN_ibuf[0]\ : INBUF
      port map(PAD => RX_FIFO_DIN(0), Y => \RX_FIFO_DIN_c[0]\);
    
    packet_avail_obuf : OUTBUF
      port map(D => packet_avail_c, PAD => packet_avail);
    
    \AFE_RX_STATE[4]\ : SLE
      port map(D => N_78_i_0, CLK => clk_c, EN => VCC_net_1, ALn
         => reset_c_i, ADn => GND_net_1, SLn => VCC_net_1, SD => 
        GND_net_1, LAT => GND_net_1, Q => \AFE_RX_STATE[4]_net_1\);
    
    rx_packet_avail_obuf : OUTBUF
      port map(D => rx_packet_avail_c, PAD => rx_packet_avail);
    
    \GND\ : GND
      port map(Y => GND_net_1);
    
    \start_bit_cntr[0]\ : SLE
      port map(D => start_bit_cntrc_2_i_0, CLK => clk_c, EN => 
        VCC_net_1, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        reset_c_i, SD => GND_net_1, LAT => GND_net_1, Q => 
        \start_bit_cntr[0]_net_1\);
    
    \RX_FIFO_DIN_ibuf[6]\ : INBUF
      port map(PAD => RX_FIFO_DIN(6), Y => \RX_FIFO_DIN_c[6]\);
    
    RX_EarlyTerm_s : SLE
      port map(D => RX_EarlyTerm_c, CLK => clk_c, EN => VCC_net_1, 
        ALn => VCC_net_1, ADn => VCC_net_1, SLn => reset_c_i, SD
         => GND_net_1, LAT => GND_net_1, Q => \RX_EarlyTerm_s\);
    
    \AFE_RX_SM.clk1x_enable_6_0\ : CFG4
      generic map(INIT => x"FF3A")

      port map(A => \AFE_RX_STATE_ns_i_a4_0_0[0]\, B => 
        idle_line_c, C => N_89, D => \AFE_RX_STATE[0]_net_1\, Y
         => \AFE_RX_SM.clk1x_enable_6\);
    
    \start_bit_cntr[1]\ : SLE
      port map(D => start_bit_cntrc_i_0, CLK => clk_c, EN => 
        VCC_net_1, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        reset_c_i, SD => GND_net_1, LAT => GND_net_1, Q => 
        \start_bit_cntr[1]_net_1\);
    
    \AFE_RX_STATE_RNO[4]\ : CFG4
      generic map(INIT => x"BFB0")

      port map(A => \manches_in_dly_c[1]\, B => 
        \manches_in_dly_c[0]\, C => \AFE_RX_STATE[4]_net_1\, D
         => idle_line_c, Y => N_78_i_0);
    
    \AFE_RX_STATE[0]\ : SLE
      port map(D => \AFE_RX_STATE_ns[4]_net_1\, CLK => clk_c, EN
         => VCC_net_1, ALn => reset_c_i, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \AFE_RX_STATE[0]_net_1\);
    
    reset_ibuf_RNI8255 : CFG1
      generic map(INIT => "01")

      port map(A => reset_c, Y => reset_c_i);
    
    \AFE_RX_SM.un1_rx_fifo_din\ : CFG3
      generic map(INIT => x"08")

      port map(A => \AFE_RX_SM.un1_rx_fifo_din_4_net_1\, B => 
        \AFE_RX_SM.un1_rx_fifo_din_5_net_1\, C => 
        \start_bit_mask\, Y => \AFE_RX_SM.un1_rx_fifo_din_net_1\);
    
    \RX_FIFO_DIN_ibuf[4]\ : INBUF
      port map(PAD => RX_FIFO_DIN(4), Y => \RX_FIFO_DIN_c[4]\);
    
    clk1x_enable_obuf : OUTBUF
      port map(D => clk1x_enable_c, PAD => clk1x_enable);
    
    \AFE_RX_SM.un1_rx_fifo_din_5\ : CFG4
      generic map(INIT => x"0001")

      port map(A => \RX_FIFO_DIN_c[6]\, B => \RX_FIFO_DIN_c[5]\, 
        C => \RX_FIFO_DIN_c[4]\, D => \RX_FIFO_DIN_c[3]\, Y => 
        \AFE_RX_SM.un1_rx_fifo_din_5_net_1\);
    
    start_bit_cntrc_0_i : CFG4
      generic map(INIT => x"0C02")

      port map(A => \start_bit_cntr[3]_net_1\, B => 
        \start_bit_cntr[2]_net_1\, C => rx_packet_end_all_c, D
         => N_17, Y => start_bit_cntrc_0_i_0);
    
    rx_packet_end_all_obuf : OUTBUF
      port map(D => rx_packet_end_all_c, PAD => rx_packet_end_all);
    
    \RX_FIFO_DIN_ibuf[5]\ : INBUF
      port map(PAD => RX_FIFO_DIN(5), Y => \RX_FIFO_DIN_c[5]\);
    
    \RX_FIFO_DIN_ibuf[2]\ : INBUF
      port map(PAD => RX_FIFO_DIN(2), Y => \RX_FIFO_DIN_c[2]\);
    
    \AFE_RX_STATE_ns[4]\ : CFG4
      generic map(INIT => x"0E0A")

      port map(A => \AFE_RX_STATE[0]_net_1\, B => packet_avail_c, 
        C => idle_line_c, D => \RX_EarlyTerm_s\, Y => 
        \AFE_RX_STATE_ns[4]_net_1\);
    
    \AFE_RX_STATE_ns_i_a4_0[0]\ : CFG3
      generic map(INIT => x"20")

      port map(A => \manches_in_dly_c[0]\, B => 
        \manches_in_dly_c[1]\, C => \AFE_RX_STATE[4]_net_1\, Y
         => \AFE_RX_STATE_ns[1]\);
    
    start_bit_masksr : CFG4
      generic map(INIT => x"FF2E")

      port map(A => \start_bit_mask\, B => sample_c, C => N_20, D
         => rx_packet_end_all_c, Y => start_bit_masks);
    
    reset_ibuf : INBUF
      port map(PAD => reset, Y => reset_c);
    
    irx_packet_end_all : SLE
      port map(D => \AFE_RX_SM.irx_packet_end_all_4\, CLK => 
        clk_c, EN => VCC_net_1, ALn => reset_c_i, ADn => 
        VCC_net_1, SLn => VCC_net_1, SD => GND_net_1, LAT => 
        GND_net_1, Q => rx_packet_end_all_c);
    
    \AFE_RX_STATE[2]\ : SLE
      port map(D => \AFE_RX_STATE_ns[2]_net_1\, CLK => clk_c, EN
         => VCC_net_1, ALn => reset_c_i, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        \AFE_RX_STATE[2]_net_1\);
    
    start_bit_mask : SLE
      port map(D => start_bit_masks, CLK => clk_c, EN => 
        VCC_net_1, ALn => VCC_net_1, ADn => VCC_net_1, SLn => 
        reset_c_i, SD => VCC_net_1, LAT => GND_net_1, Q => 
        \start_bit_mask\);
    
    start_bit_cntrc_0_1 : CFG4
      generic map(INIT => x"F1F5")

      port map(A => \start_bit_cntr[1]_net_1\, B => sample_c, C
         => rx_packet_end_all_c, D => \start_bit_cntr[0]_net_1\, 
        Y => \start_bit_cntrc_0_1\);
    
    clk_ibuf : INBUF
      port map(PAD => clk, Y => \clk_ibuf\);
    
    \clk1x_enable\ : SLE
      port map(D => \AFE_RX_SM.clk1x_enable_6\, CLK => clk_c, EN
         => VCC_net_1, ALn => reset_c_i, ADn => VCC_net_1, SLn
         => VCC_net_1, SD => GND_net_1, LAT => GND_net_1, Q => 
        clk1x_enable_c);
    

end DEF_ARCH; 
