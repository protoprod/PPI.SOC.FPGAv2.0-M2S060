-- Version: v11.8 SP2 11.8.2.4

library ieee;
use ieee.std_logic_1164.all;
library smartfusion2;
use smartfusion2.all;

entity CLOCK_DOMAIN_BUFFER_CLOCK_DOMAIN_BUFFER_0_USRAM_top is

    port( A_DOUT        : out   std_logic_vector(3 downto 0);
          B_DOUT        : out   std_logic_vector(3 downto 0);
          C_DIN         : in    std_logic_vector(7 downto 0);
          A_ADDR        : in    std_logic_vector(6 downto 0);
          B_ADDR        : in    std_logic_vector(6 downto 0);
          C_ADDR        : in    std_logic_vector(5 downto 0);
          A_BLK         : in    std_logic;
          B_BLK         : in    std_logic;
          C_BLK         : in    std_logic;
          A_ADDR_ARST_N : in    std_logic;
          B_ADDR_ARST_N : in    std_logic;
          A_ADDR_SRST_N : in    std_logic;
          B_ADDR_SRST_N : in    std_logic;
          A_ADDR_EN     : in    std_logic;
          B_ADDR_EN     : in    std_logic;
          A_CLK         : in    std_logic;
          B_CLK         : in    std_logic;
          C_CLK         : in    std_logic;
          C_WEN         : in    std_logic
        );

end CLOCK_DOMAIN_BUFFER_CLOCK_DOMAIN_BUFFER_0_USRAM_top;

architecture DEF_ARCH of 
        CLOCK_DOMAIN_BUFFER_CLOCK_DOMAIN_BUFFER_0_USRAM_top is 

  component INV
    port( A : in    std_logic := 'U';
          Y : out   std_logic
        );
  end component;

  component RAM64x18
    generic (MEMORYFILE:string := "");

    port( A_DOUT        : out   std_logic_vector(17 downto 0);
          B_DOUT        : out   std_logic_vector(17 downto 0);
          BUSY          : out   std_logic;
          A_ADDR_CLK    : in    std_logic := 'U';
          A_DOUT_CLK    : in    std_logic := 'U';
          A_ADDR_SRST_N : in    std_logic := 'U';
          A_DOUT_SRST_N : in    std_logic := 'U';
          A_ADDR_ARST_N : in    std_logic := 'U';
          A_DOUT_ARST_N : in    std_logic := 'U';
          A_ADDR_EN     : in    std_logic := 'U';
          A_DOUT_EN     : in    std_logic := 'U';
          A_BLK         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_ADDR        : in    std_logic_vector(9 downto 0) := (others => 'U');
          B_ADDR_CLK    : in    std_logic := 'U';
          B_DOUT_CLK    : in    std_logic := 'U';
          B_ADDR_SRST_N : in    std_logic := 'U';
          B_DOUT_SRST_N : in    std_logic := 'U';
          B_ADDR_ARST_N : in    std_logic := 'U';
          B_DOUT_ARST_N : in    std_logic := 'U';
          B_ADDR_EN     : in    std_logic := 'U';
          B_DOUT_EN     : in    std_logic := 'U';
          B_BLK         : in    std_logic_vector(1 downto 0) := (others => 'U');
          B_ADDR        : in    std_logic_vector(9 downto 0) := (others => 'U');
          C_CLK         : in    std_logic := 'U';
          C_ADDR        : in    std_logic_vector(9 downto 0) := (others => 'U');
          C_DIN         : in    std_logic_vector(17 downto 0) := (others => 'U');
          C_WEN         : in    std_logic := 'U';
          C_BLK         : in    std_logic_vector(1 downto 0) := (others => 'U');
          A_EN          : in    std_logic := 'U';
          A_ADDR_LAT    : in    std_logic := 'U';
          A_DOUT_LAT    : in    std_logic := 'U';
          A_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          B_EN          : in    std_logic := 'U';
          B_ADDR_LAT    : in    std_logic := 'U';
          B_DOUT_LAT    : in    std_logic := 'U';
          B_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          C_EN          : in    std_logic := 'U';
          C_WIDTH       : in    std_logic_vector(2 downto 0) := (others => 'U');
          SII_LOCK      : in    std_logic := 'U'
        );
  end component;

  component GND
    port(Y : out std_logic); 
  end component;

  component VCC
    port(Y : out std_logic); 
  end component;

    signal ARSTADDRAP, ARSTADDRBP, SRSTADDRAP, SRSTADDRBP, \VCC\, 
        \GND\, ADLIB_VCC : std_logic;
    signal GND_power_net1 : std_logic;
    signal VCC_power_net1 : std_logic;
    signal nc24, nc1, nc8, nc13, nc16, nc19, nc25, nc20, nc27, 
        nc9, nc22, nc28, nc14, nc5, nc21, nc15, nc3, nc10, nc7, 
        nc17, nc4, nc12, nc2, nc23, nc18, nc26, nc6, nc11
         : std_logic;

begin 

    \GND\ <= GND_power_net1;
    \VCC\ <= VCC_power_net1;
    ADLIB_VCC <= VCC_power_net1;

    INVARSTADDRAP : INV
      port map(A => A_ADDR_ARST_N, Y => ARSTADDRAP);
    
    CLOCK_DOMAIN_BUFFER_CLOCK_DOMAIN_BUFFER_0_USRAM_top_R0C0 : 
        RAM64x18
      port map(A_DOUT(17) => nc24, A_DOUT(16) => nc1, A_DOUT(15)
         => nc8, A_DOUT(14) => nc13, A_DOUT(13) => nc16, 
        A_DOUT(12) => nc19, A_DOUT(11) => nc25, A_DOUT(10) => 
        nc20, A_DOUT(9) => nc27, A_DOUT(8) => nc9, A_DOUT(7) => 
        nc22, A_DOUT(6) => nc28, A_DOUT(5) => nc14, A_DOUT(4) => 
        nc5, A_DOUT(3) => A_DOUT(3), A_DOUT(2) => A_DOUT(2), 
        A_DOUT(1) => A_DOUT(1), A_DOUT(0) => A_DOUT(0), 
        B_DOUT(17) => nc21, B_DOUT(16) => nc15, B_DOUT(15) => nc3, 
        B_DOUT(14) => nc10, B_DOUT(13) => nc7, B_DOUT(12) => nc17, 
        B_DOUT(11) => nc4, B_DOUT(10) => nc12, B_DOUT(9) => nc2, 
        B_DOUT(8) => nc23, B_DOUT(7) => nc18, B_DOUT(6) => nc26, 
        B_DOUT(5) => nc6, B_DOUT(4) => nc11, B_DOUT(3) => 
        B_DOUT(3), B_DOUT(2) => B_DOUT(2), B_DOUT(1) => B_DOUT(1), 
        B_DOUT(0) => B_DOUT(0), BUSY => OPEN, A_ADDR_CLK => A_CLK, 
        A_DOUT_CLK => \VCC\, A_ADDR_SRST_N => SRSTADDRAP, 
        A_DOUT_SRST_N => \VCC\, A_ADDR_ARST_N => ARSTADDRAP, 
        A_DOUT_ARST_N => \VCC\, A_ADDR_EN => A_ADDR_EN, A_DOUT_EN
         => \VCC\, A_BLK(1) => A_BLK, A_BLK(0) => \VCC\, 
        A_ADDR(9) => \GND\, A_ADDR(8) => A_ADDR(6), A_ADDR(7) => 
        A_ADDR(5), A_ADDR(6) => A_ADDR(4), A_ADDR(5) => A_ADDR(3), 
        A_ADDR(4) => A_ADDR(2), A_ADDR(3) => A_ADDR(1), A_ADDR(2)
         => A_ADDR(0), A_ADDR(1) => \GND\, A_ADDR(0) => \GND\, 
        B_ADDR_CLK => B_CLK, B_DOUT_CLK => \VCC\, B_ADDR_SRST_N
         => SRSTADDRBP, B_DOUT_SRST_N => \VCC\, B_ADDR_ARST_N => 
        ARSTADDRBP, B_DOUT_ARST_N => \VCC\, B_ADDR_EN => 
        B_ADDR_EN, B_DOUT_EN => \VCC\, B_BLK(1) => B_BLK, 
        B_BLK(0) => \VCC\, B_ADDR(9) => \GND\, B_ADDR(8) => 
        B_ADDR(6), B_ADDR(7) => B_ADDR(5), B_ADDR(6) => B_ADDR(4), 
        B_ADDR(5) => B_ADDR(3), B_ADDR(4) => B_ADDR(2), B_ADDR(3)
         => B_ADDR(1), B_ADDR(2) => B_ADDR(0), B_ADDR(1) => \GND\, 
        B_ADDR(0) => \GND\, C_CLK => C_CLK, C_ADDR(9) => \GND\, 
        C_ADDR(8) => C_ADDR(5), C_ADDR(7) => C_ADDR(4), C_ADDR(6)
         => C_ADDR(3), C_ADDR(5) => C_ADDR(2), C_ADDR(4) => 
        C_ADDR(1), C_ADDR(3) => C_ADDR(0), C_ADDR(2) => \GND\, 
        C_ADDR(1) => \GND\, C_ADDR(0) => \GND\, C_DIN(17) => 
        \GND\, C_DIN(16) => \GND\, C_DIN(15) => \GND\, C_DIN(14)
         => \GND\, C_DIN(13) => \GND\, C_DIN(12) => \GND\, 
        C_DIN(11) => \GND\, C_DIN(10) => \GND\, C_DIN(9) => \GND\, 
        C_DIN(8) => \GND\, C_DIN(7) => C_DIN(7), C_DIN(6) => 
        C_DIN(6), C_DIN(5) => C_DIN(5), C_DIN(4) => C_DIN(4), 
        C_DIN(3) => C_DIN(3), C_DIN(2) => C_DIN(2), C_DIN(1) => 
        C_DIN(1), C_DIN(0) => C_DIN(0), C_WEN => C_WEN, C_BLK(1)
         => C_BLK, C_BLK(0) => \VCC\, A_EN => \VCC\, A_ADDR_LAT
         => \GND\, A_DOUT_LAT => \VCC\, A_WIDTH(2) => \GND\, 
        A_WIDTH(1) => \VCC\, A_WIDTH(0) => \GND\, B_EN => \VCC\, 
        B_ADDR_LAT => \GND\, B_DOUT_LAT => \VCC\, B_WIDTH(2) => 
        \GND\, B_WIDTH(1) => \VCC\, B_WIDTH(0) => \GND\, C_EN => 
        \VCC\, C_WIDTH(2) => \GND\, C_WIDTH(1) => \VCC\, 
        C_WIDTH(0) => \VCC\, SII_LOCK => \GND\);
    
    INVSRSTADDRBP : INV
      port map(A => B_ADDR_SRST_N, Y => SRSTADDRBP);
    
    INVARSTADDRBP : INV
      port map(A => B_ADDR_ARST_N, Y => ARSTADDRBP);
    
    INVSRSTADDRAP : INV
      port map(A => A_ADDR_SRST_N, Y => SRSTADDRAP);
    
    GND_power_inst1 : GND
      port map( Y => GND_power_net1);

    VCC_power_inst1 : VCC
      port map( Y => VCC_power_net1);


end DEF_ARCH; 
