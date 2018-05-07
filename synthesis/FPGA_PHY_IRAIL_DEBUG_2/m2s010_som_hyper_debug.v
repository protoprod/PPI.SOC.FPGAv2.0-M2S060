// available hyper connections - for debug and ip models
// timestamp: 1520360761


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

wire d_mdc_0;
syn_hyper_connect d_mdc_connect_0(d_mdc_0);
defparam d_mdc_connect_0.tag = "d_mdc";


wire [3:0] d_txd_0;
syn_hyper_connect d_txd_connect_0(d_txd_0);
defparam d_txd_connect_0.w = 4;
defparam d_txd_connect_0.tag = "d_txd";


wire d_txen_0;
syn_hyper_connect d_txen_connect_0(d_txen_0);
defparam d_txen_connect_0.tag = "d_txen";


wire manchester_in_0;
syn_hyper_connect manchester_in_connect_0(manchester_in_0);
defparam manchester_in_connect_0.tag = "manchester_in";


wire manch_out_n_0;
syn_hyper_connect manch_out_n_connect_0(manch_out_n_0);
defparam manch_out_n_connect_0.tag = "manch_out_n";


wire mac_mii_col_0;
syn_hyper_connect mac_mii_col_connect_0(mac_mii_col_0);
defparam mac_mii_col_connect_0.tag = "m2s010_som_sb_0.mac_mii_col";


wire mac_mii_crs_0;
syn_hyper_connect mac_mii_crs_connect_0(mac_mii_crs_0);
defparam mac_mii_crs_connect_0.tag = "m2s010_som_sb_0.mac_mii_crs";


wire mac_mii_mdc_0;
syn_hyper_connect mac_mii_mdc_connect_0(mac_mii_mdc_0);
defparam mac_mii_mdc_connect_0.tag = "m2s010_som_sb_0.mac_mii_mdc";


wire mac_mii_mdi_0;
syn_hyper_connect mac_mii_mdi_connect_0(mac_mii_mdi_0);
defparam mac_mii_mdi_connect_0.tag = "m2s010_som_sb_0.mac_mii_mdi";

wire mac_mii_mdi_1;
syn_hyper_connect mac_mii_mdi_connect_1(mac_mii_mdi_1);
defparam mac_mii_mdi_connect_1.tag = "CommsFPGA_top_0.Phy_Mux_Inst.mac_mii_mdi";


wire mac_mii_mdo_0;
syn_hyper_connect mac_mii_mdo_connect_0(mac_mii_mdo_0);
defparam mac_mii_mdo_connect_0.tag = "m2s010_som_sb_0.mac_mii_mdo";


wire mac_mii_mdo_en_0;
syn_hyper_connect mac_mii_mdo_en_connect_0(mac_mii_mdo_en_0);
defparam mac_mii_mdo_en_connect_0.tag = "m2s010_som_sb_0.mac_mii_mdo_en";


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


wire mac_mii_tx_en_0;
syn_hyper_connect mac_mii_tx_en_connect_0(mac_mii_tx_en_0);
defparam mac_mii_tx_en_connect_0.tag = "m2s010_som_sb_0.mac_mii_tx_en";


wire f_txen_0;
syn_hyper_connect f_txen_connect_0(f_txen_0);
defparam f_txen_connect_0.tag = "CommsFPGA_top_0.f_txen";


wire manch_out_p_0;
syn_hyper_connect manch_out_p_connect_0(manch_out_p_0);
defparam manch_out_p_connect_0.tag = "CommsFPGA_top_0.manch_out_p";


wire tx_enable_0;
syn_hyper_connect tx_enable_connect_0(tx_enable_0);
defparam tx_enable_connect_0.tag = "CommsFPGA_top_0.tx_enable";


wire clk16x_0;
syn_hyper_connect clk16x_connect_0(clk16x_0);
defparam clk16x_connect_0.tag = "CommsFPGA_top_0.clk16x";


wire f_mdo_0;
syn_hyper_connect f_mdo_connect_0(f_mdo_0);
defparam f_mdo_connect_0.tag = "CommsFPGA_top_0.Phy_Mux_Inst.f_mdo";


wire f_mdo_en_0;
syn_hyper_connect f_mdo_en_connect_0(f_mdo_en_0);
defparam f_mdo_en_connect_0.tag = "CommsFPGA_top_0.Phy_Mux_Inst.f_mdo_en";


wire pmad_mdi_0;
syn_hyper_connect pmad_mdi_connect_0(pmad_mdi_0);
defparam pmad_mdi_connect_0.tag = "CommsFPGA_top_0.MDIO_SLAVE_INST.pmad_mdi";


wire mdio_output_0;
syn_hyper_connect mdio_output_connect_0(mdio_output_0);
defparam mdio_output_connect_0.tag = "CommsFPGA_top_0.MDIO_SLAVE_INST.mdio_output";


wire mdio_output_enable_0;
syn_hyper_connect mdio_output_enable_connect_0(mdio_output_enable_0);
defparam mdio_output_enable_connect_0.tag = "CommsFPGA_top_0.MDIO_SLAVE_INST.mdio_output_enable";


wire manchester_out_0;
syn_hyper_connect manchester_out_connect_0(manchester_out_0);
defparam manchester_out_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.manchester_out";


wire [3:0] mii_tx_d_0;
syn_hyper_connect mii_tx_d_connect_0(mii_tx_d_0);
defparam mii_tx_d_connect_0.w = 4;
defparam mii_tx_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.mii_tx_d";


wire bit_clk_0;
syn_hyper_connect bit_clk_connect_0(bit_clk_0);
defparam bit_clk_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.bit_clk";


wire [5:0] tx_state_0;
syn_hyper_connect tx_state_connect_0(tx_state_0);
defparam tx_state_connect_0.w = 6;
defparam tx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.NIBBLE_TO_SERIAL_SM_INST.tx_state";


wire collision_detect_s_0;
syn_hyper_connect collision_detect_s_connect_0(collision_detect_s_0);
defparam collision_detect_s_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_2_INST.NIBBLE_TO_SERIAL_SM_INST.collision_detect_s";


wire [5:0] rx_state_0;
syn_hyper_connect rx_state_connect_0(rx_state_0);
defparam rx_state_connect_0.w = 6;
defparam rx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.rx_state";


wire [7:0] rx_s2p_0;
syn_hyper_connect rx_s2p_connect_0(rx_s2p_0);
defparam rx_s2p_connect_0.w = 8;
defparam rx_s2p_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.rx_s2p";


wire i_start_bit_mask_0;
syn_hyper_connect i_start_bit_mask_connect_0(i_start_bit_mask_0);
defparam i_start_bit_mask_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.i_start_bit_mask";


wire rx_center_sample_0;
syn_hyper_connect rx_center_sample_connect_0(rx_center_sample_0);
defparam rx_center_sample_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.RECEIVE_STATE_MACHINE_INST.rx_center_sample";


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


wire isampler_clk1x_en_0;
syn_hyper_connect isampler_clk1x_en_connect_0(isampler_clk1x_en_0);
defparam isampler_clk1x_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.isampler_clk1x_en";


wire [7:0] s2p_data_0;
syn_hyper_connect s2p_data_connect_0(s2p_data_0);
defparam s2p_data_connect_0.w = 8;
defparam s2p_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER2_INST.MANCHESTER_DECODER_ADAPTER_INST.s2p_data";


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
