# The JTAG clocks in the instrumentation logic need timing constraints
define_clock   {n:ident_coreinst.comm_block_INST.tck} -period 1000.0 -clockgroup identify_jtag_group1
define_clock   {n:ident_coreinst.comm_block_INST.dr2_tck} -period 1000.0 -clockgroup identify_jtag_group1
