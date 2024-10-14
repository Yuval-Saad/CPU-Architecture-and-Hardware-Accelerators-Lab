library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;

ENTITY OutputPort IS
	PORT(reset, clock                   : IN        STD_LOGIC;  
         CS, A0, MemWrite, MemRead      : IN        STD_LOGIC; 
		 Data                           : INOUT     STD_LOGIC_VECTOR (31 DOWNTO 0);
         PortOut                        : OUT       STD_LOGIC_VECTOR (7 DOWNTO 0));
END OutputPort;

ARCHITECTURE OutputPort OF OutputPort IS
    SIGNAL En       : STD_LOGIC;
    SIGNAL LetchIn  : STD_LOGIC_VECTOR (31 DOWNTO 0);
    SIGNAL pinIn    : STD_LOGIC;
    SIGNAL DataOut  : STD_LOGIC_VECTOR (31 DOWNTO 0);
BEGIN
    En <= CS and A0 and MemWrite;
    pinIn <= CS and A0 and MemRead;
    PortOut <= DataOut(7 DOWNTO 0);
    

    process (clock) begin
        if reset = '1' then 
            DataOut <= (others => '0');
        elsif (rising_edge(clock)) then
            if En = '1' then
                DataOut <= LetchIn;
            end if;
        end if;
    end process;
        
    pin: BidirPin generic map (32) port map (Dout => DataOut,
			                                en => pinIn,
			                                Din => LetchIn,
			                                IOpin => Data);

END OutputPort;
