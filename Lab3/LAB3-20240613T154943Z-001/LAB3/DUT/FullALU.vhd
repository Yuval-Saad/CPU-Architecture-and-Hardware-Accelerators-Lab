LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY FullALU IS
  GENERIC (Dwidth: integer:=16);
  PORT (Ain,Cin: IN STD_LOGIC;
        opcode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        clk:  in std_logic;  
        ALUIn: IN STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        ALUOut: OUT STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        Cflag,Zflag,Nflag: OUT STD_LOGIC);
END FullALU;
--------------------------------------------------------
ARCHITECTURE FullALU OF FullALU IS
    component ALU is
        generic(Dwidth: integer);
        port (opcode: in std_logic_vector(3 downto 0);
              A,B:	in std_logic_vector(Dwidth-1 downto 0);
              C:      out std_logic_vector(Dwidth-1 downto 0);
              Cflag,Zflag,Nflag: out std_logic
        );
    end component;
    signal Aentry : std_logic_vector(Dwidth-1 downto 0);
    signal CaluOUT : std_logic_vector(Dwidth-1 downto 0);
    signal CflagALU, ZflagALU, NflagALU : STD_LOGIC;
BEGIN
    ALUInst : ALU generic map (Dwidth) port map (opcode , Aentry , ALUIn , CaluOUT , CflagALU, ZflagALU, NflagALU);
    PROCESS (clk)
    BEGIN
    if (clk'event and clk='1') then
	    if (Ain='1') then
			Aentry <= ALUIn; 
	    end if;
        if (Cin='1') then
			ALUOut <= CaluOUT; 
            case opcode is
                when "0000" =>
                    Cflag <= CflagALU;
                    Zflag <= ZflagALU;
                    Nflag <= NflagALU;
                when "0001" =>
                    Cflag <= CflagALU;
                    Zflag <= ZflagALU;
                    Nflag <= NflagALU;
                when "0010" =>
                    Zflag <= ZflagALU;
                    Nflag <= NflagALU;
                when "0011" =>
                    Zflag <= ZflagALU;
                    Nflag <= NflagALU;
                when "0100" =>
                    Zflag <= ZflagALU;
                    Nflag <= NflagALU;
                when others =>
                    null;
            end case;
	    end if;
              -- TODELETE
--        assert false 
--        report "In ALU:   " &
--               "[time =" & to_string(now) & "]" &
--               "[Ain: " & to_string(Ain) & "]" &
--               "[Cin: " & to_string(Cin) & "]" &
--               "[to register C enters: " & to_string(CaluOUT) & "]" &
--               "[in register A: " & to_string(Aentry) & "]" & 
--               "[in the entry : " & to_string(ALUIn) & "]" & 
--               "[opcode is : " & to_string(opcode) & "]" 
--      severity note;
	end if;
    END PROCESS;
END FullALU;

