library ieee;
use ieee.std_logic_1164.all;
------------------------------------------------
ENTITY ShiftReg IS
  GENERIC (n : integer := 3);
  PORT ( din, clk, rst: IN std_logic;
                  dout: OUT std_logic);
  END ShiftReg;
------------------------------------------------
ARCHITECTURE rtl OF ShiftReg IS
  SIGNAL internal: std_logic_vector (0 to n-1);
BEGIN
  PROCESS (clk, rst)
  BEGIN
	IF (rst='1') THEN
		internal <= (others => '0');
		dout <= '0';
	ELSIF (clk'EVENT and clk='1') THEN
		internal(0) <= din;
		for i in 0 to n-2 loop
			internal(i+1) <= internal(i);
		end loop;
		dout <= internal(n-1);
   END IF;
  END PROCESS;
END rtl;
