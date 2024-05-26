onerror {resume}
add list -width 15 /tbtop/T2/Y_i
add list /tbtop/T2/X_i
add list /tbtop/T2/ALUFN_i
add list /tbtop/T2/ALUout_o
add list /tbtop/T2/Nflag_o
add list /tbtop/T2/Cflag_o
add list /tbtop/T2/Zflag_o
add list /tbtop/T2/Vflag_o
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta collapse
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
