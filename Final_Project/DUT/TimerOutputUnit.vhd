library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;
use ieee.numeric_std.all;

ENTITY TimerOutputUnit IS
	PORT(BTCCR0, BTCCR1: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         BTOUTEN, BTOUTMD: IN STD_LOGIC;
         timer: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         PWMout: OUT STD_LOGIC);
END TimerOutputUnit;

ARCHITECTURE TimerOutputUnit OF TimerOutputUnit IS
    SIGNAL PWM: STD_LOGIC;
BEGIN
    process (timer) begin
        if BTOUTEN = '1' then
            if timer <= BTCCR1 then
                PWM <= '0';    
            else
                PWM <= '1';
            end if;
        end if;
    end process;

    PWMout <= PWM when BTOUTMD = '0' else not PWM;
END TimerOutputUnit;