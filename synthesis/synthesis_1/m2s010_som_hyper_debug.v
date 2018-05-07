// available hyper connections - for debug and ip models
// timestamp: 1487702721


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

wire [7:0] apb3_addr_0;
syn_hyper_connect apb3_addr_connect_0(apb3_addr_0);
defparam apb3_addr_connect_0.w = 8;
defparam apb3_addr_connect_0.tag = "CommsFPGA_top_0.apb3_addr";


wire apb3_enable_0;
syn_hyper_connect apb3_enable_connect_0(apb3_enable_0);
defparam apb3_enable_connect_0.tag = "CommsFPGA_top_0.apb3_enable";


wire [7:0] apb3_rdata_0;
syn_hyper_connect apb3_rdata_connect_0(apb3_rdata_0);
defparam apb3_rdata_connect_0.w = 8;
defparam apb3_rdata_connect_0.tag = "CommsFPGA_top_0.apb3_rdata";


wire apb3_ready_0;
syn_hyper_connect apb3_ready_connect_0(apb3_ready_0);
defparam apb3_ready_connect_0.tag = "CommsFPGA_top_0.apb3_ready";


wire apb3_sel_0;
syn_hyper_connect apb3_sel_connect_0(apb3_sel_0);
defparam apb3_sel_connect_0.tag = "CommsFPGA_top_0.apb3_sel";


wire [7:0] apb3_wdata_0;
syn_hyper_connect apb3_wdata_connect_0(apb3_wdata_0);
defparam apb3_wdata_connect_0.w = 8;
defparam apb3_wdata_connect_0.tag = "CommsFPGA_top_0.apb3_wdata";


wire apb3_write_0;
syn_hyper_connect apb3_write_connect_0(apb3_write_0);
defparam apb3_write_connect_0.tag = "CommsFPGA_top_0.apb3_write";


wire bit_clk_0;
syn_hyper_connect bit_clk_connect_0(bit_clk_0);
defparam bit_clk_connect_0.tag = "CommsFPGA_top_0.bit_clk";


wire clk_0;
syn_hyper_connect clk_connect_0(clk_0);
defparam clk_connect_0.tag = "CommsFPGA_top_0.clk";


wire [8:0] rx_fifo_din_pipe_0;
syn_hyper_connect rx_fifo_din_pipe_connect_0(rx_fifo_din_pipe_0);
defparam rx_fifo_din_pipe_connect_0.w = 9;
defparam rx_fifo_din_pipe_connect_0.tag = "CommsFPGA_top_0.rx_fifo_din_pipe";


wire rx_fifo_txcoldetdis_wr_en_0;
syn_hyper_connect rx_fifo_txcoldetdis_wr_en_connect_0(rx_fifo_txcoldetdis_wr_en_0);
defparam rx_fifo_txcoldetdis_wr_en_connect_0.tag = "CommsFPGA_top_0.rx_fifo_txcoldetdis_wr_en";


wire tx_enable_0;
syn_hyper_connect tx_enable_connect_0(tx_enable_0);
defparam tx_enable_connect_0.tag = "CommsFPGA_top_0.tx_enable";


wire tx_fifo_empty_0;
syn_hyper_connect tx_fifo_empty_connect_0(tx_fifo_empty_0);
defparam tx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.tx_fifo_empty";


wire start_tx_fifo_0;
syn_hyper_connect start_tx_fifo_connect_0(start_tx_fifo_0);
defparam start_tx_fifo_connect_0.tag = "CommsFPGA_top_0.start_tx_fifo";


wire tx_packet_complt_0;
syn_hyper_connect tx_packet_complt_connect_0(tx_packet_complt_0);
defparam tx_packet_complt_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.tx_packet_complt";


wire rx_fifo_overflow_0;
syn_hyper_connect rx_fifo_overflow_connect_0(rx_fifo_overflow_0);
defparam rx_fifo_overflow_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_fifo_overflow";


wire rx_fifo_underrun_0;
syn_hyper_connect rx_fifo_underrun_connect_0(rx_fifo_underrun_0);
defparam rx_fifo_underrun_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_fifo_underrun";


wire [7:0] rx_packet_depth_0;
syn_hyper_connect rx_packet_depth_connect_0(rx_packet_depth_0);
defparam rx_packet_depth_connect_0.w = 8;
defparam rx_packet_depth_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_depth";


wire rx_packet_depth_status_0;
syn_hyper_connect rx_packet_depth_status_connect_0(rx_packet_depth_status_0);
defparam rx_packet_depth_status_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_depth_status";


wire apb3_clk_0;
syn_hyper_connect apb3_clk_connect_0(apb3_clk_0);
defparam apb3_clk_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.apb3_clk";


wire int_0;
syn_hyper_connect int_connect_0(int_0);
defparam int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.int";


wire [7:0] int_reg_0;
syn_hyper_connect int_reg_connect_0(int_reg_0);
defparam int_reg_connect_0.w = 8;
defparam int_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.int_reg";


wire int_reg_clr_0;
syn_hyper_connect int_reg_clr_connect_0(int_reg_clr_0);
defparam int_reg_clr_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.int_reg_clr";


wire rx_fifo_overflow_int_0;
syn_hyper_connect rx_fifo_overflow_int_connect_0(rx_fifo_overflow_int_0);
defparam rx_fifo_overflow_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.rx_fifo_overflow_int";


wire rx_fifo_underrun_int_0;
syn_hyper_connect rx_fifo_underrun_int_connect_0(rx_fifo_underrun_int_0);
defparam rx_fifo_underrun_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.rx_fifo_underrun_int";


wire tx_fifo_underrun_int_0;
syn_hyper_connect tx_fifo_underrun_int_connect_0(tx_fifo_underrun_int_0);
defparam tx_fifo_underrun_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.tx_fifo_underrun_int";


wire rx_packet_avail_0;
syn_hyper_connect rx_packet_avail_connect_0(rx_packet_avail_0);
defparam rx_packet_avail_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.rx_packet_avail";


wire rx_packet_complt_0;
syn_hyper_connect rx_packet_complt_connect_0(rx_packet_complt_0);
defparam rx_packet_complt_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.rx_packet_complt";


wire rx_packet_end_0;
syn_hyper_connect rx_packet_end_connect_0(rx_packet_end_0);
defparam rx_packet_end_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.rx_packet_end";


wire rx_packet_end_all_0;
syn_hyper_connect rx_packet_end_all_connect_0(rx_packet_end_all_0);
defparam rx_packet_end_all_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.rx_packet_end_all";


wire [10:0] readfifo_wr_state_0;
syn_hyper_connect readfifo_wr_state_connect_0(readfifo_wr_state_0);
defparam readfifo_wr_state_connect_0.w = 11;
defparam readfifo_wr_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.readfifo_wr_state";


wire [4:0] afe_rx_state_0;
syn_hyper_connect afe_rx_state_connect_0(afe_rx_state_0);
defparam afe_rx_state_connect_0.w = 5;
defparam afe_rx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.afe_rx_state";


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
