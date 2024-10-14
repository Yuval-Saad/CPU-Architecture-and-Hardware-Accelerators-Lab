onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/rst
add wave -noupdate /tb_top/clk
add wave -noupdate /tb_top/enb
add wave -noupdate /tb_top/Y_i
add wave -noupdate /tb_top/X_i
add wave -noupdate /tb_top/ALUFN_i
add wave -noupdate /tb_top/PWMout
add wave -noupdate /tb_top/top_inst/PWMInst/rst
add wave -noupdate /tb_top/top_inst/PWMInst/enb
add wave -noupdate /tb_top/top_inst/PWMInst/clk
add wave -noupdate /tb_top/top_inst/PWMInst/Y
add wave -noupdate /tb_top/top_inst/PWMInst/X
add wave -noupdate /tb_top/top_inst/PWMInst/ALUFN
add wave -noupdate /tb_top/top_inst/PWMInst/PWMout
add wave -noupdate /tb_top/top_inst/PWMInst/count
add wave -noupdate /tb_top/top_inst/PWMInst/zeros_vector
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {850086 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 304
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
WaveRestoreZoom {0 ps} {8656916 ps}
