device jtagport builtin
iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 4096

signals add -iice {IICE} -silent -trigger -sample  {/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/irx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/irx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/irx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/irx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/irx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/itx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/readfifo_read_ptr}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/readfifo_write_ptr}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/rx_fifo_dout}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/rx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/rx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/rx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/rx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_crc_error}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_earlyterm}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_packet_avail}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_packet_complt}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_packet_end}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/AFE_RX_STATE_MACHINE/behavioral/afe_rx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/clkdiv}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/iidle_line}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/inrz_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/s2p_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/ReadFIFO_Write_SM_PROC/behavioral/readfifo_wr_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/ReadFIFO_Write_SM_PROC/rx_crc_error}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/tx_collision_detect}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/tx_packet_complt}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/p2s_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/manchester_out}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/tx_preamble}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_addr}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_enable}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_rdata}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_ready}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_sel}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_wdata}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_write}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/col_detect_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/col_detect_d}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_crc_error_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_crc_error_int_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_crc_error_int_d}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/int_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/rx_packet_avail_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/apb3_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/apb3_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/int_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/status_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/up_eop}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/up_eop_sync}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/imanch_out_p}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_din_pipe}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_dout}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_txcoldetdis_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/rx_packet_avail}\
{/rtl/CommsFPGA_top_0/behavioral/tx_collision_detect}\
{/rtl/CommsFPGA_top_0/behavioral/tx_enable}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_dout}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/tx_preamble}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/clk16x}

