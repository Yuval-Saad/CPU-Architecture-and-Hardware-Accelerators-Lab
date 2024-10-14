library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;

ENTITY GPIOwrap IS
	PORT(reset, clock				: IN 	STD_LOGIC; 
         MemWrite, MemRead          : IN    STD_LOGIC;
		 Address                    : IN    STD_LOGIC_VECTOR (5 DOWNTO 0); -- [A11, A5, A4, A3, A2, A0] 
         Data                       : INOUT STD_LOGIC_VECTOR (31 DOWNTO 0); -- [D7 .. D0]
         SW                         : IN    STD_LOGIC_VECTOR (7 DOWNTO 0);
         HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: OUT STD_LOGIC_VECTOR (6 DOWNTO 0); 
         LEDs                       : OUT   STD_LOGIC_VECTOR (7 DOWNTO 0));
END GPIOwrap;

ARCHITECTURE GPIOwrap OF GPIOwrap IS
    SIGNAL CS: STD_LOGIC_VECTOR (4 DOWNTO 0); -- [SW, HEX10, HEX32, HEX54, LEDs]
    SIGNAL HEX0DecodeInput, HEX1DecodeInput, HEX2DecodeInput, HEX3DecodeInput, HEX4DecodeInput, HEX5DecodeInput: STD_LOGIC_VECTOR (7 DOWNTO 0);
    SIGNAL NotA0 : STD_LOGIC;
BEGIN
    NotA0 <= not Address(0);
    AddrDecode: AddressDecoder port map(A => Address(5 downto 1),
                                        CS => CS);
    Switches: InputPort port map (CS => CS(4),
                                  MemRead => MemRead,
                                  InPort => SW,
                                  Data => Data);
    HEX5Port: OutputPort port map (reset => reset,
                                  clock => clock,
                                  CS => CS(3),
                                  A0 => Address(0),
                                  MemWrite => MemWrite,
                                  MemRead => MemRead,
                                  Data => Data,
                                  PortOut => HEX5DecodeInput);
    HEX4Port: OutputPort port map (reset => reset,
                                  clock => clock,
                                  CS => CS(3),
                                  A0 => NotA0,
                                  MemWrite => MemWrite,
                                  MemRead => MemRead,
                                  Data => Data,
                                  PortOut => HEX4DecodeInput);
    HEX3Port: OutputPort port map (reset => reset,
                                  clock => clock,
                                  CS => CS(2),
                                  A0 => Address(0),
                                  MemWrite => MemWrite,
                                  MemRead => MemRead,
                                  Data => Data,
                                  PortOut => HEX3DecodeInput);
    HEX2Port: OutputPort port map (reset => reset,
                                  clock => clock,
                                  CS => CS(2),
                                  A0 => NotA0,
                                  MemWrite => MemWrite,
                                  MemRead => MemRead,
                                  Data => Data,
                                  PortOut => HEX2DecodeInput);
    HEX1Port: OutputPort port map (reset => reset,
                                   clock => clock,
                                   CS => CS(1),
                                   A0 => Address(0),
                                   MemWrite => MemWrite,
                                   MemRead => MemRead,
                                   Data => Data,
                                   PortOut => HEX1DecodeInput);
    HEX0Port: OutputPort port map (reset => reset,
                                   clock => clock,CS => CS(1),
                                   A0 => NotA0,
                                   MemWrite => MemWrite,
                                   MemRead => MemRead,
                                   Data => Data,
                                   PortOut => HEX0DecodeInput);
    LEDsPort: OutputPort port map (reset => reset,
                                   clock => clock,
                                   CS => CS(0),
                                   A0 => '1',
                                   MemWrite => MemWrite,
                                   MemRead => MemRead,
                                   Data => Data,
                                   PortOut => LEDs);
    HEX0Decode: HEXdecode port map (Xin => HEX0DecodeInput(3 downto 0),
                                    Xout => HEX0);
    HEX1Decode: HEXdecode port map (Xin => HEX1DecodeInput(3 downto 0),
                                    Xout => HEX1);
    HEX2Decode: HEXdecode port map (Xin => HEX2DecodeInput(3 downto 0),
                                    Xout => HEX2);
    HEX3Decode: HEXdecode port map (Xin => HEX3DecodeInput(3 downto 0),
                                    Xout => HEX3);
    HEX4Decode: HEXdecode port map (Xin => HEX4DecodeInput(3 downto 0),
                                    Xout => HEX4);
    HEX5Decode: HEXdecode port map (Xin => HEX5DecodeInput(3 downto 0),
                                    Xout => HEX5);
END GPIOwrap;