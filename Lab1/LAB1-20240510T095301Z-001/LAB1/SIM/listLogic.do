onerror {resume}
add list -width 15 /tblogic/L2/Y
add list /tblogic/L2/X
add list /tblogic/L2/ALUFN
add list /tblogic/L2/res
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta collapse
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
