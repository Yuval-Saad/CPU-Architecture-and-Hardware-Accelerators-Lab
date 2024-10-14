onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/clock
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/RXUART
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/TXUART
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/SW
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/KEY
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/PWMout
add wave -noupdate -expand -group HEX -radix hexadecimal /tb_top/TOP_INST/HEX0
add wave -noupdate -expand -group HEX -radix hexadecimal /tb_top/TOP_INST/HEX1
add wave -noupdate -expand -group HEX -radix hexadecimal /tb_top/TOP_INST/HEX2
add wave -noupdate -expand -group HEX -radix hexadecimal /tb_top/TOP_INST/HEX3
add wave -noupdate -expand -group HEX -radix hexadecimal /tb_top/TOP_INST/HEX4
add wave -noupdate -expand -group HEX -radix hexadecimal /tb_top/TOP_INST/HEX5
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/LEDs
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/INTR
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/INTA
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/MemRead
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/MemWrite
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/addr
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/data
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/irq
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/GIE
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/TXBUFRead
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/RXBUFRead
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/DivIFG
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/set_BTIFG
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/AddrToGPIO
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/SystemKeys
add wave -noupdate -radix hexadecimal /tb_top/TOP_INST/reset
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/reset
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/clock
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTR
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTA
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/GIEOut
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MemReadOut
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MemWriteOut
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/Addr
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/data
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/read_data_1
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/read_data_2
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/Sign_Extend
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/Add_result
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ALU_result
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/read_data
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/read_dataMEM
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/read_dataPer
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ALUSrc
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/Branch
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/RegDst
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/Regwrite
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/JAL
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/bCond
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MemWrite
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MemWriteMEM
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MemtoReg
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MemRead
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MemReadMEM
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/Instruction
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/Jump
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ALUControl
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/PCPlus4
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/GIE
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/GIEOff
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/StorePC
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/SavedPC
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/GIEOn
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/NxtPCOut
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/InterruptInstructionValid
add wave -noupdate -group MIPS -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/InterruptInstruction
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/InstructionOut
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/PC_plus_4_out
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/NxtPCOut
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/Add_result
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/Branch
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/bCond
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/Jump
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/read_data_1
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/InterruptInstructionValid
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/InterruptInstruction
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/clock
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/reset
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/PC
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/PC_plus_4
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/next_PC
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/Mem_Addr
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/pre_Next_PC
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/JumpAddress
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/InstructionMEM
add wave -noupdate -group FETCH -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/IFE/Instruction
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/read_data_1
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/read_data_2
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/Instruction
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/read_data
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/ALU_result
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/PCPlus4
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/RegWrite
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/JALctl
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/MemtoReg
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/RegDst
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/Sign_extend
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/clock
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/reset
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/GIE
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/GIEOff
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/StorePC
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/SavedPC
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/GIEOn
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/register_array
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/pre_write_register_address
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/write_register_address
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/pre_write_data
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/write_data
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/read_register_1_address
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/read_register_2_address
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/write_register_address_1
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/write_register_address_0
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/Instruction_immediate_value
add wave -noupdate -group DECODE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/ID/ra_registe_address
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/Opcode
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/FuncOpcode
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/RegDst
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/ALUSrc
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/MemtoReg
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/RegWrite
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/MemRead
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/MemWrite
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/BranchOut
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/Jump
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/JAL
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/ALUControl
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/R_format
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/Immidiate
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/J
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/JR
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/JALop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/Branch
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/Lw
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/Sw
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/ANDop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/ORop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/ADDop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/SUBop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/SRLop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/SLLop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/MULop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/XORop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/SLTop
add wave -noupdate -group CONTROL -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/CTL/LUIop
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/Read_data_1
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/Read_data_2
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/Sign_extend
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/ALUControl
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/ALUSrc
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/bCond
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/ALU_Result
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/Add_Result
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/PC_plus_4
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/Ainput
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/Binput
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/ALU_output_mux
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/Branch_Add
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/ALU_ctl
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/zero
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/OutShilfer
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/toShift
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/numShifts
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/mulResult
add wave -noupdate -group EXECUTE -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/EXE/ShiftDir
add wave -noupdate -group MEM -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MEM/read_data
add wave -noupdate -group MEM -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MEM/address
add wave -noupdate -group MEM -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MEM/write_data
add wave -noupdate -group MEM -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MEM/MemRead
add wave -noupdate -group MEM -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MEM/Memwrite
add wave -noupdate -group MEM -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MEM/clock
add wave -noupdate -group MEM -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MEM/reset
add wave -noupdate -group MEM -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/MEM/write_clock
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/clock
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/reset
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/instruction
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/NxtPCOut
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/INTR
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/INTA
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/InterruptInstructionValid
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/GIEOff
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/GIEOn
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/StorePC
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/SavedPC
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/InterruptInstruction
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/curr_state
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/gotReti
add wave -noupdate -group INTERRUPTHANDLER -radix hexadecimal /tb_top/TOP_INST/MIPS_INST/INTERRUPT/next_state
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/rst
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/clk
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/MemWrite
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/MemRead
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/irq
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/addr
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/GIE
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/INTA
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/TXBUFRead
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/RXBUFRead
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/INTR
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/data
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/clr_irq
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/setIFG
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/writeIE
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/IFG
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/IE
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/OutType
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/writeToBusEn
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/DataIn
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/DataOut
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/SWIFGWrite
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/NotSWIFGWrite
add wave -noupdate -group INTERRUPTCONTROLLER -radix hexadecimal /tb_top/TOP_INST/InterruptController_INST/INTAClear
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/rst
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/clk
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/MemWrite
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/MemRead
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/addr
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/data
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/DivIFG
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/OutQuatient
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/OutResidue
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/OutDivisor
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/OutDividend
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/setDividend
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/setDivisor
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/DataOut
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/DataIn
add wave -noupdate -group DIVIDER -radix hexadecimal /tb_top/TOP_INST/Divider_INST/writeToBusEn
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/rst
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/clk
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/MemWrite
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/MemRead
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/addr
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/data
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/set_BTIFG
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/PWMout
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/BTCCR0
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/BTCCR1
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/BTCTL
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/BTCNT
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/BTCNT_internal
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/WriteTimer
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/DataOut
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/DataIn
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/writeToBusEn
add wave -noupdate -group TIMER -radix hexadecimal /tb_top/TOP_INST/Timer_INST/nextTimer
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/MemWrite
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/MemRead
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/Address
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/Data
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/SW
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX0
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX1
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX2
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX3
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX4
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX5
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/LEDs
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/CS
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX0DecodeInput
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX1DecodeInput
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX2DecodeInput
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX3DecodeInput
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX4DecodeInput
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/HEX5DecodeInput
add wave -noupdate -group GPIO -radix hexadecimal /tb_top/TOP_INST/GPIO_INST/NotA0
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2773119 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 297
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
WaveRestoreZoom {2894297 ps} {3309480 ps}
