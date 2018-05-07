device jtagport builtin
iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 4096

signals add -iice {IICE} -silent -trigger -sample  {/d_mdc}\
{/d_txd}\
{/d_txen}\
{/manch_out_n}\
{/manchester_in}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/clkdiv}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/clock_adjust}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/imanches_in_dly}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/inrz_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/isampler_clk1x_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/s2p_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/i_start_bit_mask}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/rx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/rx_center_sample}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/rx_s2p}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/NIBBLE_TO_SERIAL_SM_INST/behavioral/tx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/NIBBLE_TO_SERIAL_SM_INST/collision_detect_s}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/bit_clk}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/manchester_out}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/mii_tx_d}\
{/rtl/CommsFPGA_top_0/behavioral/MDIO_SLAVE_INST/pmad_mdi}\
{/rtl/CommsFPGA_top_0/behavioral/MDIO_SLAVE_INST/translated/mdio_output}\
{/rtl/CommsFPGA_top_0/behavioral/MDIO_SLAVE_INST/translated/mdio_output_enable}\
{/rtl/CommsFPGA_top_0/behavioral/Phy_Mux_Inst/f_mdo}\
{/rtl/CommsFPGA_top_0/behavioral/Phy_Mux_Inst/f_mdo_en}\
{/rtl/CommsFPGA_top_0/behavioral/Phy_Mux_Inst/mac_mii_mdi}\
{/rtl/CommsFPGA_top_0/behavioral/f_txen}\
{/rtl/CommsFPGA_top_0/behavioral/tx_enable}\
{/rtl/CommsFPGA_top_0/manch_out_p}\
{/rtl/m2s010_som_sb_0/mac_mii_col}\
{/rtl/m2s010_som_sb_0/mac_mii_crs}\
{/rtl/m2s010_som_sb_0/mac_mii_mdc}\
{/rtl/m2s010_som_sb_0/mac_mii_mdi}\
{/rtl/m2s010_som_sb_0/mac_mii_mdo}\
{/rtl/m2s010_som_sb_0/mac_mii_mdo_en}\
{/rtl/m2s010_som_sb_0/mac_mii_rx_clk}\
{/rtl/m2s010_som_sb_0/mac_mii_rx_dv}\
{/rtl/m2s010_som_sb_0/mac_mii_rx_er}\
{/rtl/m2s010_som_sb_0/mac_mii_rxd}\
{/rtl/m2s010_som_sb_0/mac_mii_tx_en}\
{/rtl/m2s010_som_sb_0/mac_mii_txd}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/clk16x}

