# Written by Synplify Pro version map201609actrcp1, Build 005R. Synopsys Run ID: sid1516301814 
# Top Level Design Parameters 

# Clocks 
create_clock -period 1000.000 -waveform {0.000 500.000} -name {ident_coreinst.comm_block_INST.dr2_tck} [get_pins {ident_coreinst/comm_block_INST/jtagi/jtag_clkint_prim:Y}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_CommsFPGA_CCC_0_FCCC|GL1_net_inferred_clock} [get_pins {CommsFPGA_CCC_0/CCC_INST:GL1}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_sb_MSS|FIC_2_APB_M_PCLK_inferred_clock} [get_pins {m2s010_som_sb_0/m2s010_som_sb_MSS_0/MSS_ADLIB_INST:CLK_CONFIG_APB}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_sb_CCC_0_FCCC|GL0_net_inferred_clock} [get_pins {m2s010_som_sb_0/CCC_0/CCC_INST:GL0}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som|D_TXC} [get_ports {D_TXC}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som|D_RXC} [get_ports {D_RXC}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {CommsFPGA_top|BIT_CLK_inferred_clock} [get_pins {CommsFPGA_top_0/BIT_CLK:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som|H_MDC} [get_ports {H_MDC}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {CommsFPGA_top|ClkDivider_inferred_clock[1]} [get_pins {CommsFPGA_top_0/ClkDivider[1]:Q}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {m2s010_som_CommsFPGA_CCC_0_FCCC|GL0_net_inferred_clock} [get_pins {CommsFPGA_CCC_0/CCC_INST:GL0}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {jtag_interface_x|identify_clk_int_inferred_clock} [get_pins {ident_coreinst/comm_block_INST/jtagi/b9_Rcmi_KsDw:UDRCK}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {jtag_interface_x|b10_8Kz_rKlrtX} [get_pins {ident_coreinst/comm_block_INST/jtagi/b10_8Kz_rKlrtX_RNO:Y}] 
create_clock -period 10.000 -waveform {0.000 5.000} -name {jtag_interface_x|b9_nv_oQwfYF} [get_pins {ident_coreinst/comm_block_INST/jtagi/b9_nv_oQwfYF_3_0_a2:Y}] 

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
set Inferred_clkgroup_4 [list m2s010_som|D_RXC]
set Inferred_clkgroup_3 [list m2s010_som|D_TXC]
set Inferred_clkgroup_7 [list m2s010_som|H_MDC]
set Inferred_clkgroup_9 [list m2s010_som_CommsFPGA_CCC_0_FCCC|GL0_net_inferred_clock]
set Inferred_clkgroup_0 [list m2s010_som_CommsFPGA_CCC_0_FCCC|GL1_net_inferred_clock]
set Inferred_clkgroup_8 [list CommsFPGA_top|ClkDivider_inferred_clock\[1\]]
set Inferred_clkgroup_6 [list CommsFPGA_top|BIT_CLK_inferred_clock]
set Inferred_clkgroup_2 [list m2s010_som_sb_CCC_0_FCCC|GL0_net_inferred_clock]
set Inferred_clkgroup_1 [list m2s010_som_sb_MSS|FIC_2_APB_M_PCLK_inferred_clock]
set Inferred_clkgroup_12 [list jtag_interface_x|b9_nv_oQwfYF]
set identify_jtag_group1 [list ident_coreinst.comm_block_INST.dr2_tck]
set Inferred_clkgroup_11 [list jtag_interface_x|b10_8Kz_rKlrtX]
set Inferred_clkgroup_10 [list jtag_interface_x|identify_clk_int_inferred_clock]
set_clock_groups -asynchronous -group $Inferred_clkgroup_4
set_clock_groups -asynchronous -group $Inferred_clkgroup_3
set_clock_groups -asynchronous -group $Inferred_clkgroup_7
set_clock_groups -asynchronous -group $Inferred_clkgroup_9
set_clock_groups -asynchronous -group $Inferred_clkgroup_0
set_clock_groups -asynchronous -group $Inferred_clkgroup_8
set_clock_groups -asynchronous -group $Inferred_clkgroup_6
set_clock_groups -asynchronous -group $Inferred_clkgroup_2
set_clock_groups -asynchronous -group $Inferred_clkgroup_1
set_clock_groups -asynchronous -group $Inferred_clkgroup_12
set_clock_groups -asynchronous -group $identify_jtag_group1
set_clock_groups -asynchronous -group $Inferred_clkgroup_11
set_clock_groups -asynchronous -group $Inferred_clkgroup_10


# syn_mode Attributes 

# Cells 

# Port DRC Rules 

# Input Transition Constraints 

# Unused constraints (intentionally commented out) 

# Non-forward-annotatable constraints (intentionally commented out) 

# Block Path constraints 

