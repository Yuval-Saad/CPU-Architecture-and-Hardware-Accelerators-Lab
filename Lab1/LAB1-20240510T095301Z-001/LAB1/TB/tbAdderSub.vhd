library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
---------------------------------------------------------
entity tbAdderSub is
	constant n1 : integer := 4;
    constant n2 : integer := 8;
    constant n3 : integer := 16;
    constant n4 : integer := 32;
end tbAdderSub;
-------------------------------------------------------------------------------
architecture tbAdder of tbAdderSub is

    COMPONENT AdderSub IS
        GENERIC (n : INTEGER := 8);
        PORT 
        (  
            Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
            X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
            sub_cont: IN STD_LOGIC;
            cout: OUT STD_LOGIC;
            res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL sub_cont :  STD_LOGIC;

	SIGNAL X1,Y1:  STD_LOGIC_VECTOR (n1-1 DOWNTO 0);
	SIGNAL res1:  STD_LOGIC_VECTOR(n1-1 downto 0); 
    SIGNAL cout1:  STD_LOGIC;

    SIGNAL X2,Y2:  STD_LOGIC_VECTOR (n2-1 DOWNTO 0);
	SIGNAL res2:  STD_LOGIC_VECTOR(n2-1 downto 0); 
    SIGNAL cout2:  STD_LOGIC;

    SIGNAL X3,Y3:  STD_LOGIC_VECTOR (n3-1 DOWNTO 0);
	SIGNAL res3:  STD_LOGIC_VECTOR(n3-1 downto 0);
    SIGNAL cout3:  STD_LOGIC;
 
    SIGNAL X4,Y4:  STD_LOGIC_VECTOR (n4-1 DOWNTO 0);
	SIGNAL res4:  STD_LOGIC_VECTOR(n4-1 downto 0); 
    SIGNAL cout4:  STD_LOGIC;

begin
	A1 : AdderSub generic map (n1) port map(Y1 , X1 , sub_cont , cout1 , res1);
    A2 : AdderSub generic map (n2) port map(Y2 , X2 , sub_cont , cout2 , res2);
    A3 : AdderSub generic map (n3) port map(Y3 , X3 , sub_cont , cout3 , res3);
    A4 : AdderSub generic map (n4) port map(Y4 , X4 , sub_cont , cout4 , res4);

	--------- start of stimulus section ----------------------------------------		
    tb_x_y : process
    begin
        sub_cont <= '0';
        for j in 0 to 1 loop
            X1 <= (others => '0');
            Y1 <= (others => '0');
            X2 <= (others => '0');
            Y2 <= (others => '0');
            X3 <= (others => '0');
            Y3 <= (others => '0');
            X4 <= (others => '0');
            Y4 <= (others => '0');
            wait for 50 ns;
            X1 <= X1 + 5;
            X2 <= X2 + 86;
            X3 <= X3 + 1564;
            X4 <= X4 + 159542164;
            wait for 50 ns;
            Y1 <= Y1 + 6;
            Y2 <= Y2 + 110;
            Y3 <= Y3 + 1565;
            Y4 <= Y4 + 200000000;
            wait for 50 ns;
            X1 <= B"1100";
            X2 <= B"10101011";
            X3 <= B"1011100101011001";
            X4 <= B"10000000000000000000000000000001";
            wait for 50 ns;
            Y1 <= B"1010";
            Y2 <= B"10100001";
            Y3 <= B"1010111011111111";
            Y4 <= B"10000000000000000000000000000000";
            wait for 50 ns;
            Y1 <= B"1110";
            Y2 <= B"10111000";
            Y3 <= B"1011111001110001";
            Y4 <= B"10000000000000000000100110101000";
            wait for 50 ns;
            X1 <= (others => '0');
            X2 <= (others => '0');
            X3 <= (others => '0');
            X4 <= (others => '0');
            wait for 50 ns;
            X1 <= X1 + 4;
            X2 <= X2 + 101;
            X3 <= X3 + 906;
            X4 <= X4 + 3;
            wait for 50 ns;
            sub_cont <= '1';
        end loop;
        wait;
    end process;

end architecture tbAdder;