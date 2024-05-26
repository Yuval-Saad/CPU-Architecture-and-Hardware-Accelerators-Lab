library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
---------------------------------------------------------
entity tbShifter is
	constant n1 : integer := 4;
    constant k1 : integer := 2;
    constant n2 : integer := 8;
    constant k2 : integer := 3;
    constant n3 : integer := 16;
    constant k3 : integer := 4;
    constant n4 : integer := 32;
    constant k4 : integer := 5;
end tbShifter;
-------------------------------------------------------------------------------
architecture tbSht of tbShifter is

    COMPONENT Shifter IS
        GENERIC (n : INTEGER;
                 k : INTEGER);
        PORT 
        (  
        Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
        dir: IN STD_LOGIC;
        cout: OUT STD_LOGIC;
        res: OUT STD_LOGIC_VECTOR (n-1 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL dir :  STD_LOGIC;

	SIGNAL X1,Y1:  STD_LOGIC_VECTOR (n1-1 DOWNTO 0);
	SIGNAL reso1:  STD_LOGIC_VECTOR(n1-1 downto 0); 
    SIGNAL cout1:  STD_LOGIC;

    SIGNAL X2,Y2:  STD_LOGIC_VECTOR (n2-1 DOWNTO 0);
	SIGNAL reso2:  STD_LOGIC_VECTOR(n2-1 downto 0); 
    SIGNAL cout2:  STD_LOGIC;

    SIGNAL X3,Y3:  STD_LOGIC_VECTOR (n3-1 DOWNTO 0);
	SIGNAL reso3:  STD_LOGIC_VECTOR(n3-1 downto 0);
    SIGNAL cout3:  STD_LOGIC;
 
    SIGNAL X4,Y4:  STD_LOGIC_VECTOR (n4-1 DOWNTO 0);
	SIGNAL reso4:  STD_LOGIC_VECTOR(n4-1 downto 0); 
    SIGNAL cout4:  STD_LOGIC;

begin
	S1 : Shifter generic map (n1,k1) port map(Y1 , X1 , dir , cout1 , reso1);
    S2 : Shifter generic map (n2,k2) port map(Y2 , X2 , dir , cout2 , reso2);
    S3 : Shifter generic map (n3,k3) port map(Y3 , X3 , dir , cout3 , reso3);
    S4 : Shifter generic map (n4,k4) port map(Y4 , X4 , dir , cout4 , reso4);

	--------- start of stimulus section ----------------------------------------		
    tb_x_y : process
    begin
        dir <= '0';
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
            for i in 0 to 15 loop
                X1 <= X1 + 1;
                if (Y1 >= 15) then
                    Y1 <= Y1 + 3;
                else 
                    Y1 <= Y1 + 3;
                end if;
                X2 <= X2 + 1;
                Y2 <= Y2 + 10;
                X3 <= X3 + 5;
                Y3 <= Y3 + 1359;
                X4 <= X4 + B"1001001000001101001100001";
                Y4 <= Y4 + 123540217;
                wait for 50 ns;
            end loop;
            dir <= '1';
        end loop;
        wait;
    end process;

end architecture tbSht;