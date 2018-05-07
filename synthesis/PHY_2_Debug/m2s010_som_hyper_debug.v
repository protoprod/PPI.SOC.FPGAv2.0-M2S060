// available hyper connections - for debug and ip models
// timestamp: 1516301814


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

wire d_col_0;
syn_hyper_connect d_col_connect_0(d_col_0);
defparam d_col_connect_0.tag = "d_col";


wire d_crs_0;
syn_hyper_connect d_crs_connect_0(d_crs_0);
defparam d_crs_connect_0.tag = "d_crs";


wire d_mdc_0;
syn_hyper_connect d_mdc_connect_0(d_mdc_0);
defparam d_mdc_connect_0.tag = "d_mdc";


wire d_rxc_0;
syn_hyper_connect d_rxc_connect_0(d_rxc_0);
defparam d_rxc_connect_0.tag = "d_rxc";


wire [3:0] d_rxd_0;
syn_hyper_connect d_rxd_connect_0(d_rxd_0);
defparam d_rxd_connect_0.w = 4;
defparam d_rxd_connect_0.tag = "d_rxd";


wire d_rxdv_0;
syn_hyper_connect d_rxdv_connect_0(d_rxdv_0);
defparam d_rxdv_connect_0.tag = "d_rxdv";


wire d_rxer_0;
syn_hyper_connect d_rxer_connect_0(d_rxer_0);
defparam d_rxer_connect_0.tag = "d_rxer";


wire d_txc_0;
syn_hyper_connect d_txc_connect_0(d_txc_0);
defparam d_txc_connect_0.tag = "d_txc";


wire [3:0] d_txd_0;
syn_hyper_connect d_txd_connect_0(d_txd_0);
defparam d_txd_connect_0.w = 4;
defparam d_txd_connect_0.tag = "d_txd";


wire d_txen_0;
syn_hyper_connect d_txen_connect_0(d_txen_0);
defparam d_txen_connect_0.tag = "d_txen";


wire bit_clk2x_0;
syn_hyper_connect bit_clk2x_connect_0(bit_clk2x_0);
defparam bit_clk2x_connect_0.tag = "CommsFPGA_top_0.bit_clk2x";


wire mac_mii_mdi_0;
syn_hyper_connect mac_mii_mdi_connect_0(mac_mii_mdi_0);
defparam mac_mii_mdi_connect_0.tag = "m2s010_som_sb_0.mac_mii_mdi";


wire mac_mii_mdo_0;
syn_hyper_connect mac_mii_mdo_connect_0(mac_mii_mdo_0);
defparam mac_mii_mdo_connect_0.tag = "m2s010_som_sb_0.mac_mii_mdo";


wire mac_mii_mdo_en_0;
syn_hyper_connect mac_mii_mdo_en_connect_0(mac_mii_mdo_en_0);
defparam mac_mii_mdo_en_connect_0.tag = "m2s010_som_sb_0.mac_mii_mdo_en";


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
