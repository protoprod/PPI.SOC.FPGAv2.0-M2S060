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
{/rtl/m2s010_som_sb_0/mac_mii_mdi}\
{/rtl/m2s010_som_sb_0/mac_mii_mdo}\
{/rtl/m2s010_som_sb_0/mac_mii_mdo_en}
iice clock -iice {IICE} -edge positive {/rtl/CommsFPGA_top_0/bit_clk2x}

