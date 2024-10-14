LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MipsInterruptHandler IS
        PORT(clock,reset	            : IN  STD_LOGIC;
             instruction		        : IN  STD_LOGIC_VECTOR(31 downto 0);	-- from IFETCH
             NxtPCOut                   : IN  STD_LOGIC_VECTOR( 11 DOWNTO 0);
             INTR                       : IN  STD_LOGIC;
             INTA                       : OUT STD_LOGIC;
             InterruptInstructionValid  : OUT STD_LOGIC;
             GIEOff                     : OUT STD_LOGIC;
             GIEOn                      : OUT STD_LOGIC;
             StorePC                    : OUT STD_LOGIC;
             SavedPC                    : OUT STD_LOGIC_VECTOR( 11 DOWNTO 0);
             InterruptInstruction       : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0));
END MipsInterruptHandler;


ARCHITECTURE MipsInterruptHandler OF MipsInterruptHandler IS
    type state is (state0, state1, state2, state3, state4);
    SIGNAL curr_state, next_state : state;
    SIGNAL gotReti :    STD_LOGIC;
BEGIN
    process (clock)
    begin
        if (rising_edge(clock)) then
            if(reset='1') then
                curr_state <= state0;
            else
                curr_state <= next_state;
            end if;
        end if;	
    end process;   

    process (clock)
    begin 
        if(rising_edge(clock)) then
            if(reset='1') then 
                SavedPC <= (others => '0');
            elsif (curr_state = state0 and INTR = '1') then
                SavedPC <= NxtPCOut;
            end if;
        end if;
    end process;

    process(curr_state, INTR, gotReti)
	begin
		case curr_state is

			when state0 =>
				if (INTR = '1') then
					next_state <= state1;
				else 
                    next_state <= state0;
				end if;
            
			when state1 =>
                next_state <= state2;
            
			when state2 =>
                next_state <= state3;

			when state3 =>
                next_state <= state4;
            
			when state4 =>
				if (gotReti = '1') then
					next_state <= state0;
				else 
                    next_state <= state4;
				end if;
		end case;

	end process;
    GIEOff <= '1' WHEN curr_state = state1 ELSE '0';
    StorePC <= '1' WHEN curr_state = state3 ELSE '0';
    GIEOn <= '1' WHEN curr_state = state4 AND gotReti = '1' ELSE '0';
    INTA <= '1' WHEN curr_state = state1 ELSE '0';
    InterruptInstructionValid <= '1' when curr_state = state1 OR curr_state = state2 OR curr_state = state3 ELSE '0';
    InterruptInstruction <= B"100011" & B"00000" & B"11011" & X"083E" WHEN curr_state = state1 ELSE -- load type to k1
                            B"100011" & B"11011" & B"11011" & X"0000" WHEN curr_state = state2 ELSE -- load the content of type to k1 
                            B"000000" & B"11011" & B"0000000000" & B"00000" & B"001000" WHEN curr_state = state3 ELSE (others => '0'); --JR k1
    gotReti <= '1' WHEN instruction = B"000000" & B"11011" & B"0000000000" & B"00000" & B"001000" ELSE '0';

END MipsInterruptHandler;