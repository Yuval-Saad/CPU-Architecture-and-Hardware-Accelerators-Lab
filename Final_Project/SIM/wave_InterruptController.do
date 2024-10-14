onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/rst
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/clk
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/MemWrite
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/MemRead
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/irq
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/addr
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/data
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/IFG
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/IE
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/OutType
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/GIE
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/INTR
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/INTA
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/TXBUFRead
add wave -noupdate -radix hexadecimal /tb_interruptcontroller/InterruptControllerWrapInst/RXBUFRead
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1887156 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 399
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
WaveRestoreZoom {0 ps} {2100 ns}
