new_project \
         -name {m2s010_som} \
         -location {C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0\designer\m2s010_som\m2s010_som_fp} \
         -mode {chain} \
         -connect_programmers {FALSE}
add_actel_device \
         -device {M2S060T} \
         -name {M2S060T}
enable_device \
         -name {M2S060T} \
         -enable {TRUE}
save_project
close_project
