onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tblogic/L2/Y
add wave -noupdate /tblogic/L2/X
add wave -noupdate /tblogic/L2/ALUFN
add wave -noupdate /tblogic/L2/res
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2359003 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {1536 ns} {2560 ns}
