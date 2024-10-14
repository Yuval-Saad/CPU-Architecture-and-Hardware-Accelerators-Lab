LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
-------------------------------------
ENTITY FPGA IS
  GENERIC (n : INTEGER := 8;
		   k : integer := 3;   -- k=log2(n)
		   m : integer := 4	); -- m=2^(k-1)
  PORT 
  (       clk: IN STD_LOGIC;
		  SW: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		  KEY : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
          HEX0,HEX1,HEX2,HEX3,HEX4,HEX5: OUT STD_LOGIC_VECTOR(6 downto 0);
          LEDR59 : OUT STD_LOGIC_VECTOR(4 downto 0);
          LEDR03 : OUT STD_LOGIC_VECTOR(3 downto 0);
		  PWMout: OUT STD_LOGIC
  ); -- Zflag,Cflag,Nflag,Vflag
END FPGA;
------------- complete the top Architecture code --------------
ARCHITECTURE FPGA OF FPGA IS 

component top IS
  GENERIC (n : INTEGER;
		   k : integer;
		   m : integer);
  PORT 
  (       rst , clk , enb: IN STD_LOGIC;
		  Y_i,X_i: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
		  ALUFN_i : IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		  ALUout_o: OUT STD_LOGIC_VECTOR(n-1 downto 0);
		  Nflag_o,Cflag_o,Zflag_o,Vflag_o: OUT STD_LOGIC;
		  PWMout: OUT STD_LOGIC
  );
END component;

component HEXdecode IS
  PORT 
  (  
	  Xin: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
      Xout: OUT STD_LOGIC_VECTOR (6 DOWNTO 0)
  );
END component;

component PLL is
	port (
		refclk   : in  std_logic := '0'; --  refclk.clk
		rst      : in  std_logic := '0'; --   reset.reset
		outclk_0 : out std_logic;        -- outclk0.clk
		locked   : out std_logic         --  locked.export
	);
end component PLL;


    SIGNAL Y,X : STD_LOGIC_VECTOR(n-1 downto 0) := (others => '0');
    SIGNAL ALUFN : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    SIGNAL ALUout_o: STD_LOGIC_VECTOR(n-1 downto 0);
    SIGNAL Nflag_o,Cflag_o,Zflag_o,Vflag_o: STD_LOGIC;
    SIGNAL PLLclk: STD_LOGIC;
    SIGNAL rst: STD_LOGIC;
BEGIN

    PLLInst    : PLL 	                        	PORT MAP (clk , rst , PLLclk , open);
    TOPInst    : top 	GENERIC MAP (n , k , m)		PORT MAP (rst , PLLclk , SW(8) , Y , X , ALUFN ,ALUout_o , Nflag_o,Cflag_o,Zflag_o,Vflag_o , PWMout);
    rst <= not KEY(3);
    LEDR59 <= ALUFN;
    HEX0decode : HEXdecode PORT MAP (X(3 downto 0) , HEX0);
    HEX1decode : HEXdecode PORT MAP (X(n-1 downto 4) , HEX1);
    HEX2decode : HEXdecode PORT MAP (Y(3 downto 0) , HEX2);
    HEX3decode : HEXdecode PORT MAP (Y(n-1 downto 4) , HEX3);
    HEX4decode : HEXdecode PORT MAP (ALUout_o(3 downto 0) , HEX4);
    HEX5decode : HEXdecode PORT MAP (ALUout_o(n-1 downto 4) , HEX5);
    LEDR03(0) <= Nflag_o;
    LEDR03(1) <= Cflag_o;
    LEDR03(2) <= Zflag_o;
    LEDR03(3) <= Vflag_o;

    process (PLLclk)
    begin
        if (PLLclk 'event and PLLclk='1') then
            if (KEY(0) = '0') then
                Y <= SW(n-1 downto 0);
            end if;
        end if;
    end process;

    process (PLLclk)
    begin
        if (PLLclk 'event and PLLclk='1') then
            if (KEY(2) = '0') then
                X <= SW(n-1 downto 0);
            end if;
        end if;
    end process;

    process (PLLclk)
    begin
        if (PLLclk 'event and PLLclk='1') then
            if (KEY(1) = '0') then
                ALUFN <= SW(4 downto 0);
            end if;
        end if;
    end process;

END FPGA;