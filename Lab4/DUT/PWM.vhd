library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 

ENTITY PWM IS
  GENERIC (n : INTEGER := 8);
  PORT 
  ( rst, enb, clk: IN STD_LOGIC;
	Y: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    X: IN STD_LOGIC_VECTOR (n-1 DOWNTO 0);
    ALUFN: IN STD_LOGIC;
    PWMout: OUT STD_LOGIC
  );
END PWM;
-----------------------------------------
ARCHITECTURE PWM OF PWM IS

    signal count: STD_LOGIC_VECTOR (n-1 DOWNTO 0) := (others => '0');
    signal zeros_vector : std_logic_vector(n-1 downto 0) := (others => '0');
begin

	process (clk)
	begin
        if (rst = '1') then 
            count <= zeros_vector;
		elsif (clk 'event and clk='1') then
            if (enb = '1') then 
                if (count = Y) then 
                    count <= zeros_vector;
                else
                    count <= count + 1;
                end if;
            end if;
        end if;
	end process;

    process (clk,rst)
	begin
        if (rst = '1') then 
            PWMout <= ALUFN;
		elsif (clk 'event and clk='1') then
            if (enb = '1') then 
                if (count < X) then
                    PWMout <= ALUFN;
                else 
                    PWMout <= (not ALUFN);
                end if;
            end if;
        end if;
	end process;

END PWM;