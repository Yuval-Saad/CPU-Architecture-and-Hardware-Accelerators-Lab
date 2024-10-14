onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_timer/Timer_inst/rst
add wave -noupdate /tb_timer/Timer_inst/clk
add wave -noupdate /tb_timer/Timer_inst/MemWrite
add wave -noupdate /tb_timer/Timer_inst/MemRead
add wave -noupdate -radix hexadecimal /tb_timer/Timer_inst/addr
add wave -noupdate -radix decimal /tb_timer/Timer_inst/data
add wave -noupdate /tb_timer/Timer_inst/set_BTIFG
add wave -noupdate /tb_timer/Timer_inst/PWMout
add wave -noupdate -radix decimal /tb_timer/Timer_inst/BTCCR0
add wave -noupdate -radix decimal /tb_timer/Timer_inst/BTCCR1
add wave -noupdate -radix hexadecimal /tb_timer/Timer_inst/BTCTL
add wave -noupdate -radix binary /tb_timer/Timer_inst/BTCNT
add wave -noupdate -radix decimal /tb_timer/Timer_inst/nextTimer
add wave -noupdate /tb_timer/Timer_inst/WriteTimer
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {381677 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 250
configure wave -valuecolwidth 230
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
WaveRestoreZoom {0 ps} {878363 ps}
