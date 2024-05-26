library ieee;
use ieee.std_logic_1164.all;
use IEEE.std_logic_unsigned.all; 
 
entity freq_divider is 
	GENERIC(n : INTEGER := 2 ; m : INTEGER := 1 );
	port (rst,clk : in std_logic;	
		   out1,out2 : out std_logic); 
end freq_divider;
---------------------------------------------------------------
architecture rtl of freq_divider is
    signal q_int : std_logic_vector (31 downto 0);
begin
	process (clk,rst)
	begin
		if(rst='1') then
			q_int <= (others => '0');
		elsif (rising_edge(clk)) then	   
			q_int <= q_int + 1;
		end if;
    end process;
    out1 <= q_int(n);
	out2 <= q_int(m);
end rtl;



