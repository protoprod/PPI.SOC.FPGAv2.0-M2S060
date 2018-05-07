project -load C:/PULSAR/Projects/PPI/PoweredRail/Common_Module_SOC/CommonModule_Rev1_5Common/synthesis/m2s010_som_syn.prj
puts "Generating SRS instrumenttion to file C:\PULSAR\Projects\PPI\PoweredRail\Common_Module_SOC\CommonModule_Rev1_5Common\synthesis\synthesis_1\instr_sources\syn_dics.v"
 if { [catch {write instrumentation} err] } {
    puts stderr "write instrumentation failed $err"
    exit 9
}
