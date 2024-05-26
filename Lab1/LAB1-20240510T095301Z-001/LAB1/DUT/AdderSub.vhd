LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY AdderSub IS
  GENERIC (n : INTEGER := 8);
  PORT 
  (  
	Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    sub_cont: IN STD_LOGIC;
    cout: OUT STD_LOGIC;
    res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
  );
END AdderSub;
-----------------------------------------
ARCHITECTURE adder OF AdderSub IS  --using full adder component
    COMPONENT FA IS
        PORT (xi, yi, cin: IN std_logic;
                s, cout: OUT std_logic);
    END COMPONENT;
    SIGNAL newX , cis : STD_LOGIC_VECTOR (n-1 DOWNTO 0);
BEGIN
    GenNewX : FOR i IN 0 TO n-1 GENERATE --generating the new X vector after considering the operation 
        newX(i) <= X(i) XOR sub_cont;
    END GENERATE;

    -- connecting the chain of full adders

    first : FA PORT MAP (newX(0) , Y(0) , sub_cont , res(0) , cis(0)); 

    rest : FOR i IN 1 TO n-1 GENERATE
        chain : FA PORT MAP (newX(i) , Y(i) , cis(i-1) , res(i) , cis(i));
    END GENERATE;

    cout <= cis(n-1);

END adder;

