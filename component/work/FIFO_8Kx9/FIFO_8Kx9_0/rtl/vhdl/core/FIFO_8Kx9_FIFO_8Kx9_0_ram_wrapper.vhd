-- This is automatically generated file --

LIBRARY ieee; 
  USE ieee.std_logic_1164.all; 
  USE ieee.numeric_std.all; 
  

ENTITY FIFO_8Kx9_FIFO_8Kx9_0_ram_wrapper IS 
  GENERIC( RWIDTH    : integer := 18;   
           WWIDTH    : integer := 18;   
           RDEPTH    : integer := 1024; 
           WDEPTH    : integer :=1024;  
           SYNC      : integer :=0;     
           CTRL_TYPE : integer :=1;     
           PIPE      : integer := 1 );  
  PORT( 
    WDATA  : IN std_logic_vector(WWIDTH -1 downto 0); 
    WADDR  : IN std_logic_vector(WDEPTH -1 downto 0); 
    WEN    : IN std_logic; 
    REN    : IN std_logic; 
    RDATA  : OUT std_logic_vector(RWIDTH -1 downto 0); 
    RADDR  : IN std_logic_vector(RDEPTH -1 downto 0); 
    RESET_N: IN std_logic; 
    CLOCK  : IN std_logic; 
    RCLOCK : IN std_logic; 
A_SB_CORRECT         : OUT std_logic;   
B_SB_CORRECT         : OUT std_logic;   
A_DB_DETECT          : OUT std_logic;   
B_DB_DETECT          : OUT std_logic;   
    WCLOCK : IN std_logic 
  ); 
END FIFO_8Kx9_FIFO_8Kx9_0_ram_wrapper; 

ARCHITECTURE generated OF FIFO_8Kx9_FIFO_8Kx9_0_ram_wrapper IS 

COMPONENT FIFO_8Kx9_FIFO_8Kx9_0_LSRAM_top
PORT (
WD                      : IN std_logic_vector(WWIDTH-1 DOWNTO 0);   
RD                      : OUT std_logic_vector(RWIDTH-1 DOWNTO 0);   
WADDR                   : IN std_logic_vector(WDEPTH-1 DOWNTO 0);   
RADDR                   : IN std_logic_vector(RDEPTH-1 DOWNTO 0);   
WEN                     : IN std_logic;   
REN                     : IN std_logic;   
WCLK                    : IN std_logic;   
RCLK                    : IN std_logic);  
END COMPONENT;
SIGNAL RDATA_xhdl1              :  std_logic_vector(RWIDTH - 1 DOWNTO 0);   

BEGIN 

RDATA <= RDATA_xhdl1;

L1_asyncnonpipe : FIFO_8Kx9_FIFO_8Kx9_0_LSRAM_top 
PORT MAP (
WD    => WDATA,      
WADDR => WADDR,      
WEN   => WEN,        
WCLK  => WCLOCK,     
RD    => RDATA_xhdl1,
RADDR => RADDR,      
REN   => REN,        
RCLK  => RCLOCK);    


END ARCHITECTURE generated;
