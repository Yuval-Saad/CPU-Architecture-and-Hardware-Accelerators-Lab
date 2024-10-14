onerror {resume}
add list -width 20 /datapathtb/Mem_wr
add list /datapathtb/Mem_out
add list /datapathtb/Mem_in
add list /datapathtb/Cout
add list /datapathtb/Cin
add list /datapathtb/Ain
add list /datapathtb/RFin
add list /datapathtb/RFout
add list /datapathtb/IRin
add list /datapathtb/PCin
add list /datapathtb/Imm1_in
add list /datapathtb/Imm2_in
add list /datapathtb/OPC
add list /datapathtb/RFaddr
add list /datapathtb/PCsel
add list /datapathtb/clk
add list /datapathtb/rst
add list /datapathtb/MemProgIn
add list /datapathtb/WrenProgIn
add list /datapathtb/WAddrProgIn
add list /datapathtb/MemDataIn
add list /datapathtb/WrenDataIn
add list /datapathtb/TBactive
add list /datapathtb/WAddrDataIn
add list /datapathtb/RAddrDataIn
add list /datapathtb/MemDataOut
add list /datapathtb/op_st
add list /datapathtb/op_ld
add list /datapathtb/op_mov
add list /datapathtb/op_done
add list /datapathtb/op_add
add list /datapathtb/op_sub
add list /datapathtb/op_jmp
add list /datapathtb/op_jc
add list /datapathtb/op_and
add list /datapathtb/op_or
add list /datapathtb/op_xor
add list /datapathtb/op_jnc
add list /datapathtb/Nflag
add list /datapathtb/Zflag
add list /datapathtb/Cflag
configure list -usestrobe 0
configure list -strobestart {0 ps} -strobeperiod {0 ps}
configure list -usesignaltrigger 1
configure list -delta all
configure list -signalnamewidth 0
configure list -datasetprefix 0
configure list -namelimit 5
