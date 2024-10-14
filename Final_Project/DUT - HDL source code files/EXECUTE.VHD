--  Execute module (implements the data ALU and Branch Address Adder  
--  for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
use work.aux_package.all;


ENTITY  Execute IS
	PORT(	Read_data_1 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Read_data_2 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Sign_extend 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ALUControl 		: IN 	STD_LOGIC_VECTOR( 3 DOWNTO 0 );
			ALUSrc 			: IN 	STD_LOGIC;
			bCond 			: OUT	STD_LOGIC;
			ALU_Result 		: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Add_Result 		: OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
			PC_plus_4 		: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 ));
END Execute;

ARCHITECTURE behavior OF Execute IS
	SIGNAL Ainput, Binput 	: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL ALU_output_mux	: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL Branch_Add 		: STD_LOGIC_VECTOR( 9 DOWNTO 0 );
	SIGNAL ALU_ctl			: STD_LOGIC_VECTOR( 2 DOWNTO 0 );
	SIGNAL zero				: STD_LOGIC;
	SIGNAL OutShilfer	    : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL toShift, numShifts : STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL mulResult 		: STD_LOGIC_VECTOR( 63 DOWNTO 0 );
	SIGNAL ShiftDir			: STD_LOGIC;

BEGIN
	Ainput <= Read_data_1;
						-- ALU input mux
	Binput <= Read_data_2 
		WHEN ( ALUSrc = '0' ) 
  		ELSE  Sign_extend( 31 DOWNTO 0 );
						-- Generate Zero Flag
	zero <= '1' 
		WHEN ( ALU_output_mux( 31 DOWNTO 0 ) = X"00000000"  )
		ELSE '0';    
	bCond <= zero WHEN ALUControl(3) = '0' ELSE NOT zero;
						-- Select ALU output        
	ALU_result <= X"0000000" & B"000"  & ALU_output_mux( 31 ) 
		WHEN  ALUControl = "1011" 
		ELSE  	ALU_output_mux( 31 DOWNTO 0 );
						-- Adder to compute Branch Address
	Branch_Add	<= PC_plus_4( 11 DOWNTO 2 ) +  Sign_extend( 8 DOWNTO 0 ) ;
		Add_result 	<= Branch_Add( 9 DOWNTO 0 );

PROCESS ( ALUControl, Ainput, Binput, mulResult, OutShilfer )
	BEGIN
					-- Select ALU operation
 	CASE ALUControl IS
						-- ALU performs ALUresult = A_input AND B_input
		WHEN "0000" =>	ALU_output_mux 	<= Ainput AND Binput; 
						-- ALU performs ALUresult = A_input OR B_input
     	WHEN "0001" =>	ALU_output_mux 	<= Ainput OR Binput;
						-- ALU performs ALUresult = A_input + B_input
	 	WHEN "0010" =>	ALU_output_mux 	<= Ainput + Binput;
						-- ALU performs ALUresult = A_input -B_input
		WHEN "0011" =>	ALU_output_mux 	<= Ainput - Binput;
		WHEN "0100" =>  ALU_output_mux  <= OutShilfer;
		WHEN "0101" =>  ALU_output_mux  <= OutShilfer;
		WHEN "0110" =>  ALU_output_mux  <= mulResult( 31 DOWNTO 0 );
		WHEN "0111" =>  ALU_output_mux  <= Ainput XOR Binput;
						-- ALU performs ?
		WHEN "1000" =>  ALU_output_mux <= X"00000000";
						-- ALU performs ?
		WHEN "1001" =>  ALU_output_mux <= X"00000000";
						-- ALU performs ?
		WHEN "1010" =>  ALU_output_mux <= X"00000000";
		WHEN "1011" =>  ALU_output_mux <= Ainput - Binput;
						-- ALU performs ?
		WHEN "1100" =>  ALU_output_mux <= X"00000000";
						-- ALU performs ?
		WHEN "1101" =>  ALU_output_mux <= X"00000000";
						-- ALU performs ?
		WHEN "1110" =>  ALU_output_mux <= X"00000000";
		WHEN "1111" =>  ALU_output_mux <= OutShilfer;
 	 	WHEN OTHERS	=>	ALU_output_mux <= X"00000000" ;
  	END CASE;
END PROCESS;

mulResult <= Ainput * Binput;

ShiftDir <= '1' WHEN ALUControl = "0100" ELSE '0';
numShifts <= X"000000" & B"00010000" WHEN ALUControl = "1111" ELSE X"000000" & B"000" & Sign_extend( 10 DOWNTO 6);
toShift <= Sign_extend WHEN ALUControl = "1111" ELSE Read_data_2;

ShilferInst : Shifter generic map (n => 32,
								   k => 5) 
					  port map    (Y => toShift,
					  			   X => numShifts,
								   dir => ShiftDir,
								   cout => open,
								   res => OutShilfer);

END behavior;