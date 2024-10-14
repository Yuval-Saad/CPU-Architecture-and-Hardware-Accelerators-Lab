library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;
use ieee.numeric_std.all;

ENTITY Timer IS
	PORT(rst, clk: STD_LOGIC;
         MemWrite, MemRead: IN STD_LOGIC;
         addr: IN STD_LOGIC_VECTOR(11 DOWNTO 0);
         data: INOUT STD_LOGIC_VECTOR(31 DOWNTO 0);
         set_BTIFG , PWMout: OUT STD_LOGIC);
END Timer;

ARCHITECTURE Timer OF Timer IS
    SIGNAL BTCCR0, BTCCR1: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL BTCTL: STD_LOGIC_VECTOR(7 DOWNTO 0);
    SIGNAL BTCNT, BTCNT_internal: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL WriteTimer: STD_LOGIC;
    SIGNAL DataOut: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL DataIn: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL writeToBusEn: STD_LOGIC;
    SIGNAL nextTimer: STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL prevTimer: STD_LOGIC_VECTOR(31 DOWNTO 0);

BEGIN

    process (clk, rst) begin
        if (rst = '1') then
            BTCCR0 <= (others => '0');
        elsif (rising_edge(clk)) then
            if MemWrite = '1' then
                if addr = X"824" then
                    BTCCR0 <= DataIn;
                end if;
            end if;
        end if;
    end process;

    process (clk, rst) begin
        if (rst = '1') then
            BTCCR1 <= (others => '0');
        elsif (rising_edge(clk)) then
            if MemWrite = '1' then
                if addr = X"828" then
                    BTCCR1 <= DataIn;
                end if;
            end if;
        end if;
    end process;

    process (clk, rst) begin
        if (rst = '1') then
            BTCTL <= (others => '0');
        elsif (rising_edge(clk)) then
            if MemWrite = '1' then
                if addr = X"81C" then
                    BTCTL <= DataIn(7 downto 0);
                end if;
            end if;
        end if;
    end process;

    process (clk, rst) begin
        if (rst = '1') then
            BTCNT_internal <= (others => '0');
        elsif (rising_edge(clk)) then
            if MemWrite = '1' and addr = X"820" then
                BTCNT_internal <= DataIn;
            elsif prevTimer /= nextTimer then
                BTCNT_internal <= nextTimer;
            end if;
        end if;
    end process;

    process (clk, rst) begin
        if (rst = '1') then
            prevTimer <= (others => '0');
        elsif (rising_edge(clk)) then
            if BTCTL(5) = '0' then
                prevTimer <= nextTimer;
            end if;
        end if;
    end process;

    pin: BidirPin generic map (32) port map (Dout => DataOut,
			                                 en => writeToBusEn,
			                                 Din => DataIn,
			                                 IOpin => data);
    
    writeToBusEn <= MemRead when (addr = X"81C" or addr = X"828" or addr = X"824" or addr = X"820") else '0';

    with addr select 
        DataOut <= X"000000" & BTCTL when X"81C",
                   BTCCR0 when X"824",
                   BTCCR1 when X"828",
                   BTCNT when X"820",
                   (others => '0') when others;                 

    TimerOutPut: TimerOutputUnit port map(BTCCR0 => BTCCR0,
                                          BTCCR1 => BTCCR1,
                                          BTOUTEN => BTCTL(6),
                                          BTOUTMD => BTCTL(7),
                                          timer => BTCNT,
                                          PWMout => PWMout);
    
    -- process (WriteTimer ,nextTimer) begin
    --     BTCNT_internal <= BTCNT_internal;
    --     if WriteTimer = '1' then
    --         BTCNT_internal <= DataIn;
    --     elsif prevTimer /= nextTimer then
    --         BTCNT_internal <= nextTimer;
    --     -- end if;
    --     -- prevTimer <= nextTimer;
    -- end process;

    -- BTCNT_internal <= DataIn when WriteTimer = '1' else nextTimer;
    BTCNT <= BTCNT_internal;


    Timer_inst: BTCNTwrap port map(rst => rst,
                                   MCLK => clk,
                                   BTSSEL => BTCTL(4 downto 3),
                                   BTHOLD => BTCTL(5),
                                   BTCCR0 => BTCCR0,
                                   currentTimer => BTCNT_internal,
                                   nextTimer => nextTimer);

    with BTCTL(2 downto 0) select
        set_BTIFG <= BTCNT(0) when "000",
                     BTCNT(3) when "001",
                     BTCNT(7) when "010",
                     BTCNT(11) when "011",
                     BTCNT(15) when "100",
                     BTCNT(19) when "101",
                     BTCNT(23) when "110",
                     BTCNT(25) when others;

END Timer;