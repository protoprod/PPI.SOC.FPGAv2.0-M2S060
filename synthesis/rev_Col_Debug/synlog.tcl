project -load C:/Users/gcallsen/Documents/Projects/FPGA/v1_6-082217/synthesis/m2s010_som_syn.prj
puts "Generating SRS instrumentation file: C:\Users\gcallsen\Documents\Projects\FPGA\v1_6-082217\synthesis\rev_Col_Debug\instr_sources\syn_dics.v"
 if { [catch {write instrumentation} err] } {
    puts stderr "write instrumentation failed $err"
    exit 9
}
