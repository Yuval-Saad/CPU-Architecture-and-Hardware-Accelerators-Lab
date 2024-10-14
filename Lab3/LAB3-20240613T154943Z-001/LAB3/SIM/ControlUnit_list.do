onerror {resume}
add list -width 20 /controlunittb/clk
add list /controlunittb/rst
add list /controlunittb/enb
add list /controlunittb/done
add list /controlunittb/op_st
add list /controlunittb/op_ld
add list /controlunittb/op_mov
add list /controlunittb/op_done
add list /controlunittb/op_add
add list /controlunittb/op_sub
add list /controlunittb/op_jmp
add list /controlunittb/op_jc
add list /controlunittb/op_and
add list /controlunittb/op_or
add list /controlunittb/op_xor
add list /controlunittb/op_jnc
add list /controlunittb/Nflag
add list /controlunittb/Zflag
add list /controlunittb/Cflag
add list /controlunittb/Mem_wr
add list /controlunittb/Mem_out
add list /controlunittb/Mem_in
add list /controlunittb/Cout
add list /controlunittb/Cin
add list /controlunittb/Ain
add list /controlunittb/RFin
add list /controlunittb/RFout
add list /controlunittb/IRin
add list /controlunittb/PCin
add list /controlunittb/Imm1_in
add list /controlunittb/Imm2_in
add list /controlunittb/OPC
add list /controlunittb/RFaddr
add list /controlunittb/PCsel
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
