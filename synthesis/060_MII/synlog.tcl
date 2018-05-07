project -load C:/Users/gcallsen/Documents/GitHubBF/PPI.SOC.FPGAv2.0/synthesis/m2s010_som_syn.prj
puts "Generating SRS instrumentation file: C:\Users\gcallsen\Documents\GitHubBF\PPI.SOC.FPGAv2.0\synthesis\060_MII\instr_sources\syn_dics.v"
 if { [catch {write instrumentation} err] } {
    puts stderr "write instrumentation failed $err"
    exit 9
}
