library IEEE;
use ieee.std_logic_1164.all;
---------------------------------------------------------
entity ControlUnitTB is
end ControlUnitTB;
---------------------------------------------------------
architecture ControlUnitTB of ControlUnitTB is

    COMPONENT ControlUnit IS
        PORT ( 	clk, rst, enb: IN STD_LOGIC;
                done: OUT STD_LOGIC;

                op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc: IN STD_LOGIC;
                Nflag , Zflag , Cflag : IN STD_LOGIC;

                Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in : OUT STD_LOGIC;
                OPC : OUT STD_LOGIC_Vector(3 downto 0);
                RFaddr,PCsel : OUT STD_LOGIC_Vector(1 downto 0)
                );
    END COMPONENT;

    SIGNAL clk, rst, enb: STD_LOGIC;
    SIGNAL done: STD_LOGIC;
    SIGNAL op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc: STD_LOGIC;
    SIGNAL Nflag , Zflag , Cflag : STD_LOGIC;
    SIGNAL Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in : STD_LOGIC;
    SIGNAL OPC : STD_LOGIC_Vector(3 downto 0);
    SIGNAL RFaddr,PCsel : STD_LOGIC_Vector(1 downto 0);
begin

	ControlUnitTest : ControlUnit port map    (clk, rst, enb, done,
                                               op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc,
                                               Nflag , Zflag , Cflag,
                                               Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in,
                                               OPC, RFaddr ,PCsel);
    
	------------ start of stimulus section --------------	

        gen_clk : process
        begin
		  clk <= '0';
		  wait for 50 ns;
		  clk <= not clk;
		  wait for 50 ns;
        end process;
		
        gen_rst : process
        begin 
            rst <= '1';
            wait for 100 ns;
            rst <= '0';            
            wait for 9900 ns;
        end process;

        gen_enb : process
        begin
            enb <= '1';
            wait for 9 us;
            enb <= '0';
            wait for 1 us;
        end process;

        simulation : process (clk, rst)
        variable state : integer := 0;
    begin
        if (rst = '1') then -- state_rst
            Nflag <= '0';
            Zflag <= '0';
            Cflag <= '0';
            op_st <= '0';
            op_ld <= '0';
            op_mov <= '0';
            op_done <= '0';
            op_add <= '0';
            op_sub <= '0';
            op_jmp <= '0';
            op_jc <= '0';
            op_and <= '0';
            op_or <= '0';
            op_xor <= '0';
            op_jnc <= '0';  
            state := 0; 
        elsif (clk'event and clk = '1') then
            case state is
                when 0 => -- state_fetch
                    state := 1; 
                    op_add <= '1'; -- goto add - is 3 cycles 
                when 1 to 3 => -- add_op
                    state := state + 1; 
                when 4 => -- state_fetch
                    state := 5; 
                    op_add <= '0';
                    op_sub <= '1'; -- goto sub - is 3 cycles
                when 5 to 7 => -- sub_op
                    state := state + 1; 
                when 8 => -- state_fetch
                    state := 9; 
                    op_sub <= '0';
                    op_and <= '1'; -- goto and - is 3 cycles
                when 9 to 11 => -- and_op
                    state := state + 1; 
                when 12 => -- state_fetch
                    state := 13; 
                    op_and <= '0';
                    op_or <= '1'; -- goto or - is 3 cycles
                when 13 to 15 => -- or_op
                    state := state + 1;
                when 16 => -- state_fetch
                    state := 17; 
                    op_or <= '0';
                    op_xor <= '1'; -- goto xor - is 3 cycles
                when 17 to 19 => -- xor_op
                    state := state + 1;
                when 20 => -- state_fetch
                    state := 21; 
                    op_xor <= '0';
                    op_jmp <= '1'; -- goto jmp - is 1 cycle
                when 21 =>
                    state := state + 1;
                when 22 => -- state_fetch
                    state := 23; 
                    op_jmp <= '0';
                    op_jc <= '1'; -- goto jc - is 1 cycle
                when 23 =>
                    state := state + 1;
                when 24 => -- state_fetch
                    state := 25; 
                    op_jc <= '0';
                    op_jnc <= '1'; -- goto jnc - is 1 cycle
                when 25 =>
                    state := state + 1;
                when 26 => -- state_fetch
                    state := 27; 
                    op_jnc <= '0';
                    op_jc <= '1'; -- goto jc - is 1 cycle
                    Cflag <= '1';
                when 27 =>
                    state := state + 1; 
                when 28 => -- state_fetch
                    state := 29; 
                    op_jc <= '0';
                    op_jnc <= '1'; -- goto jnc - is 1 cycle
                when 29 =>
                    state := state + 1; 
                when 30 => -- state_fetch
                    state := 31; 
                    op_jnc <= '0';
                    op_mov <= '1'; -- goto mov - is 1 cycle
                    Cflag <= '1';
                when 31 =>
                    state := state + 1; 
                when 32 => -- state_fetch
                    state := 33; 
                    op_mov <= '0';
                    op_ld <= '1'; -- goto ld - is 4 cycles
                when 33 to 36 => -- ld_op
                    state := state + 1;
                when 37 => -- state_fetch
                    state := 38; 
                    op_ld <= '0';
                    op_st <= '1'; -- goto st - is 4 cycles
                when 38 to 41 => -- st_op
                    state := state + 1;
                when 42 => -- state_fetch
                    state := 43; 
                    op_st <= '0';
                    op_done <= '1'; -- goto done - is 1 cycle
                when 43 => -- state_fetch
                    state := 0; 
                    op_done <= '0';
                when others =>
                    state := 0;
            end case;
        end if;
    end process;
  
end architecture ControlUnitTB;
