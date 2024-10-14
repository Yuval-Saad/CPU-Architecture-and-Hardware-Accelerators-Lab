-- Ifetch module (provides the PC and instruction 
--memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY Ifetch IS
	GENERIC (ModelSim			: BOOLEAN := true;
			 adressSize			: INTEGER := 10);
	PORT(	InstructionOut 				: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	PC_plus_4_out 				: OUT	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
			NxtPCOut					: OUT	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
        	Add_result 					: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        	Branch 						: IN 	STD_LOGIC;
        	bCond 						: IN 	STD_LOGIC;
			Jump						: IN  	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			read_data_1  				: IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			InterruptInstructionValid   : IN 	STD_LOGIC;
            InterruptInstruction        : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0);
        	clock, reset 				: IN 	STD_LOGIC);
END Ifetch;

ARCHITECTURE behavior OF Ifetch IS
	SIGNAL PC, PC_plus_4 	 : STD_LOGIC_VECTOR( 11 DOWNTO 0 );
	SIGNAL next_PC 			 : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL Mem_Addr			 : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL pre_Next_PC		 : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL JumpAddress		 : STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL InstructionMEM	 : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Instruction		 : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL real_address 	 : STD_LOGIC_VECTOR(adressSize-1 DOWNTO 0);


BEGIN

modelSimCase : if (ModelSim = TRUE) GENERATE
	real_address <= Mem_Addr;
END GENERATE;
QuartusCase : if (ModelSim = FALSE) GENERATE
	real_address <= Mem_Addr & "00";
END GENERATE;

						--ROM for Instruction Memory
inst_memory: altsyncram
	
	GENERIC MAP (operation_mode 			=> "ROM",
				 width_a 					=> 32,
			  	 widthad_a 					=> adressSize,
				 numwords_a 				=> 2**adressSize,
				 lpm_hint 					=> "ENABLE_RUNTIME_MOD = YES,INSTANCE_NAME = ITCM",
				 lpm_type 					=> "altsyncram",
				 outdata_reg_a 				=> "UNREGISTERED",
				 init_file 					=> "C:\Yoni\ModelSim\HW_ACCELERATORS_PROJ\Final_Project\TestMem\DriveTests\Interrupt based IO\test3\ITCM.hex",
				 intended_device_family 	=> "Cyclone")
	PORT MAP 	(clock0     				=> clock,
				 address_a 					=> real_address, 
				 q_a 						=> InstructionMEM);
					-- Instructions always start on word address - not byte
		PC(1 DOWNTO 0) <= "00";
					-- copy output signals - allows read inside module
		PC_plus_4_out 	<= PC_plus_4;
						-- send address to inst. memory address register
		Mem_Addr <= Next_PC;
						-- Adder to increment PC by 4        
      	PC_plus_4( 11 DOWNTO 2 )  <= PC( 11 DOWNTO 2 ) + 1;
       	PC_plus_4( 1 DOWNTO 0 )  <= "00";
						-- Mux to select Branch Address or PC + 4        
		pre_Next_PC  <= X"00" & B"00"  WHEN Reset = '1' ELSE
			Add_result  WHEN ( ( Branch = '1' ) AND ( bCond = '1' ) ) 
			ELSE PC_plus_4( 11 DOWNTO 2 );

		Next_PC <= X"00" & "00"  WHEN Reset = '1' ELSE
				   read_data_1( 11 DOWNTO 2 ) WHEN Jump = "10" ELSE
				   JumpAddress WHEN Jump = "01" ELSE pre_Next_PC;
		-- WITH Jump SELECT
		-- 	Next_PC <= read_data_1( 10 DOWNTO 2 ) WHEN "10",
		-- 			   JumpAddress WHEN "01",
		-- 			   pre_Next_PC WHEN OTHERS;

		Instruction <= InterruptInstruction WHEN InterruptInstructionValid = '1' ELSE InstructionMEM;
		InstructionOut <= Instruction;
		JumpAddress <= Instruction( 9 DOWNTO 0 );
		NxtPCOut <= Next_PC & "00";
	PROCESS
		BEGIN
			WAIT UNTIL ( clock'EVENT ) AND ( clock = '1' );
			IF reset = '1' THEN
				   PC( 11 DOWNTO 2) <= "0000000000"; 
			ELSE 
				   PC( 11 DOWNTO 2 ) <= next_PC;
			END IF;
	END PROCESS;
END behavior;


