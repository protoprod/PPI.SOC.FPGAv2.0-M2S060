// available hyper connections - for debug and ip models
// timestamp: 1503670179


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

wire manchester_in_0;
syn_hyper_connect manchester_in_connect_0(manchester_in_0);
defparam manchester_in_connect_0.tag = "CommsFPGA_top_0.manchester_in";


wire manch_out_p_0;
syn_hyper_connect manch_out_p_connect_0(manch_out_p_0);
defparam manch_out_p_connect_0.tag = "CommsFPGA_top_0.manch_out_p";


wire [8:0] rx_fifo_din_pipe_0;
syn_hyper_connect rx_fifo_din_pipe_connect_0(rx_fifo_din_pipe_0);
defparam rx_fifo_din_pipe_connect_0.w = 9;
defparam rx_fifo_din_pipe_connect_0.tag = "CommsFPGA_top_0.rx_fifo_din_pipe";


wire [8:0] rx_fifo_dout_0;
syn_hyper_connect rx_fifo_dout_connect_0(rx_fifo_dout_0);
defparam rx_fifo_dout_connect_0.w = 9;
defparam rx_fifo_dout_connect_0.tag = "CommsFPGA_top_0.rx_fifo_dout";

wire [8:0] rx_fifo_dout_1;
syn_hyper_connect rx_fifo_dout_connect_1(rx_fifo_dout_1);
defparam rx_fifo_dout_connect_1.w = 9;
defparam rx_fifo_dout_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_dout";


wire rx_fifo_overflow_0;
syn_hyper_connect rx_fifo_overflow_connect_0(rx_fifo_overflow_0);
defparam rx_fifo_overflow_connect_0.tag = "CommsFPGA_top_0.rx_fifo_overflow";

wire rx_fifo_overflow_1;
syn_hyper_connect rx_fifo_overflow_connect_1(rx_fifo_overflow_1);
defparam rx_fifo_overflow_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_overflow";


wire [7:0] apb3_addr_0;
syn_hyper_connect apb3_addr_connect_0(apb3_addr_0);
defparam apb3_addr_connect_0.w = 8;
defparam apb3_addr_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_addr";


wire apb3_clk_0;
syn_hyper_connect apb3_clk_connect_0(apb3_clk_0);
defparam apb3_clk_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_clk";


wire apb3_enable_0;
syn_hyper_connect apb3_enable_connect_0(apb3_enable_0);
defparam apb3_enable_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_enable";


wire [7:0] apb3_rdata_0;
syn_hyper_connect apb3_rdata_connect_0(apb3_rdata_0);
defparam apb3_rdata_connect_0.w = 8;
defparam apb3_rdata_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_rdata";


wire apb3_ready_0;
syn_hyper_connect apb3_ready_connect_0(apb3_ready_0);
defparam apb3_ready_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_ready";


wire apb3_sel_0;
syn_hyper_connect apb3_sel_connect_0(apb3_sel_0);
defparam apb3_sel_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_sel";


wire [7:0] apb3_wdata_0;
syn_hyper_connect apb3_wdata_connect_0(apb3_wdata_0);
defparam apb3_wdata_connect_0.w = 8;
defparam apb3_wdata_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_wdata";


wire apb3_write_0;
syn_hyper_connect apb3_write_connect_0(apb3_write_0);
defparam apb3_write_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_write";


wire int_0;
syn_hyper_connect int_connect_0(int_0);
defparam int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.int";


wire [7:0] rx_packet_depth_0;
syn_hyper_connect rx_packet_depth_connect_0(rx_packet_depth_0);
defparam rx_packet_depth_connect_0.w = 8;
defparam rx_packet_depth_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_depth";


wire rx_packet_depth_status_0;
syn_hyper_connect rx_packet_depth_status_connect_0(rx_packet_depth_status_0);
defparam rx_packet_depth_status_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_depth_status";


wire clk16x_0;
syn_hyper_connect clk16x_connect_0(clk16x_0);
defparam clk16x_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.clk16x";


wire col_detect_0;
syn_hyper_connect col_detect_connect_0(col_detect_0);
defparam col_detect_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.col_detect";


wire irx_fifo_rd_en_0;
syn_hyper_connect irx_fifo_rd_en_connect_0(irx_fifo_rd_en_0);
defparam irx_fifo_rd_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.irx_fifo_rd_en";

wire [3:0] irx_fifo_rd_en_1;
syn_hyper_connect irx_fifo_rd_en_connect_1(irx_fifo_rd_en_1);
defparam irx_fifo_rd_en_connect_1.w = 4;
defparam irx_fifo_rd_en_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_rd_en";


wire [7:0] int_reg_0;
syn_hyper_connect int_reg_connect_0(int_reg_0);
defparam int_reg_connect_0.w = 8;
defparam int_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.int_reg";


wire rx_crc_error_0;
syn_hyper_connect rx_crc_error_connect_0(rx_crc_error_0);
defparam rx_crc_error_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_crc_error";


wire rx_packet_avail_int_0;
syn_hyper_connect rx_packet_avail_int_connect_0(rx_packet_avail_int_0);
defparam rx_packet_avail_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_avail_int";


wire tx_packet_complt_0;
syn_hyper_connect tx_packet_complt_connect_0(tx_packet_complt_0);
defparam tx_packet_complt_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.tx_packet_complt";


wire [2:0] up_eop_sync_0;
syn_hyper_connect up_eop_sync_connect_0(up_eop_sync_0);
defparam up_eop_sync_connect_0.w = 3;
defparam up_eop_sync_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.up_eop_sync";


wire rx_fifo_underrun_0;
syn_hyper_connect rx_fifo_underrun_connect_0(rx_fifo_underrun_0);
defparam rx_fifo_underrun_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.rx_fifo_underrun";

wire rx_fifo_underrun_1;
syn_hyper_connect rx_fifo_underrun_connect_1(rx_fifo_underrun_1);
defparam rx_fifo_underrun_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_underrun";


wire tx_fifo_overflow_0;
syn_hyper_connect tx_fifo_overflow_connect_0(tx_fifo_overflow_0);
defparam tx_fifo_overflow_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.tx_fifo_overflow";


wire tx_fifo_underrun_0;
syn_hyper_connect tx_fifo_underrun_connect_0(tx_fifo_underrun_0);
defparam tx_fifo_underrun_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.tx_fifo_underrun";


wire block_int_until_rd_0;
syn_hyper_connect block_int_until_rd_connect_0(block_int_until_rd_0);
defparam block_int_until_rd_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.block_int_until_rd";


wire irx_packet_avail_int_0;
syn_hyper_connect irx_packet_avail_int_connect_0(irx_packet_avail_int_0);
defparam irx_packet_avail_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.irx_packet_avail_int";


wire man_data_0;
syn_hyper_connect man_data_connect_0(man_data_0);
defparam man_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.man_data";


wire [8:0] tx_state_0;
syn_hyper_connect tx_state_connect_0(tx_state_0);
defparam tx_state_connect_0.w = 9;
defparam tx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_state";


wire [10:0] readfifo_wr_state_0;
syn_hyper_connect readfifo_wr_state_connect_0(readfifo_wr_state_0);
defparam readfifo_wr_state_connect_0.w = 11;
defparam readfifo_wr_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.readfifo_wr_state";


wire [3:0] clkdiv_0;
syn_hyper_connect clkdiv_connect_0(clkdiv_0);
defparam clkdiv_connect_0.w = 4;
defparam clkdiv_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.clkdiv";


wire clock_adjust_0;
syn_hyper_connect clock_adjust_connect_0(clock_adjust_0);
defparam clock_adjust_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.clock_adjust";


wire inrz_data_0;
syn_hyper_connect inrz_data_connect_0(inrz_data_0);
defparam inrz_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.inrz_data";


wire [7:0] s2p_data_0;
syn_hyper_connect s2p_data_connect_0(s2p_data_0);
defparam s2p_data_connect_0.w = 8;
defparam s2p_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.s2p_data";


wire [5:0] afe_rx_state_0;
syn_hyper_connect afe_rx_state_connect_0(afe_rx_state_0);
defparam afe_rx_state_connect_0.w = 6;
defparam afe_rx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.afe_rx_state";


wire rx_fifo_empty_0;
syn_hyper_connect rx_fifo_empty_connect_0(rx_fifo_empty_0);
defparam rx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_empty";


wire rx_fifo_full_0;
syn_hyper_connect rx_fifo_full_connect_0(rx_fifo_full_0);
defparam rx_fifo_full_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_full";


wire [1:0] readfifo_read_ptr_0;
syn_hyper_connect readfifo_read_ptr_connect_0(readfifo_read_ptr_0);
defparam readfifo_read_ptr_connect_0.w = 2;
defparam readfifo_read_ptr_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.readfifo_read_ptr";


wire [1:0] readfifo_write_ptr_0;
syn_hyper_connect readfifo_write_ptr_connect_0(readfifo_write_ptr_0);
defparam readfifo_write_ptr_connect_0.w = 2;
defparam readfifo_write_ptr_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.readfifo_write_ptr";


wire [3:0] irx_fifo_wr_en_0;
syn_hyper_connect irx_fifo_wr_en_connect_0(irx_fifo_wr_en_0);
defparam irx_fifo_wr_en_connect_0.w = 4;
defparam irx_fifo_wr_en_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_wr_en";


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
