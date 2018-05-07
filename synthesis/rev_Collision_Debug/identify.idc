device jtagport builtin
iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 4096

signals add -iice {IICE} -silent -trigger -sample  {/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/AFE_RX_STATE_MACHINE/behavioral/afe_rx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/idle_line_cntr}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/iidle_line}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/inrz_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/manches_in}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/MANCHESTER_DECODER_ADAPTER_INST/v1/s2p_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/ReadFIFO_Write_SM_PROC/behavioral/readfifo_wr_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TRANSMIT_SM/behavioral/tx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/behavioral/loopback}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/behavioral/rx_fifo_din_d1}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/behavioral/rx_fifo_wr_en_d}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/behavioral/tx_fifo_dout_d1}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/behavioral/tx_fifo_dout_d2_sync2rx}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/behavioral/tx_fifo_dout_d2_synccompare}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/external_loopback}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/internal_loopback}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/rx_crc_byte_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/rx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/tx_col_detect_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/tx_collision_detect}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/tx_enable}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/tx_fifo_dout}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/TX_COLLISION_DETECTOR_INST/tx_packet_complt}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/itx_preamble}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/tx_preamble_d}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/behavioral/tx_preamble_pat_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/clk_bit_5mhz}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/manchester_out}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_addr}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_clk}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_enable}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_rdata}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/apb3_wdata}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/control_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/int_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/iup_eop}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/rx_packet_depth}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/status_reg}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_crc_error}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_rd_en}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_packet_avail_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_empty}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_full}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/tx_fifo_wr_en}\
{/rtl/CommsFPGA_top_0/manch_out_p}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/clk}

