device jtagport builtin
iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 4096

signals add -iice {IICE} -silent -trigger -sample  {/rtl/CommsFPGA_top_0/apb3_addr}\
{/rtl/CommsFPGA_top_0/apb3_rdata}\
{/rtl/CommsFPGA_top_0/apb3_ready}\
{/rtl/CommsFPGA_top_0/apb3_wdata}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/readfifo_read_ptr}\
{/rtl/CommsFPGA_top_0/behavioral/FIFOS_INST/behavioral/readfifo_write_ptr}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/AFE_RX_STATE_MACHINE/behavioral/afe_rx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/clock_adjust}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/iidle_line}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/inrz_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/s2p_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/ReadFIFO_Write_SM_PROC/behavioral/readfifo_wr_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TRANSMIT_SM/behavioral/tx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/p2s_data}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/control_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/int_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/iup_eop}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/status_reg}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_din_pipe}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_dout}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_txcoldetdis_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/rx_packet_complt}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_dout}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/up_eop_cntdown_en}\
{/rtl/CommsFPGA_top_0/drvr_en}\
{/rtl/CommsFPGA_top_0/manch_out_p}\
{/rtl/CommsFPGA_top_0/manchester_in}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/clk}

