project -load C:/Users/gcallsen/Documents/Projects/FPGA/081817-1v6-Linux-Debug-Ident/synthesis/m2s010_som_syn.prj
puts "Generating SRS instrumentation file: C:\Users\gcallsen\Documents\Projects\FPGA\081817-1v6-Linux-Debug-Ident\synthesis\rev_debug\instr_sources\syn_dics.v"
 if { [catch {write instrumentation} err] } {
    puts stderr "write instrumentation failed $err"
    exit 9
}
