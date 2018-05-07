# Written by Synplify Pro version map201609actrcp1, Build 005R. Synopsys Run ID: sid1521569700 
# Top Level Design Parameters 

# Clocks 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_sb_MSS|FIC_2_APB_M_PCLK_inferred_clock} [get_pins {m2s010_som_sb_0/m2s010_som_sb_MSS_0/MSS_ADLIB_INST:CLK_CONFIG_APB}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_sb_CCC_0_FCCC|GL0_net_inferred_clock} [get_pins {m2s010_som_sb_0/CCC_0/CCC_INST:GL0}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {CommsFPGA_top|ClkDivider_inferred_clock[1]} [get_pins {CommsFPGA_top_0/ClkDivider[1]:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som|I2C_0_SCL_F2M} [get_ports {I2C_0_SCL_F2M}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_CommsFPGA_CCC_0_FCCC|GL1_net_inferred_clock} [get_pins {CommsFPGA_CCC_0/CCC_INST:GL1}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {CommsFPGA_top|BIT_CLK_inferred_clock} [get_pins {CommsFPGA_top_0/BIT_CLK:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_sb_MSS|MAC_MII_MDC_inferred_clock} [get_pins {m2s010_som_sb_0/m2s010_som_sb_MSS_0/MSS_ADLIB_INST:MDCF}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_CommsFPGA_CCC_0_FCCC|GL0_net_inferred_clock} [get_pins {CommsFPGA_CCC_0/CCC_INST:GL0}] 

# Virtual Clocks 

# Generated Clocks 

# Paths Between Clocks 

# Multicycle Constraints 

# Point-to-point Delay Constraints 

# False Path Constraints 

# Output Load Constraints 

# Driving Cell Constraints 

# Input Delay Constraints 

# Output Delay Constraints 

# Wire Loads 

# Other Constraints 

# syn_hier Attributes 

# set_case Attributes 

# Clock Delay Constraints 
set Inferred_clkgroup_3 [list m2s010_som|I2C_0_SCL_F2M]
set Inferred_clkgroup_8 [list m2s010_som_CommsFPGA_CCC_0_FCCC|GL0_net_inferred_clock]
set Inferred_clkgroup_5 [list m2s010_som_CommsFPGA_CCC_0_FCCC|GL1_net_inferred_clock]
set Inferred_clkgroup_2 [list CommsFPGA_top|ClkDivider_inferred_clock\[1\]]
set Inferred_clkgroup_6 [list CommsFPGA_top|BIT_CLK_inferred_clock]
set Inferred_clkgroup_1 [list m2s010_som_sb_CCC_0_FCCC|GL0_net_inferred_clock]
set Inferred_clkgroup_0 [list m2s010_som_sb_MSS|FIC_2_APB_M_PCLK_inferred_clock]
set Inferred_clkgroup_7 [list m2s010_som_sb_MSS|MAC_MII_MDC_inferred_clock]
set_clock_groups -asynchronous -group $Inferred_clkgroup_3
set_clock_groups -asynchronous -group $Inferred_clkgroup_8
set_clock_groups -asynchronous -group $Inferred_clkgroup_5
set_clock_groups -asynchronous -group $Inferred_clkgroup_2
set_clock_groups -asynchronous -group $Inferred_clkgroup_6
set_clock_groups -asynchronous -group $Inferred_clkgroup_1
set_clock_groups -asynchronous -group $Inferred_clkgroup_0
set_clock_groups -asynchronous -group $Inferred_clkgroup_7


# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

