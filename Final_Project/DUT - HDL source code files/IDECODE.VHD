						--  Idecode module (implements the register file for
LIBRARY IEEE; 			-- the MIPS computer)
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY Idecode IS
	  PORT(	read_data_1	: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data_2	: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			Instruction : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			read_data 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			ALU_result	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			PCPlus4		: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 ); -- to mux for ra (jal)
			RegWrite 	: IN 	STD_LOGIC;
			JALctl		: IN	STD_LOGIC; -- for mux to ra 
			MemtoReg 	: IN 	STD_LOGIC;
			RegDst 		: IN 	STD_LOGIC;
			Sign_extend : OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			clock,reset	: IN 	STD_LOGIC;
			GIE 		: OUT 	STD_LOGIC;
			GIEOff      : IN 	STD_LOGIC;
			StorePC		: IN 	STD_LOGIC;
			SavedPC		: IN	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
			GIEOn       : IN 	STD_LOGIC);
END Idecode;


ARCHITECTURE behavior OF Idecode IS
TYPE register_file IS ARRAY ( 0 TO 31 ) OF STD_LOGIC_VECTOR( 31 DOWNTO 0 );

	SIGNAL register_array				: register_file;
	SIGNAL pre_write_register_address 	: STD_LOGIC_VECTOR( 4 DOWNTO 0 ); -- new
	SIGNAL write_register_address 		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL pre_write_data				: STD_LOGIC_VECTOR( 31 DOWNTO 0 ); -- new
	SIGNAL write_data					: STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	SIGNAL read_register_1_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL read_register_2_address		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_register_address_1		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL write_register_address_0		: STD_LOGIC_VECTOR( 4 DOWNTO 0 );
	SIGNAL Instruction_immediate_value	: STD_LOGIC_VECTOR( 15 DOWNTO 0 );
	SIGNAL ra_registe_address			: STD_LOGIC_VECTOR( 4 DOWNTO 0 );

BEGIN
	read_register_1_address 	<= Instruction( 25 DOWNTO 21 );
   	read_register_2_address 	<= Instruction( 20 DOWNTO 16 );
   	write_register_address_1	<= Instruction( 15 DOWNTO 11 );
   	write_register_address_0 	<= Instruction( 20 DOWNTO 16 );
	ra_registe_address			<= "11111";
   	Instruction_immediate_value <= Instruction( 15 DOWNTO 0 );
					-- Read Register 1 Operation
	read_data_1 <= register_array( 
			      CONV_INTEGER( read_register_1_address ) );
					-- Read Register 2 Operation		 
	read_data_2 <= register_array( 
			      CONV_INTEGER( read_register_2_address ) );
					-- Mux for Register Write Address
    pre_write_register_address <= write_register_address_1 
			WHEN RegDst = '1'  			ELSE write_register_address_0;
	write_register_address <= ra_registe_address
			WHEN JALctl = '1' ELSE pre_write_register_address;
					-- Mux to bypass data memory for Rformat instructions
	pre_write_data <= ALU_result( 31 DOWNTO 0 ) 
			WHEN ( MemtoReg = '0' ) 	ELSE read_data;
					-- Sign Extend 16-bits to 32-bits
	write_data <= X"00000" & PCPlus4
			WHEN JALctl = '1' ELSE pre_write_data;
    	Sign_extend <= X"0000" & Instruction_immediate_value
		WHEN Instruction_immediate_value(15) = '0'
		ELSE	X"FFFF" & Instruction_immediate_value;

	GIE <= register_array(26)(0);
PROCESS
	BEGIN
		WAIT UNTIL clock'EVENT AND clock = '1';
		IF reset = '1' THEN
					-- Initial register values on reset are register = reg#
					-- use loop to automatically generate reset logic 
					-- for all registers
			FOR i IN 0 TO 31 LOOP
				register_array(i) <= CONV_STD_LOGIC_VECTOR( i, 32 );
 			END LOOP;
		ELSE
			IF RegWrite = '1' AND write_register_address /= 0 THEN
				register_array( CONV_INTEGER( write_register_address)) <= write_data;
			END IF;
			IF GIEOff = '1' THEN
				register_array(26)(0) <= '0';
			END IF;
			IF StorePC = '1' THEN
				register_array(27) <= X"00000" & SavedPC;
			END IF;
			IF GIEOn = '1' THEN
				register_array(26)(0) <= '1';
			END IF;
		END IF;
	END PROCESS;
END behavior;


