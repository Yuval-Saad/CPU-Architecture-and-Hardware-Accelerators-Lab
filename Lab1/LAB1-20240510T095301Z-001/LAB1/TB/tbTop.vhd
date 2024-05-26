library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
---------------------------------------------------------
entity tbTop is
	constant n1 : integer := 4;
    constant k1 : integer := 2;
	constant m1 : integer := 2;

    constant n2 : integer := 8;
    constant k2 : integer := 3;
	constant m2 : integer := 4;

    constant n3 : integer := 16;
    constant k3 : integer := 4;
	constant m3 : integer := 8;

	constant n4 : integer := 32;
    constant k4 : integer := 5;
	constant m4 : integer := 16;
end tbTop;
-------------------------------------------------------------------------------
architecture tbT of tbTop is

    COMPONENT top IS
        GENERIC (n : INTEGER;
                 k : INTEGER;
                 m : INTEGER);
        PORT 
        (  
        Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
                ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
                ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
                Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC
        );
    END COMPONENT;

    SIGNAL ALUFN: STD_LOGIC_VECTOR (4 DOWNTO 0);

	SIGNAL X1,Y1:  STD_LOGIC_VECTOR (n1-1 DOWNTO 0);
	SIGNAL res1:  STD_LOGIC_VECTOR(n1-1 downto 0); 
    SIGNAL Nflag1 , Cflag1 , Zflag1 , Vflag1: STD_LOGIC;

    SIGNAL X2,Y2:  STD_LOGIC_VECTOR (n2-1 DOWNTO 0);
	SIGNAL res2:  STD_LOGIC_VECTOR(n2-1 downto 0); 
    SIGNAL Nflag2 , Cflag2 , Zflag2 , Vflag2: STD_LOGIC;

    SIGNAL X3,Y3:  STD_LOGIC_VECTOR (n3-1 DOWNTO 0);
	SIGNAL res3:  STD_LOGIC_VECTOR(n3-1 downto 0);
    SIGNAL Nflag3 , Cflag3 , Zflag3 , Vflag3: STD_LOGIC;
 
    SIGNAL X4,Y4:  STD_LOGIC_VECTOR (n4-1 DOWNTO 0);
	SIGNAL res4:  STD_LOGIC_VECTOR(n4-1 downto 0); 
    SIGNAL Nflag4 , Cflag4 , Zflag4 , Vflag4: STD_LOGIC;

begin
	T1 : top generic map (n1,k1,m1) port map(Y1 , X1 , ALUFN , res1 , Nflag1 , Cflag1 , Zflag1 , Vflag1);
    T2 : top generic map (n2,k2,m2) port map(Y2 , X2 , ALUFN , res2 , Nflag2 , Cflag2 , Zflag2 , Vflag2);
    T3 : top generic map (n3,k3,m3) port map(Y3 , X3 , ALUFN , res3 , Nflag3 , Cflag3 , Zflag3 , Vflag3);
    T4 : top generic map (n4,k4,m4) port map(Y4 , X4 , ALUFN , res4 , Nflag4 , Cflag4 , Zflag4 , Vflag4);

	--------- start of stimulus section ----------------------------------------		
    tb_sim : process
    begin
        X1 <= B"0011";
        Y1 <= B"0101";
        X2 <= B"00110011";
        Y2 <= B"01010101";
        X3 <= B"0011001100110011";
        Y3 <= B"0101010101010101";
        X4 <= B"00110011001100110011001100110011";
        Y4 <= B"01010101010101010101010101010101";
        ALUFN <= (others => '0');
        wait for 50 ns;
        for i in 1 to 31 loop
            ALUFN <= ALUFN + 1;
            wait for 50 ns;
        end loop;
        wait;
    end process;

end architecture tbT;