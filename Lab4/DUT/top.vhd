LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY top IS
  GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
  PORT 
  (       rst , clk , enb: IN STD_LOGIC;
		  Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC;
		  PWMout: OUT STD_LOGIC
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

	COMPONENT PWM IS
	GENERIC (n : INTEGER);
	PORT 
	( rst, enb, clk: IN STD_LOGIC;
		Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		ALUFN: IN STD_LOGIC;
		PWMout: OUT STD_LOGIC
	);
	END COMPONENT;
	---------SIGNAL lines we see in the task--------
	SIGNAL inAddX , inAddY , inLogX , inLogY , inShtX , inShtY , inPWMX , inPWMY , inAddForMux , inLogForMux , inShtForMux : STD_LOGIC_VECTOR (n-1 DOWNTO 0);

	---------SIGNAL lines for shifter logic--------
	SIGNAL coutShifter : STD_LOGIC;

	---------SIGNAL lines for Adder logic--------
	SIGNAL coutAdder , inOperation : STD_LOGIC;

	---------SIGNAL lines for General logic--------
	SIGNAL ALUout_buff: STD_LOGIC_VECTOR(n-1 downto 0);



BEGIN

	---Clac main SIGNALS---
	inAddY <= Y_i WHEN ALUFN_i(4 DOWNTO 1) = "0100" OR ALUFN_i(4 DOWNTO 0) = "01010" ELSE (others => '0');
	inAddX <= X_i WHEN ALUFN_i(4 DOWNTO 1) = "0100" OR ALUFN_i(4 DOWNTO 0) = "01010" ELSE (others => '0'); 

	inLogX <= X_i WHEN ALUFN_i(4 DOWNTO 3) = "11" ELSE (others => '0');
	inLogY <= Y_i WHEN ALUFN_i(4 DOWNTO 3) = "11" ELSE (others => '0');
	inShtX <= X_i WHEN ALUFN_i(4 DOWNTO 1) = "1000" ELSE (others => '0'); --bits 1,2 in ALUFN Must be 00 for Valid input for Shift
	inShtY <= Y_i WHEN ALUFN_i(4 DOWNTO 1) = "1000" ELSE (others => '0'); --bits 1,2 in ALUFN Must be 00 for Valid input for Shift

	inPWMX <= X_i WHEN ALUFN_i(4 DOWNTO 1) = "0000" ELSE (others => '0');
	inPWMY <= Y_i WHEN ALUFN_i(4 DOWNTO 1) = "0000" ELSE (others => '0');

	---PWM INST---
	PWMInst    : PWM 	GENERIC MAP (n)		PORT MAP (rst , enb , clk , inPWMY , inPWMX , ALUFN_i(0) , PWMout);


	---Calc input for Mux From Logic---
	logicInst    : Logic 	GENERIC MAP (n)		PORT MAP (inLogY , inLogX , ALUFN_i(2 DOWNTO 0) , inLogForMux);

	---Calc input for Mux From Shifter---
	shifterInst  : Shifter 	GENERIC MAP (n,k)	PORT MAP (inShtY , inShtX , ALUFN_i(0) , coutShifter , inShtForMux);

	---Calc input for Mux From Adder---
	inOperation 	<= ALUFN_i(1) XOR ALUFN_i(0) WHEN ALUFN_i(4 DOWNTO 2) = "010" ELSE '0' ;
	adderSubInst : AdderSub GENERIC MAP (n)	    PORT MAP (inAddY , inAddX , inOperation , coutAdder , inAddForMux);

	---Calc Flags---
	Zflag_o <= '1' WHEN ALUout_buff = (n-1 downto 0 => '0') ELSE '0';
	Cflag_o <= coutAdder WHEN ALUFN_i(4 DOWNTO 3) = "01" ELSE
			   coutShifter WHEN ALUFN_i(4 DOWNTO 3) = "10" ELSE '0';
	Nflag_o <= ALUout_buff(ALUout_buff'HIGH);

	---out (f' (Op XNOR s)) + out' (f (Op Xor s)) -
	Vflag_o <= (inAddForMux(inAddForMux'HIGH) AND (NOT inAddY(inAddY'HIGH)) AND (inOperation XNOR inAddX(inAddX'HIGH))) OR
				((NOT inAddForMux(inAddForMux'HIGH)) AND inAddY(inAddY'HIGH) AND (inOperation XOR inAddX(inAddX'HIGH)))			
				WHEN (ALUFN_i(4 DOWNTO 3) = "01") ELSE '0';


	---Clac Output--
	WITH ALUFN_i(4 DOWNTO 3) SELECT 
		ALUout_buff <= inAddForMux WHEN "01",
					inLogForMux WHEN "11",
					inShtForMux WHEN "10",
					(others => '0') WHEN OTHERS;

	ALUout_o <= ALUout_buff;
END struct;
