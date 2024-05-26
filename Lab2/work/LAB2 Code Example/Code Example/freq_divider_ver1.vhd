library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-----------------------------------------
ENTITY freq_divider IS
	GENERIC(n : INTEGER := 8);
	PORT ( 	  rst, clk : IN STD_LOGIC;
			out1, out2 : BUFFER STD_LOGIC);
END freq_divider;
-----------------------------------------
ARCHITECTURE rtl OF freq_divider IS
	SIGNAL count1 : INTEGER RANGE 0 TO n-1;
BEGIN
	PROCESS (clk)
		VARIABLE count2 : INTEGER RANGE 0 TO n-1 ;
	BEGIN
		IF (rst='1')THEN
			out1<='0';
			out2<='0';
		ELSIF (clk'EVENT AND clk='1') THEN
			count1 <= count1 + 1;
			count2 := count2 + 1;
			IF (count1 = 3 ) THEN
				out1 <= NOT out1;
				count1 <= 0;
			END IF;
			
			IF (count2 = 3 ) THEN
				out2 <= NOT out2;
				count2 := 0;
			END IF;
		END IF;
	END PROCESS;
END rtl;

