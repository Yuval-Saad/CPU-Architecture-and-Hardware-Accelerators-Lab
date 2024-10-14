onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/rst
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/clk
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/MemWrite
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/MemRead
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/addr
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/data
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/DivIFG
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/OutQuatient
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/OutResidue
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/OutDivisor
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/OutDividend
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/setDividend
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/setDivisor
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/DataOut
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/DataIn
add wave -noupdate -radix hexadecimal /tb_divider/Divider_inst/writeToBusEn
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/rst
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/clk
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/EN
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/Data
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/setDividend
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/setDivisor
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/OutQuatient
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/OutResidue
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/OutDivisor
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/OutDividend
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/DivIFG
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/Divisor
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/Quatient
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/Residue
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/Dividend
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/pos
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/SubResult
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/SubSign
add wave -noupdate -group DividerCore -radix hexadecimal /tb_divider/Divider_inst/DividerInst/DividendRegister
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {118 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 397
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
WaveRestoreZoom {0 ps} {717 ps}
