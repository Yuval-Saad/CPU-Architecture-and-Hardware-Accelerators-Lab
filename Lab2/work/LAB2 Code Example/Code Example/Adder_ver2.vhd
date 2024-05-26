LIBRARY ieee;
USE ieee.std_logic_1164.all;
-------------------------------------
ENTITY Adder IS
  GENERIC (length : INTEGER := 8);
  PORT ( a, b: IN INTEGER RANGE 0 TO 2**length-1; -- same as RANGE 0 TO 255
          cin: IN STD_LOGIC;
            s: OUT INTEGER RANGE 0 TO 2**length-1; -- same as RANGE 0 TO 255
         cout: OUT STD_LOGIC);
END Adder;
------------------------------------------------
ARCHITECTURE rtl OF Adder IS
BEGIN
  PROCESS (a, b, cin)
    VARIABLE temp : INTEGER RANGE 0 TO 2**(length+1)-1; -- same as RANGE 0 TO 511
  BEGIN
    IF (cin='1') THEN temp:=1;
    ELSE temp:=0;
    END IF;
    temp := a + b + temp;
    IF (temp > 2**length-1) THEN
       cout <= '1';
       temp := temp-2**length; -- temp := temp-256, to get 8-bit only
    ELSE cout <= '0';
    END IF;
    s <= temp;
  END PROCESS;
END rtl;



