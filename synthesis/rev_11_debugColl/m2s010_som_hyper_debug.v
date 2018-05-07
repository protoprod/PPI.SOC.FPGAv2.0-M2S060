// available hyper connections - for debug and ip models
// timestamp: 1508785624


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


wire rx_fifo_empty_0;
syn_hyper_connect rx_fifo_empty_connect_0(rx_fifo_empty_0);
defparam rx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.rx_fifo_empty";

wire rx_fifo_empty_1;
syn_hyper_connect rx_fifo_empty_connect_1(rx_fifo_empty_1);
defparam rx_fifo_empty_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_empty";


wire [3:0] rx_fifo_empty_v_0;
syn_hyper_connect rx_fifo_empty_v_connect_0(rx_fifo_empty_v_0);
defparam rx_fifo_empty_v_connect_0.w = 4;
defparam rx_fifo_empty_v_connect_0.tag = "CommsFPGA_top_0.rx_fifo_empty_v";


wire rx_fifo_full_0;
syn_hyper_connect rx_fifo_full_connect_0(rx_fifo_full_0);
defparam rx_fifo_full_connect_0.tag = "CommsFPGA_top_0.rx_fifo_full";

wire rx_fifo_full_1;
syn_hyper_connect rx_fifo_full_connect_1(rx_fifo_full_1);
defparam rx_fifo_full_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_full";


wire rx_fifo_overflow_0;
syn_hyper_connect rx_fifo_overflow_connect_0(rx_fifo_overflow_0);
defparam rx_fifo_overflow_connect_0.tag = "CommsFPGA_top_0.rx_fifo_overflow";

wire rx_fifo_overflow_1;
syn_hyper_connect rx_fifo_overflow_connect_1(rx_fifo_overflow_1);
defparam rx_fifo_overflow_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_overflow";


wire rx_fifo_txcoldetdis_wr_en_0;
syn_hyper_connect rx_fifo_txcoldetdis_wr_en_connect_0(rx_fifo_txcoldetdis_wr_en_0);
defparam rx_fifo_txcoldetdis_wr_en_connect_0.tag = "CommsFPGA_top_0.rx_fifo_txcoldetdis_wr_en";

wire rx_fifo_txcoldetdis_wr_en_1;
syn_hyper_connect rx_fifo_txcoldetdis_wr_en_connect_1(rx_fifo_txcoldetdis_wr_en_1);
defparam rx_fifo_txcoldetdis_wr_en_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_fifo_txcoldetdis_wr_en";


wire rx_fifo_underrun_0;
syn_hyper_connect rx_fifo_underrun_connect_0(rx_fifo_underrun_0);
defparam rx_fifo_underrun_connect_0.tag = "CommsFPGA_top_0.rx_fifo_underrun";

wire rx_fifo_underrun_1;
syn_hyper_connect rx_fifo_underrun_connect_1(rx_fifo_underrun_1);
defparam rx_fifo_underrun_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_underrun";


wire rx_fifo_rd_en_0;
syn_hyper_connect rx_fifo_rd_en_connect_0(rx_fifo_rd_en_0);
defparam rx_fifo_rd_en_connect_0.tag = "CommsFPGA_top_0.rx_fifo_rd_en";

wire rx_fifo_rd_en_1;
syn_hyper_connect rx_fifo_rd_en_connect_1(rx_fifo_rd_en_1);
defparam rx_fifo_rd_en_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_fifo_rd_en";


wire [7:0] tx_fifo_dout_0;
syn_hyper_connect tx_fifo_dout_connect_0(tx_fifo_dout_0);
defparam tx_fifo_dout_connect_0.w = 8;
defparam tx_fifo_dout_connect_0.tag = "CommsFPGA_top_0.tx_fifo_dout";


wire tx_fifo_empty_0;
syn_hyper_connect tx_fifo_empty_connect_0(tx_fifo_empty_0);
defparam tx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.tx_fifo_empty";


wire tx_fifo_full_0;
syn_hyper_connect tx_fifo_full_connect_0(tx_fifo_full_0);
defparam tx_fifo_full_connect_0.tag = "CommsFPGA_top_0.tx_fifo_full";


wire tx_fifo_rd_en_0;
syn_hyper_connect tx_fifo_rd_en_connect_0(tx_fifo_rd_en_0);
defparam tx_fifo_rd_en_connect_0.tag = "CommsFPGA_top_0.tx_fifo_rd_en";


wire tx_fifo_wr_en_0;
syn_hyper_connect tx_fifo_wr_en_connect_0(tx_fifo_wr_en_0);
defparam tx_fifo_wr_en_connect_0.tag = "CommsFPGA_top_0.tx_fifo_wr_en";

wire tx_fifo_wr_en_1;
syn_hyper_connect tx_fifo_wr_en_connect_1(tx_fifo_wr_en_1);
defparam tx_fifo_wr_en_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.tx_fifo_wr_en";


wire idle_line_status_0;
syn_hyper_connect idle_line_status_connect_0(idle_line_status_0);
defparam idle_line_status_connect_0.tag = "CommsFPGA_top_0.idle_line_status";


wire clk_bit_5mhz_0;
syn_hyper_connect clk_bit_5mhz_connect_0(clk_bit_5mhz_0);
defparam clk_bit_5mhz_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.clk_bit_5mhz";


wire manchester_out_0;
syn_hyper_connect manchester_out_connect_0(manchester_out_0);
defparam manchester_out_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.manchester_out";


wire tx_dataen_0;
syn_hyper_connect tx_dataen_connect_0(tx_dataen_0);
defparam tx_dataen_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.tx_dataen";

wire tx_dataen_1;
syn_hyper_connect tx_dataen_connect_1(tx_dataen_1);
defparam tx_dataen_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_dataen";


wire tx_dataen_d1_0;
syn_hyper_connect tx_dataen_d1_connect_0(tx_dataen_d1_0);
defparam tx_dataen_d1_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.tx_dataen_d1";


wire [7:0] p2s_data_0;
syn_hyper_connect p2s_data_connect_0(p2s_data_0);
defparam p2s_data_connect_0.w = 8;
defparam p2s_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.p2s_data";


wire start_tx_fifo_0;
syn_hyper_connect start_tx_fifo_connect_0(start_tx_fifo_0);
defparam start_tx_fifo_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.start_tx_fifo";

wire start_tx_fifo_1;
syn_hyper_connect start_tx_fifo_connect_1(start_tx_fifo_1);
defparam start_tx_fifo_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.start_tx_fifo";


wire tx_preamble_pat_en_0;
syn_hyper_connect tx_preamble_pat_en_connect_0(tx_preamble_pat_en_0);
defparam tx_preamble_pat_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.tx_preamble_pat_en";


wire [7:0] rx_fifo_din_pipe_d1_0;
syn_hyper_connect rx_fifo_din_pipe_d1_connect_0(rx_fifo_din_pipe_d1_0);
defparam rx_fifo_din_pipe_d1_connect_0.w = 8;
defparam rx_fifo_din_pipe_d1_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.rx_fifo_din_pipe_d1";


wire [7:0] rx_fifo_wr_en_d_0;
syn_hyper_connect rx_fifo_wr_en_d_connect_0(rx_fifo_wr_en_d_0);
defparam rx_fifo_wr_en_d_connect_0.w = 8;
defparam rx_fifo_wr_en_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.rx_fifo_wr_en_d";


wire [1:0] sync2rxclk_tx_enable_0;
syn_hyper_connect sync2rxclk_tx_enable_connect_0(sync2rxclk_tx_enable_0);
defparam sync2rxclk_tx_enable_connect_0.w = 2;
defparam sync2rxclk_tx_enable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.sync2rxclk_tx_enable";


wire [1:0] sync2rxclk_tx_packet_complt_0;
syn_hyper_connect sync2rxclk_tx_packet_complt_connect_0(sync2rxclk_tx_packet_complt_0);
defparam sync2rxclk_tx_packet_complt_connect_0.w = 2;
defparam sync2rxclk_tx_packet_complt_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.sync2rxclk_tx_packet_complt";


wire [7:0] tx_fifo_dout_d5_sync2rx_0;
syn_hyper_connect tx_fifo_dout_d5_sync2rx_connect_0(tx_fifo_dout_d5_sync2rx_0);
defparam tx_fifo_dout_d5_sync2rx_connect_0.w = 8;
defparam tx_fifo_dout_d5_sync2rx_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_fifo_dout_d5_sync2rx";


wire [7:0] tx_fifo_dout_d5_synccompare_0;
syn_hyper_connect tx_fifo_dout_d5_synccompare_connect_0(tx_fifo_dout_d5_synccompare_0);
defparam tx_fifo_dout_d5_synccompare_connect_0.w = 8;
defparam tx_fifo_dout_d5_synccompare_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_fifo_dout_d5_synccompare";


wire [3:0] tx_coll_detect_cnt_0;
syn_hyper_connect tx_coll_detect_cnt_connect_0(tx_coll_detect_cnt_0);
defparam tx_coll_detect_cnt_connect_0.w = 4;
defparam tx_coll_detect_cnt_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_coll_detect_cnt";


wire tx_collision_detect_0;
syn_hyper_connect tx_collision_detect_connect_0(tx_collision_detect_0);
defparam tx_collision_detect_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_collision_detect";

wire tx_collision_detect_1;
syn_hyper_connect tx_collision_detect_connect_1(tx_collision_detect_1);
defparam tx_collision_detect_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.tx_collision_detect";


wire tx_enable_0;
syn_hyper_connect tx_enable_connect_0(tx_enable_0);
defparam tx_enable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_enable";


wire tx_preamble_0;
syn_hyper_connect tx_preamble_connect_0(tx_preamble_0);
defparam tx_preamble_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_preamble";


wire [8:0] tx_state_0;
syn_hyper_connect tx_state_connect_0(tx_state_0);
defparam tx_state_connect_0.w = 9;
defparam tx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_state";


wire coll_det_reset_0;
syn_hyper_connect coll_det_reset_connect_0(coll_det_reset_0);
defparam coll_det_reset_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.coll_det_reset";


wire collision_detect_sync10mhz_d_0;
syn_hyper_connect collision_detect_sync10mhz_d_connect_0(collision_detect_sync10mhz_d_0);
defparam collision_detect_sync10mhz_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.collision_detect_sync10mhz_d";


wire itx_postamble_0;
syn_hyper_connect itx_postamble_connect_0(itx_postamble_0);
defparam itx_postamble_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.itx_postamble";


wire tx_packet_complt_0;
syn_hyper_connect tx_packet_complt_connect_0(tx_packet_complt_0);
defparam tx_packet_complt_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_packet_complt";

wire tx_packet_complt_1;
syn_hyper_connect tx_packet_complt_connect_1(tx_packet_complt_1);
defparam tx_packet_complt_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.tx_packet_complt";


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


wire rx_add_cmpr_en_0;
syn_hyper_connect rx_add_cmpr_en_connect_0(rx_add_cmpr_en_0);
defparam rx_add_cmpr_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.rx_add_cmpr_en";


wire [7:0] rx_fifo_din_0;
syn_hyper_connect rx_fifo_din_connect_0(rx_fifo_din_0);
defparam rx_fifo_din_connect_0.w = 8;
defparam rx_fifo_din_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_fifo_din";


wire rx_fifo_wr_en_0;
syn_hyper_connect rx_fifo_wr_en_connect_0(rx_fifo_wr_en_0);
defparam rx_fifo_wr_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_fifo_wr_en";


wire rx_inprocess_d1_0;
syn_hyper_connect rx_inprocess_d1_connect_0(rx_inprocess_d1_0);
defparam rx_inprocess_d1_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_inprocess_d1";


wire [10:0] readfifo_wr_state_0;
syn_hyper_connect readfifo_wr_state_connect_0(readfifo_wr_state_0);
defparam readfifo_wr_state_connect_0.w = 11;
defparam readfifo_wr_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.readfifo_wr_state";


wire sm_advance_i_0;
syn_hyper_connect sm_advance_i_connect_0(sm_advance_i_0);
defparam sm_advance_i_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.sm_advance_i";


wire [9:0] consumer_type_0;
syn_hyper_connect consumer_type_connect_0(consumer_type_0);
defparam consumer_type_connect_0.w = 10;
defparam consumer_type_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.consumer_type";


wire [9:0] consumer_type1_reg_0;
syn_hyper_connect consumer_type1_reg_connect_0(consumer_type1_reg_0);
defparam consumer_type1_reg_connect_0.w = 10;
defparam consumer_type1_reg_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.consumer_type1_reg";


wire hold_collision_0;
syn_hyper_connect hold_collision_connect_0(hold_collision_0);
defparam hold_collision_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.hold_collision";


wire irx_fifo_wr_en_0;
syn_hyper_connect irx_fifo_wr_en_connect_0(irx_fifo_wr_en_0);
defparam irx_fifo_wr_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.irx_fifo_wr_en";

wire [3:0] irx_fifo_wr_en_1;
syn_hyper_connect irx_fifo_wr_en_connect_1(irx_fifo_wr_en_1);
defparam irx_fifo_wr_en_connect_1.w = 4;
defparam irx_fifo_wr_en_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_wr_en";


wire packet_avail_0;
syn_hyper_connect packet_avail_connect_0(packet_avail_0);
defparam packet_avail_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.packet_avail";

wire packet_avail_1;
syn_hyper_connect packet_avail_connect_1(packet_avail_1);
defparam packet_avail_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.packet_avail";


wire rx_crc_error_0;
syn_hyper_connect rx_crc_error_connect_0(rx_crc_error_0);
defparam rx_crc_error_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_crc_error";


wire [1:0] rx_add_cmpr_en_d_0;
syn_hyper_connect rx_add_cmpr_en_d_connect_0(rx_add_cmpr_en_d_0);
defparam rx_add_cmpr_en_d_connect_0.w = 2;
defparam rx_add_cmpr_en_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_add_cmpr_en_d";


wire [11:0] rx_byte_cntr_0;
syn_hyper_connect rx_byte_cntr_connect_0(rx_byte_cntr_0);
defparam rx_byte_cntr_connect_0.w = 12;
defparam rx_byte_cntr_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_byte_cntr";


wire [15:0] rx_crc_data_calc_0;
syn_hyper_connect rx_crc_data_calc_connect_0(rx_crc_data_calc_0);
defparam rx_crc_data_calc_connect_0.w = 16;
defparam rx_crc_data_calc_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_crc_data_calc";


wire [15:0] rx_crc_data_store_0;
syn_hyper_connect rx_crc_data_store_connect_0(rx_crc_data_store_0);
defparam rx_crc_data_store_connect_0.w = 16;
defparam rx_crc_data_store_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_crc_data_store";


wire rx_packet_complt_0;
syn_hyper_connect rx_packet_complt_connect_0(rx_packet_complt_0);
defparam rx_packet_complt_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_packet_complt";

wire rx_packet_complt_1;
syn_hyper_connect rx_packet_complt_connect_1(rx_packet_complt_1);
defparam rx_packet_complt_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_complt";


wire [11:0] rx_packet_length_0;
syn_hyper_connect rx_packet_length_connect_0(rx_packet_length_0);
defparam rx_packet_length_connect_0.w = 12;
defparam rx_packet_length_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_packet_length";


wire sampler_clk1x_en_0;
syn_hyper_connect sampler_clk1x_en_connect_0(sampler_clk1x_en_0);
defparam sampler_clk1x_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.sampler_clk1x_en";


wire tx_col_detect_en_0;
syn_hyper_connect tx_col_detect_en_connect_0(tx_col_detect_en_0);
defparam tx_col_detect_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.tx_col_detect_en";


wire [1:0] manchester_in_d_0;
syn_hyper_connect manchester_in_d_connect_0(manchester_in_d_0);
defparam manchester_in_d_connect_0.w = 2;
defparam manchester_in_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.manchester_in_d";


wire clk1x_enable_0;
syn_hyper_connect clk1x_enable_connect_0(clk1x_enable_0);
defparam clk1x_enable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.clk1x_enable";


wire [3:0] clkdiv_0;
syn_hyper_connect clkdiv_connect_0(clkdiv_0);
defparam clkdiv_connect_0.w = 4;
defparam clkdiv_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.clkdiv";


wire clock_adjust_0;
syn_hyper_connect clock_adjust_connect_0(clock_adjust_0);
defparam clock_adjust_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.clock_adjust";


wire [7:0] decoder_shiftreg_0;
syn_hyper_connect decoder_shiftreg_connect_0(decoder_shiftreg_0);
defparam decoder_shiftreg_connect_0.w = 8;
defparam decoder_shiftreg_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.decoder_shiftreg";


wire decoder_transition_0;
syn_hyper_connect decoder_transition_connect_0(decoder_transition_0);
defparam decoder_transition_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.decoder_transition";


wire [3:0] decoder_transition_d_0;
syn_hyper_connect decoder_transition_d_connect_0(decoder_transition_d_0);
defparam decoder_transition_d_connect_0.w = 4;
defparam decoder_transition_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.decoder_transition_d";


wire inrz_data_0;
syn_hyper_connect inrz_data_connect_0(inrz_data_0);
defparam inrz_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.inrz_data";


wire iidle_line_0;
syn_hyper_connect iidle_line_connect_0(iidle_line_0);
defparam iidle_line_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.iidle_line";


wire [1:0] imanches_in_dly_0;
syn_hyper_connect imanches_in_dly_connect_0(imanches_in_dly_0);
defparam imanches_in_dly_connect_0.w = 2;
defparam imanches_in_dly_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.imanches_in_dly";


wire irx_center_sample_0;
syn_hyper_connect irx_center_sample_connect_0(irx_center_sample_0);
defparam irx_center_sample_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.irx_center_sample";


wire isampler_clk1x_en_0;
syn_hyper_connect isampler_clk1x_en_connect_0(isampler_clk1x_en_0);
defparam isampler_clk1x_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.isampler_clk1x_en";


wire manches_transition_0;
syn_hyper_connect manches_transition_connect_0(manches_transition_0);
defparam manches_transition_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.manches_transition";


wire [3:0] manches_transition_d_0;
syn_hyper_connect manches_transition_d_connect_0(manches_transition_d_0);
defparam manches_transition_d_connect_0.w = 4;
defparam manches_transition_d_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.manches_transition_d";


wire manches_in_0;
syn_hyper_connect manches_in_connect_0(manches_in_0);
defparam manches_in_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.manches_in";


wire manches_in_s_0;
syn_hyper_connect manches_in_s_connect_0(manches_in_s_0);
defparam manches_in_s_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.manches_in_s";


wire rx_packet_end_all_0;
syn_hyper_connect rx_packet_end_all_connect_0(rx_packet_end_all_0);
defparam rx_packet_end_all_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.rx_packet_end_all";


wire [7:0] s2p_data_0;
syn_hyper_connect s2p_data_connect_0(s2p_data_0);
defparam s2p_data_connect_0.w = 8;
defparam s2p_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.s2p_data";


wire [5:0] afe_rx_state_0;
syn_hyper_connect afe_rx_state_connect_0(afe_rx_state_0);
defparam afe_rx_state_connect_0.w = 6;
defparam afe_rx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.afe_rx_state";


wire irx_packet_end_all_0;
syn_hyper_connect irx_packet_end_all_connect_0(irx_packet_end_all_0);
defparam irx_packet_end_all_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.irx_packet_end_all";


wire [3:0] rx_fifo_reset_v_0;
syn_hyper_connect rx_fifo_reset_v_connect_0(rx_fifo_reset_v_0);
defparam rx_fifo_reset_v_connect_0.w = 4;
defparam rx_fifo_reset_v_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_reset_v";


wire rx_fifo_wr_clk_0;
syn_hyper_connect rx_fifo_wr_clk_connect_0(rx_fifo_wr_clk_0);
defparam rx_fifo_wr_clk_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_wr_clk";


wire [1:0] readfifo_read_ptr_0;
syn_hyper_connect readfifo_read_ptr_connect_0(readfifo_read_ptr_0);
defparam readfifo_read_ptr_connect_0.w = 2;
defparam readfifo_read_ptr_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.readfifo_read_ptr";


wire [1:0] readfifo_write_ptr_0;
syn_hyper_connect readfifo_write_ptr_connect_0(readfifo_write_ptr_0);
defparam readfifo_write_ptr_connect_0.w = 2;
defparam readfifo_write_ptr_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.readfifo_write_ptr";


wire tx_fifo_overflow_0;
syn_hyper_connect tx_fifo_overflow_connect_0(tx_fifo_overflow_0);
defparam tx_fifo_overflow_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.tx_fifo_overflow";


wire tx_fifo_underrun_0;
syn_hyper_connect tx_fifo_underrun_connect_0(tx_fifo_underrun_0);
defparam tx_fifo_underrun_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.tx_fifo_underrun";


wire ififo_ptr_err_0;
syn_hyper_connect ififo_ptr_err_connect_0(ififo_ptr_err_0);
defparam ififo_ptr_err_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.ififo_ptr_err";


wire [3:0] irx_fifo_empty_0;
syn_hyper_connect irx_fifo_empty_connect_0(irx_fifo_empty_0);
defparam irx_fifo_empty_connect_0.w = 4;
defparam irx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_empty";


wire [3:0] irx_fifo_full_0;
syn_hyper_connect irx_fifo_full_connect_0(irx_fifo_full_0);
defparam irx_fifo_full_connect_0.w = 4;
defparam irx_fifo_full_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_full";


wire [3:0] irx_fifo_overflow_0;
syn_hyper_connect irx_fifo_overflow_connect_0(irx_fifo_overflow_0);
defparam irx_fifo_overflow_connect_0.w = 4;
defparam irx_fifo_overflow_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_overflow";


wire [3:0] irx_fifo_underrun_0;
syn_hyper_connect irx_fifo_underrun_connect_0(irx_fifo_underrun_0);
defparam irx_fifo_underrun_connect_0.w = 4;
defparam irx_fifo_underrun_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_underrun";


wire [3:0] irx_fifo_rd_en_0;
syn_hyper_connect irx_fifo_rd_en_connect_0(irx_fifo_rd_en_0);
defparam irx_fifo_rd_en_connect_0.w = 4;
defparam irx_fifo_rd_en_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_rd_en";


wire itx_fifo_empty_0;
syn_hyper_connect itx_fifo_empty_connect_0(itx_fifo_empty_0);
defparam itx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.itx_fifo_empty";


wire irx_fifo_rst_0;
syn_hyper_connect irx_fifo_rst_connect_0(irx_fifo_rst_0);
defparam irx_fifo_rst_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_rst";


wire itx_fifo_rst_0;
syn_hyper_connect itx_fifo_rst_connect_0(itx_fifo_rst_0);
defparam itx_fifo_rst_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.itx_fifo_rst";


wire [2:0] packet_available_clear_reg_0;
syn_hyper_connect packet_available_clear_reg_connect_0(packet_available_clear_reg_0);
defparam packet_available_clear_reg_connect_0.w = 3;
defparam packet_available_clear_reg_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.packet_available_clear_reg";


wire rx_packet_avail_int_0;
syn_hyper_connect rx_packet_avail_int_connect_0(rx_packet_avail_int_0);
defparam rx_packet_avail_int_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.rx_packet_avail_int";

wire rx_packet_avail_int_1;
syn_hyper_connect rx_packet_avail_int_connect_1(rx_packet_avail_int_1);
defparam rx_packet_avail_int_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.rx_packet_avail_int";


wire up_eop_0;
syn_hyper_connect up_eop_connect_0(up_eop_0);
defparam up_eop_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.up_eop";

wire up_eop_1;
syn_hyper_connect up_eop_connect_1(up_eop_1);
defparam up_eop_connect_1.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.up_eop";


wire [7:0] apb3_addr_0;
syn_hyper_connect apb3_addr_connect_0(apb3_addr_0);
defparam apb3_addr_connect_0.w = 8;
defparam apb3_addr_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_addr";


wire apb3_clk_0;
syn_hyper_connect apb3_clk_connect_0(apb3_clk_0);
defparam apb3_clk_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_clk";


wire [7:0] apb3_rdata_0;
syn_hyper_connect apb3_rdata_connect_0(apb3_rdata_0);
defparam apb3_rdata_connect_0.w = 8;
defparam apb3_rdata_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_rdata";


wire [7:0] apb3_wdata_0;
syn_hyper_connect apb3_wdata_connect_0(apb3_wdata_0);
defparam apb3_wdata_connect_0.w = 8;
defparam apb3_wdata_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_wdata";


wire bw_debug_clk_0;
syn_hyper_connect bw_debug_clk_connect_0(bw_debug_clk_0);
defparam bw_debug_clk_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.bw_debug_clk";


wire bw_debug_reg_0;
syn_hyper_connect bw_debug_reg_connect_0(bw_debug_reg_0);
defparam bw_debug_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.bw_debug_reg";


wire bw_debug_reg_rs_0;
syn_hyper_connect bw_debug_reg_rs_connect_0(bw_debug_reg_rs_0);
defparam bw_debug_reg_rs_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.bw_debug_reg_rs";


wire [7:0] rx_packet_depth_0;
syn_hyper_connect rx_packet_depth_connect_0(rx_packet_depth_0);
defparam rx_packet_depth_connect_0.w = 8;
defparam rx_packet_depth_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_depth";


wire rx_packet_depth_status_0;
syn_hyper_connect rx_packet_depth_status_connect_0(rx_packet_depth_status_0);
defparam rx_packet_depth_status_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_depth_status";


wire col_detect_0;
syn_hyper_connect col_detect_connect_0(col_detect_0);
defparam col_detect_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.col_detect";


wire [7:0] control_reg_0;
syn_hyper_connect control_reg_connect_0(control_reg_0);
defparam control_reg_connect_0.w = 8;
defparam control_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.control_reg";


wire [7:0] int_reg_0;
syn_hyper_connect int_reg_connect_0(int_reg_0);
defparam int_reg_connect_0.w = 8;
defparam int_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.int_reg";


wire iup_eop_cntdown_en_0;
syn_hyper_connect iup_eop_cntdown_en_connect_0(iup_eop_cntdown_en_0);
defparam iup_eop_cntdown_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.iup_eop_cntdown_en";


wire [2:0] rx_packet_complt_apb_0;
syn_hyper_connect rx_packet_complt_apb_connect_0(rx_packet_complt_apb_0);
defparam rx_packet_complt_apb_connect_0.w = 3;
defparam rx_packet_complt_apb_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_complt_apb";


wire rx_packet_complt_apb_en_0;
syn_hyper_connect rx_packet_complt_apb_en_connect_0(rx_packet_complt_apb_en_0);
defparam rx_packet_complt_apb_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_complt_apb_en";


wire [2:0] rx_packet_complt_cnt_0;
syn_hyper_connect rx_packet_complt_cnt_connect_0(rx_packet_complt_cnt_0);
defparam rx_packet_complt_cnt_connect_0.w = 3;
defparam rx_packet_complt_cnt_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_complt_cnt";


wire rx_packet_complt_cnt_en_0;
syn_hyper_connect rx_packet_complt_cnt_en_connect_0(rx_packet_complt_cnt_en_0);
defparam rx_packet_complt_cnt_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_complt_cnt_en";


wire [7:0] status_reg_0;
syn_hyper_connect status_reg_connect_0(status_reg_0);
defparam status_reg_connect_0.w = 8;
defparam status_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.status_reg";


wire [2:0] up_eop_sync_0;
syn_hyper_connect up_eop_sync_connect_0(up_eop_sync_0);
defparam up_eop_sync_connect_0.w = 3;
defparam up_eop_sync_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.up_eop_sync";


wire col_detect_c_0;
syn_hyper_connect col_detect_c_connect_0(col_detect_c_0);
defparam col_detect_c_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.col_detect_c";


wire [2:0] col_detect_d_0;
syn_hyper_connect col_detect_d_connect_0(col_detect_d_0);
defparam col_detect_d_connect_0.w = 3;
defparam col_detect_d_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.col_detect_d";


wire col_detect_int_0;
syn_hyper_connect col_detect_int_connect_0(col_detect_int_0);
defparam col_detect_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.col_detect_int";


wire col_detect_int_c_0;
syn_hyper_connect col_detect_int_c_connect_0(col_detect_int_c_0);
defparam col_detect_int_c_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.col_detect_int_c";


wire [7:0] delay_to_post_int_0;
syn_hyper_connect delay_to_post_int_connect_0(delay_to_post_int_0);
defparam delay_to_post_int_connect_0.w = 8;
defparam delay_to_post_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.delay_to_post_int";


wire done_w_active_rx_fifo_0;
syn_hyper_connect done_w_active_rx_fifo_connect_0(done_w_active_rx_fifo_0);
defparam done_w_active_rx_fifo_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.done_w_active_rx_fifo";


wire iint_0;
syn_hyper_connect iint_connect_0(iint_0);
defparam iint_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.iint";


wire [7:0] iint_reg_0;
syn_hyper_connect iint_reg_connect_0(iint_reg_0);
defparam iint_reg_connect_0.w = 8;
defparam iint_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.iint_reg";


wire tx_fifo_underrun_int_c_0;
syn_hyper_connect tx_fifo_underrun_int_c_connect_0(tx_fifo_underrun_int_c_0);
defparam tx_fifo_underrun_int_c_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.tx_fifo_underrun_int_c";


wire tx_packet_complt_int_0;
syn_hyper_connect tx_packet_complt_int_connect_0(tx_packet_complt_int_0);
defparam tx_packet_complt_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.tx_packet_complt_int";


wire tx_packet_complt_to_apb3_clk_0;
syn_hyper_connect tx_packet_complt_to_apb3_clk_connect_0(tx_packet_complt_to_apb3_clk_0);
defparam tx_packet_complt_to_apb3_clk_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.tx_packet_complt_to_apb3_clk";


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
