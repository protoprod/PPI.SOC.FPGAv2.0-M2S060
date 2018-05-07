device jtagport builtin
iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 8192

signals add -iice {IICE} -silent -trigger -sample  {/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/internal_loopback}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/mii_rx_d}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/mii_rx_en}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/bit_cntr}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/i_rx_packet_end_all}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/i_start_bit_mask}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/long_bit_cntr}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/behavioral/rx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/clk1x_enable}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/idle_line}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/rx_byte_valid}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/rx_center_sample}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/RECEIVE_STATE_MACHINE_INST/sfd_timeout}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/aempty}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/clkdomain_buf_empty}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/clkdomain_buf_full}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/clkdomain_buf_notempty}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/clkdomain_buf_overrun}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/clkdomain_buf_rden}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/clkdomain_buf_underflow}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/fifo_read_sm}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/fifo_read_sm_del}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/rx_byte_nibble_swap}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/rx_byte_valid}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_DECODER2_INST/v1/rx_s2p}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/NIBBLE_TO_SERIAL_SM_INST/behavioral/tx_state}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/behavioral/p2s_data}\
{/rtl/CommsFPGA_top_0/behavioral/MANCHESTER_ENCODER_2_INST/bit_clk}\
{/rtl/CommsFPGA_top_0/behavioral/mii_clk}\
{/rtl/CommsFPGA_top_0/behavioral/mii_tx_clk}\
{/rtl/CommsFPGA_top_0/behavioral/tx_enable}\
{/rtl/CommsFPGA_top_0/d_crs}\
{/rtl/CommsFPGA_top_0/d_mdc}\
{/rtl/CommsFPGA_top_0/d_mdi}\
{/rtl/CommsFPGA_top_0/d_mdo}\
{/rtl/CommsFPGA_top_0/d_mdo_en}\
{/rtl/CommsFPGA_top_0/d_rxc}\
{/rtl/CommsFPGA_top_0/d_rxd}\
{/rtl/CommsFPGA_top_0/d_rxdv}\
{/rtl/CommsFPGA_top_0/d_rxer}\
{/rtl/CommsFPGA_top_0/d_txc}\
{/rtl/CommsFPGA_top_0/d_txd}\
{/rtl/CommsFPGA_top_0/d_txen}\
{/rtl/CommsFPGA_top_0/mac_mii_col}\
{/rtl/CommsFPGA_top_0/mac_mii_crs}\
{/rtl/CommsFPGA_top_0/mac_mii_mdc}\
{/rtl/CommsFPGA_top_0/mac_mii_mdi}\
{/rtl/CommsFPGA_top_0/mac_mii_mdo}\
{/rtl/CommsFPGA_top_0/mac_mii_mdo_en}\
{/rtl/CommsFPGA_top_0/mac_mii_rx_clk}\
{/rtl/CommsFPGA_top_0/mac_mii_rx_dv}\
{/rtl/CommsFPGA_top_0/mac_mii_rx_er}\
{/rtl/CommsFPGA_top_0/mac_mii_rxd}\
{/rtl/CommsFPGA_top_0/mac_mii_tx_clk}\
{/rtl/CommsFPGA_top_0/mac_mii_tx_en}\
{/rtl/CommsFPGA_top_0/mac_mii_txd}\
{/rtl/CommsFPGA_top_0/manch_out_p}\
{/rtl/CommsFPGA_top_0/manchester_in}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/bit_clk2x}

