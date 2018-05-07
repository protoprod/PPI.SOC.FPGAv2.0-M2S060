project -load C:/Users/gcallsen/Documents/Projects/FPGA/1v6_Linux_4KLA_Lost_packets081317/synthesis/m2s010_som_syn.prj
puts "Generating SRS instrumentation file: C:\Users\gcallsen\Documents\Projects\FPGA\1v6_Linux_4KLA_Lost_packets081317\synthesis\rev_2_NoImplement\instr_sources\syn_dics.v"
 if { [catch {write instrumentation} err] } {
    puts stderr "write instrumentation failed $err"
    exit 9
}
