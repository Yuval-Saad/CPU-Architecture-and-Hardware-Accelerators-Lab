LIBRARY ieee;
USE ieee.std_logic_1164.all;
-----------------------------------------------------
ENTITY ControlUnit IS
	PORT ( 	clk, rst, enb: IN STD_LOGIC;
			done: OUT STD_LOGIC;

			op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn: IN STD_LOGIC;
			Nflag , Zflag , Cflag : IN STD_LOGIC;

			Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in : OUT STD_LOGIC;
        	OPC : OUT STD_LOGIC_Vector(3 downto 0);
        	RFaddr,PCsel : OUT STD_LOGIC_Vector(1 downto 0)
			);
END ControlUnit;
-----------------------------------------------------
ARCHITECTURE state_machine OF ControlUnit IS
	TYPE state IS (state_rst , state_fetch , state_decode , state_Rtype0 , state_Rtype1 , state_Rtype2 , state_Jtype0 , state_mov , state_Itype0 , state_Itype1 , state_st0 , state_st1 , state_ld0 , state_ld1);
	SIGNAL pr_state, nx_state: state;
	SIGNAL NflagSig , ZflagSig , CflagSig : STD_LOGIC;
BEGIN
---------- Lower section: ------------------------
	PROCESS (rst, clk)
	BEGIN
		IF (rst='1') THEN
			pr_state <= state_rst;
		ELSIF (clk'EVENT AND clk='1') THEN
			-- TODELETE	
			if (enb = '0') then
				pr_state <= pr_state;
			else
				pr_state <= nx_state;
			end if;
		END IF;
	END PROCESS;
---------- Upper section: ------------------------
  PROCESS (op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn , Nflag , Zflag , Cflag , pr_state)
  BEGIN
	CASE pr_state IS
		WHEN state_rst =>
--		assert false 
--		report "[time =" & to_string(now) & "]" &"[in " & to_string(nx_state) & "]"
--		severity note;
			PCsel <= "00";
			PCin <= '1';
			Mem_wr <= '0';
			Mem_out <= '0';
			Mem_in <= '0';
			Cout <= '0';
			Cin <= '0';
			Ain <= '0';
			RFin <= '0';
			RFout <= '0';
			IRin <= '0';
			Imm1_in <= '0';
			Imm2_in <= '0';
        	OPC <= "1111"; -- default
        	RFaddr <= "00";
			--NflagSig <= '0';
			--ZflagSig <= '0';
			--CflagSig <= '0';
			done <= '0';
			nx_state <= state_fetch;
		WHEN state_fetch => 
--		assert false 
--		report "[time =" & to_string(now) & "]" &"[in " & to_string(nx_state) & "]"
--		severity note;
			PCin <= '0';
			IRin <= '1';
			PCsel <= "00";
			Mem_wr <= '0';
			Mem_out <= '0';
			Mem_in <= '0';
			Cout <= '0';
			Cin <= '0';
			Ain <= '0';
			RFin <= '0';
			RFout <= '0';
			Imm1_in <= '0';
			Imm2_in <= '0';
        		OPC <= "1111"; -- default
        	RFaddr <= "00";
			nx_state <= state_decode;
		WHEN state_decode =>
			IRin <= '0';
			if (op_add = '1' OR op_sub = '1' OR op_and = '1' OR op_or = '1' OR op_xor = '1') then
				nx_state <= state_Rtype0;
			elsif(op_jmp = '1' OR op_jc = '1' OR op_jnc = '1' OR op_jn = '1') then
				nx_state <= state_Jtype0;
			elsif(op_mov = '1' ) then 
				nx_state <= state_mov;
			elsif (op_ld = '1' OR op_st = '1') then
				nx_state <= state_Itype0;
			elsif(op_done = '1') then
				done <= '1';
				nx_state <= state_rst;
			end if;
			OPC <= "1111"; -- default
		WHEN state_Rtype0 =>
			IRin <= '0';
			PCin <= '1';
			PCsel <= "10";
			RFaddr <= "01";
			RFin <= '0';
			RFout <= '1';
			Ain <= '1';
			nx_state <= state_Rtype1;
        		OPC <= "1111"; -- default
		WHEN state_Rtype1 =>
			PCin <= '0';
			PCsel <= "00";
			RFaddr <= "00";
			RFin <= '0';
			RFout <= '1';
			Ain <= '0';
			if (op_add = '1') then
				OPC <= "0000";
				--CflagSig <= Cflag;
			elsif (op_sub = '1') then
				OPC <= "0001";
				--CflagSig <= Cflag;
			elsif (op_and = '1') then
				OPC <= "0010";
			elsif (op_or = '1') then
				OPC <= "0011";
			elsif (op_xor = '1') then
				OPC <= "0100";
			end if;
			Cin <= '1';
			--NflagSig <= Nflag;
			--ZflagSig <= Zflag;
			nx_state <= state_Rtype2;
		WHEN state_Rtype2 =>
			RFaddr <= "10";
			RFin <= '1';
			RFout <= '0'; 
			OPC <= "1111"; -- return to default
			Cin <= '0';
			Cout <= '1';
			nx_state <= state_fetch;
		WHEN state_Jtype0 =>
			IRin <= '0';
			PCin <= '1';
			if ((op_jmp = '1') OR ((op_jc = '1') AND (CflagSig = '1')) OR ((op_jnc = '1') AND (CflagSig = '0')) OR ((op_jn = '1') AND (NflagSig = '1'))) then
				PCsel <= "01";
			else 
				PCsel <= "10";
			end if;
			nx_state <= state_fetch;
        		OPC <= "1111"; -- default
		WHEN state_mov =>
			IRin <= '0';
			PCin <= '1';
			PCsel <= "10";
			RFaddr <= "10";
			Imm1_in <= '1';
			RFout <= '0';
			RFin <= '1';
			nx_state <= state_fetch;
			OPC <= "1111"; -- default
		WHEN state_Itype0 =>
--		assert false 
--		report "[time =" & to_string(now) & "]" &"[in " & to_string(nx_state) & "]"
--		severity note;
			IRin <= '0';
			PCin <= '1';
			PCsel <= "10";
			RFaddr <= "01";
			RFout <= '1';
			RFin <= '0';
			Ain <= '1';
			nx_state <= state_Itype1;
        		OPC <= "1111"; -- default
		WHEN state_Itype1 =>
--		assert false 
--		report "[time =" & to_string(now) & "]" &"[in " & to_string(nx_state) & "]"
--		severity note;
			PCin <= '0';
			PCsel <= "00";
			RFout <= '0';
			Ain <= '0';
			Imm2_in <= '1';
			OPC <= "1101"; -- add
			Cin <= '1';
			if (op_st = '1') then
				nx_state <= state_st0;
			else 
				nx_state <= state_ld0;
			end if;
		WHEN state_ld0 =>
--		assert false 
--		report "[time =" & to_string(now) & "]" &"[in " & to_string(nx_state) & "]"
--		severity note;
			Imm2_in <= '0';
			Cin <= '0';
			Cout <= '1';
			Mem_out <= '0';
			nx_state <= state_ld1;
	        	OPC <= "1111"; -- default
		WHEN state_ld1 =>
--		assert false 
--		report "[time =" & to_string(now) & "]" &"[in " & to_string(nx_state) & "]"
--		severity note;
			Cout <= '0';
			Mem_out <= '1';
			RFout <= '0';
			RFaddr <= "10";
			RFin <= '1';
			nx_state <= state_fetch;
	        	OPC <= "1111"; -- default
		WHEN state_st0 =>
			Imm2_in <= '0';
			Cin <= '0';
			Cout <= '1';
			Mem_in <= '1';
			nx_state <= state_st1;
	        	OPC <= "1111"; -- default
		WHEN state_st1 =>
			Cout <= '0';
			Mem_in <= '0';
			RFaddr <= "10";
			RFout <= '1';
			RFin <= '0';
			Mem_wr <= '1';
			nx_state <= state_fetch;
        		OPC <= "1111"; -- default
	END CASE;
  END PROCESS;
	NflagSig <= Nflag;
	ZflagSig <= Zflag;
	CflagSig <= Cflag;
END state_machine;

