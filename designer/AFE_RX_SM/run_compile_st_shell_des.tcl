set_device \
    -family  SmartFusion2 \
    -die     PA4M6000 \
    -package fcs325 \
    -speed   STD \
    -tempr   {IND} \
    -voltr   {IND}
set_def {VOLTAGE} {1.2}
set_def {VCCI_1.2_VOLTR} {COM}
set_def {VCCI_1.5_VOLTR} {COM}
set_def {VCCI_1.8_VOLTR} {COM}
set_def {VCCI_2.5_VOLTR} {COM}
set_def {VCCI_3.3_VOLTR} {COM}
set_def USE_TCGEN 1
set_def NETLIST_TYPE EDIF
set_name AFE_RX_SM
set_workdir {C:\work\IRail\PPI.IRail.SoC.FPGA\designer\AFE_RX_SM}
set_log     {C:\work\IRail\PPI.IRail.SoC.FPGA\designer\AFE_RX_SM\AFE_RX_SM_sdc.log}
set_design_state pre_layout
