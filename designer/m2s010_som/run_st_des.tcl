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
set_def USE_CONSTRAINTS_FLOW 0
set_def USE_TCGEN 1
set_name m2s010_som
set_workdir {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv1.6\designer\m2s010_som}
set_design_state post_layout
