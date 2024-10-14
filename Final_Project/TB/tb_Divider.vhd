LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;


entity tb_Divider is
end tb_Divider;

architecture tb_Divider of tb_Divider is

    SIGNAL rst, clk: STD_LOGIC := '0';
    SIGNAL MemWrite, MemRead: STD_LOGIC := '0';
    SIGNAL addr: STD_LOGIC_VECTOR(11 DOWNTO 0) := (others => '0');
    SIGNAL data: STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    SIGNAL DivIFG: STD_LOGIC := '0';

begin

    Divider_inst: DividerWrap port map(rst => rst,
                                       clk => clk,
                                       MemWrite => MemWrite,
                                       MemRead => MemRead,
                                       addr => addr,
                                       data => data,
                                       DivIFG => DivIFG);
    
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
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        data <= X"000007D0";
        addr <= X"82C";
        MemWrite <= '1';             --Set Dividend 2000
        wait until rising_edge(clk);
        data <= X"00000003";
        addr <= X"830";              --Set Divisor 3
        wait until rising_edge(clk);
        MemWrite <= '0';
        MemRead <= '1';
        data <=  (others => 'Z');
        addr <= X"82C";               --read Dividend
        wait until rising_edge(clk);
        addr <= X"830";               --read Divisor
        wait until rising_edge(clk);
        addr <= x"834";               --read Quotient
        wait until rising_edge(clk);
        addr <= x"838";               --read Residue
        wait until rising_edge(clk);
        MemRead <= '0';
        for i in 0 to 31 loop          --wait for timer to count
            wait until rising_edge(clk);
        end loop;
        MemRead <= '1';
        addr <= X"82C";               --read Dividend
        wait until rising_edge(clk);
        addr <= X"830";               --read Divisor
        wait until rising_edge(clk);
        addr <= x"834";               --read Quotient
        wait until rising_edge(clk);
        addr <= x"838";               --read Residue              
        wait until rising_edge(clk);
        MemRead <= '0';
        MemWrite <= '1';
        data <= X"00000020";
        addr <= X"82C";             --Set Dividend 32
        wait until rising_edge(clk);
        data <= X"00000010";
        addr <= X"830";              --Set Divisor 16
        wait until rising_edge(clk);
        MemWrite <= '0';
        for i in 0 to 9 loop
            wait until rising_edge(clk);
        end loop;
        MemWrite <= '1';
        data <= X"00000500";
        addr <= X"82C";             --Set Dividend 1280
        wait until rising_edge(clk);
        data <= X"00000030";
        addr <= X"830";              --Set Divisor 48
        wait until rising_edge(clk);
        MemWrite <= '0';
        for i in 0 to 50 loop
            wait until rising_edge(clk);
        end loop;
    end process;
end tb_Divider;