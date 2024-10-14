library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;
use ieee.std_logic_unsigned.all;

ENTITY BTCNT IS
	PORT(rst, clk, EN: IN STD_LOGIC;
         BTCCR0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         currentTimer: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         nextTimer: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END BTCNT;

ARCHITECTURE BTCNT OF BTCNT IS
BEGIN
    process (clk, rst) begin
        if (rst = '1') then
            nextTimer <= (others => '0');
        elsif (rising_edge(clk)) then
            if (EN = '1') then
                if (BTCCR0 <= currentTimer) then 
                    nextTimer <= (others => '0');
                else
                    nextTimer <= currentTimer + 1;
                end if;
            end if;
        end if;	
    end process;
END BTCNT;