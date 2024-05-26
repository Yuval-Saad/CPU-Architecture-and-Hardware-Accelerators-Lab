library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
USE work.aux_package.all;
---------------------------------------------------------
entity tb is
	constant n : integer := 8;
end tb;
---------------------------------------------------------
architecture tb of tb is
	SIGNAL rst,ena,clk : std_logic;
	SIGNAL x12 : std_logic_vector(7 downto 0);
	SIGNAL detector1 : std_logic;
	SIGNAL detector2 : std_logic;
	SIGNAL x3 : std_logic_vector(15 downto 0);
	SIGNAL DetectionCode : integer range 0 to 3;
	SIGNAL detector3 : std_logic;
begin
	L0 : top generic map (8,7,3) port map(rst,ena,clk,x12,DetectionCode,detector1);
    L1 : top generic map (8,4,3) port map(rst,ena,clk,x12,DetectionCode,detector2);
	L2 : top generic map (16,5,3) port map(rst,ena,clk,x3,DetectionCode,detector3);

    
	------------ start of stimulus section --------------	

        gen_clk : process
        begin
		  clk <= '0';
		  wait for 50 ns;
		  clk <= not clk;
		  wait for 50 ns;
        end process;
		
        gen_code : process
        begin
            for i in 0 to 4 loop
                DetectionCode <= i;
                wait for 10 us;
            end loop;
        end process;

		gen_x12 : process
        begin
		  for i in 1 to 5 loop
            x12 <= (others => '0');
            for k in 0 to 20 loop
			    wait for 100 ns;
			    x12 <= x12+i;
		    end loop;
          end loop;
        end process;
		  
		gen_x3 : process
        begin
          x3 <= "1110011001001110";
		  for i in 1 to 5 loop
            for k in 0 to 20 loop
			    wait for 100 ns;
			    x3 <= x3+i;
		    end loop;
          end loop;
        end process;

		gen_rst : process
        begin
            rst <= '1';
            wait for 50 ns;
            rst <= not rst;
            wait for 1850 ns;
        end process; 

		gen_ena : process
        begin
            ena <= '1';
            wait for 850 ns;
            ena <= not ena;
            wait for 200 ns;
        end process;
  
end architecture tb;
