LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.aux_package.all;

ENTITY TOP IS
    PORT(   InClock				                : IN  STD_LOGIC; 
            -- DIVClk                              : IN  STD_LOGIC;
            RXUART			                  	: IN  STD_LOGIC;
            TXUART			                  	: IN  STD_LOGIC;
            SW                                  : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
            KEY             					: IN  STD_LOGIC_VECTOR (3 downto 0);
            PWMout                              : OUT STD_LOGIC;
            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5  : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); 
            LEDs                                : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END TOP;

ARCHITECTURE TOP OF TOP IS
    SIGNAL INTR         : STD_LOGIC;
    SIGNAL INTA         : STD_LOGIC;
    SIGNAL MemRead      : STD_LOGIC;
    SIGNAL MemWrite     : STD_LOGIC;
    SIGNAL addr         : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL data         : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL irq          : STD_LOGIC_VECTOR(7 downto 0);
    SIGNAL GIE          : STD_LOGIC;
    SIGNAL TXBUFRead    : STD_LOGIC;
    SIGNAL RXBUFRead    : STD_LOGIC;
    SIGNAL DivIFG       : STD_LOGIC;
    SIGNAL set_BTIFG    : STD_LOGIC;
    SIGNAL AddrToGPIO              : STD_LOGIC_VECTOR(5 DOWNTO 0);
    SIGNAL SystemKeys              : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL reset,clock,dividerClk  : STD_LOGIC;
BEGIN

    irq <= ('0', DivIFG, SystemKeys(3), SystemKeys(2), SystemKeys(1), set_BTIFG, '0', '0');
    AddrToGPIO <= (addr(11), addr(5), addr(4), addr(3), addr(2), addr(0));
    reset <= SystemKeys(0);
    SystemKeys <= NOT KEY;

    -- clock <= InClock; --comment in quartus
    -- dividerClk <= DIVClk;

	PLL_INST : PLL PORT MAP (refclk => InClock,
                             rst => '0',
                             outclk_0 => clock,
                             outclk_1 => dividerClk,
                             locked => open);


    
    MIPS_INST : MIPS GENERIC MAP (ModelSim					=> false,
                                  adressSize				=> 12) -- 9 for modelSim 11 for quartus
                     PORT MAP    (reset       => reset,
                                  clock       => clock,
                                  INTR        => INTR,
                                  INTA        => INTA,
                                  GIEOut      => GIE,
                                  MemReadOut  => MemRead,
                                  MemWriteOut => MemWrite,
                                  Addr        => addr,
                                  data        => data);
    
    InterruptController_INST : InterruptControllerWrap
                     PORT MAP    (rst           => reset,
                                  clk           => clock,
                                  MemWrite      => MemWrite,
                                  MemRead       => MemRead,
                                  irq           => irq,
                                  addr          => addr(11 downto 0),
                                  GIE           => GIE,
                                  INTA          => INTA,
                                  TXBUFRead     => TXBUFRead,
                                  RXBUFRead     => RXBUFRead,
                                  INTR          => INTR,
                                  data          => data);

    Divider_INST : DividerWrap
                     PORT MAP   (rst           => reset,
                                 clk           => dividerClk,
                                 MemWrite      => MemWrite,
                                 MemRead       => MemRead,
                                 addr          => addr(11 downto 0),
                                 data          => data,
                                 DivIFG        => DivIFG);

    Timer_INST : Timer
                     PORT MAP   (rst           => reset,
                                 clk           => clock,
                                 MemWrite      => MemWrite,
                                 MemRead       => MemRead,
                                 addr          => addr(11 downto 0),
                                 data          => data,
                                 set_BTIFG     => set_BTIFG,
                                 PWMout        => PWMout);

    GPIO_INST : GPIOwrap
                     PORT MAP   (reset         => reset,
                                 clock         => clock,
                                 MemWrite      => MemWrite,
                                 MemRead       => MemRead,
                                 Address       => AddrToGPIO,
                                 Data          => Data,
                                 SW            => SW,
                                 HEX0          => HEX0,
                                 HEX1          => HEX1,
                                 HEX2          => HEX2,
                                 HEX3          => HEX3,
                                 HEX4          => HEX4,
                                 HEX5          => HEX5,
                                 LEDs          => LEDs);

END TOP;

