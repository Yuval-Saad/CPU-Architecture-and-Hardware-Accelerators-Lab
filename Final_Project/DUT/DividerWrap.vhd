library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;
use ieee.numeric_std.all;

ENTITY DividerWrap IS
	PORT(rst, clk: IN STD_LOGIC;
         MemWrite, MemRead: IN STD_LOGIC;
         addr: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
         data: INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         DivIFG: OUT STD_LOGIC);
END DividerWrap;

ARCHITECTURE DividerWrap OF DividerWrap IS
    SIGNAL OutQuatient, OutResidue, OutDivisor, OutDividend: unsigned(31 DOWNTO 0);
    SIGNAL setDividend, setDivisor: STD_LOGIC;
    SIGNAL DataOut: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DataIn: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL writeToBusEn: STD_LOGIC;
BEGIN

    DividerInst: Divider port map (rst => rst,
                                   clk => clk,
                                   EN => '1',
                                   Data => DataIn,
                                   setDividend => setDividend,
                                   setDivisor => setDivisor,
                                   OutQuatient => OutQuatient,
                                   OutResidue => OutResidue,
                                   OutDivisor => OutDivisor,
                                   OutDividend => OutDividend,
                                   DivIFG => DivIFG);

    setDivisor <= MemWrite when addr = X"830" else '0';
    setDividend <= MemWrite when addr = X"82C" else '0';
    writeToBusEn <= MemRead when (addr = X"82C" or addr = X"830" or addr = X"834" or addr = X"838") else '0';
    with addr select 
    DataOut <= std_logic_vector(OutDividend) when X"82C",
               std_logic_vector(OutDivisor) when X"830",
               std_logic_vector(OutQuatient) when X"834",
               std_logic_vector(OutResidue) when X"838",
               (others => '0') when others; 
               
    pin: BidirPin generic map (32) port map (Dout => DataOut,
			                                 en => writeToBusEn,
			                                 Din => DataIn,
			                                 IOpin => data);
    
END DividerWrap;