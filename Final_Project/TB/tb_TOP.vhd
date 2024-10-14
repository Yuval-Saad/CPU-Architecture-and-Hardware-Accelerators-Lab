ENTITY tb_TOP IS
END tb_TOP ;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use work.aux_package.all;

ARCHITECTURE tb_TOP OF tb_TOP IS
        SIGNAL clock, DIVClk                        : STD_LOGIC := '0'; 
        SIGNAL RXUART, TXUART                       : STD_LOGIC := '0';
        SIGNAL SW 			                        : STD_LOGIC_VECTOR (7 DOWNTO 0) := X"99";
        SIGNAL KEY                                  : STD_LOGIC_VECTOR (3 downto 0) := (others => '1');
        SIGNAL PWMout               	            : STD_LOGIC;
        SIGNAL HEX0, HEX1, HEX2, HEX3, HEX4, HEX5   : STD_LOGIC_VECTOR(6 DOWNTO 0);
        SIGNAL LEDs						            : STD_LOGIC_VECTOR (7 DOWNTO 0);
                -- ModuleWare signal declarations(v1.9) for instance 'U_0' of 'clk'
        SIGNAL mw_U_0clk : std_logic;
        SIGNAL mw_U_0disable_clk : boolean := FALSE;
BEGIN

    div_clk: PROCESS
    BEGIN
    WHILE NOT mw_U_0disable_clk LOOP
        DIVClk <= '0', '1' AFTER 15 ns;
        WAIT FOR 30 ns;
    END LOOP;
    WAIT;
    END PROCESS div_clk;

    u_0clk_proc: PROCESS
    BEGIN
    WHILE NOT mw_U_0disable_clk LOOP
        mw_U_0clk <= '0', '1' AFTER 50 ns;
        WAIT FOR 100 ns;
    END LOOP;
    WAIT;
    END PROCESS u_0clk_proc;
    mw_U_0disable_clk <= TRUE AFTER 3000 ms;
    clock <= mw_U_0clk;

    tb : process begin
        KEY(0) <= '1';
        wait for 20 ns;
        KEY(0) <= '0';
        wait for 120 ns;
        KEY(0) <= '1';
        SW <= X"AA";
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        KEY(1) <= '0';
        wait until rising_edge(clock);
        KEY(1) <= '1';
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        SW <= X"BB";
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        KEY(2) <= '0';
        wait until rising_edge(clock);
        KEY(2) <= '1';
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        SW <= X"CC";
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        KEY(3) <= '0';
        wait until rising_edge(clock);
        KEY(3) <= '1';
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        KEY(0) <= '0';
        wait until rising_edge(clock);
        wait until rising_edge(clock);
        KEY(0) <= '1';
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        SW <= X"11";
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        KEY(1) <= '0';
        wait until rising_edge(clock);
        KEY(1) <= '1';
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        SW <= X"22";
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        KEY(2) <= '0';
        wait until rising_edge(clock);
        KEY(2) <= '1';
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        SW <= X"33";
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        KEY(3) <= '0';
        wait until rising_edge(clock);
        KEY(3) <= '1';
        for i in 0 to 100 loop
            wait until rising_edge(clock);
        end loop;
        WAIT;
    end process;





    TOP_INST : TOP
      GENERIC MAP (ModelSim => TRUE,
                   adressSize => 9)
      PORT MAP (
         InClock         => clock,
         DIVClk          => DIVClk,
         RXUART          => RXUART,
         TXUART          => TXUART,
         SW              => SW,
         KEY             => KEY,
         PWMout          => PWMout,
         HEX0            => HEX0,
         HEX1            => HEX1,
         HEX2            => HEX2,
         HEX3            => HEX3,
         HEX4            => HEX4,
         HEX5            => HEX5,
         LEDs            => LEDs);

END tb_TOP;
