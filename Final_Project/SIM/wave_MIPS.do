onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /mips_tb/U_0/reset
add wave -noupdate -radix hexadecimal /mips_tb/U_0/clock
add wave -noupdate -radix hexadecimal /mips_tb/U_0/INTR
add wave -noupdate -radix hexadecimal /mips_tb/U_0/INTA
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MemReadOut
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MemWriteOut
add wave -noupdate -radix hexadecimal /mips_tb/U_0/Addr
add wave -noupdate -radix hexadecimal /mips_tb/U_0/data
add wave -noupdate -radix hexadecimal /mips_tb/U_0/Instruction
add wave -noupdate -radix hexadecimal /mips_tb/U_0/read_data_1
add wave -noupdate -radix hexadecimal /mips_tb/U_0/read_data_2
add wave -noupdate -radix hexadecimal /mips_tb/U_0/Sign_Extend
add wave -noupdate -radix hexadecimal /mips_tb/U_0/Add_result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ALU_result
add wave -noupdate -radix hexadecimal /mips_tb/U_0/read_data
add wave -noupdate -radix hexadecimal /mips_tb/U_0/read_dataMEM
add wave -noupdate -radix hexadecimal /mips_tb/U_0/read_dataPer
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ALUSrc
add wave -noupdate -radix hexadecimal /mips_tb/U_0/Branch
add wave -noupdate -radix hexadecimal /mips_tb/U_0/RegDst
add wave -noupdate -radix hexadecimal /mips_tb/U_0/Regwrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/JAL
add wave -noupdate -radix hexadecimal /mips_tb/U_0/bCond
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MemWrite
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MemWriteMEM
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MemtoReg
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MemRead
add wave -noupdate -radix hexadecimal /mips_tb/U_0/MemReadMEM
add wave -noupdate -radix hexadecimal /mips_tb/U_0/Jump
add wave -noupdate -radix hexadecimal /mips_tb/U_0/ALUControl
add wave -noupdate -radix hexadecimal /mips_tb/U_0/PCPlus4
add wave -noupdate -radix hexadecimal /mips_tb/U_0/GIE
add wave -noupdate -radix hexadecimal /mips_tb/U_0/GIEOff
add wave -noupdate -radix hexadecimal /mips_tb/U_0/StorePC
add wave -noupdate -radix hexadecimal /mips_tb/U_0/SavedPC
add wave -noupdate -radix hexadecimal /mips_tb/U_0/GIEOn
add wave -noupdate -radix hexadecimal /mips_tb/U_0/NxtPCOut
add wave -noupdate -radix hexadecimal /mips_tb/U_0/InterruptInstructionValid
add wave -noupdate -radix hexadecimal /mips_tb/U_0/InterruptInstruction
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/InstructionOut
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4_out
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/NxtPCOut
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/Add_result
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/Branch
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/bCond
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/Jump
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/read_data_1
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/InterruptInstructionValid
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/InterruptInstruction
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/clock
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/reset
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/PC
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/PC_plus_4
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/next_PC
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/Mem_Addr
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/pre_Next_PC
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/JumpAddress
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/InstructionMEM
add wave -noupdate -group Fetch -radix hexadecimal /mips_tb/U_0/IFE/Instruction
add wave -noupdate -group Decode /mips_tb/U_0/ID/read_data_1
add wave -noupdate -group Decode /mips_tb/U_0/ID/read_data_2
add wave -noupdate -group Decode /mips_tb/U_0/ID/Instruction
add wave -noupdate -group Decode /mips_tb/U_0/ID/read_data
add wave -noupdate -group Decode /mips_tb/U_0/ID/ALU_result
add wave -noupdate -group Decode /mips_tb/U_0/ID/PCPlus4
add wave -noupdate -group Decode /mips_tb/U_0/ID/RegWrite
add wave -noupdate -group Decode /mips_tb/U_0/ID/JALctl
add wave -noupdate -group Decode /mips_tb/U_0/ID/MemtoReg
add wave -noupdate -group Decode /mips_tb/U_0/ID/RegDst
add wave -noupdate -group Decode /mips_tb/U_0/ID/Sign_extend
add wave -noupdate -group Decode /mips_tb/U_0/ID/clock
add wave -noupdate -group Decode /mips_tb/U_0/ID/reset
add wave -noupdate -group Decode /mips_tb/U_0/ID/GIE
add wave -noupdate -group Decode /mips_tb/U_0/ID/GIEOff
add wave -noupdate -group Decode /mips_tb/U_0/ID/StorePC
add wave -noupdate -group Decode /mips_tb/U_0/ID/SavedPC
add wave -noupdate -group Decode /mips_tb/U_0/ID/GIEOn
add wave -noupdate -group Decode /mips_tb/U_0/ID/register_array
add wave -noupdate -group Decode /mips_tb/U_0/ID/pre_write_register_address
add wave -noupdate -group Decode /mips_tb/U_0/ID/write_register_address
add wave -noupdate -group Decode /mips_tb/U_0/ID/pre_write_data
add wave -noupdate -group Decode /mips_tb/U_0/ID/write_data
add wave -noupdate -group Decode /mips_tb/U_0/ID/read_register_1_address
add wave -noupdate -group Decode /mips_tb/U_0/ID/read_register_2_address
add wave -noupdate -group Decode /mips_tb/U_0/ID/write_register_address_1
add wave -noupdate -group Decode /mips_tb/U_0/ID/write_register_address_0
add wave -noupdate -group Decode /mips_tb/U_0/ID/Instruction_immediate_value
add wave -noupdate -group Decode /mips_tb/U_0/ID/ra_registe_address
add wave -noupdate -group Control /mips_tb/U_0/CTL/Opcode
add wave -noupdate -group Control /mips_tb/U_0/CTL/FuncOpcode
add wave -noupdate -group Control /mips_tb/U_0/CTL/RegDst
add wave -noupdate -group Control /mips_tb/U_0/CTL/ALUSrc
add wave -noupdate -group Control /mips_tb/U_0/CTL/MemtoReg
add wave -noupdate -group Control /mips_tb/U_0/CTL/RegWrite
add wave -noupdate -group Control /mips_tb/U_0/CTL/MemRead
add wave -noupdate -group Control /mips_tb/U_0/CTL/MemWrite
add wave -noupdate -group Control /mips_tb/U_0/CTL/BranchOut
add wave -noupdate -group Control /mips_tb/U_0/CTL/Jump
add wave -noupdate -group Control /mips_tb/U_0/CTL/JAL
add wave -noupdate -group Control /mips_tb/U_0/CTL/ALUControl
add wave -noupdate -group Control /mips_tb/U_0/CTL/R_format
add wave -noupdate -group Control /mips_tb/U_0/CTL/Immidiate
add wave -noupdate -group Control /mips_tb/U_0/CTL/J
add wave -noupdate -group Control /mips_tb/U_0/CTL/JR
add wave -noupdate -group Control /mips_tb/U_0/CTL/JALop
add wave -noupdate -group Control /mips_tb/U_0/CTL/Branch
add wave -noupdate -group Control /mips_tb/U_0/CTL/Lw
add wave -noupdate -group Control /mips_tb/U_0/CTL/Sw
add wave -noupdate -group Control /mips_tb/U_0/CTL/ANDop
add wave -noupdate -group Control /mips_tb/U_0/CTL/ORop
add wave -noupdate -group Control /mips_tb/U_0/CTL/ADDop
add wave -noupdate -group Control /mips_tb/U_0/CTL/SUBop
add wave -noupdate -group Control /mips_tb/U_0/CTL/SRLop
add wave -noupdate -group Control /mips_tb/U_0/CTL/SLLop
add wave -noupdate -group Control /mips_tb/U_0/CTL/MULop
add wave -noupdate -group Control /mips_tb/U_0/CTL/XORop
add wave -noupdate -group Control /mips_tb/U_0/CTL/SLTop
add wave -noupdate -group Control /mips_tb/U_0/CTL/LUIop
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Read_data_1
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Read_data_2
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Sign_extend
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/ALUControl
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/ALUSrc
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/bCond
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/ALU_Result
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Add_Result
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/PC_plus_4
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Ainput
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Binput
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/ALU_output_mux
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/Branch_Add
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/ALU_ctl
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/zero
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/OutShilfer
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/toShift
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/numShifts
add wave -noupdate -expand -group Execute /mips_tb/U_0/EXE/mulResult
add wave -noupdate -expand -group Execute -radix hexadecimal /mips_tb/U_0/EXE/ShiftDir
add wave -noupdate -group Memory /mips_tb/U_0/MEM/read_data
add wave -noupdate -group Memory /mips_tb/U_0/MEM/address
add wave -noupdate -group Memory /mips_tb/U_0/MEM/write_data
add wave -noupdate -group Memory /mips_tb/U_0/MEM/MemRead
add wave -noupdate -group Memory /mips_tb/U_0/MEM/Memwrite
add wave -noupdate -group Memory /mips_tb/U_0/MEM/clock
add wave -noupdate -group Memory /mips_tb/U_0/MEM/reset
add wave -noupdate -group Memory /mips_tb/U_0/MEM/write_clock
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/clock
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/reset
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/instruction
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/NxtPCOut
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/GIE
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/INTR
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/INTA
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/InterruptInstructionValid
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/GIEOff
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/GIEOn
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/StorePC
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/SavedPC
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/InterruptInstruction
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/curr_state
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/next_state
add wave -noupdate -group Interrupt /mips_tb/U_0/INTERRUPT/gotReti
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {500589 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 403
configure wave -valuecolwidth 188
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
WaveRestoreZoom {0 ps} {337919 ps}
