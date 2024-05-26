LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Logic IS
  GENERIC (n : INTEGER := 8);
  PORT 
  (  
	  Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    ALUFN: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
    res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
  );
END Logic;
-----------------------------------------
ARCHITECTURE log OF Logic IS
    SIGNAL notRes , orRes , andRes , xorRes , norRes , nandRes , xnorRes : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
BEGIN
    --calc all the logical operations--
    CalcRes : FOR i IN 0 TO n-1 GENERATE
        notRes(i) <= (NOT Y(i));
        orRes(i) <= Y(i) OR X(i);
        andRes(i) <= Y(i) AND X(i);
        xorRes(i) <= Y(i) XOR X(i);
        norRes(i) <= Y(i) NOR X(i);
        nandRes(i) <= Y(i) NAND X(i);
        xnorRes (i) <= Y(i) XNOR X(i);
    END GENERATE;

    --muxing for the correct operation--
    WITH ALUFN(2 DOWNTO 0) SELECT 
    res <= notRes WHEN "000",
           orRes WHEN "001",
           andRes WHEN "010",
           xorRes WHEN "011",
           norRes WHEN "100",
           nandRes WHEN "101",
           xnorRes WHEN "111",
           (others => '0') WHEN OTHERS;

END log;