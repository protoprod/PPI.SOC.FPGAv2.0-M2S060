device jtagport builtin
iice new {IICE} -type regular
iice controller -iice {IICE} none
iice sampler -iice {IICE} -depth 4096

signals add -iice {IICE} -silent -trigger -sample  {/d_col}\
{/d_crs}\
{/d_mdc}\
{/d_rxc}\
{/d_rxd}\
{/d_rxdv}\
{/d_rxer}\
{/d_txc}\
{/d_txd}\
{/d_txen}\
{/manch_out_n}\
{/manch_out_p}\
{/manchester_in}\
{/rtl/CommsFPGA_top_0/behavioral/Phy_Mux_Inst/d_mdc}\
{/rtl/CommsFPGA_top_0/behavioral/Phy_Mux_Inst/d_txd}\
{/rtl/CommsFPGA_top_0/behavioral/Phy_Mux_Inst/mii_dbg_phyn}\
{/rtl/m2s010_som_sb_0/mac_mii_mdi}\
{/rtl/m2s010_som_sb_0/rtl/m2s010_som_sb_MSS_0/m3_reset_n}\
{/rtl/m2s010_som_sb_0/rtl/m2s010_som_sb_MSS_0/mac_mii_mdo}\
{/rtl/m2s010_som_sb_0/rtl/m2s010_som_sb_MSS_0/mac_mii_mdo_en}\
{/rtl/m2s010_som_sb_0/rtl/m2s010_som_sb_MSS_0/mac_mii_tx_er}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_CCC_0/gl1}

