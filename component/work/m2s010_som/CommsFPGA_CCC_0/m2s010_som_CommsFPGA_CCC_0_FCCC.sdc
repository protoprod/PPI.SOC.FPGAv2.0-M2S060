set_component m2s010_som_CommsFPGA_CCC_0_FCCC
# Microsemi Corp.
# Date: 2018-Jun-25 15:05:18
#

create_clock -period 50 [ get_pins { CCC_INST/XTLOSC } ]
create_generated_clock -multiply_by 40 -divide_by 5 -source [ get_pins { CCC_INST/XTLOSC } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
create_generated_clock -multiply_by 40 -divide_by 40 -source [ get_pins { CCC_INST/XTLOSC } ] -phase 0 [ get_pins { CCC_INST/GL1 } ]
create_generated_clock -multiply_by 40 -divide_by 16 -source [ get_pins { CCC_INST/XTLOSC } ] -phase 0 [ get_pins { CCC_INST/GL2 } ]
