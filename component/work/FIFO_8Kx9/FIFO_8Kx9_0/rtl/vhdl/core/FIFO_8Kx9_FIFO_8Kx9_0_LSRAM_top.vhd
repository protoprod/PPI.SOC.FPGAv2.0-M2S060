-- Version: v11.8 11.8.0.26

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity FIFO_8Kx9_FIFO_8Kx9_0_LSRAM_top is

    port( WD    : in    std_logic_vector(8 downto 0);
          RD    : out   std_logic_vector(8 downto 0);
          WADDR : in    std_logic_vector(10 downto 0);
          RADDR : in    std_logic_vector(10 downto 0);
          WEN   : in    std_logic;
          REN   : in    std_logic;
          WCLK  : in    std_logic;
          RCLK  : in    std_logic
        );

end FIFO_8Kx9_FIFO_8Kx9_0_LSRAM_top;

architecture DEF_ARCH of FIFO_8Kx9_FIFO_8Kx9_0_LSRAM_top is 

  component RAM1K18
    generic (MEMORYFILE:string := "");

    port( A_DOUT        : out   std_logic_vector(17 downto 0);
          B_DOUT        : out   std_logic_vector(17 downto 0);
          BUSY          : out   std_logic;
          A_CLK         : in    std_logic := 'U';
          A_DOUT_CLK    : in    std_logic := 'U';
          A_ARST_N      : in    std_logic := 'U';
          A_DOUT_EN     : in    std_logic := 'U';
          A_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          A_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          A_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          A_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_CLK         : in    std_logic := 'U';
          B_DOUT_CLK    : in    std_logic := 'U';
          B_ARST_N      : in    std_logic := 'U';
          B_DOUT_EN     : in    std_logic := 'U';
          B_BLK         : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          B_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          B_ADDR        : in    std_logic_vector(13 downto 0) := (others => 'U');
          B_WEN         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_EN          : in    std_logic := 'U';
          A_DOUT_LAT    : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          A_WMODE       : in    std_logic := 'U';
          B_EN          : in    std_logic := 'U';
          B_DOUT_LAT    : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_WMODE       : in    std_logic := 'U';
          SII_LOCK      : in    std_logic := 'U'
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal \VCC\, \GND\, ADLIB_VCC : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;
    signal nc24, nc1, nc8, nc13, nc16, nc19, nc25, nc20, nc27, 
        nc9, nc22, nc14, nc5, nc21, nc15, nc3, nc10, nc7, nc17, 
        nc4, nc12, nc2, nc23, nc18, nc26, nc6, nc11 : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    FIFO_8Kx9_FIFO_8Kx9_0_LSRAM_top_R0C0 : RAM1K18
      port map(A_DOUT(17) => nc24, A_DOUT(16) => nc1, A_DOUT(15)
         => nc8, A_DOUT(14) => nc13, A_DOUT(13) => nc16, 
        A_DOUT(12) => nc19, A_DOUT(11) => nc25, A_DOUT(10) => 
        nc20, A_DOUT(9) => nc27, A_DOUT(8) => RD(8), A_DOUT(7)
         => RD(7), A_DOUT(6) => RD(6), A_DOUT(5) => RD(5), 
        A_DOUT(4) => RD(4), A_DOUT(3) => RD(3), A_DOUT(2) => 
        RD(2), A_DOUT(1) => RD(1), A_DOUT(0) => RD(0), B_DOUT(17)
         => nc9, B_DOUT(16) => nc22, B_DOUT(15) => nc14, 
        B_DOUT(14) => nc5, B_DOUT(13) => nc21, B_DOUT(12) => nc15, 
        B_DOUT(11) => nc3, B_DOUT(10) => nc10, B_DOUT(9) => nc7, 
        B_DOUT(8) => nc17, B_DOUT(7) => nc4, B_DOUT(6) => nc12, 
        B_DOUT(5) => nc2, B_DOUT(4) => nc23, B_DOUT(3) => nc18, 
        B_DOUT(2) => nc26, B_DOUT(1) => nc6, B_DOUT(0) => nc11, 
        BUSY => OPEN, A_CLK => RCLK, A_DOUT_CLK => \VCC\, 
        A_ARST_N => \VCC\, A_DOUT_EN => \VCC\, A_BLK(2) => REN, 
        A_BLK(1) => \VCC\, A_BLK(0) => \VCC\, A_DOUT_ARST_N => 
        \VCC\, A_DOUT_SRST_N => \VCC\, A_DIN(17) => \GND\, 
        A_DIN(16) => \GND\, A_DIN(15) => \GND\, A_DIN(14) => 
        \GND\, A_DIN(13) => \GND\, A_DIN(12) => \GND\, A_DIN(11)
         => \GND\, A_DIN(10) => \GND\, A_DIN(9) => \GND\, 
        A_DIN(8) => \GND\, A_DIN(7) => \GND\, A_DIN(6) => \GND\, 
        A_DIN(5) => \GND\, A_DIN(4) => \GND\, A_DIN(3) => \GND\, 
        A_DIN(2) => \GND\, A_DIN(1) => \GND\, A_DIN(0) => \GND\, 
        A_ADDR(13) => RADDR(10), A_ADDR(12) => RADDR(9), 
        A_ADDR(11) => RADDR(8), A_ADDR(10) => RADDR(7), A_ADDR(9)
         => RADDR(6), A_ADDR(8) => RADDR(5), A_ADDR(7) => 
        RADDR(4), A_ADDR(6) => RADDR(3), A_ADDR(5) => RADDR(2), 
        A_ADDR(4) => RADDR(1), A_ADDR(3) => RADDR(0), A_ADDR(2)
         => \GND\, A_ADDR(1) => \GND\, A_ADDR(0) => \GND\, 
        A_WEN(1) => \GND\, A_WEN(0) => \GND\, B_CLK => WCLK, 
        B_DOUT_CLK => \VCC\, B_ARST_N => \VCC\, B_DOUT_EN => 
        \VCC\, B_BLK(2) => WEN, B_BLK(1) => \VCC\, B_BLK(0) => 
        \VCC\, B_DOUT_ARST_N => \GND\, B_DOUT_SRST_N => \VCC\, 
        B_DIN(17) => \GND\, B_DIN(16) => \GND\, B_DIN(15) => 
        \GND\, B_DIN(14) => \GND\, B_DIN(13) => \GND\, B_DIN(12)
         => \GND\, B_DIN(11) => \GND\, B_DIN(10) => \GND\, 
        B_DIN(9) => \GND\, B_DIN(8) => WD(8), B_DIN(7) => WD(7), 
        B_DIN(6) => WD(6), B_DIN(5) => WD(5), B_DIN(4) => WD(4), 
        B_DIN(3) => WD(3), B_DIN(2) => WD(2), B_DIN(1) => WD(1), 
        B_DIN(0) => WD(0), B_ADDR(13) => WADDR(10), B_ADDR(12)
         => WADDR(9), B_ADDR(11) => WADDR(8), B_ADDR(10) => 
        WADDR(7), B_ADDR(9) => WADDR(6), B_ADDR(8) => WADDR(5), 
        B_ADDR(7) => WADDR(4), B_ADDR(6) => WADDR(3), B_ADDR(5)
         => WADDR(2), B_ADDR(4) => WADDR(1), B_ADDR(3) => 
        WADDR(0), B_ADDR(2) => \GND\, B_ADDR(1) => \GND\, 
        B_ADDR(0) => \GND\, B_WEN(1) => \GND\, B_WEN(0) => \VCC\, 
        A_EN => \VCC\, A_DOUT_LAT => \VCC\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \VCC\, A_WMODE => 
        \GND\, B_EN => \VCC\, B_DOUT_LAT => \VCC\, B_WIDTH(2) => 
        \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \VCC\, B_WMODE
         => \GND\, SII_LOCK => \GND\);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
