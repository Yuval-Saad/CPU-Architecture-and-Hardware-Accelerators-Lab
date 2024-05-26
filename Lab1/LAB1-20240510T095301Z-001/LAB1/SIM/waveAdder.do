onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbaddersub/A2/sub_cont
add wave -noupdate -radix decimal /tbaddersub/A2/Y
add wave -noupdate -radix decimal /tbaddersub/A2/X
add wave -noupdate -radix decimal /tbaddersub/A2/res
add wave -noupdate /tbaddersub/A2/cout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {361975 ps} 0}
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
WaveRestoreZoom {0 ps} {1024 ns}
