LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;


entity tb_InterruptController is
end tb_InterruptController;

architecture tb_InterruptController of tb_InterruptController is

    SIGNAL rst, clk: STD_LOGIC := '0';
    SIGNAL MemWrite, MemRead: STD_LOGIC := '0';
    SIGNAL irq: STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    SIGNAL addr: STD_LOGIC_VECTOR(11 DOWNTO 0) := (others => '0');
    SIGNAL GIE: STD_LOGIC := '0';
    SIGNAL INTA: STD_LOGIC := '0';
    SIGNAL TXBUFRead: STD_LOGIC := '0';
    SIGNAL RXBUFRead: STD_LOGIC := '0';
    SIGNAL INTR: STD_LOGIC := '0';
    SIGNAL data: STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');

begin

    InterruptControllerWrapInst: InterruptControllerWrap port map(rst => rst,
                                                                  clk => clk,
                                                                  MemWrite => MemWrite,
                                                                  MemRead => MemRead,
                                                                  irq => irq,
                                                                  addr => addr,
                                                                  GIE => GIE,
                                                                  INTA => INTA,
                                                                  TXBUFRead => TXBUFRead,
                                                                  RXBUFRead => RXBUFRead,
                                                                  INTR => INTR,
                                                                  data => data);
    
    gen_clk : process begin
        clk <= '0';
        wait for 50 ns;
        clk <= not clk;
        wait for 50 ns;
    end process;

    tb : process begin
        rst <= '1';
        wait until rising_edge(clk);      
        rst <= '0';
        wait until rising_edge(clk);
        GIE <= '1'; 
        data <= X"000000" & X"55"; 
        addr <= X"83C";
        MemWrite <= '1';             --write "55" to IE
        wait until rising_edge(clk);
        MemWrite <= '0';
        MemRead <= '1';
        data <=  (others => 'Z');
        addr <= X"83C";               --read IE
        wait until rising_edge(clk);
        irq <= X"07";                 --set irq
        wait until rising_edge(clk);
        irq <= X"00";
        MemWrite <= '0';
        MemRead <= '1';
        data <=  (others => 'Z');
        addr <= X"83D";               --read IFG
        wait until rising_edge(clk);
        data <=  (others => 'Z');
        addr <= X"83E";               --read TYPE
        wait until rising_edge(clk);
        GIE <= '0';
        wait until rising_edge(clk);
        GIE <= '1';
        wait until rising_edge(clk);
        INTA <= '1';
        data <=  (others => 'Z');
        addr <= X"83E";               --read TYPE
        wait until rising_edge(clk);
        INTA <= '0';
        data <=  (others => 'Z');
        addr <= X"83D";               --read IFG
        wait until rising_edge(clk);
        data <=  (others => 'Z');
        addr <= X"83E";               --read TYPE
        wait until rising_edge(clk);
        MemWrite <= '1';
        MemRead <= '0';
        data <= X"000000" & X"03";
        addr <= X"83D";               --WRITE IFG
        wait until rising_edge(clk);
        data <= X"000000" & X"FF";
        addr <= X"83C";               --WRITE IE
        wait until rising_edge(clk);
        MemWrite <= '0';
        MemRead <= '1';
        data <=  (others => 'Z');
        addr <= X"83E";               --read TYPE
        wait until rising_edge(clk);
        data <=  (others => 'Z');
        addr <= X"83D";               --READ IFG
        wait until rising_edge(clk);
        RXBUFRead <= '1';
        data <=  (others => 'Z');
        addr <= X"83D";             --READ IFG
        wait until rising_edge(clk);
        RXBUFRead <= '0';
        data <=  (others => 'Z');
        addr <= X"83E";               --read TYPE
        wait until rising_edge(clk);
        TXBUFRead <= '1';
        data <=  (others => 'Z');
        addr <= X"83D";             --read IFG
        wait until rising_edge(clk);
        TXBUFRead <= '0';
        data <=  (others => 'Z');
        addr <= X"83E";               --read TYPE
        wait until rising_edge(clk);
    end process;
end tb_InterruptController;