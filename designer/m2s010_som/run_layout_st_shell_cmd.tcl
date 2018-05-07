if { [catch "file delete -force -- {C:\PULSAR\Projects\PPI\PoweredRail\Eval_Board_SOC\m2s010-som-fg484-1a-116-Rev1a_c\designer\m2s010_som\pinslacks.txt}"] } {
   ;
}
report -type slack {C:\PULSAR\Projects\PPI\PoweredRail\Eval_Board_SOC\m2s010-som-fg484-1a-116-Rev1a_c\designer\m2s010_som\pinslacks.txt}
