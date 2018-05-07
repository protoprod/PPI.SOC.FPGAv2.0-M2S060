set_component m2s010_som_sb_FABOSC_0_OSC
# Microsemi Corp.
# Date: 2018-Apr-24 08:36:39
#

create_clock -ignore_errors -period 20 [ get_pins { I_RCOSC_25_50MHZ/CLKOUT } ]
create_clock -ignore_errors -period 50 [ get_pins { I_XTLOSC/CLKOUT } ]
