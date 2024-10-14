library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;

ENTITY INTBitReg IS
	PORT(rst, clk, setIFG, clr_irq, eint: IN STD_LOGIC; 
         irq: BUFFER STD_LOGIC;
         IFGx: OUT STD_LOGIC);
END INTBitReg;

ARCHITECTURE INTBitReg OF INTBitReg IS
    --SIGNAL InReg, clr: STD_LOGIC;
    SIGNAL setIFGprev: STD_LOGIC;

BEGIN
    -- process (setIFG, clr) begin
    --     if (clr = '1') then
    --         InReg <= '0';
    --     elsif (rising_edge(setIFG)) then
    --         InReg <= '1';
    --     end if;
    -- end process;

    -- process (clk, rst) begin
    --     if (rising_edge(clk)) then
    --         if (rst = '1') then
    --             irq <= '0';
    --         else
    --             irq <= InReg;
    --         end if;
    --     end if;
    -- end process;

    -- clr <= clr_irq or rst;
    -- IFGx <= irq and eint;


    process (clk, rst) begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                irq <= '0';
                setIFGprev <= '0';
            else 
                if (clr_irq = '1') then
                    irq <= '0';
                elsif (setIFG = '1' and setIFGprev = '0') then
                    irq <= '1';
                end if;
                setIFGprev <= setIFG;
            end if;
        end if;
    end process;
    
    IFGx <= irq and eint;

END INTBitReg;
