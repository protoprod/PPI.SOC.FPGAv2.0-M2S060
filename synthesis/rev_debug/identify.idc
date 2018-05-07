device jtagport builtin
iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 4096

signals add -iice {IICE} -silent -trigger -sample  {/manch_out_p}\
{/manchester_in}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/readfifo_read_ptr}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/readfifo_write_ptr}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_crc_error}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_fifo_din_pipe}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/AFE_RX_STATE_MACHINE/behavioral/afe_rx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/clkdiv}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/clock_adjust}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/iidle_line}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/inrz_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/manches_in}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/s2p_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/idle_line}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/packet_avail}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TRANSMIT_SM/behavioral/itx_enable}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TRANSMIT_SM/behavioral/itx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TRANSMIT_SM/behavioral/itx_postamble}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TRANSMIT_SM/behavioral/tx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TRANSMIT_SM/tx_dataen}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TRANSMIT_SM/tx_preamble}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/p2s_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/tx_col_detect_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/tx_collision_detect}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_addr}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_clk}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_enable}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_rdata}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_ready}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_sel}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_wdata}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/block_int_until_rd}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/col_detect_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/col_detect_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/col_detect_int_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/irx_packet_avail_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_crc_error_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_crc_error_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_crc_error_int_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_fifo_overflow_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_fifo_overflow_int_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_fifo_underrun_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_fifo_underrun_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_fifo_underrun_int_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/tx_fifo_overflow_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/tx_fifo_underrun_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/tx_fifo_underrun_int_c}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/tx_packet_complt_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/col_detect}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/int_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/apb3_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/apb3_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/control_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/control_reg_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/iapb3_ready}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/int_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/irx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/itx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/iup_eop}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/read_reg_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/rx_packet_depth}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/status_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/up_eop_sync}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/write_reg_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_crc_error}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_rst}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_rst}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/external_loopback}\
{/rtl/CommsFPGA_top_0/behavioral/internal_loopback}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_din_pipe}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_dout}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/rx_packet_avail_int}\
{/rtl/CommsFPGA_top_0/behavioral/rx_packet_complt}\
{/rtl/CommsFPGA_top_0/behavioral/rx_packet_end}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_dout}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/tx_packet_complt}\
{/rtl/CommsFPGA_top_0/drvr_en}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/clk16x}
