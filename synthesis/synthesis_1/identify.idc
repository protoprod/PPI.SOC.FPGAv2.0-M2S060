iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 1024

signals add -iice {IICE} -silent -trigger -sample {/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_packet_avail}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_packet_complt}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/rx_packet_end}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/AFE_RX_STATE_MACHINE/behavioral/afe_rx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/ReadFIFO_Write_SM_PROC/behavioral/readfifo_wr_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER_INST/v1/rx_packet_end_all}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_INST/tx_packet_complt}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_fifo_overflow_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/rx_fifo_underrun_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/rx_packet_depth}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/rx_packet_depth_status}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_overflow}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/rx_fifo_underrun}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_din_pipe}\
{/rtl/CommsFPGA_top_0/behavioral/rx_fifo_txcoldetdis_wr_en}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/clk}

iice new {IICE_0} -type regular
iice controller -iice {IICE_0} none
iice sampler -iice {IICE_0} -depth 1024

signals add -iice {IICE_0} -silent -trigger -sample {/rtl/CommsFPGA_top_0/apb3_addr}\
{/rtl/CommsFPGA_top_0/apb3_enable}\
{/rtl/CommsFPGA_top_0/apb3_rdata}\
{/rtl/CommsFPGA_top_0/apb3_ready}\
{/rtl/CommsFPGA_top_0/apb3_sel}\
{/rtl/CommsFPGA_top_0/apb3_wdata}\
{/rtl/CommsFPGA_top_0/apb3_write}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/int_reg_clr}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/behavioral/tx_fifo_underrun_int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/int}\
{/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/int_reg}\
{/rtl/CommsFPGA_top_0/behavioral/bit_clk}\
{/rtl/CommsFPGA_top_0/behavioral/start_tx_fifo}\
{/rtl/CommsFPGA_top_0/behavioral/tx_enable}\
{/rtl/CommsFPGA_top_0/behavioral/tx_fifo_empty}
iice clock -iice {IICE_0} -edge positive {/rtl/CommsFPGA_top_0/behavioral/PROCESSOR_INTERFACE_INST/behavioral/INTERRUPT_INST/apb3_clk}

