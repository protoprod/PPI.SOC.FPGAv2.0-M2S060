project -load C:/Users/gcallsen/Documents/Projects/FPGA/v1_6-082417-DebugCol/synthesis/m2s010_som_syn.prj
puts "Generating SRS instrumentation file: C:\Users\gcallsen\Documents\Projects\FPGA\v1_6-082417-DebugCol\synthesis\rev_debug1\instr_sources\syn_dics.v"
 if { [catch {write instrumentation} err] } {
    puts stderr "write instrumentation failed $err"
    exit 9
}
