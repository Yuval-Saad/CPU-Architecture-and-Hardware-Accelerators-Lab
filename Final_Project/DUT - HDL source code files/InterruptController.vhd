library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;

ENTITY InterruptController IS
    PORT(rst, clk: IN STD_LOGIC;
         setIFG, clr_irq: IN STD_LOGIC_VECTOR(7 downto 0);
         data: IN STD_LOGIC_VECTOR(7 downto 0);
         writeIE: IN STD_LOGIC;  
         GIE: IN STD_LOGIC;  
         INTR: OUT STD_LOGIC;
         irq: OUT STD_LOGIC_VECTOR(7 downto 0);
         OutType: OUT STD_LOGIC_VECTOR(7 downto 0);
         IFG, IE: BUFFER STD_LOGIC_VECTOR(7 downto 0));
END InterruptController;

ARCHITECTURE InterruptController OF InterruptController IS
BEGIN

    process (rst, clk) begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                IE <= (others => '0');
            elsif (writeIE = '1') then
                IE <= data;
            end if;
        end if;
    end process;

    INTRegInst: INTReg port map (rst => rst,
                                 clk => clk,
                                 setIFG => setIFG,
                                 clr_irq => clr_irq,
                                 eint => IE,
                                 GIE => GIE,
                                 IFG => IFG,
                                 INTR => INTR,
                                 irq => irq);

    OutType <= X"08" when IFG(0) = '1' else
               X"0C" when IFG(0) = '0' and IFG(1) = '1' else
               X"10" when IFG(0) = '0' and IFG(1) = '0' and IFG(2) = '1' else
               X"14" when IFG(0) = '0' and IFG(1) = '0' and IFG(2) = '0' and IFG(3) = '1' else
               X"18" when IFG(0) = '0' and IFG(1) = '0' and IFG(2) = '0' and IFG(3) = '0' and IFG(4) = '1' else
               X"1C" when IFG(0) = '0' and IFG(1) = '0' and IFG(2) = '0' and IFG(3) = '0' and IFG(4) = '0' and IFG(5) = '1' else
               X"20" when IFG(0) = '0' and IFG(1) = '0' and IFG(2) = '0' and IFG(3) = '0' and IFG(4) = '0' and IFG(5) = '0' and IFG(6) = '1' else
               X"00" when IFG(0) = '0' and IFG(1) = '0' and IFG(2) = '0' and IFG(3) = '0' and IFG(4) = '0' and IFG(5) = '0' and IFG(6) = '0' and IFG(7) = '0' else X"00";

END InterruptController;
