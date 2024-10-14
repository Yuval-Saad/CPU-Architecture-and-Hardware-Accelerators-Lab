library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;

ENTITY InterruptControllerWrap IS
    PORT(rst, clk: IN STD_LOGIC;
         MemWrite, MemRead: IN STD_LOGIC;
         irq: IN STD_LOGIC_VECTOR(7 downto 0);
         addr: IN STD_LOGIC_VECTOR(11 downto 0);
         GIE: IN STD_LOGIC;  
         INTA: IN STD_LOGIC;
         TXBUFRead: IN STD_LOGIC;
         RXBUFRead: IN STD_LOGIC;
         INTR: OUT STD_LOGIC;
         data: INOUT STD_LOGIC_VECTOR(31 downto 0));
END InterruptControllerWrap;
         
ARCHITECTURE InterruptControllerWrap OF InterruptControllerWrap IS
    SIGNAL clr_irq, setIFG: STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL writeIE: STD_LOGIC;
    SIGNAL IFG, IE, OutType: STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL writeToBusEn: STD_LOGIC;
    SIGNAL DataIn, DataOut: STD_LOGIC_VECTOR(31 downto 0); 
    SIGNAL SWIFGWrite, NotSWIFGWrite: STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL INTAClear: STD_LOGIC_VECTOR(7 downto 0);
BEGIN
    pin: BidirPin generic map (32) port map (Dout => DataOut,
                                            en => writeToBusEn,
                                            Din => DataIn,
                                            IOpin => data);

    writeToBusEn <= MemRead when (addr = X"83C" or addr = X"83D" or addr = X"83E") else '0';
    with addr select 
        DataOut <= X"000000" & IE when X"83C",
                   X"000000" & IFG when X"83D",
                   X"000000" & OutType when X"83E",
                   (others => '0') when others; 

    InterruptControllerInst: InterruptController port map (rst => rst,
                                                           clk => clk,
                                                           setIFG => setIFG,
                                                           clr_irq => clr_irq,
                                                           data => DataIn(7 DOWNTO 0),
                                                           writeIE => writeIE,
                                                           GIE=> GIE,
                                                           INTR => INTR,
                                                           irq => open,
                                                           OutType => OutType,
                                                           IFG => IFG,
                                                           IE => IE);

    writeIE <= MemWrite when addr = X"83C" else '0';
    SWIFGWrite <= DataIn(7 DOWNTO 0) when MemWrite = '1' and addr = X"83D" else (others => '0');
    GenNotSWIFGWrite : for i in 0 to 7 generate
        NotSWIFGWrite(i) <= not DataIn(i) when MemWrite = '1' and addr = X"83D" else '0';
    end generate GenNotSWIFGWrite;
    IFGUpdateSET : for i in 0 to 7 generate
        setIFG(i) <= irq(i) or SWIFGWrite(i);
    end generate IFGUpdateSET;

    INTAClear <= X"01" when INTA = '1' and IFG(0) = '1' else
                 X"02" when INTA = '1' and IFG(0) = '0' and IFG(1) = '1' else
                 X"04" when INTA = '1' and IFG(0) = '0' and IFG(1) = '0' and IFG(2) = '1' else
                 X"40" when INTA = '1' and IFG(0) = '0' and IFG(1) = '0' and IFG(2) = '0' and IFG(3) = '0' and IFG(4) = '0' and IFG(5) = '0' and IFG(6) = '1' else X"00";

    clr_irq(0) <= INTAClear(0) or NotSWIFGWrite(0) or RXBUFRead;
    clr_irq(1) <= INTAClear(1) or NotSWIFGWrite(1) or TXBUFRead;
    IFGUpdateClr : for i in 2 to 7 generate
        clr_irq(i) <= INTAClear(i) or NotSWIFGWrite(i);
    end generate IFGUpdateClr;

    END InterruptControllerWrap;
