----------------------------------------------------------------------
-- Created by SmartDesign Thu Mar 08 10:28:50 2018
-- Version: v11.8 SP2 11.8.2.4
----------------------------------------------------------------------

----------------------------------------------------------------------
-- Libraries
----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

library smartfusion2;
use smartfusion2.all;
library COREFIFO_LIB;
use COREFIFO_LIB.all;
----------------------------------------------------------------------
-- CLOCK_DOMAIN_BUFFER entity declaration
----------------------------------------------------------------------
entity CLOCK_DOMAIN_BUFFER is
    -- Port list
    port(
        -- Inputs
        DATA      : in  std_logic_vector(7 downto 0);
        RCLOCK    : in  std_logic;
        RE        : in  std_logic;
        RESET     : in  std_logic;
        WCLOCK    : in  std_logic;
        WE        : in  std_logic;
        -- Outputs
        AEMPTY    : out std_logic;
        DVLD      : out std_logic;
        EMPTY     : out std_logic;
        FULL      : out std_logic;
        OVERFLOW  : out std_logic;
        Q         : out std_logic_vector(3 downto 0);
        UNDERFLOW : out std_logic
        );
end CLOCK_DOMAIN_BUFFER;
----------------------------------------------------------------------
-- CLOCK_DOMAIN_BUFFER architecture body
----------------------------------------------------------------------
architecture RTL of CLOCK_DOMAIN_BUFFER is
----------------------------------------------------------------------
-- Component declarations
----------------------------------------------------------------------
-- CLOCK_DOMAIN_BUFFER_CLOCK_DOMAIN_BUFFER_0_COREFIFO   -   Actel:DirectCore:COREFIFO:2.6.108
component CLOCK_DOMAIN_BUFFER_CLOCK_DOMAIN_BUFFER_0_COREFIFO
    generic( 
        AE_STATIC_EN   : integer := 1 ;
        AEVAL          : integer := 2 ;
        AF_STATIC_EN   : integer := 0 ;
        AFVAL          : integer := 60 ;
        CTRL_TYPE      : integer := 3 ;
        ECC            : integer := 0 ;
        ESTOP          : integer := 1 ;
        FAMILY         : integer := 19 ;
        FSTOP          : integer := 1 ;
        FWFT           : integer := 0 ;
        OVERFLOW_EN    : integer := 1 ;
        PIPE           : integer := 1 ;
        PREFETCH       : integer := 0 ;
        RCLK_EDGE      : integer := 1 ;
        RDCNT_EN       : integer := 0 ;
        RDEPTH         : integer := 128 ;
        RE_POLARITY    : integer := 0 ;
        READ_DVALID    : integer := 1 ;
        RESET_POLARITY : integer := 1 ;
        RWIDTH         : integer := 4 ;
        SYNC           : integer := 0 ;
        UNDERFLOW_EN   : integer := 1 ;
        WCLK_EDGE      : integer := 1 ;
        WDEPTH         : integer := 64 ;
        WE_POLARITY    : integer := 0 ;
        WRCNT_EN       : integer := 0 ;
        WRITE_ACK      : integer := 0 ;
        WWIDTH         : integer := 8 
        );
    -- Port list
    port(
        -- Inputs
        CLK        : in  std_logic;
        DATA       : in  std_logic_vector(7 downto 0);
        MEMRD      : in  std_logic_vector(3 downto 0);
        RCLOCK     : in  std_logic;
        RE         : in  std_logic;
        RESET      : in  std_logic;
        WCLOCK     : in  std_logic;
        WE         : in  std_logic;
        -- Outputs
        AEMPTY     : out std_logic;
        AFULL      : out std_logic;
        DB_DETECT  : out std_logic;
        DVLD       : out std_logic;
        EMPTY      : out std_logic;
        FULL       : out std_logic;
        MEMRADDR   : out std_logic_vector(6 downto 0);
        MEMRE      : out std_logic;
        MEMWADDR   : out std_logic_vector(5 downto 0);
        MEMWD      : out std_logic_vector(7 downto 0);
        MEMWE      : out std_logic;
        OVERFLOW   : out std_logic;
        Q          : out std_logic_vector(3 downto 0);
        RDCNT      : out std_logic_vector(7 downto 0);
        SB_CORRECT : out std_logic;
        UNDERFLOW  : out std_logic;
        WACK       : out std_logic;
        WRCNT      : out std_logic_vector(6 downto 0)
        );
end component;
----------------------------------------------------------------------
-- Signal declarations
----------------------------------------------------------------------
signal AEMPTY_net_0    : std_logic;
signal DVLD_net_0      : std_logic;
signal EMPTY_net_0     : std_logic;
signal FULL_net_0      : std_logic;
signal OVERFLOW_net_0  : std_logic;
signal Q_2             : std_logic_vector(3 downto 0);
signal UNDERFLOW_net_0 : std_logic;
signal FULL_net_1      : std_logic;
signal EMPTY_net_1     : std_logic;
signal OVERFLOW_net_1  : std_logic;
signal UNDERFLOW_net_1 : std_logic;
signal DVLD_net_1      : std_logic;
signal Q_2_net_0       : std_logic_vector(3 downto 0);
signal AEMPTY_net_1    : std_logic;
----------------------------------------------------------------------
-- TiedOff Signals
----------------------------------------------------------------------
signal GND_net         : std_logic;
signal MEMRD_const_net_0: std_logic_vector(3 downto 0);

begin
----------------------------------------------------------------------
-- Constant assignments
----------------------------------------------------------------------
 GND_net           <= '0';
 MEMRD_const_net_0 <= B"0000";
----------------------------------------------------------------------
-- Top level output port assignments
----------------------------------------------------------------------
 FULL_net_1      <= FULL_net_0;
 FULL            <= FULL_net_1;
 EMPTY_net_1     <= EMPTY_net_0;
 EMPTY           <= EMPTY_net_1;
 OVERFLOW_net_1  <= OVERFLOW_net_0;
 OVERFLOW        <= OVERFLOW_net_1;
 UNDERFLOW_net_1 <= UNDERFLOW_net_0;
 UNDERFLOW       <= UNDERFLOW_net_1;
 DVLD_net_1      <= DVLD_net_0;
 DVLD            <= DVLD_net_1;
 Q_2_net_0       <= Q_2;
 Q(3 downto 0)   <= Q_2_net_0;
 AEMPTY_net_1    <= AEMPTY_net_0;
 AEMPTY          <= AEMPTY_net_1;
----------------------------------------------------------------------
-- Component instances
----------------------------------------------------------------------
-- CLOCK_DOMAIN_BUFFER_0   -   Actel:DirectCore:COREFIFO:2.6.108
CLOCK_DOMAIN_BUFFER_0 : CLOCK_DOMAIN_BUFFER_CLOCK_DOMAIN_BUFFER_0_COREFIFO
    generic map( 
        AE_STATIC_EN   => ( 1 ),
        AEVAL          => ( 2 ),
        AF_STATIC_EN   => ( 0 ),
        AFVAL          => ( 60 ),
        CTRL_TYPE      => ( 3 ),
        ECC            => ( 0 ),
        ESTOP          => ( 1 ),
        FAMILY         => ( 19 ),
        FSTOP          => ( 1 ),
        FWFT           => ( 0 ),
        OVERFLOW_EN    => ( 1 ),
        PIPE           => ( 1 ),
        PREFETCH       => ( 0 ),
        RCLK_EDGE      => ( 1 ),
        RDCNT_EN       => ( 0 ),
        RDEPTH         => ( 128 ),
        RE_POLARITY    => ( 0 ),
        READ_DVALID    => ( 1 ),
        RESET_POLARITY => ( 1 ),
        RWIDTH         => ( 4 ),
        SYNC           => ( 0 ),
        UNDERFLOW_EN   => ( 1 ),
        WCLK_EDGE      => ( 1 ),
        WDEPTH         => ( 64 ),
        WE_POLARITY    => ( 0 ),
        WRCNT_EN       => ( 0 ),
        WRITE_ACK      => ( 0 ),
        WWIDTH         => ( 8 )
        )
    port map( 
        -- Inputs
        CLK        => GND_net, -- tied to '0' from definition
        WCLOCK     => WCLOCK,
        RCLOCK     => RCLOCK,
        RESET      => RESET,
        WE         => WE,
        RE         => RE,
        DATA       => DATA,
        MEMRD      => MEMRD_const_net_0, -- tied to X"0" from definition
        -- Outputs
        FULL       => FULL_net_0,
        EMPTY      => EMPTY_net_0,
        AFULL      => OPEN,
        AEMPTY     => AEMPTY_net_0,
        OVERFLOW   => OVERFLOW_net_0,
        UNDERFLOW  => UNDERFLOW_net_0,
        WACK       => OPEN,
        DVLD       => DVLD_net_0,
        MEMWE      => OPEN,
        MEMRE      => OPEN,
        SB_CORRECT => OPEN,
        DB_DETECT  => OPEN,
        Q          => Q_2,
        WRCNT      => OPEN,
        RDCNT      => OPEN,
        MEMWADDR   => OPEN,
        MEMRADDR   => OPEN,
        MEMWD      => OPEN 
        );

end RTL;
