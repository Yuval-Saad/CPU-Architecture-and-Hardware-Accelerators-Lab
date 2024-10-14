onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /controlunittb/clk
add wave -noupdate /controlunittb/rst
add wave -noupdate /controlunittb/enb
add wave -noupdate /controlunittb/done
add wave -noupdate /controlunittb/op_st
add wave -noupdate /controlunittb/op_ld
add wave -noupdate /controlunittb/op_mov
add wave -noupdate /controlunittb/op_done
add wave -noupdate /controlunittb/op_add
add wave -noupdate /controlunittb/op_sub
add wave -noupdate /controlunittb/op_jmp
add wave -noupdate /controlunittb/op_jc
add wave -noupdate /controlunittb/op_and
add wave -noupdate /controlunittb/op_or
add wave -noupdate /controlunittb/op_xor
add wave -noupdate /controlunittb/op_jnc
add wave -noupdate /controlunittb/Nflag
add wave -noupdate /controlunittb/Zflag
add wave -noupdate /controlunittb/Cflag
add wave -noupdate /controlunittb/Mem_wr
add wave -noupdate /controlunittb/Mem_out
add wave -noupdate /controlunittb/Mem_in
add wave -noupdate /controlunittb/Cout
add wave -noupdate /controlunittb/Cin
add wave -noupdate /controlunittb/Ain
add wave -noupdate /controlunittb/RFin
add wave -noupdate /controlunittb/RFout
add wave -noupdate /controlunittb/IRin
add wave -noupdate /controlunittb/PCin
add wave -noupdate /controlunittb/Imm1_in
add wave -noupdate /controlunittb/Imm2_in
add wave -noupdate /controlunittb/OPC
add wave -noupdate /controlunittb/RFaddr
add wave -noupdate /controlunittb/PCsel
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {297781 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 204
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {5075216 ps}
