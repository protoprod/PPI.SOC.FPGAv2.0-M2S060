// available hyper connections - for debug and ip models
// timestamp: 1547998970


`ifndef SYN_HYPER_CONNECT
`define SYN_HYPER_CONNECT 1
module syn_hyper_connect(out) /* synthesis syn_black_box=1 syn_noprune=1 */;
parameter w = 1;
parameter tag = "xxx";
parameter dflt = 0;
parameter mustconnect = 1'b1;
output [w-1:0] out;
endmodule
`endif

module m2s010_som_hyper_debug(dummy);
input dummy; /* avoid compiler error for no ports */

wire manch_out_n_0;
syn_hyper_connect manch_out_n_connect_0(manch_out_n_0);
defparam manch_out_n_connect_0.tag = "manch_out_n";

wire manch_out_n_1;
syn_hyper_connect manch_out_n_connect_1(manch_out_n_1);
defparam manch_out_n_connect_1.tag = "CommsFPGA_top_0.manch_out_n";


wire manch_out_p_0;
syn_hyper_connect manch_out_p_connect_0(manch_out_p_0);
defparam manch_out_p_connect_0.tag = "manch_out_p";

wire manch_out_p_1;
syn_hyper_connect manch_out_p_connect_1(manch_out_p_1);
defparam manch_out_p_connect_1.tag = "CommsFPGA_top_0.manch_out_p";


wire mac_mii_col_0;
syn_hyper_connect mac_mii_col_connect_0(mac_mii_col_0);
defparam mac_mii_col_connect_0.tag = "m2s010_som_sb_0.mac_mii_col";


wire mac_mii_crs_0;
syn_hyper_connect mac_mii_crs_connect_0(mac_mii_crs_0);
defparam mac_mii_crs_connect_0.tag = "m2s010_som_sb_0.mac_mii_crs";


wire mac_mii_mdc_0;
syn_hyper_connect mac_mii_mdc_connect_0(mac_mii_mdc_0);
defparam mac_mii_mdc_connect_0.tag = "m2s010_som_sb_0.mac_mii_mdc";


wire [3:0] mac_mii_rxd_0;
syn_hyper_connect mac_mii_rxd_connect_0(mac_mii_rxd_0);
defparam mac_mii_rxd_connect_0.w = 4;
defparam mac_mii_rxd_connect_0.tag = "m2s010_som_sb_0.mac_mii_rxd";


wire mac_mii_rx_clk_0;
syn_hyper_connect mac_mii_rx_clk_connect_0(mac_mii_rx_clk_0);
defparam mac_mii_rx_clk_connect_0.tag = "m2s010_som_sb_0.mac_mii_rx_clk";


wire mac_mii_rx_dv_0;
syn_hyper_connect mac_mii_rx_dv_connect_0(mac_mii_rx_dv_0);
defparam mac_mii_rx_dv_connect_0.tag = "m2s010_som_sb_0.mac_mii_rx_dv";


wire mac_mii_rx_er_0;
syn_hyper_connect mac_mii_rx_er_connect_0(mac_mii_rx_er_0);
defparam mac_mii_rx_er_connect_0.tag = "m2s010_som_sb_0.mac_mii_rx_er";


wire [3:0] mac_mii_txd_0;
syn_hyper_connect mac_mii_txd_connect_0(mac_mii_txd_0);
defparam mac_mii_txd_connect_0.w = 4;
defparam mac_mii_txd_connect_0.tag = "m2s010_som_sb_0.mac_mii_txd";


wire mac_mii_tx_clk_0;
syn_hyper_connect mac_mii_tx_clk_connect_0(mac_mii_tx_clk_0);
defparam mac_mii_tx_clk_connect_0.tag = "m2s010_som_sb_0.mac_mii_tx_clk";


wire mac_mii_tx_en_0;
syn_hyper_connect mac_mii_tx_en_connect_0(mac_mii_tx_en_0);
defparam mac_mii_tx_en_connect_0.tag = "m2s010_som_sb_0.mac_mii_tx_en";


wire manchester_in_0;
syn_hyper_connect manchester_in_connect_0(manchester_in_0);
defparam manchester_in_connect_0.tag = "CommsFPGA_top_0.manchester_in";


wire clk16x_0;
syn_hyper_connect clk16x_connect_0(clk16x_0);
defparam clk16x_connect_0.tag = "CommsFPGA_top_0.clk16x";


wire jabber_tx_disable_0;
syn_hyper_connect jabber_tx_disable_connect_0(jabber_tx_disable_0);
defparam jabber_tx_disable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.jabber_tx_disable";


wire manchester_out_0;
syn_hyper_connect manchester_out_connect_0(manchester_out_0);
defparam manchester_out_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.manchester_out";


wire [3:0] mii_tx_d_0;
syn_hyper_connect mii_tx_d_connect_0(mii_tx_d_0);
defparam mii_tx_d_connect_0.w = 4;
defparam mii_tx_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.mii_tx_d";


wire mii_tx_en_0;
syn_hyper_connect mii_tx_en_connect_0(mii_tx_en_0);
defparam mii_tx_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.mii_tx_en";


wire tx_state_idle_0;
syn_hyper_connect tx_state_idle_connect_0(tx_state_idle_0);
defparam tx_state_idle_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.tx_state_idle";

wire tx_state_idle_1;
syn_hyper_connect tx_state_idle_connect_1(tx_state_idle_1);
defparam tx_state_idle_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.tx_state_idle";


wire i_tx_enable_0;
syn_hyper_connect i_tx_enable_connect_0(i_tx_enable_0);
defparam i_tx_enable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.i_tx_enable";


wire [3:0] p2s_data_0;
syn_hyper_connect p2s_data_connect_0(p2s_data_0);
defparam p2s_data_connect_0.w = 4;
defparam p2s_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.p2s_data";


wire [5:0] tx_state_0;
syn_hyper_connect tx_state_connect_0(tx_state_0);
defparam tx_state_connect_0.w = 6;
defparam tx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.NIBBLE_TO_SERIAL_SM_INST.tx_state";


wire bit_clk_0;
syn_hyper_connect bit_clk_connect_0(bit_clk_0);
defparam bit_clk_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.NIBBLE_TO_SERIAL_SM_INST.bit_clk";


wire sfd_timeout_0;
syn_hyper_connect sfd_timeout_connect_0(sfd_timeout_0);
defparam sfd_timeout_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.sfd_timeout";

wire sfd_timeout_1;
syn_hyper_connect sfd_timeout_connect_1(sfd_timeout_1);
defparam sfd_timeout_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.sfd_timeout";


wire idle_line_0;
syn_hyper_connect idle_line_connect_0(idle_line_0);
defparam idle_line_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.idle_line";


wire irx_center_sample_0;
syn_hyper_connect irx_center_sample_connect_0(irx_center_sample_0);
defparam irx_center_sample_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.irx_center_sample";

wire irx_center_sample_1;
syn_hyper_connect irx_center_sample_connect_1(irx_center_sample_1);
defparam irx_center_sample_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.irx_center_sample";


wire sampler_clk1x_en_0;
syn_hyper_connect sampler_clk1x_en_connect_0(sampler_clk1x_en_0);
defparam sampler_clk1x_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.sampler_clk1x_en";


wire start_bit_mask_0;
syn_hyper_connect start_bit_mask_connect_0(start_bit_mask_0);
defparam start_bit_mask_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.start_bit_mask";


wire [5:0] rx_state_0;
syn_hyper_connect rx_state_connect_0(rx_state_0);
defparam rx_state_connect_0.w = 6;
defparam rx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.rx_state";


wire rx_byte_valid_0;
syn_hyper_connect rx_byte_valid_connect_0(rx_byte_valid_0);
defparam rx_byte_valid_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.rx_byte_valid";


wire clk1x_enable_0;
syn_hyper_connect clk1x_enable_connect_0(clk1x_enable_0);
defparam clk1x_enable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.clk1x_enable";

wire clk1x_enable_1;
syn_hyper_connect clk1x_enable_connect_1(clk1x_enable_1);
defparam clk1x_enable_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.clk1x_enable";


wire [15:0] cnt_sfd_0;
syn_hyper_connect cnt_sfd_connect_0(cnt_sfd_0);
defparam cnt_sfd_connect_0.w = 16;
defparam cnt_sfd_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.cnt_sfd";


wire i_rx_packet_end_all_0;
syn_hyper_connect i_rx_packet_end_all_connect_0(i_rx_packet_end_all_0);
defparam i_rx_packet_end_all_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.i_rx_packet_end_all";


wire i_start_bit_mask_0;
syn_hyper_connect i_start_bit_mask_connect_0(i_start_bit_mask_0);
defparam i_start_bit_mask_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.i_start_bit_mask";


wire missed_sfd_flag_0;
syn_hyper_connect missed_sfd_flag_connect_0(missed_sfd_flag_0);
defparam missed_sfd_flag_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.missed_sfd_flag";


wire [3:0] clkdiv_0;
syn_hyper_connect clkdiv_connect_0(clkdiv_0);
defparam clkdiv_connect_0.w = 4;
defparam clkdiv_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.clkdiv";


wire clock_adjust_0;
syn_hyper_connect clock_adjust_connect_0(clock_adjust_0);
defparam clock_adjust_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.clock_adjust";


wire inrz_data_0;
syn_hyper_connect inrz_data_connect_0(inrz_data_0);
defparam inrz_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.inrz_data";


wire [1:0] imanches_in_dly_0;
syn_hyper_connect imanches_in_dly_connect_0(imanches_in_dly_0);
defparam imanches_in_dly_connect_0.w = 2;
defparam imanches_in_dly_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.imanches_in_dly";


wire [1:0] manches_shiftreg_0;
syn_hyper_connect manches_shiftreg_connect_0(manches_shiftreg_0);
defparam manches_shiftreg_connect_0.w = 2;
defparam manches_shiftreg_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.manches_shiftreg";


wire manches_transition_0;
syn_hyper_connect manches_transition_connect_0(manches_transition_0);
defparam manches_transition_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.manches_transition";


wire rx_packet_end_all_0;
syn_hyper_connect rx_packet_end_all_connect_0(rx_packet_end_all_0);
defparam rx_packet_end_all_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.rx_packet_end_all";


wire identify_sampler_ready_0;
syn_hyper_connect identify_sampler_ready_connect_0(identify_sampler_ready_0);
defparam identify_sampler_ready_connect_0.tag = "ident_coreinst.IICE_INST.b3_SoW.identify_sampler_ready";


wire Identify_IICE_trigger_ext_0;
syn_hyper_connect Identify_IICE_trigger_ext_connect_0(Identify_IICE_trigger_ext_0);
defparam Identify_IICE_trigger_ext_connect_0.tag = "ident_coreinst.IICE_INST.Identify_IICE_trigger_ext";


wire [7:0] ujtag_wrapper_uireg_0;
syn_hyper_connect ujtag_wrapper_uireg_connect_0(ujtag_wrapper_uireg_0);
defparam ujtag_wrapper_uireg_connect_0.w = 8;
defparam ujtag_wrapper_uireg_connect_0.tag = "ident_coreinst.comm_block_INST.jtagi.ujtag_wrapper_uireg";


wire ujtag_wrapper_urstb_0;
syn_hyper_connect ujtag_wrapper_urstb_connect_0(ujtag_wrapper_urstb_0);
defparam ujtag_wrapper_urstb_connect_0.tag = "ident_coreinst.comm_block_INST.jtagi.ujtag_wrapper_urstb";


wire ujtag_wrapper_udrupd_0;
syn_hyper_connect ujtag_wrapper_udrupd_connect_0(ujtag_wrapper_udrupd_0);
defparam ujtag_wrapper_udrupd_connect_0.tag = "ident_coreinst.comm_block_INST.jtagi.ujtag_wrapper_udrupd";


wire ujtag_wrapper_udrck_0;
syn_hyper_connect ujtag_wrapper_udrck_connect_0(ujtag_wrapper_udrck_0);
defparam ujtag_wrapper_udrck_connect_0.tag = "ident_coreinst.comm_block_INST.jtagi.ujtag_wrapper_udrck";


wire ujtag_wrapper_udrcap_0;
syn_hyper_connect ujtag_wrapper_udrcap_connect_0(ujtag_wrapper_udrcap_0);
defparam ujtag_wrapper_udrcap_connect_0.tag = "ident_coreinst.comm_block_INST.jtagi.ujtag_wrapper_udrcap";


wire ujtag_wrapper_udrsh_0;
syn_hyper_connect ujtag_wrapper_udrsh_connect_0(ujtag_wrapper_udrsh_0);
defparam ujtag_wrapper_udrsh_connect_0.tag = "ident_coreinst.comm_block_INST.jtagi.ujtag_wrapper_udrsh";


wire ujtag_wrapper_utdi_0;
syn_hyper_connect ujtag_wrapper_utdi_connect_0(ujtag_wrapper_utdi_0);
defparam ujtag_wrapper_utdi_connect_0.tag = "ident_coreinst.comm_block_INST.jtagi.ujtag_wrapper_utdi";

endmodule
