open_project -project {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som_fp\m2s010_som.pro}\
         -connect_programmers {FALSE}
if { [catch {load_programming_data \
    -name {M2S060T} \
    -fpga {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.map} \
    -header {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.hdr} \
    -envm {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.efc}  \
    -spm {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.spm} \
    -dca {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.dca} } return_val] } {
save_project
close_project
exit }
export_single_stapl \
    -name {M2S060T} \
    -file {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\export\m2s010_somm2s060-v0xD-SEPII-uBoot_M2S060T.stp} \
    -secured
set_programming_file -name {M2S060T} -no_file
save_project
close_project
