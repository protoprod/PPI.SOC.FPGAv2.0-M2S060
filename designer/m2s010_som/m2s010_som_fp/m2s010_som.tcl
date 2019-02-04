open_project -project {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som_fp\m2s010_som.pro}
set_programming_file -name {M2S060T} -file {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0-M2S060\designer\m2s010_som\m2s010_som.ipd}
enable_device -name {M2S060T} -enable 1
set_programming_action -action {PROGRAM} -name {M2S060T} 
run_selected_actions
set_programming_file -name {M2S060T} -no_file
save_project
close_project
