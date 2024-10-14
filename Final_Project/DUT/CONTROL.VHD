		-- control module (implements MIPS control unit)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY control IS
   PORT( 	
	Opcode 		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	FuncOpcode	: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
	RegDst 		: OUT 	STD_LOGIC;
	ALUSrc 		: OUT 	STD_LOGIC;
	MemtoReg 	: OUT 	STD_LOGIC;
	RegWrite 	: OUT 	STD_LOGIC;
	MemRead 	: OUT 	STD_LOGIC;
	MemWrite 	: OUT 	STD_LOGIC;
	BranchOut 	: OUT 	STD_LOGIC;
	Jump		: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
	JAL		 	: OUT 	STD_LOGIC;
	ALUControl 	: OUT 	STD_LOGIC_VECTOR( 3 DOWNTO 0 ));
END control;

ARCHITECTURE behavior OF control IS

	SIGNAL  R_format, Immidiate, J, JR, JALop, Branch, Lw, Sw, Shift : STD_LOGIC;
	SIGNAL  ANDop, ORop, ADDop, SUBop, SRLop, SLLop, MULop, XORop, SLTop, LUIop : STD_LOGIC;

BEGIN           
	R_format 	<= 	'1'	 WHEN  (Opcode = "000000" and FuncOpcode(5) = '1') or Opcode = "011100" ELSE '0';
	Immidiate   <=  '1'  WHEN  Opcode(5 DOWNTO 3) = "001"  ELSE '0';
	JR			<=  '1'  WHEN  (Opcode = "000000" and FuncOpcode(5 DOWNTO 3) = "001") ELSE '0';
	J 			<=  '1'  WHEN  Opcode = "0000010"  ELSE '0';
	JALop		<=	'1'	 WHEN  Opcode = "0000011"  ELSE '0';
	Branch		<=  '1'	 WHEN  Opcode(5 downto 2) = "0001"  ELSE '0';
	Lw          <=  '1'  WHEN  Opcode = "100011"  ELSE '0';
 	Sw          <=  '1'  WHEN  Opcode = "101011"  ELSE '0';
	Shift		<=	'1'  WHEN  (Opcode = "000000" and FuncOpcode(5 DOWNTO 3) = "000") ELSE '0';
  	RegDst    	<=  R_format OR Shift;
 	ALUSrc  	<=  Immidiate OR Lw OR Sw OR Shift;
	MemtoReg 	<=  Lw;
  	RegWrite 	<=  R_format OR Immidiate OR JALop OR Lw OR Shift;
  	MemRead 	<=  Lw;
   	MemWrite 	<=  Sw; 
	BranchOut   <=  Branch;
	Jump		<=  "10" WHEN JR = '1' ELSE "01" WHEN J = '1' OR JALop = '1' ELSE "00"; 
	JAL			<=  JALop;

	ANDop 		<= 	'1' WHEN (Opcode = "000000" and FuncOpcode = "100100") or Opcode = "001100" ELSE '0';
	ORop		<=  '1' WHEN (Opcode = "000000" and FuncOpcode = "100101") or Opcode = "001101" ELSE '0';
	ADDop		<=  '1' WHEN (Opcode = "000000" and (FuncOpcode = "100000" or FuncOpcode = "100001")) or Opcode = "001000" or Opcode = "100011" or Opcode = "101011" ELSE '0';
	SUBop		<=  '1' WHEN (Opcode = "000000" and FuncOpcode = "100010") or Opcode = "000100" ELSE '0';
	SRLop		<=  '1' WHEN (Opcode = "000000" and FuncOpcode = "000010") ELSE '0';
	SLLop		<=  '1' WHEN (Opcode = "000000" and FuncOpcode = "000000") ELSE '0';
	MULop		<=  '1' WHEN Opcode = "011100" ELSE '0';
	XORop		<=  '1' WHEN (Opcode = "000000" and FuncOpcode = "100110") or Opcode = "001110" ELSE '0';
	SLTop		<=  '1' WHEN (Opcode = "000000" and FuncOpcode = "101010") or Opcode = "000101" or Opcode = "001010" ELSE '0';
	LUIop		<=  '1' WHEN Opcode = "001111" ELSE '0';

	ALUControl <= "0000" WHEN ANDop = '1' ELSE
				  "0001" WHEN ORop = '1' ELSE
				  "0010" WHEN ADDop = '1' ELSE
				  "0011" WHEN SUBop = '1' ELSE
				  "0100" WHEN SRLop = '1' ELSE
				  "0101" WHEN SLLop = '1' ELSE
				  "0110" WHEN MULop = '1' ELSE
				  "0111" WHEN XORop = '1' ELSE
				  "1011" WHEN SLTop = '1' ELSE
				  "1111" WHEN LUIop = '1' ELSE "0000";
END behavior;


