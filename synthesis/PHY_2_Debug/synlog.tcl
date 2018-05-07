project -load C:/Users/gcallsen/Documents/GitHubBF/PPI.SOC.FPGAv2.0/synthesis/m2s010_som_syn.prj
impl -active PHY_2_Debug
puts "Generating SRS instrumentation file: C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0\synthesis\PHY_2_Debug\instr_sources\syn_dics.v"
 if { [catch {write instrumentation} err] } {
    puts stderr "write instrumentation failed $err"
    exit 9
}
