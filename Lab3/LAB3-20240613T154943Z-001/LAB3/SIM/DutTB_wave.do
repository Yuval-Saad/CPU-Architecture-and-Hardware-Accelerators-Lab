onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /duttb/top_unit/clk
add wave -noupdate /duttb/top_unit/op_st
add wave -noupdate /duttb/top_unit/op_ld
add wave -noupdate /duttb/top_unit/op_mov
add wave -noupdate /duttb/top_unit/op_done
add wave -noupdate /duttb/top_unit/op_add
add wave -noupdate /duttb/top_unit/op_sub
add wave -noupdate /duttb/top_unit/op_jmp
add wave -noupdate /duttb/top_unit/op_jc
add wave -noupdate /duttb/top_unit/op_and
add wave -noupdate /duttb/top_unit/op_or
add wave -noupdate /duttb/top_unit/op_xor
add wave -noupdate /duttb/top_unit/op_jnc
add wave -noupdate /duttb/top_unit/Nflag
add wave -noupdate /duttb/top_unit/Zflag
add wave -noupdate /duttb/top_unit/Cflag
add wave -noupdate /duttb/top_unit/Mem_wr
add wave -noupdate /duttb/top_unit/Mem_out
add wave -noupdate /duttb/top_unit/Mem_in
add wave -noupdate /duttb/top_unit/Cout
add wave -noupdate /duttb/top_unit/Cin
add wave -noupdate /duttb/top_unit/Ain
add wave -noupdate /duttb/top_unit/RFin
add wave -noupdate /duttb/top_unit/RFout
add wave -noupdate /duttb/top_unit/IRin
add wave -noupdate /duttb/top_unit/PCin
add wave -noupdate /duttb/top_unit/Imm1_in
add wave -noupdate /duttb/top_unit/Imm2_in
add wave -noupdate /duttb/top_unit/OPC
add wave -noupdate /duttb/top_unit/RFaddr
add wave -noupdate /duttb/top_unit/PCsel
add wave -noupdate /duttb/top_unit/ControlUnitInst/pr_state
add wave -noupdate /duttb/top_unit/ControlUnitInst/nx_state
add wave -noupdate /duttb/top_unit/DatapathInst/FetchSmallCycleInst/IROut
add wave -noupdate /duttb/top_unit/DatapathInst/FetchSmallCycleInst/PCCountInst/PC
add wave -noupdate -radix decimal /duttb/top_unit/DatapathInst/MainBus
add wave -noupdate /duttb/top_unit/DatapathInst/DataMemInOut
add wave -noupdate /duttb/top_unit/ControlUnitInst/NflagSig
add wave -noupdate /duttb/top_unit/ControlUnitInst/ZflagSig
add wave -noupdate /duttb/top_unit/ControlUnitInst/CflagSig
add wave -noupdate /duttb/top_unit/TBactive
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9533005 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 374
configure wave -valuecolwidth 111
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {9374978 ps} {9531831 ps}
