library ieee;
use ieee.std_logic_1164.all;
--------------------------------------------------------------
entity OPCDecoder is
port(	opcode:	in std_logic_vector(3 downto 0);
		op_st,op_ld,op_mov,op_done,op_add,op_sub,op_jmp,op_jc,op_and,op_or,op_xor,op_jnc,op_jn: out std_logic
);
end OPCDecoder;
--------------------------------------------------------------
architecture OPCDecoder of OPCDecoder is
begin	

        op_add <= '1' when opcode = "0000" else '0';
        op_sub <= '1' when opcode = "0001" else '0';
        op_and <= '1' when opcode = "0010" else '0';
        op_or <= '1' when opcode = "0011" else '0';
        op_xor <= '1' when opcode = "0100" else '0';
        -- unused <= '1' when opcode = "0000" else '0';
        -- unused <= '1' when opcode = "0000" else '0';
        op_jmp <= '1' when opcode = "0111" else '0';
        op_jc <= '1' when opcode = "1000" else '0';
        op_jnc <= '1' when opcode = "1001" else '0';
        op_jn <= '1' when opcode = "1010" else '0';
        -- unused <= '1' when opcode = "0000" else '0';
        op_mov <= '1' when opcode = "1100" else '0';
        op_ld <= '1' when opcode = "1101" else '0';
        op_st <= '1' when opcode = "1110" else '0';
        op_done <= '1' when opcode = "1111" else '0';

end OPCDecoder;