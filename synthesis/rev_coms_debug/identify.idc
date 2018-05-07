device jtagport builtin
iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 8192

signals add -iice {IICE} -silent -trigger -sample  {/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/reset_all_pkt_cntrs}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/sfd_timeout}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/clk1x_enable}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/rx_packet_end_all}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/clkdiv}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/clock_adjust}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/decoder_shiftreg}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/decoder_transition}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/decoder_transition_d}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/imanches_in_dly}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/inrz_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/manches_shiftreg}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/manches_transition}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/manches_transition_d}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/cnt_sfd}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/i_rx_packet_end_all}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/i_start_bit_mask}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/missed_sfd_flag}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/rx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/clk1x_enable}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/rx_byte_valid}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/sfd_timeout}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/tx_state_idle}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/idle_line}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/irx_center_sample}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/sampler_clk1x_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/start_bit_mask}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/NIBBLE_TO_SERIAL_SM_INST/behavioral/reset_all_pkt_cntrs_d}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/NIBBLE_TO_SERIAL_SM_INST/behavioral/rs_pkt_reg}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/NIBBLE_TO_SERIAL_SM_INST/bit_clk}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/i_tx_enable}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/jabber_tx_disable}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/p2s_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/manchester_out}\
{/rtl/CommsFPGA_top_0/manch_out_p}\
{/rtl/CommsFPGA_top_0/manchester_in}\
{/rtl/m2s010_som_sb_0/mac_mii_col}\
{/rtl/m2s010_som_sb_0/mac_mii_crs}\
{/rtl/m2s010_som_sb_0/mac_mii_rx_dv}\
{/rtl/m2s010_som_sb_0/mac_mii_rxd}\
{/rtl/m2s010_som_sb_0/mac_mii_tx_en}\
{/rtl/m2s010_som_sb_0/mac_mii_txd}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/clk16x}

