library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;
use ieee.numeric_std.all;

ENTITY Divider IS
	PORT(rst, clk, EN: IN STD_LOGIC;
         Data: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         setDividend, setDivisor: IN STD_LOGIC;
         OutQuatient, OutResidue, OutDivisor, OutDividend: OUT unsigned(31 DOWNTO 0);
         DivIFG: OUT STD_LOGIC);
END Divider;
         
ARCHITECTURE Divider OF Divider IS
    SIGNAL Divisor, Quatient, Residue: unsigned(31 DOWNTO 0);
    SIGNAL Dividend: unsigned(63 DOWNTO 0);
    SIGNAL pos: unsigned(5 DOWNTO 0);
    SIGNAL SubResult: unsigned(31 DOWNTO 0);
    SIGNAL SubSign: STD_LOGIC;
    SIGNAL DividendRegister : unsigned(31 DOWNTO 0);

BEGIN

    process (clk, rst) begin
        if (rst = '1') then
            DividendRegister <= (others => '0');
        elsif (rising_edge(clk)) then
            if (setDividend = '1') then 
                DividendRegister <= unsigned(Data);
            end if;
        end if;	
    end process;

    process (clk, rst) begin
        if (rst = '1') then
            pos <= (others => '0');
        elsif (rising_edge(clk)) then
            if (setDivisor = '1' or setDividend = '1') then 
                pos <= (others => '0');
            elsif (EN = '1' and pos < "100100") then
                pos <= pos + 1;
            end if;
        end if;	
    end process;

    process (clk, rst) begin
        if (rst = '1') then
            Divisor <= (others => '0');
        elsif (rising_edge(clk)) then
            if (setDivisor = '1') then 
                Divisor <= unsigned(Data);
            end if;
        end if;	
    end process;

    process (clk, rst) begin
        if (rst = '1') then
            Dividend <= (others => '0');
        elsif (rising_edge(clk)) then
            if (pos = "000001") then 
                Dividend <= X"00000000" & DividendRegister;
            elsif (EN = '1' and pos < "100011") then
                if (SubSign = '1') then 
                    Dividend <= SubResult(30 downto 0) & Dividend(31 downto 0) & '0';
                else
                    Dividend <= Dividend(62 downto 0) & '0';
                end if;
            end if;
        end if;	
    end process;

    process (clk, rst) begin
        if (rst = '1') then
            Quatient <= (others => '0');
        elsif (rising_edge(clk)) then
            if (pos = "000001") then 
                Quatient <= (others => '0');
            elsif (EN = '1' and pos < "100011") then
                Quatient <= Quatient(30 downto 0) & SubSign;
            end if;
        end if;	
    end process;
    
    process (clk, rst) begin
        if (rst = '1') then
            Residue <= (others => '0');
        elsif (rising_edge(clk)) then
            if (pos = "000001") then 
                Residue <= (others => '0');
            elsif (EN = '1' and pos = "100010") then
                if (SubSign = '1') then
                    Residue <= SubResult;
                else
                    Residue <= Dividend(63 downto 32);
                end if;
            end if;
        end if;	
    end process;
                    
    OutQuatient <= Quatient;
    OutResidue <= Residue;
    OutDivisor <= Divisor;
    OutDividend <= DividendRegister;
    DivIFG <= '1' when pos = "100011" else '0';
    SubResult <= Dividend(63 downto 32) - Divisor;
    SubSign <= '1' when Dividend(63 downto 32) >= Divisor else '0';
                    
END Divider;