// available hyper connections - for debug and ip models
// timestamp: 1520611772


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

wire d_crs_0;
syn_hyper_connect d_crs_connect_0(d_crs_0);
defparam d_crs_connect_0.tag = "CommsFPGA_top_0.d_crs";


wire d_mdc_0;
syn_hyper_connect d_mdc_connect_0(d_mdc_0);
defparam d_mdc_connect_0.tag = "CommsFPGA_top_0.d_mdc";


wire d_mdi_0;
syn_hyper_connect d_mdi_connect_0(d_mdi_0);
defparam d_mdi_connect_0.tag = "CommsFPGA_top_0.d_mdi";


wire d_mdo_0;
syn_hyper_connect d_mdo_connect_0(d_mdo_0);
defparam d_mdo_connect_0.tag = "CommsFPGA_top_0.d_mdo";


wire d_mdo_en_0;
syn_hyper_connect d_mdo_en_connect_0(d_mdo_en_0);
defparam d_mdo_en_connect_0.tag = "CommsFPGA_top_0.d_mdo_en";


wire d_rxc_0;
syn_hyper_connect d_rxc_connect_0(d_rxc_0);
defparam d_rxc_connect_0.tag = "CommsFPGA_top_0.d_rxc";


wire [3:0] d_rxd_0;
syn_hyper_connect d_rxd_connect_0(d_rxd_0);
defparam d_rxd_connect_0.w = 4;
defparam d_rxd_connect_0.tag = "CommsFPGA_top_0.d_rxd";


wire d_rxdv_0;
syn_hyper_connect d_rxdv_connect_0(d_rxdv_0);
defparam d_rxdv_connect_0.tag = "CommsFPGA_top_0.d_rxdv";


wire d_rxer_0;
syn_hyper_connect d_rxer_connect_0(d_rxer_0);
defparam d_rxer_connect_0.tag = "CommsFPGA_top_0.d_rxer";


wire d_txc_0;
syn_hyper_connect d_txc_connect_0(d_txc_0);
defparam d_txc_connect_0.tag = "CommsFPGA_top_0.d_txc";


wire [3:0] d_txd_0;
syn_hyper_connect d_txd_connect_0(d_txd_0);
defparam d_txd_connect_0.w = 4;
defparam d_txd_connect_0.tag = "CommsFPGA_top_0.d_txd";


wire d_txen_0;
syn_hyper_connect d_txen_connect_0(d_txen_0);
defparam d_txen_connect_0.tag = "CommsFPGA_top_0.d_txen";


wire mac_mii_col_0;
syn_hyper_connect mac_mii_col_connect_0(mac_mii_col_0);
defparam mac_mii_col_connect_0.tag = "CommsFPGA_top_0.mac_mii_col";


wire mac_mii_crs_0;
syn_hyper_connect mac_mii_crs_connect_0(mac_mii_crs_0);
defparam mac_mii_crs_connect_0.tag = "CommsFPGA_top_0.mac_mii_crs";


wire mac_mii_mdc_0;
syn_hyper_connect mac_mii_mdc_connect_0(mac_mii_mdc_0);
defparam mac_mii_mdc_connect_0.tag = "CommsFPGA_top_0.mac_mii_mdc";


wire mac_mii_mdi_0;
syn_hyper_connect mac_mii_mdi_connect_0(mac_mii_mdi_0);
defparam mac_mii_mdi_connect_0.tag = "CommsFPGA_top_0.mac_mii_mdi";


wire mac_mii_mdo_0;
syn_hyper_connect mac_mii_mdo_connect_0(mac_mii_mdo_0);
defparam mac_mii_mdo_connect_0.tag = "CommsFPGA_top_0.mac_mii_mdo";


wire mac_mii_mdo_en_0;
syn_hyper_connect mac_mii_mdo_en_connect_0(mac_mii_mdo_en_0);
defparam mac_mii_mdo_en_connect_0.tag = "CommsFPGA_top_0.mac_mii_mdo_en";


wire [3:0] mac_mii_rxd_0;
syn_hyper_connect mac_mii_rxd_connect_0(mac_mii_rxd_0);
defparam mac_mii_rxd_connect_0.w = 4;
defparam mac_mii_rxd_connect_0.tag = "CommsFPGA_top_0.mac_mii_rxd";


wire mac_mii_rx_clk_0;
syn_hyper_connect mac_mii_rx_clk_connect_0(mac_mii_rx_clk_0);
defparam mac_mii_rx_clk_connect_0.tag = "CommsFPGA_top_0.mac_mii_rx_clk";


wire mac_mii_rx_dv_0;
syn_hyper_connect mac_mii_rx_dv_connect_0(mac_mii_rx_dv_0);
defparam mac_mii_rx_dv_connect_0.tag = "CommsFPGA_top_0.mac_mii_rx_dv";


wire mac_mii_rx_er_0;
syn_hyper_connect mac_mii_rx_er_connect_0(mac_mii_rx_er_0);
defparam mac_mii_rx_er_connect_0.tag = "CommsFPGA_top_0.mac_mii_rx_er";


wire [3:0] mac_mii_txd_0;
syn_hyper_connect mac_mii_txd_connect_0(mac_mii_txd_0);
defparam mac_mii_txd_connect_0.w = 4;
defparam mac_mii_txd_connect_0.tag = "CommsFPGA_top_0.mac_mii_txd";


wire mac_mii_tx_clk_0;
syn_hyper_connect mac_mii_tx_clk_connect_0(mac_mii_tx_clk_0);
defparam mac_mii_tx_clk_connect_0.tag = "CommsFPGA_top_0.mac_mii_tx_clk";


wire mac_mii_tx_en_0;
syn_hyper_connect mac_mii_tx_en_connect_0(mac_mii_tx_en_0);
defparam mac_mii_tx_en_connect_0.tag = "CommsFPGA_top_0.mac_mii_tx_en";


wire manchester_in_0;
syn_hyper_connect manchester_in_connect_0(manchester_in_0);
defparam manchester_in_connect_0.tag = "CommsFPGA_top_0.manchester_in";


wire manch_out_p_0;
syn_hyper_connect manch_out_p_connect_0(manch_out_p_0);
defparam manch_out_p_connect_0.tag = "CommsFPGA_top_0.manch_out_p";


wire mii_clk_0;
syn_hyper_connect mii_clk_connect_0(mii_clk_0);
defparam mii_clk_connect_0.tag = "CommsFPGA_top_0.mii_clk";


wire mii_tx_clk_0;
syn_hyper_connect mii_tx_clk_connect_0(mii_tx_clk_0);
defparam mii_tx_clk_connect_0.tag = "CommsFPGA_top_0.mii_tx_clk";


wire tx_enable_0;
syn_hyper_connect tx_enable_connect_0(tx_enable_0);
defparam tx_enable_connect_0.tag = "CommsFPGA_top_0.tx_enable";


wire bit_clk2x_0;
syn_hyper_connect bit_clk2x_connect_0(bit_clk2x_0);
defparam bit_clk2x_connect_0.tag = "CommsFPGA_top_0.bit_clk2x";


wire bit_clk_0;
syn_hyper_connect bit_clk_connect_0(bit_clk_0);
defparam bit_clk_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.bit_clk";


wire [3:0] p2s_data_0;
syn_hyper_connect p2s_data_connect_0(p2s_data_0);
defparam p2s_data_connect_0.w = 4;
defparam p2s_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.p2s_data";


wire [5:0] tx_state_0;
syn_hyper_connect tx_state_connect_0(tx_state_0);
defparam tx_state_connect_0.w = 6;
defparam tx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.NIBBLE_TO_SERIAL_SM_INST.tx_state";


wire aempty_0;
syn_hyper_connect aempty_connect_0(aempty_0);
defparam aempty_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.aempty";


wire clkdomain_buf_empty_0;
syn_hyper_connect clkdomain_buf_empty_connect_0(clkdomain_buf_empty_0);
defparam clkdomain_buf_empty_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.clkdomain_buf_empty";


wire clkdomain_buf_full_0;
syn_hyper_connect clkdomain_buf_full_connect_0(clkdomain_buf_full_0);
defparam clkdomain_buf_full_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.clkdomain_buf_full";


wire clkdomain_buf_notempty_0;
syn_hyper_connect clkdomain_buf_notempty_connect_0(clkdomain_buf_notempty_0);
defparam clkdomain_buf_notempty_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.clkdomain_buf_notempty";


wire clkdomain_buf_overrun_0;
syn_hyper_connect clkdomain_buf_overrun_connect_0(clkdomain_buf_overrun_0);
defparam clkdomain_buf_overrun_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.clkdomain_buf_overrun";


wire clkdomain_buf_underflow_0;
syn_hyper_connect clkdomain_buf_underflow_connect_0(clkdomain_buf_underflow_0);
defparam clkdomain_buf_underflow_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.clkdomain_buf_underflow";


wire clkdomain_buf_rden_0;
syn_hyper_connect clkdomain_buf_rden_connect_0(clkdomain_buf_rden_0);
defparam clkdomain_buf_rden_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.clkdomain_buf_rden";


wire [3:0] fifo_read_sm_0;
syn_hyper_connect fifo_read_sm_connect_0(fifo_read_sm_0);
defparam fifo_read_sm_connect_0.w = 4;
defparam fifo_read_sm_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.fifo_read_sm";


wire [7:0] fifo_read_sm_del_0;
syn_hyper_connect fifo_read_sm_del_connect_0(fifo_read_sm_del_0);
defparam fifo_read_sm_del_connect_0.w = 8;
defparam fifo_read_sm_del_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.fifo_read_sm_del";


wire [3:0] mii_rx_d_0;
syn_hyper_connect mii_rx_d_connect_0(mii_rx_d_0);
defparam mii_rx_d_connect_0.w = 4;
defparam mii_rx_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.mii_rx_d";


wire mii_rx_en_0;
syn_hyper_connect mii_rx_en_connect_0(mii_rx_en_0);
defparam mii_rx_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.mii_rx_en";


wire [7:0] rx_byte_nibble_swap_0;
syn_hyper_connect rx_byte_nibble_swap_connect_0(rx_byte_nibble_swap_0);
defparam rx_byte_nibble_swap_connect_0.w = 8;
defparam rx_byte_nibble_swap_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.rx_byte_nibble_swap";


wire rx_byte_valid_0;
syn_hyper_connect rx_byte_valid_connect_0(rx_byte_valid_0);
defparam rx_byte_valid_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.rx_byte_valid";

wire rx_byte_valid_1;
syn_hyper_connect rx_byte_valid_connect_1(rx_byte_valid_1);
defparam rx_byte_valid_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.rx_byte_valid";


wire [7:0] rx_s2p_0;
syn_hyper_connect rx_s2p_connect_0(rx_s2p_0);
defparam rx_s2p_connect_0.w = 8;
defparam rx_s2p_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.rx_s2p";


wire internal_loopback_0;
syn_hyper_connect internal_loopback_connect_0(internal_loopback_0);
defparam internal_loopback_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.internal_loopback";


wire [5:0] rx_state_0;
syn_hyper_connect rx_state_connect_0(rx_state_0);
defparam rx_state_connect_0.w = 6;
defparam rx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.rx_state";


wire sfd_timeout_0;
syn_hyper_connect sfd_timeout_connect_0(sfd_timeout_0);
defparam sfd_timeout_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.sfd_timeout";


wire [3:0] bit_cntr_0;
syn_hyper_connect bit_cntr_connect_0(bit_cntr_0);
defparam bit_cntr_connect_0.w = 4;
defparam bit_cntr_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.bit_cntr";


wire clk1x_enable_0;
syn_hyper_connect clk1x_enable_connect_0(clk1x_enable_0);
defparam clk1x_enable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.clk1x_enable";


wire i_rx_packet_end_all_0;
syn_hyper_connect i_rx_packet_end_all_connect_0(i_rx_packet_end_all_0);
defparam i_rx_packet_end_all_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.i_rx_packet_end_all";


wire i_start_bit_mask_0;
syn_hyper_connect i_start_bit_mask_connect_0(i_start_bit_mask_0);
defparam i_start_bit_mask_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.i_start_bit_mask";


wire idle_line_0;
syn_hyper_connect idle_line_connect_0(idle_line_0);
defparam idle_line_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.idle_line";


wire [15:0] long_bit_cntr_0;
syn_hyper_connect long_bit_cntr_connect_0(long_bit_cntr_0);
defparam long_bit_cntr_connect_0.w = 16;
defparam long_bit_cntr_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.long_bit_cntr";


wire rx_center_sample_0;
syn_hyper_connect rx_center_sample_connect_0(rx_center_sample_0);
defparam rx_center_sample_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.rx_center_sample";


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
