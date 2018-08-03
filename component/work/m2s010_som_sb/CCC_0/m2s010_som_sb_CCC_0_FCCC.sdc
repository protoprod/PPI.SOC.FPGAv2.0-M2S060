set_component m2s010_som_sb_CCC_0_FCCC
# Microsemi Corp.
# Date: 2018-Jul-30 14:34:52
#

create_clock -period 50 [ get_pins { CCC_INST/XTLOSC } ]
create_generated_clock -multiply_by 71 -divide_by 20 -source [ get_pins { CCC_INST/XTLOSC } ] -phase 0 [ get_pins { CCC_INST/GL0 } ]
