				-- Top Level Structural Model for MIPS Processor Core
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE work.aux_package.all;

ENTITY MIPS IS
	GENERIC (ModelSim			: BOOLEAN := true;
			 adressSize			: INTEGER := 9);	
	PORT(reset, clock				: IN 	STD_LOGIC; 
		 INTR						: IN 	STD_LOGIC;
		 INTA 						: OUT	STD_LOGIC;
		 GIEOut						: OUT 	STD_LOGIC;
		 MemReadOut, MemWriteOut	: OUT	STD_LOGIC;
		 Addr						: OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0);
		 data						: INOUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END MIPS;

ARCHITECTURE structure OF MIPS IS

	SIGNAL read_data_1 					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data_2 					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Sign_Extend 					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Add_result 					: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL ALU_result 					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_data 					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_dataMEM					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_dataPer					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL ALUSrc 						: STD_LOGIC;
	SIGNAL Branch 						: STD_LOGIC;
	SIGNAL RegDst 						: STD_LOGIC;
	SIGNAL Regwrite 					: STD_LOGIC;
	SIGNAL JAL		 					: STD_LOGIC;
	SIGNAL bCond 						: STD_LOGIC;
	SIGNAL MemWrite 					: STD_LOGIC;
	SIGNAL MemWriteMEM					: STD_LOGIC;
	SIGNAL MemtoReg 					: STD_LOGIC;
	SIGNAL MemRead 						: STD_LOGIC;
	SIGNAL MemReadMEM 					: STD_LOGIC;
	SIGNAL Instruction					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Jump							: STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	SIGNAL ALUControl 					: STD_LOGIC_VECTOR( 3 DOWNTO 0 );
	SIGNAL PCPlus4						: STD_LOGIC_VECTOR( 11 DOWNTO 0 );
	SIGNAL GIE	 						: STD_LOGIC;
	SIGNAL GIEOff      					: STD_LOGIC;
	SIGNAL StorePC						: STD_LOGIC;
	SIGNAL SavedPC						: STD_LOGIC_VECTOR( 11 DOWNTO 0 );
	SIGNAL GIEOn      					: STD_LOGIC;
	SIGNAL NxtPCOut						: STD_LOGIC_VECTOR( 11 DOWNTO 0 );
	SIGNAL InterruptInstructionValid    : STD_LOGIC;
	SIGNAL InterruptInstruction			: STD_LOGIC_VECTOR( 31 DOWNTO 0);

BEGIN
	GIEOut <= GIE;
	Addr <= ALU_result;
	MemReadOut <= MemRead;
	MemWriteOut <= MemWrite; 
	MemWriteMEM <= MemWrite and (not ALU_result(11));
    MemReadMEM <= MemRead and (not ALU_result(11));
    busPinALU  : BidirPin generic map (32) port map (Dout => read_data_2, en => MemWrite, Din => read_dataPer, IOpin => data);
	read_data <= read_dataPer WHEN MemRead = '1' and  ALU_result(11) = '1' ELSE read_dataMEM;
	--busPinDMEM : BidirPin generic map (32) port map (Dout => DMEM_to_bus, en => DMEM_MemRead, Din => DMEM_from_bus, IOpin => BiDirBus); -- DMEM BidirPin

  IFE : Ifetch
	GENERIC MAP (ModelSim					=> ModelSim,
				 adressSize					=> adressSize)
	PORT MAP (	InstructionOut 				=> Instruction,
    	    	PC_plus_4_out 				=> PCPlus4,
				NxtPCOut					=> NxtPCOut,
				Add_result 					=> Add_result,
				Branch 						=> Branch,
				bCond 						=> bCond,
				Jump						=> Jump,
				read_data_1					=> read_data_1,
				InterruptInstructionValid   => InterruptInstructionValid,
				InterruptInstruction		=> InterruptInstruction,
				clock 						=> clock,  
				reset 						=> reset );

   ID : Idecode
   	PORT MAP (	read_data_1 	=> read_data_1,
        		read_data_2 	=> read_data_2,
        		Instruction 	=> Instruction,
        		read_data 		=> read_data,
				ALU_result 		=> ALU_result,
				PCPlus4			=> PCPlus4,
				RegWrite 		=> RegWrite,
				JALctl			=> JAL,
				MemtoReg 		=> MemtoReg,
				RegDst 			=> RegDst,
				Sign_extend 	=> Sign_extend,
        		clock 			=> clock,  
				reset 			=> reset,
				GIE				=> GIE,
				GIEOff			=> GIEOff,
				StorePC			=> StorePC,
				SavedPC			=> SavedPC,
				GIEOn			=> GIEOn);

   CTL: control
	PORT MAP ( 	Opcode 			=> Instruction( 31 DOWNTO 26 ),
				FuncOpcode		=> Instruction( 5 DOWNTO 0 ),
				RegDst 			=> RegDst,
				ALUSrc 			=> ALUSrc,
				MemtoReg 		=> MemtoReg,
				RegWrite 		=> RegWrite,
				MemRead 		=> MemRead,
				MemWrite 		=> MemWrite,
				BranchOut 		=> Branch,
				Jump			=> Jump,
				JAL 			=> JAL,
				ALUControl		=> ALUControl);

   EXE:  Execute
   	PORT MAP (	Read_data_1 	=> read_data_1,
             	Read_data_2 	=> read_data_2,
				Sign_extend 	=> Sign_extend,
				ALUControl		=> ALUControl,
				ALUSrc 			=> ALUSrc,
				bCond 			=> bCond,
                ALU_Result		=> ALU_Result,
				Add_Result 		=> Add_Result,
				PC_plus_4		=> PCPlus4);

   MEM:  dmemory
   GENERIC MAP (ModelSim					=> ModelSim,
   				adressSize					=> adressSize)
	PORT MAP (	read_data 		=> read_dataMEM,
				address 		=> ALU_Result (11 DOWNTO 0),--jump memory address by 4
				write_data 		=> read_data_2,
				MemRead 		=> MemReadMEM, 
				Memwrite 		=> MemWriteMEM, 
                clock 			=> clock,  
				reset 			=> reset );

   INTERRUPT: MipsInterruptHandler
	PORT MAP (	clock						=> clock,
				reset	        			=> reset,
				instruction					=> instruction,
				NxtPCOut        			=> NxtPCOut,
				INTR           			 	=> INTR,
				INTA            			=> INTA,
				InterruptInstructionValid   => InterruptInstructionValid,
				GIEOff                      => GIEOff,
				GIEOn                       => GIEOn,
				StorePC                     => StorePC,
				SavedPC                     => SavedPC,
				InterruptInstruction        => InterruptInstruction);
END structure;

