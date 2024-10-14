onerror {resume}
add list -width 12 /duttb/clk
add list /duttb/rst
add list /duttb/enb
add list /duttb/done
add list /duttb/TBactive
add list /duttb/WrenProg
add list /duttb/WrenData
add list /duttb/WAddrProg
add list /duttb/WAddrData
add list /duttb/RAddrData
add list /duttb/MemDataIn
add list /duttb/MemProgIn
add list /duttb/MemDataOut
add list /duttb/writeProgMem_phase_start
add list /duttb/writeDataMem_phase_start
add list /duttb/readDataMem_phase_start
add list /duttb/writeProgMem_phase_finish
add list /duttb/writeDataMem_phase_finish
add list /duttb/readDataMem_phase_finish
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
