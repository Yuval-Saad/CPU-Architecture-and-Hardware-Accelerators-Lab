LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Shifter IS
  GENERIC (n : INTEGER := 8;
           k : integer := 3 );
  PORT 
  (  
	Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    dir: IN STD_LOGIC;
    cout: OUT STD_LOGIC;
    res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
  );
END Shifter;
-----------------------------------------
ARCHITECTURE sht OF Shifter IS
    SUBTYPE vector IS STD_LOGIC_VECTOR (n DOWNTO 0); 
    TYPE matrix IS ARRAY (k-1 DOWNTO 0) OF vector;
    SIGNAL row : matrix;
    SIGNAL copyY : STD_LOGIC_VECTOR (n DOWNTO 0); --size of vector + carry bit
BEGIN
    reverseY : FOR i IN 0 TO n-1 GENERATE --reversing Y vector if shifting right
        copyY(i) <= Y(i) WHEN dir='0' ELSE Y(n-1-i);
    END GENERATE;
    copyY(n) <= '0'; -- for carry bit
     
    row(0) <= copyY(n-1 DOWNTO 0) & '0' WHEN X(0)='1' ELSE copyY; --make the shift in each vector in the matrix
    CalcRows : FOR i IN 1 TO k-1 GENERATE
        row(i) <= row(i-1)(n-(2**i) DOWNTO 0) & ((2**i)-1 DOWNTO 0 => '0') WHEN X(i)='1' ELSE row(i-1); 
    END GENERATE;
    
    CalcResult : FOR i IN 0 TO n-1 GENERATE --reversing back if needed
        res(i) <= row(k-1)(i) WHEN dir='0' ELSE row(k-1)(n-1-i);
    END GENERATE;
    cout <= row(k-1)(n);
END sht;