LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------

  GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
  PORT 
  (  
	Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC
  ); -- Zflag,Cflag,Nflag,Vflag
END top;
------------- complete the top Architecture code --------------
ARCHITECTURE struct OF top IS 
	COMPONENT AdderSub IS
	GENERIC (n : INTEGER);
	PORT 
	(  
		Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		sub_cont: IN STD_LOGIC;
		cout: OUT STD_LOGIC;
		res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
	);
	END COMPONENT;
	COMPONENT Shifter IS
	GENERIC (n : INTEGER;
			 k : INTEGER );
	PORT 
	(  
		Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		dir: IN STD_LOGIC;
		cout: OUT STD_LOGIC;
		res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
	);
	END COMPONENT;
	COMPONENT Logic IS
	GENERIC (n : INTEGER);
	PORT 
	(  
		Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
	);
	END COMPONENT;
	---------SIGNAL lines we see in the task--------
	SIGNAL inAddX , inAddY , inLogX , inLogY , inShtX , inShtY , inAddForMux , inLogForMux , inShtForMux : STD_LOGIC_VECTOR (n-1 DOWNTO 0);

	---------SIGNAL lines for shifter logic--------
	SIGNAL coutShifter : STD_LOGIC;

	---------SIGNAL lines for Adder logic--------
	SIGNAL inXForAdderInst , inYForAdderInst : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
	SIGNAL coutAdder , inOperation : STD_LOGIC;

	---------SIGNAL lines for General logic--------
	SIGNAL ALUout_buff: STD_LOGIC_VECTOR(n-1 downto 0);




BEGIN
	---Clac main SIGNALS---
	inAddY <= Y_i WHEN ALUFN_i(4 DOWNTO 2) = "010" ELSE (others => '0'); --bit 2 in ALUFN Must be 0 for Valid input for Adder
	inAddX <= X_i WHEN ALUFN_i(4 DOWNTO 2) = "010" ELSE (others => '0'); --bit 2 in ALUFN Must be 0 for Valid input for Adder
	inLogX <= X_i WHEN ALUFN_i(4 DOWNTO 3) = "11" ELSE (others => '0');
	inLogY <= Y_i WHEN ALUFN_i(4 DOWNTO 3) = "11" ELSE (others => '0');
	inShtX <= X_i WHEN ALUFN_i(4 DOWNTO 1) = "1000" ELSE (others => '0'); --bits 1,2 in ALUFN Must be 00 for Valid input for Shift
	inShtY <= Y_i WHEN ALUFN_i(4 DOWNTO 1) = "1000" ELSE (others => '0'); --bits 1,2 in ALUFN Must be 00 for Valid input for Shift

	---Calc input for Mux From Logic---
	logicInst    : Logic 	GENERIC MAP (n)		PORT MAP (inLogY , inLogX , ALUFN_i(2 DOWNTO 0) , inLogForMux);

	---Calc input for Mux From Shifter---
	shifterInst  : Shifter 	GENERIC MAP (n,k)	PORT MAP (inShtY , inShtX , ALUFN_i(0) , coutShifter , inShtForMux);

	---Calc input for Mux From Adder---
	inXForAdderInst <= (others => '0') WHEN ALUFN_i(1 DOWNTO 0) = "11" ELSE inAddX;
	inYForAdderInst <= (others => '0') WHEN ALUFN_i(1) = '1' ELSE inAddY;
	inOperation 	<= ALUFN_i(1) XOR ALUFN_i(0) WHEN ALUFN_i(4 DOWNTO 2) = "010" ELSE '0' ;
	adderSubInst : AdderSub GENERIC MAP (n)	    PORT MAP (inYForAdderInst , inXForAdderInst , inOperation , coutAdder , inAddForMux);

	---Calc Flags---
	Zflag_o <= '1' WHEN ALUout_buff = (n-1 downto 0 => '0') ELSE '0';
	Cflag_o <= coutAdder WHEN ALUFN_i(4 DOWNTO 3) = "01" ELSE
			   coutShifter WHEN ALUFN_i(4 DOWNTO 3) = "10" ELSE '0';
	Nflag_o <= ALUout_buff(ALUout_buff'HIGH);

	---out (f' (Op XNOR s)) + out' (f (Op Xor s)) -
	Vflag_o <= 	(inAddForMux(inAddForMux'HIGH) AND (NOT inYForAdderInst(inYForAdderInst'HIGH)) AND (inOperation XNOR inXForAdderInst(inXForAdderInst'HIGH))) OR
				((NOT inAddForMux(inAddForMux'HIGH)) AND inYForAdderInst(inYForAdderInst'HIGH) AND (inOperation XOR inXForAdderInst(inXForAdderInst'HIGH)))			
				WHEN (ALUFN_i(4 DOWNTO 3) = "01") ELSE '0';


	---Clac Output--
	WITH ALUFN_i(4 DOWNTO 3) SELECT 
		ALUout_buff <= inAddForMux WHEN "01",
					inLogForMux WHEN "11",
					inShtForMux WHEN "10",
					(others => '0') WHEN OTHERS;

	ALUout_o <= ALUout_buff;

END struct;
