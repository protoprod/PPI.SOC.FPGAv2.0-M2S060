// available hyper connections - for debug and ip models
// timestamp: 1503062348


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

wire bd_resetn_0;
syn_hyper_connect bd_resetn_connect_0(bd_resetn_0);
defparam bd_resetn_connect_0.tag = "CommsFPGA_top_0.bd_resetn";


wire clk_0;
syn_hyper_connect clk_connect_0(clk_0);
defparam clk_connect_0.tag = "CommsFPGA_top_0.clk";

wire clk_1;
syn_hyper_connect clk_connect_1(clk_1);
defparam clk_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_CRC_GEN_INST.clk";

wire clk_2;
syn_hyper_connect clk_connect_2(clk_2);
defparam clk_connect_2.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.RX_CRC_GEN_INST.clk";


wire drvr_en_0;
syn_hyper_connect drvr_en_connect_0(drvr_en_0);
defparam drvr_en_connect_0.tag = "CommsFPGA_top_0.drvr_en";


wire lock_0;
syn_hyper_connect lock_connect_0(lock_0);
defparam lock_connect_0.tag = "CommsFPGA_top_0.lock";


wire manchester_in_0;
syn_hyper_connect manchester_in_connect_0(manchester_in_0);
defparam manchester_in_connect_0.tag = "CommsFPGA_top_0.manchester_in";


wire manch_out_p_0;
syn_hyper_connect manch_out_p_connect_0(manch_out_p_0);
defparam manch_out_p_connect_0.tag = "CommsFPGA_top_0.manch_out_p";


wire reset_0;
syn_hyper_connect reset_connect_0(reset_0);
defparam reset_connect_0.tag = "CommsFPGA_top_0.reset";


wire [8:0] rx_fifo_din_pipe_0;
syn_hyper_connect rx_fifo_din_pipe_connect_0(rx_fifo_din_pipe_0);
defparam rx_fifo_din_pipe_connect_0.w = 9;
defparam rx_fifo_din_pipe_connect_0.tag = "CommsFPGA_top_0.rx_fifo_din_pipe";


wire sw_reset_0;
syn_hyper_connect sw_reset_connect_0(sw_reset_0);
defparam sw_reset_connect_0.tag = "CommsFPGA_top_0.sw_reset";


wire bd_reset_0;
syn_hyper_connect bd_reset_connect_0(bd_reset_0);
defparam bd_reset_connect_0.tag = "CommsFPGA_top_0.bd_reset";


wire [7:0] long_reset_cntr_0;
syn_hyper_connect long_reset_cntr_connect_0(long_reset_cntr_0);
defparam long_reset_cntr_connect_0.w = 8;
defparam long_reset_cntr_connect_0.tag = "CommsFPGA_top_0.long_reset_cntr";


wire [7:0] apb3_addr_0;
syn_hyper_connect apb3_addr_connect_0(apb3_addr_0);
defparam apb3_addr_connect_0.w = 8;
defparam apb3_addr_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_addr";


wire [7:0] apb3_rdata_0;
syn_hyper_connect apb3_rdata_connect_0(apb3_rdata_0);
defparam apb3_rdata_connect_0.w = 8;
defparam apb3_rdata_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_rdata";


wire apb3_ready_0;
syn_hyper_connect apb3_ready_connect_0(apb3_ready_0);
defparam apb3_ready_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_ready";


wire apb3_write_0;
syn_hyper_connect apb3_write_connect_0(apb3_write_0);
defparam apb3_write_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.apb3_write";


wire rx_fifo_empty_0;
syn_hyper_connect rx_fifo_empty_connect_0(rx_fifo_empty_0);
defparam rx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_fifo_empty";

wire rx_fifo_empty_1;
syn_hyper_connect rx_fifo_empty_connect_1(rx_fifo_empty_1);
defparam rx_fifo_empty_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_empty";


wire rx_fifo_full_0;
syn_hyper_connect rx_fifo_full_connect_0(rx_fifo_full_0);
defparam rx_fifo_full_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_fifo_full";

wire rx_fifo_full_1;
syn_hyper_connect rx_fifo_full_connect_1(rx_fifo_full_1);
defparam rx_fifo_full_connect_1.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_full";


wire rx_fifo_rd_en_0;
syn_hyper_connect rx_fifo_rd_en_connect_0(rx_fifo_rd_en_0);
defparam rx_fifo_rd_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_fifo_rd_en";


wire [7:0] rx_packet_depth_0;
syn_hyper_connect rx_packet_depth_connect_0(rx_packet_depth_0);
defparam rx_packet_depth_connect_0.w = 8;
defparam rx_packet_depth_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_depth";


wire rx_packet_depth_status_0;
syn_hyper_connect rx_packet_depth_status_connect_0(rx_packet_depth_status_0);
defparam rx_packet_depth_status_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_depth_status";


wire tx_fifo_empty_0;
syn_hyper_connect tx_fifo_empty_connect_0(tx_fifo_empty_0);
defparam tx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.tx_fifo_empty";


wire tx_fifo_full_0;
syn_hyper_connect tx_fifo_full_connect_0(tx_fifo_full_0);
defparam tx_fifo_full_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.tx_fifo_full";


wire tx_fifo_wr_en_0;
syn_hyper_connect tx_fifo_wr_en_connect_0(tx_fifo_wr_en_0);
defparam tx_fifo_wr_en_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.tx_fifo_wr_en";


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


wire rx_packet_complt_0;
syn_hyper_connect rx_packet_complt_connect_0(rx_packet_complt_0);
defparam rx_packet_complt_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.rx_packet_complt";


wire [7:0] status_reg_0;
syn_hyper_connect status_reg_connect_0(status_reg_0);
defparam status_reg_connect_0.w = 8;
defparam status_reg_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.status_reg";


wire tx_packet_complt_0;
syn_hyper_connect tx_packet_complt_connect_0(tx_packet_complt_0);
defparam tx_packet_complt_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.tx_packet_complt";


wire up_eop_0;
syn_hyper_connect up_eop_connect_0(up_eop_0);
defparam up_eop_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.up_eop";


wire apb3_reset_0;
syn_hyper_connect apb3_reset_connect_0(apb3_reset_0);
defparam apb3_reset_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.apb3_reset";


wire block_int_until_rd_0;
syn_hyper_connect block_int_until_rd_connect_0(block_int_until_rd_0);
defparam block_int_until_rd_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.block_int_until_rd";


wire int_reg_clr_0;
syn_hyper_connect int_reg_clr_connect_0(int_reg_clr_0);
defparam int_reg_clr_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.int_reg_clr";


wire irx_packet_avail_int_0;
syn_hyper_connect irx_packet_avail_int_connect_0(irx_packet_avail_int_0);
defparam irx_packet_avail_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.irx_packet_avail_int";


wire rx_crc_error_int_0;
syn_hyper_connect rx_crc_error_int_connect_0(rx_crc_error_int_0);
defparam rx_crc_error_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.rx_crc_error_int";


wire rx_fifo_overflow_int_0;
syn_hyper_connect rx_fifo_overflow_int_connect_0(rx_fifo_overflow_int_0);
defparam rx_fifo_overflow_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.rx_fifo_overflow_int";


wire rx_fifo_underrun_int_0;
syn_hyper_connect rx_fifo_underrun_int_connect_0(rx_fifo_underrun_int_0);
defparam rx_fifo_underrun_int_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.rx_fifo_underrun_int";


wire [5:0] up_eop_del_0;
syn_hyper_connect up_eop_del_connect_0(up_eop_del_0);
defparam up_eop_del_connect_0.w = 6;
defparam up_eop_del_connect_0.tag = "CommsFPGA_top_0.PROCESSOR_INTERFACE_INST.INTERRUPT_INST.up_eop_del";


wire manchester_out_0;
syn_hyper_connect manchester_out_connect_0(manchester_out_0);
defparam manchester_out_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.manchester_out";


wire tx_enable_0;
syn_hyper_connect tx_enable_connect_0(tx_enable_0);
defparam tx_enable_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.tx_enable";

wire tx_enable_1;
syn_hyper_connect tx_enable_connect_1(tx_enable_1);
defparam tx_enable_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.TX_IDLE_LINE_DETECTOR.tx_enable";

wire tx_enable_2;
syn_hyper_connect tx_enable_connect_2(tx_enable_2);
defparam tx_enable_connect_2.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.RX_IDLE_LINE_DETECTOR.tx_enable";


wire tx_fifo_rd_en_0;
syn_hyper_connect tx_fifo_rd_en_connect_0(tx_fifo_rd_en_0);
defparam tx_fifo_rd_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.tx_fifo_rd_en";


wire tx_preamble_0;
syn_hyper_connect tx_preamble_connect_0(tx_preamble_0);
defparam tx_preamble_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.tx_preamble";


wire tx_collision_detect_0;
syn_hyper_connect tx_collision_detect_connect_0(tx_collision_detect_0);
defparam tx_collision_detect_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.tx_collision_detect";

wire tx_collision_detect_1;
syn_hyper_connect tx_collision_detect_connect_1(tx_collision_detect_1);
defparam tx_collision_detect_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_collision_detect";


wire [7:0] p2s_data_0;
syn_hyper_connect p2s_data_connect_0(p2s_data_0);
defparam p2s_data_connect_0.w = 8;
defparam p2s_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.p2s_data";


wire rx_crc_byte_en_0;
syn_hyper_connect rx_crc_byte_en_connect_0(rx_crc_byte_en_0);
defparam rx_crc_byte_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.rx_crc_byte_en";


wire tx_col_detect_en_0;
syn_hyper_connect tx_col_detect_en_connect_0(tx_col_detect_en_0);
defparam tx_col_detect_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_COLLISION_DETECTOR_INST.tx_col_detect_en";


wire crc_en_0;
syn_hyper_connect crc_en_connect_0(crc_en_0);
defparam crc_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_CRC_GEN_INST.crc_en";

wire crc_en_1;
syn_hyper_connect crc_en_connect_1(crc_en_1);
defparam crc_en_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.RX_CRC_GEN_INST.crc_en";


wire [15:0] crc_out_0;
syn_hyper_connect crc_out_connect_0(crc_out_0);
defparam crc_out_connect_0.w = 16;
defparam crc_out_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TX_CRC_GEN_INST.crc_out";

wire [15:0] crc_out_1;
syn_hyper_connect crc_out_connect_1(crc_out_1);
defparam crc_out_connect_1.w = 16;
defparam crc_out_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.RX_CRC_GEN_INST.crc_out";


wire [8:0] tx_state_0;
syn_hyper_connect tx_state_connect_0(tx_state_0);
defparam tx_state_connect_0.w = 9;
defparam tx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_state";


wire start_tx_fifo_s_0;
syn_hyper_connect start_tx_fifo_s_connect_0(start_tx_fifo_s_0);
defparam start_tx_fifo_s_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.start_tx_fifo_s";


wire tx_idle_line_s_0;
syn_hyper_connect tx_idle_line_s_connect_0(tx_idle_line_s_0);
defparam tx_idle_line_s_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.tx_idle_line_s";


wire idle_line_0;
syn_hyper_connect idle_line_connect_0(idle_line_0);
defparam idle_line_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.TX_IDLE_LINE_DETECTOR.idle_line";

wire idle_line_1;
syn_hyper_connect idle_line_connect_1(idle_line_1);
defparam idle_line_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.RX_IDLE_LINE_DETECTOR.idle_line";

wire idle_line_2;
syn_hyper_connect idle_line_connect_2(idle_line_2);
defparam idle_line_connect_2.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.idle_line";


wire [15:0] idle_line_cntr_0;
syn_hyper_connect idle_line_cntr_connect_0(idle_line_cntr_0);
defparam idle_line_cntr_connect_0.w = 16;
defparam idle_line_cntr_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.TX_IDLE_LINE_DETECTOR.idle_line_cntr";

wire [15:0] idle_line_cntr_1;
syn_hyper_connect idle_line_cntr_connect_1(idle_line_cntr_1);
defparam idle_line_cntr_connect_1.w = 16;
defparam idle_line_cntr_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.RX_IDLE_LINE_DETECTOR.idle_line_cntr";


wire [1:0] manches_in_dly_0;
syn_hyper_connect manches_in_dly_connect_0(manches_in_dly_0);
defparam manches_in_dly_connect_0.w = 2;
defparam manches_in_dly_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_ENCODER_INST.TRANSMIT_SM.TX_IDLE_LINE_DETECTOR.manches_in_dly";

wire [1:0] manches_in_dly_1;
syn_hyper_connect manches_in_dly_connect_1(manches_in_dly_1);
defparam manches_in_dly_connect_1.w = 2;
defparam manches_in_dly_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.RX_IDLE_LINE_DETECTOR.manches_in_dly";


wire rx_inprocess_0;
syn_hyper_connect rx_inprocess_connect_0(rx_inprocess_0);
defparam rx_inprocess_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_inprocess";


wire [10:0] readfifo_wr_state_0;
syn_hyper_connect readfifo_wr_state_connect_0(readfifo_wr_state_0);
defparam readfifo_wr_state_connect_0.w = 11;
defparam readfifo_wr_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.readfifo_wr_state";


wire sm_advance_i_0;
syn_hyper_connect sm_advance_i_connect_0(sm_advance_i_0);
defparam sm_advance_i_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.sm_advance_i";


wire hold_collision_0;
syn_hyper_connect hold_collision_connect_0(hold_collision_0);
defparam hold_collision_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.hold_collision";


wire irx_fifo_wr_en_0;
syn_hyper_connect irx_fifo_wr_en_connect_0(irx_fifo_wr_en_0);
defparam irx_fifo_wr_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.irx_fifo_wr_en";


wire irx_packet_end_0;
syn_hyper_connect irx_packet_end_connect_0(irx_packet_end_0);
defparam irx_packet_end_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.irx_packet_end";


wire packet_avail_0;
syn_hyper_connect packet_avail_connect_0(packet_avail_0);
defparam packet_avail_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.packet_avail";

wire packet_avail_1;
syn_hyper_connect packet_avail_connect_1(packet_avail_1);
defparam packet_avail_connect_1.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.packet_avail";


wire rx_crc_lowbyte_en_0;
syn_hyper_connect rx_crc_lowbyte_en_connect_0(rx_crc_lowbyte_en_0);
defparam rx_crc_lowbyte_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.rx_crc_lowbyte_en";


wire sampler_clk1x_en_0;
syn_hyper_connect sampler_clk1x_en_connect_0(sampler_clk1x_en_0);
defparam sampler_clk1x_en_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.ReadFIFO_Write_SM_PROC.sampler_clk1x_en";


wire [3:0] clkdiv_0;
syn_hyper_connect clkdiv_connect_0(clkdiv_0);
defparam clkdiv_connect_0.w = 4;
defparam clkdiv_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.clkdiv";


wire inrz_data_0;
syn_hyper_connect inrz_data_connect_0(inrz_data_0);
defparam inrz_data_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.inrz_data";


wire [1:0] imanches_in_dly_0;
syn_hyper_connect imanches_in_dly_connect_0(imanches_in_dly_0);
defparam imanches_in_dly_connect_0.w = 2;
defparam imanches_in_dly_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.imanches_in_dly";


wire irx_center_sample_0;
syn_hyper_connect irx_center_sample_connect_0(irx_center_sample_0);
defparam irx_center_sample_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.MANCHESTER_DECODER_ADAPTER_INST.irx_center_sample";


wire [5:0] afe_rx_state_0;
syn_hyper_connect afe_rx_state_connect_0(afe_rx_state_0);
defparam afe_rx_state_connect_0.w = 6;
defparam afe_rx_state_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.afe_rx_state";


wire rx_packet_avail_0;
syn_hyper_connect rx_packet_avail_connect_0(rx_packet_avail_0);
defparam rx_packet_avail_connect_0.tag = "CommsFPGA_top_0.MANCHESTER_DECODER_INST.AFE_RX_STATE_MACHINE.rx_packet_avail";


wire rx_fifo_overflow_0;
syn_hyper_connect rx_fifo_overflow_connect_0(rx_fifo_overflow_0);
defparam rx_fifo_overflow_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_overflow";


wire rx_fifo_underrun_0;
syn_hyper_connect rx_fifo_underrun_connect_0(rx_fifo_underrun_0);
defparam rx_fifo_underrun_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.rx_fifo_underrun";


wire [1:0] readfifo_read_ptr_0;
syn_hyper_connect readfifo_read_ptr_connect_0(readfifo_read_ptr_0);
defparam readfifo_read_ptr_connect_0.w = 2;
defparam readfifo_read_ptr_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.readfifo_read_ptr";


wire [1:0] readfifo_write_ptr_0;
syn_hyper_connect readfifo_write_ptr_connect_0(readfifo_write_ptr_0);
defparam readfifo_write_ptr_connect_0.w = 2;
defparam readfifo_write_ptr_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.readfifo_write_ptr";


wire [3:0] irx_fifo_empty_0;
syn_hyper_connect irx_fifo_empty_connect_0(irx_fifo_empty_0);
defparam irx_fifo_empty_connect_0.w = 4;
defparam irx_fifo_empty_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_empty";


wire [3:0] irx_fifo_full_0;
syn_hyper_connect irx_fifo_full_connect_0(irx_fifo_full_0);
defparam irx_fifo_full_connect_0.w = 4;
defparam irx_fifo_full_connect_0.tag = "CommsFPGA_top_0.FIFOS_INST.irx_fifo_full";


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
