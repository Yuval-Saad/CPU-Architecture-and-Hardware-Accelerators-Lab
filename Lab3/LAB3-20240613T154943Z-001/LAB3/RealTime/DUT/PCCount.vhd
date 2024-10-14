LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY PCCount IS
  GENERIC (Dwidth: integer:=16);
  PORT (clk: IN STD_LOGIC;
        PC: buffer STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        PCin: IN STD_LOGIC;
        PCsel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        IRreg: IN STD_LOGIC_VECTOR (7 DOWNTO 0)
  );
END PCCount;
--------------------------------------------------------
ARCHITECTURE PCCount OF PCCount IS
    COMPONENT Adder IS
    GENERIC (length : INTEGER);
    PORT ( a, b: IN STD_LOGIC_VECTOR (length-1 DOWNTO 0);
        cin: IN STD_LOGIC;
            s: OUT STD_LOGIC_VECTOR (length-1 DOWNTO 0);
        cout: OUT STD_LOGIC);
    END COMPONENT; 
    signal MuxOUT: STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal one: STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal PCplusOne: STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal IRExtention: STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal IRplusOne: STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
BEGIN
    one <= (0 => '1', others => '0');
    PCplusOneAdderInst : Adder generic map (Dwidth) port map (one , PC , '0' , PCplusOne , open);
    IRExtention(7 DOWNTO 0) <= IRreg;
    IRExtention(Dwidth-1 DOWNTO 8) <= (others => IRreg(7));
    -- change, need to do IRExtension + PCplusOne
    --IRplusOneAdderInst : Adder generic map (Dwidth) port map (one , IRExtention , '0' , IRplusOne , open);
    IRplusOneAdderInst : Adder generic map (Dwidth) port map (PCplusOne , IRExtention , '0' , IRplusOne , open);
    with PCsel select
        MuxOUT <= (others => '0')    when "00",
                  IRplusOne          when "01",
                  PCplusOne          when "10",
                  (others => '0')    when others;
    PROCESS (clk)
    BEGIN
    if (clk'event and clk='1') then
	    if (PCin='1') then
			PC <= MuxOUT; 
	    end if;
	end if;
    END PROCESS;
END PCCount;

