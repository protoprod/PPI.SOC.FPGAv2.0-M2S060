set_component m2s010_som_sb_MSS
# Microsemi Corp.
# Date: 2019-Feb-04 09:45:23
#

create_clock -period 28.169 [ get_pins { MSS_ADLIB_INST/CLK_CONFIG_APB } ]
set_false_path -ignore_errors -through [ get_pins { MSS_ADLIB_INST/CONFIG_PRESET_N } ]
