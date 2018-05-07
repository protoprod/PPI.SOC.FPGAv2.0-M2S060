project -load C:/Users/gcallsen/Documents/Projects/FPGA/ModelSimRecovery/synthesis/m2s010_som_syn.prj
puts "Generating SRS instrumentation file: C:\Users\gcallsen\Documents\Projects\FPGA\ModelSimRecovery\synthesis\synthesis_2\instr_sources\syn_dics.v"
 if { [catch {write instrumentation} err] } {
    puts stderr "write instrumentation failed $err"
    exit 9
}
