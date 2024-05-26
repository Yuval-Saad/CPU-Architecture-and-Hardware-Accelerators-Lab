onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tbshifter/dir
add wave -noupdate /tbshifter/X2
add wave -noupdate /tbshifter/Y2
add wave -noupdate /tbshifter/reso2
add wave -noupdate /tbshifter/cout2
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {585790 ps} 0}
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
WaveRestoreZoom {236135 ps} {1260135 ps}
