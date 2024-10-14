library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;

ENTITY InputPort IS
	PORT(CS, MemRead    : IN    STD_LOGIC; 
		InPort          : IN    STD_LOGIC_VECTOR (7 DOWNTO 0);
        Data            : OUT   STD_LOGIC_VECTOR (31 DOWNTO 0));
END InputPort;

ARCHITECTURE InputPort OF InputPort IS
    SIGNAL En: STD_LOGIC;
BEGIN
    En <= CS and MemRead;
	Data <= X"000000" & InPort when(En='1') else (others => 'Z'); 
END InputPort;
