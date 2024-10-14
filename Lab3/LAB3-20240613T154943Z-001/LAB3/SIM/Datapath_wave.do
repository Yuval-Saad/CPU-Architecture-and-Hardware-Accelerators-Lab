onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapathtb/IRin
add wave -noupdate /datapathtb/PCin
add wave -noupdate /datapathtb/Imm1_in
add wave -noupdate /datapathtb/Imm2_in
add wave -noupdate /datapathtb/OPC
add wave -noupdate /datapathtb/RFaddr
add wave -noupdate /datapathtb/PCsel
add wave -noupdate /datapathtb/clk
add wave -noupdate /datapathtb/rst
add wave -noupdate /datapathtb/MemProgIn
add wave -noupdate /datapathtb/WrenProgIn
add wave -noupdate /datapathtb/WAddrProgIn
add wave -noupdate /datapathtb/op_st
add wave -noupdate /datapathtb/op_ld
add wave -noupdate /datapathtb/op_mov
add wave -noupdate /datapathtb/op_done
add wave -noupdate /datapathtb/op_add
add wave -noupdate /datapathtb/op_sub
add wave -noupdate /datapathtb/op_jmp
add wave -noupdate /datapathtb/op_jc
add wave -noupdate /datapathtb/op_and
add wave -noupdate /datapathtb/op_or
add wave -noupdate /datapathtb/op_xor
add wave -noupdate /datapathtb/op_jnc
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
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
WaveRestoreZoom {0 ps} {2625 ns}
