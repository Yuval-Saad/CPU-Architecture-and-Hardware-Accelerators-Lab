library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;

ENTITY INTReg IS
	PORT(rst, clk: IN STD_LOGIC; 
         setIFG, clr_irq, eint: IN STD_LOGIC_VECTOR(7 downto 0); 
         GIE: IN STD_LOGIC; 
         IFG: BUFFER STD_LOGIC_VECTOR(7 downto 0); 
         INTR: OUT STD_LOGIC;
         irq: OUT STD_LOGIC_VECTOR(7 downto 0));
END INTReg;

ARCHITECTURE INTReg OF INTReg IS
    SIGNAL OrIFG: STD_LOGIC;
BEGIN
    IFG0: INTBitReg port map (rst => rst,
                              clk => clk,
                              setIFG => setIFG(0),
                              clr_irq => clr_irq(0),
                              eint => eint(0),
                              irq => irq(0),
                              IFGx => IFG(0));
    IFG1: INTBitReg port map (rst => rst,
                              clk => clk,
                              setIFG => setIFG(1),
                              clr_irq => clr_irq(1),
                              eint => eint(1),
                              irq => irq(1),
                              IFGx => IFG(1));
    IFG2: INTBitReg port map (rst => rst,
                              clk => clk,
                              setIFG => setIFG(2),
                              clr_irq => clr_irq(2),
                              eint => eint(2),
                              irq => irq(2),
                              IFGx => IFG(2));
    IFG3: INTBitReg port map (rst => rst,
                              clk => clk,
                              setIFG => setIFG(3),
                              clr_irq => clr_irq(3),
                              eint => eint(3),
                              irq => irq(3),
                              IFGx => IFG(3));
    IFG4: INTBitReg port map (rst => rst,
                              clk => clk,
                              setIFG => setIFG(4),
                              clr_irq => clr_irq(4),
                              eint => eint(4),
                              irq => irq(4),
                              IFGx => IFG(4));
    IFG5: INTBitReg port map (rst => rst,
                              clk => clk,
                              setIFG => setIFG(5),
                              clr_irq => clr_irq(5),
                              eint => eint(5),
                              irq => irq(5),
                              IFGx => IFG(5));
    IFG6: INTBitReg port map (rst => rst,
                              clk => clk,
                              setIFG => setIFG(6),
                              clr_irq => clr_irq(6),
                              eint => eint(6),
                              irq => irq(6),
                              IFGx => IFG(6));
    IFG7: INTBitReg port map (rst => rst,
                              clk => clk,
                              setIFG => setIFG(7),
                              clr_irq => clr_irq(7),
                              eint => eint(7),
                              irq => irq(7),
                              IFGx => IFG(7));
    
    OrIFG <= IFG(0) or IFG(1) or IFG(2) or IFG(3) or IFG(4) or IFG(5) or IFG(6) or IFG(7);
    INTR <= OrIFG and GIE;
END INTReg;
