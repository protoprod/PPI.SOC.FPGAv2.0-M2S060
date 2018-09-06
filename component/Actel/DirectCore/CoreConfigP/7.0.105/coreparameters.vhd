----------------------------------------------------------------------
-- Created by Microsemi SmartDesign Wed Sep 05 15:42:49 2018
-- Parameters for CoreConfigP
----------------------------------------------------------------------


LIBRARY ieee;
   USE ieee.std_logic_1164.all;
   USE ieee.std_logic_unsigned.all;
   USE ieee.numeric_std.all;

package coreparameters is
    constant DEVICE_090 : integer := 0;
    constant ENABLE_SOFT_RESETS : integer := 0;
    constant FDDR_IN_USE : integer := 0;
    constant MDDR_IN_USE : integer := 1;
    constant SDIF0_IN_USE : integer := 0;
    constant SDIF0_PCIE : integer := 0;
    constant SDIF1_IN_USE : integer := 0;
    constant SDIF1_PCIE : integer := 0;
    constant SDIF2_IN_USE : integer := 0;
    constant SDIF2_PCIE : integer := 0;
    constant SDIF3_IN_USE : integer := 0;
    constant SDIF3_PCIE : integer := 0;
end coreparameters;
