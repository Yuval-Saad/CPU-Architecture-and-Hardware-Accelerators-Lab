library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
---------------------------------------------------------
entity DatapathTB is
    constant Dwidth : integer := 16;
    constant AMwidth : integer := 6;
    constant ARwidth : integer := 4;
    constant dept : integer := 64;
end DatapathTB;
---------------------------------------------------------
architecture DatapathTB of DatapathTB is

    COMPONENT Datapath IS
    GENERIC (Dwidth: integer;
             AMwidth: integer;
             ARwidth: integer;
             dept:   integer);
    PORT (Mem_wr, Mem_out,Mem_in, Cout,Cin,Ain,RFin,RFout,IRin,PCin,Imm1_in,Imm2_in : IN STD_LOGIC;
          OPC : IN STD_LOGIC_Vector(3 downto 0);
          RFaddr,PCsel : IN STD_LOGIC_Vector(1 downto 0);
  
          clk,rst : IN STD_LOGIC;
          MemProgIn : IN STD_LOGIC_Vector(Dwidth-1 DOWNTO 0);
          WrenProgIn : IN STD_LOGIC;
          WAddrProgIn : IN STD_LOGIC_Vector(AMwidth-1 DOWNTO 0);
          MemDataIn : IN STD_LOGIC_Vector(Dwidth-1 DOWNTO 0);
          WrenDataIn,TBactive : IN STD_LOGIC;
          WAddrDataIn,RAddrDataIn : IN STD_LOGIC_Vector(AMwidth-1 DOWNTO 0);
          
          MemDataOut : OUT STD_LOGIC_Vector(Dwidth-1 DOWNTO 0);
  
          op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc: OUT STD_LOGIC;
          Nflag , Zflag , Cflag : OUT STD_LOGIC
    );
  
  END COMPONENT;

    SIGNAL Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in : STD_LOGIC;
    SIGNAL OPC : STD_LOGIC_Vector(3 downto 0);
    SIGNAL RFaddr,PCsel : STD_LOGIC_Vector(1 downto 0);

    SIGNAL clk, rst: STD_LOGIC;
    SIGNAL MemProgIn : STD_LOGIC_Vector(Dwidth-1 DOWNTO 0);
    SIGNAL WrenProgIn : STD_LOGIC;
    SIGNAL WAddrProgIn : STD_LOGIC_Vector(AMwidth-1 DOWNTO 0);
    SIGNAL MemDataIn : STD_LOGIC_Vector(Dwidth-1 DOWNTO 0);
    SIGNAL WrenDataIn,TBactive : STD_LOGIC;
    SIGNAL WAddrDataIn,RAddrDataIn : STD_LOGIC_Vector(AMwidth-1 DOWNTO 0);
    SIGNAL MemDataOut : STD_LOGIC_Vector(Dwidth-1 DOWNTO 0);

    SIGNAL op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc: STD_LOGIC;
    SIGNAL Nflag , Zflag , Cflag : STD_LOGIC;

begin

	DatapathTest : Datapath generic map (Dwidth,AMwidth,ARwidth,dept) 
                                  port map    (Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in ,
                                               OPC , RFaddr , PCsel ,
                                               clk , rst ,
                                               MemProgIn , WrenProgIn , WAddrProgIn , 
                                               MemDataIn , WrenDataIn , TBactive , WAddrDataIn , RAddrDataIn , MemDataOut ,
                                               op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc ,
                                               Nflag , Zflag , Cflag);
    
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

        simulation : process (clk, rst)
        variable WriteDataState : integer := 0;
        variable progAddr : STD_LOGIC_Vector(AMwidth-1 DOWNTO 0) := (others => '0');
        variable progOPCODE : STD_LOGIC_Vector(3 DOWNTO 0) := (others => '0');
    begin
        if (rst = '1') then
            Mem_wr <= '0';
            Mem_out <= '0';
            Mem_in <= '0';
            Cout <= '0';
            Cin <= '0';
            Ain <= '0';
            RFin <= '0';
            RFout <= '0';
            IRin <= '0';
            PCin <= '1';
            Imm1_in <= '0';
            Imm2_in <= '0';
            OPC <= "0000";
            RFaddr <= "00";
            PCsel <= "00";
            MemProgIn <= (others => '0');
            WrenProgIn <= '0';
            WAddrProgIn <= (others => '0');
            MemDataIn <= (others => '0');
            WrenDataIn <= '0';
            TBactive <= '0';
            WAddrDataIn <= (others => '0');
            RAddrDataIn <= (others => '0');
        elsif (clk'event and clk = '1') then
            if (WriteDataState < 15) then --write to program phase
                PCin <= '0';
                WrenProgIn <= '1';
                WAddrProgIn <= progAddr;
                progAddr := progAddr + 1;
                MemProgIn(Dwidth-1 DOWNTO Dwidth-4) <= progOPCODE;
                progOPCODE := progOPCODE + 1;
                MemProgIn(Dwidth-5 DOWNTO 0) <= (others => '0');
                WriteDataState := WriteDataState + 1;
            elsif (WriteDataState = 15) then --see decoded opcodes phase
                WriteDataState := WriteDataState + 1;
                WrenProgIn <= '0';
                IRin <= '1';
                PCin <= '1';
                PCsel <= "10";
            else
                null;
            end if;
        end if;
    end process;
  
end architecture DatapathTB;
