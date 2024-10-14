library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;

ENTITY AddressDecoder IS
	PORT(A                          : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
		 CS                         : OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
END AddressDecoder;

ARCHITECTURE AddressDecoder OF AddressDecoder IS
BEGIN

    WITH A SELECT        
        CS <= "00001" WHEN "10000",
              "00010" WHEN "10001",
              "00100" WHEN "10010",
              "01000" WHEN "10011",
              "10000" WHEN "10100",
              "00000" WHEN OTHERS;

END AddressDecoder;
