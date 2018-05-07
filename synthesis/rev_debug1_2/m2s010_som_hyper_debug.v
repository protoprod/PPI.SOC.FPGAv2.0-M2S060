// available hyper connections - for debug and ip models
// timestamp: 1504381068


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

wire [7:0] apb3_rdata_0;
syn_hyper_connect apb3_rdata_connect_0(apb3_rdata_0);
defparam apb3_rdata_connect_0.w = 8;
defparam apb3_rdata_connect_0.tag = "CommsFPGA_top_0.apb3_rdata";

wire [7:0] apb3_rdata_1;
syn_hyper_connect apb3_rdata_connect_1(apb3_rdata_1);
defparam apb3_rdata_connect_1.w = 8;
defparam apb3_rdata_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_rdata";


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


wire apb3_enable_0;
syn_hyper_connect apb3_enable_connect_0(apb3_enable_0);
defparam apb3_enable_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_enable";


wire apb3_ready_0;
syn_hyper_connect apb3_ready_connect_0(apb3_ready_0);
defparam apb3_ready_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_ready";


wire apb3_sel_0;
syn_hyper_connect apb3_sel_connect_0(apb3_sel_0);
defparam apb3_sel_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_sel";


wire apb3_write_0;
syn_hyper_connect apb3_write_connect_0(apb3_write_0);
defparam apb3_write_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_write";


wire int_0;
syn_hyper_connect int_connect_0(int_0);
defparam int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.int";

wire int_1;
syn_hyper_connect int_connect_1(int_1);
defparam int_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.int";


wire pkt_depth_tx_err_0;
syn_hyper_connect pkt_depth_tx_err_connect_0(pkt_depth_tx_err_0);
defparam pkt_depth_tx_err_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.pkt_depth_tx_err";


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


wire [7:0] control_reg_0;
syn_hyper_connect control_reg_connect_0(control_reg_0);
defparam control_reg_connect_0.w = 8;
defparam control_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.control_reg";


wire irx_fifo_rd_en_0;
syn_hyper_connect irx_fifo_rd_en_connect_0(irx_fifo_rd_en_0);
defparam irx_fifo_rd_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.irx_fifo_rd_en";

wire [3:0] irx_fifo_rd_en_1;
syn_hyper_connect irx_fifo_rd_en_connect_1(irx_fifo_rd_en_1);
defparam irx_fifo_rd_en_connect_1.w = 4;
defparam irx_fifo_rd_en_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_rd_en";


wire itx_fifo_wr_en_0;
syn_hyper_connect itx_fifo_wr_en_connect_0(itx_fifo_wr_en_0);
defparam itx_fifo_wr_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.itx_fifo_wr_en";


wire [7:0] int_reg_0;
syn_hyper_connect int_reg_connect_0(int_reg_0);
defparam int_reg_connect_0.w = 8;
defparam int_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.int_reg";

wire [7:0] int_reg_1;
syn_hyper_connect int_reg_connect_1(int_reg_1);
defparam int_reg_connect_1.w = 8;
defparam int_reg_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.int_reg";


wire iup_eop_0;
syn_hyper_connect iup_eop_connect_0(iup_eop_0);
defparam iup_eop_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.iup_eop";


wire iup_eop_cntdown_en_0;
syn_hyper_connect iup_eop_cntdown_en_connect_0(iup_eop_cntdown_en_0);
defparam iup_eop_cntdown_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.iup_eop_cntdown_en";


wire rx_crc_error_0;
syn_hyper_connect rx_crc_error_connect_0(rx_crc_error_0);
defparam rx_crc_error_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_crc_error";

wire rx_crc_error_1;
syn_hyper_connect rx_crc_error_connect_1(rx_crc_error_1);
defparam rx_crc_error_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_crc_error";


wire rx_packet_avail_int_0;
syn_hyper_connect rx_packet_avail_int_connect_0(rx_packet_avail_int_0);
defparam rx_packet_avail_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_avail_int";


wire rx_packet_complt_0;
syn_hyper_connect rx_packet_complt_connect_0(rx_packet_complt_0);
defparam rx_packet_complt_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_complt";


wire start_tx_fifo_0;
syn_hyper_connect start_tx_fifo_connect_0(start_tx_fifo_0);
defparam start_tx_fifo_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.start_tx_fifo";

wire start_tx_fifo_1;
syn_hyper_connect start_tx_fifo_connect_1(start_tx_fifo_1);
defparam start_tx_fifo_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.start_tx_fifo";


wire [7:0] status_reg_0;
syn_hyper_connect status_reg_connect_0(status_reg_0);
defparam status_reg_connect_0.w = 8;
defparam status_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.status_reg";


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


wire [7:0] p2s_data_0;
syn_hyper_connect p2s_data_connect_0(p2s_data_0);
defparam p2s_data_connect_0.w = 8;
defparam p2s_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.p2s_data";


wire [7:0] rx_fifo_din_pipe_d1_0;
syn_hyper_connect rx_fifo_din_pipe_d1_connect_0(rx_fifo_din_pipe_d1_0);
defparam rx_fifo_din_pipe_d1_connect_0.w = 8;
defparam rx_fifo_din_pipe_d1_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.rx_fifo_din_pipe_d1";


wire [1:0] sync2rxclk_tx_enable_0;
syn_hyper_connect sync2rxclk_tx_enable_connect_0(sync2rxclk_tx_enable_0);
defparam sync2rxclk_tx_enable_connect_0.w = 2;
defparam sync2rxclk_tx_enable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.sync2rxclk_tx_enable";


wire [1:0] sync2rxclk_tx_packet_complt_0;
syn_hyper_connect sync2rxclk_tx_packet_complt_connect_0(sync2rxclk_tx_packet_complt_0);
defparam sync2rxclk_tx_packet_complt_connect_0.w = 2;
defparam sync2rxclk_tx_packet_complt_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.sync2rxclk_tx_packet_complt";


wire [7:0] tx_fifo_dout_d5_synccompare_0;
syn_hyper_connect tx_fifo_dout_d5_synccompare_connect_0(tx_fifo_dout_d5_synccompare_0);
defparam tx_fifo_dout_d5_synccompare_connect_0.w = 8;
defparam tx_fifo_dout_d5_synccompare_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_fifo_dout_d5_synccompare";


wire tx_collision_detect_0;
syn_hyper_connect tx_collision_detect_connect_0(tx_collision_detect_0);
defparam tx_collision_detect_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_collision_detect";


wire tx_col_detect_en_0;
syn_hyper_connect tx_col_detect_en_connect_0(tx_col_detect_en_0);
defparam tx_col_detect_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_col_detect_en";


wire clk_bit_5mhz_0;
syn_hyper_connect clk_bit_5mhz_connect_0(clk_bit_5mhz_0);
defparam clk_bit_5mhz_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.clk_bit_5mhz";


wire [8:0] tx_state_0;
syn_hyper_connect tx_state_connect_0(tx_state_0);
defparam tx_state_connect_0.w = 9;
defparam tx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_state";


wire byte_clk_en_0;
syn_hyper_connect byte_clk_en_connect_0(byte_clk_en_0);
defparam byte_clk_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.byte_clk_en";


wire [1:0] manches_in_dly_0;
syn_hyper_connect manches_in_dly_connect_0(manches_in_dly_0);
defparam manches_in_dly_connect_0.w = 2;
defparam manches_in_dly_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.manches_in_dly";


wire start_tx_fifo_s_0;
syn_hyper_connect start_tx_fifo_s_connect_0(start_tx_fifo_s_0);
defparam start_tx_fifo_s_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.start_tx_fifo_s";


wire tx_idle_line_0;
syn_hyper_connect tx_idle_line_connect_0(tx_idle_line_0);
defparam tx_idle_line_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_idle_line";


wire tx_idle_line_s_0;
syn_hyper_connect tx_idle_line_s_connect_0(tx_idle_line_s_0);
defparam tx_idle_line_s_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_idle_line_s";


wire [3:0] idle_debug_sm_0;
syn_hyper_connect idle_debug_sm_connect_0(idle_debug_sm_0);
defparam idle_debug_sm_connect_0.w = 4;
defparam idle_debug_sm_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.TX_IDLE_LINE_DETECTOR.idle_debug_sm";

wire [3:0] idle_debug_sm_1;
syn_hyper_connect idle_debug_sm_connect_1(idle_debug_sm_1);
defparam idle_debug_sm_connect_1.w = 4;
defparam idle_debug_sm_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.RX_IDLE_LINE_DETECTOR.idle_debug_sm";


wire idle_line_0;
syn_hyper_connect idle_line_connect_0(idle_line_0);
defparam idle_line_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.TX_IDLE_LINE_DETECTOR.idle_line";

wire idle_line_1;
syn_hyper_connect idle_line_connect_1(idle_line_1);
defparam idle_line_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.RX_IDLE_LINE_DETECTOR.idle_line";


wire idle_line_temp_0;
syn_hyper_connect idle_line_temp_connect_0(idle_line_temp_0);
defparam idle_line_temp_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.TX_IDLE_LINE_DETECTOR.idle_line_temp";

wire idle_line_temp_1;
syn_hyper_connect idle_line_temp_connect_1(idle_line_temp_1);
defparam idle_line_temp_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.RX_IDLE_LINE_DETECTOR.idle_line_temp";


wire prbs_gen_reg0_0;
syn_hyper_connect prbs_gen_reg0_connect_0(prbs_gen_reg0_0);
defparam prbs_gen_reg0_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.TX_IDLE_LINE_DETECTOR.prbs_gen_reg0";

wire prbs_gen_reg0_1;
syn_hyper_connect prbs_gen_reg0_connect_1(prbs_gen_reg0_1);
defparam prbs_gen_reg0_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.RX_IDLE_LINE_DETECTOR.prbs_gen_reg0";


wire [10:0] readfifo_wr_state_0;
syn_hyper_connect readfifo_wr_state_connect_0(readfifo_wr_state_0);
defparam readfifo_wr_state_connect_0.w = 11;
defparam readfifo_wr_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.readfifo_wr_state";


wire [15:0] rx_crc_data_calc_0;
syn_hyper_connect rx_crc_data_calc_connect_0(rx_crc_data_calc_0);
defparam rx_crc_data_calc_connect_0.w = 16;
defparam rx_crc_data_calc_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_crc_data_calc";


wire sampler_clk1x_en_0;
syn_hyper_connect sampler_clk1x_en_connect_0(sampler_clk1x_en_0);
defparam sampler_clk1x_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.sampler_clk1x_en";


wire [1:0] manchester_in_d_0;
syn_hyper_connect manchester_in_d_connect_0(manchester_in_d_0);
defparam manchester_in_d_connect_0.w = 2;
defparam manchester_in_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.manchester_in_d";


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


wire [1:0] imanches_in_dly_0;
syn_hyper_connect imanches_in_dly_connect_0(imanches_in_dly_0);
defparam imanches_in_dly_connect_0.w = 2;
defparam imanches_in_dly_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.imanches_in_dly";


wire manches_in_0;
syn_hyper_connect manches_in_connect_0(manches_in_0);
defparam manches_in_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.manches_in";


wire manches_in_s_0;
syn_hyper_connect manches_in_s_connect_0(manches_in_s_0);
defparam manches_in_s_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.manches_in_s";


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


wire ififo_ptr_err_0;
syn_hyper_connect ififo_ptr_err_connect_0(ififo_ptr_err_0);
defparam ififo_ptr_err_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.ififo_ptr_err";


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
