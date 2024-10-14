LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;


entity tb_Timer is
end tb_Timer;

architecture tb_Timer of tb_Timer is

    signal rst, clk: STD_LOGIC := '0';
    signal MemWrite, MemRead: STD_LOGIC := '0';
    signal addr: STD_LOGIC_VECTOR(11 DOWNTO 0) := (others => '0');
    signal data: STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
    signal set_BTIFG , PWMout: STD_LOGIC := '0';

begin

    Timer_inst: Timer port map(rst => rst,
                               clk => clk,
                               MemWrite => MemWrite,
                               MemRead => MemRead,
                               addr => addr,
                               data => data,
                               set_BTIFG => set_BTIFG,
                               PWMout => PWMout);
    
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
        wait until rising_edge(clk); -- CCR are 0 then timer should not count
        data <= X"000003E8";
        addr <= X"824";
        MemWrite <= '1';             --set CCR0 to value 7
        wait until rising_edge(clk);
        data <= X"000000FA";
        addr <= X"828";              --set CCR1 to value 4
        wait until rising_edge(clk);
        data <= X"00000027";
        addr <= x"81C";              --set BTCTL to HOLD and first FLAG
        wait until rising_edge(clk);
        MemWrite <= '0';
        MemRead <= '1';
        data <=  (others => 'Z');
        addr <= X"824";               --read CCR0
        wait until rising_edge(clk);
        addr <= X"828";               --read CCR1
        wait until rising_edge(clk);
        addr <= x"81C";               --read BTCTL
        wait until rising_edge(clk);
        addr <= x"820";               --read Timer
        wait until rising_edge(clk);
        MemWrite <= '1';
        MemRead <= '0';
        addr <= x"81C";
        data <= X"00000007";          --set BTCTL to NOT HOLD and first FLAG
        wait until rising_edge(clk);
        MemWrite <= '0';
        for i in 0 to 9 loop          --wait for timer to count
            wait until rising_edge(clk);
        end loop;
        MemWrite <= '1';              
        data <= X"00000047";          --set BTCTL to EN (for PWN OUTput) and first FLAG
        wait until rising_edge(clk);
        MemWrite <= '0';
        for i in 0 to 10000 loop          --wait for timer to count
            wait until rising_edge(clk);
        end loop;
        MemWrite <= '1';
        addr <= x"820";
        data <= X"00000002";          --set Timer to 2
        wait until rising_edge(clk);
        MemWrite <= '0';
        for i in 0 to 9 loop          --wait for timer to count
            wait until rising_edge(clk);
        end loop;
        MemWrite <= '1';
        addr <= x"81C" ;
        data <= x"000000C7";          --set BTCTL to EN (for PWN OUTput), Mode 1 and first FLAG
        wait until rising_edge(clk);
        MemWrite <= '0';
        for i in 0 to 9 loop          --wait for timer to count
            wait until rising_edge(clk);
        end loop;
        MemWrite <= '1';
        data <= x"000000CF";          --set BTCTL to EN (for PWN OUTput), Mode 1 and first FLAG with clock divider 2
        wait until rising_edge(clk);
        MemWrite <= '0';
        for i in 0 to 14 loop         --wait for timer to count
            wait until rising_edge(clk);
        end loop;
        MemWrite <= '1';
        data <= x"000000D7";          --set BTCTL to EN (for PWN OUTput), Mode 1 and first FLAG with clock divider 4
        wait until rising_edge(clk);
        MemWrite <= '0';
        for i in 0 to 28 loop         --wait for timer to count
            wait until rising_edge(clk);
        end loop;
        MemWrite <= '1';
        data <= x"000000DF";          --set BTCTL to EN (for PWN OUTput), Mode 1 and first FLAG with clock divider 8
        wait until rising_edge(clk);
        MemWrite <= '0';
        wait until rising_edge(clk);
        wait until rising_edge(clk);
        MemWrite <= '1';
        addr <= x"820";
        data <= X"00000005";          --set Timer to 2
        wait until rising_edge(clk);
        MemWrite <= '0';
        wait until rising_edge(clk);
        for i in 0 to 56 loop         --wait for timer to count
            wait until rising_edge(clk);
        end loop;
      
    end process;
end tb_Timer;