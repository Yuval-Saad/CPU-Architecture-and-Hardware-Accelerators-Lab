library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--------------------------------------------------------------
entity ALU is
generic( Dwidth: integer:=16);
port (  opcode: in std_logic_vector(3 downto 0);
    	A,B:	in std_logic_vector(Dwidth-1 downto 0);
        C:      out std_logic_vector(Dwidth-1 downto 0);
        Cflag,Zflag,Nflag: out std_logic
);
end ALU;
--------------------------------------------------------------
architecture ALU of ALU is
    COMPONENT Adder IS
    GENERIC (length : INTEGER);
    PORT ( a, b: IN STD_LOGIC_VECTOR (length-1 DOWNTO 0);
          cin: IN STD_LOGIC;
            s: OUT STD_LOGIC_VECTOR (length-1 DOWNTO 0);
        cout: OUT STD_LOGIC);
    END COMPONENT;  
    signal AdderIn1, AdderIn2: STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal AdderS: STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal Addercin, Addercout: STD_LOGIC;
    signal Cout: std_logic_vector(Dwidth-1 downto 0);

begin			
    adderInst : Adder generic map (Dwidth) port map (AdderIn1 , AdderIn2 , Addercin , AdderS , Addercout);

    AdderIn1 <= A;

    with opcode select 
        AdderIn2 <= NOT B when "0001",
                    B when others;

    with opcode select 
        Addercin <= '1' when "0001",
                    '0' when others;

    with opcode select
        Cout <= AdderIn1 AND AdderIn2 when "0010",
                AdderIn1 OR AdderIn2  when "0011",
                AdderIn1 XOR AdderIn2 when "0100",
                AdderS                when "0000",
                AdderS                when "0001",
		        AdderS		          when "1101",	-- add for load / store opcodes
                (others => '0')       when others;

    Cflag <= Addercout;

    Nflag <= Cout(Dwidth-1);

    Zflag <= '1' when conv_integer(Cout)=0 else '0';

    C <= Cout;

end ALU;