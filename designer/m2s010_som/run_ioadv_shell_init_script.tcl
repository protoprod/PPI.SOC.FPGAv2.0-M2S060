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
set_def {PLL_SUPPLY} {PLL_SUPPLY_25}
set_netlist -afl {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.afl} -adl {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.adl}
set_constraints   {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.tcml}
set_placement   {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.loc}
set_routing     {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.seg}
