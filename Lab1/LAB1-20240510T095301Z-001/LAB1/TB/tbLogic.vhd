library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
---------------------------------------------------------
entity tbLogic is
	constant n1 : integer := 4;
    constant n2 : integer := 8;
	constant n3 : integer := 16;
	constant n4 : integer := 32;
end tbLogic;
-------------------------------------------------------------------------------
architecture tbLog of tbLogic is

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

    SIGNAL ALUFNi :  STD_LOGIC_VECTOR (2 DOWNTO 0);

	SIGNAL X1,Y1:  STD_LOGIC_VECTOR (n1-1 DOWNTO 0);
	SIGNAL reso1:  STD_LOGIC_VECTOR(n1-1 downto 0); 

    SIGNAL X2,Y2:  STD_LOGIC_VECTOR (n2-1 DOWNTO 0);
	SIGNAL reso2:  STD_LOGIC_VECTOR(n2-1 downto 0); 

    SIGNAL X3,Y3:  STD_LOGIC_VECTOR (n3-1 DOWNTO 0);
	SIGNAL reso3:  STD_LOGIC_VECTOR(n3-1 downto 0); 

    SIGNAL X4,Y4:  STD_LOGIC_VECTOR (n4-1 DOWNTO 0);
	SIGNAL reso4:  STD_LOGIC_VECTOR(n4-1 downto 0); 

begin
	L1 : Logic generic map (n1) port map(Y1 , X1 , ALUFNi , reso1);
    L2 : Logic generic map (n2) port map(Y2 , X2 , ALUFNi , reso2);
    L3 : Logic generic map (n3) port map(Y3 , X3 , ALUFNi , reso3);
    L4 : Logic generic map (n4) port map(Y4 , X4 , ALUFNi , reso4);

	--------- start of stimulus section ----------------------------------------		
    tb_x_y : process
    begin
        ALUFNi <= (others => '0');
        for j in 0 to 7 loop
            X1 <= (others => '0');
            Y1 <= (others => '1');
            X2 <= (others => '0');
            Y2 <= (others => '1');
            X3 <= (others => '0');
            Y3 <= (others => '1');
            X4 <= (others => '0');
            Y4 <= (others => '1');
            wait for 50 ns;
            for i in 0 to 7 loop
                X1 <= X1 + 1;
                Y1 <= Y1 - 2;
                X2 <= X2 + 13;
                Y2 <= Y2 - 27;
                X3 <= X3 + 3093;
                Y3 <= Y3 - 2957;
                X4 <= X4 + 212348585;
                Y4 <= Y4 - 123848750;
                wait for 50 ns;
            end loop;
            ALUFNi <= ALUFNi + 1;
        end loop;
        wait;
    end process;

end architecture tbLog;