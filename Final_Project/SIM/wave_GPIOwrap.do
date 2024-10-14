onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_gpiowrap/MemWrite
add wave -noupdate /tb_gpiowrap/MemRead
add wave -noupdate /tb_gpiowrap/Address
add wave -noupdate -radix hexadecimal /tb_gpiowrap/Data
add wave -noupdate -radix hexadecimal /tb_gpiowrap/SW
add wave -noupdate -radix hexadecimal /tb_gpiowrap/LEDs
add wave -noupdate -radix hexadecimal /tb_gpiowrap/GPIOwrap_inst/HEX5Port/PortOut
add wave -noupdate -radix hexadecimal /tb_gpiowrap/GPIOwrap_inst/HEX4Port/PortOut
add wave -noupdate -radix hexadecimal /tb_gpiowrap/GPIOwrap_inst/HEX3Port/PortOut
add wave -noupdate -radix hexadecimal /tb_gpiowrap/GPIOwrap_inst/HEX2Port/PortOut
add wave -noupdate -radix hexadecimal /tb_gpiowrap/GPIOwrap_inst/HEX1Port/PortOut
add wave -noupdate -radix hexadecimal /tb_gpiowrap/GPIOwrap_inst/HEX0Port/PortOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {16200000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 442
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
WaveRestoreZoom {10449472 ps} {17150528 ps}
