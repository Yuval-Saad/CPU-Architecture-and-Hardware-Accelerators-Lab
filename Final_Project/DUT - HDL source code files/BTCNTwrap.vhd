library ieee;
use ieee.std_logic_1164.all;
use work.aux_package.all;
use ieee.numeric_std.all;

ENTITY BTCNTwrap IS
	PORT(rst: IN STD_LOGIC;
         MCLK: IN STD_LOGIC;
         BTSSEL: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
         BTHOLD: IN STD_LOGIC;
         BTCCR0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         currentTimer: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
         nextTimer: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
END BTCNTwrap;

ARCHITECTURE BTCNTwrap OF BTCNTwrap IS
    SIGNAL notBTHOLD: STD_LOGIC;
    SIGNAL clk: STD_LOGIC;
    SIGNAL MCLKs: unsigned(2 DOWNTO 0) := "000";
    
BEGIN

    process (MCLK, rst) begin
        if (rst = '1') then
            MCLKs <= "000";
        elsif (rising_edge(MCLK)) then
            MCLKs <= MCLKs + 1;
        end if;
    end process;


    with BTSSEL select 
        clk <= MCLK when "00",
               MCLKs(0) when "01",
               MCLKs(1) when "10",
               MCLKs(2) when others;
    
    notBTHOLD <= not BTHOLD;
    
    BTCNTinst: BTCNT port map (rst => rst,
                               clk => clk,
                               EN =>notBTHOLD,
                               BTCCR0 => BTCCR0,
                               currentTimer => currentTimer,
                               nextTimer => nextTimer);

END BTCNTwrap;