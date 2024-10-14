LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY Top IS
    GENERIC (Dwidth: integer:=16;
             AMwidth: integer:=6;
             ARwidth: integer:=4;
             dept:   integer:=64);
	PORT ( 	clk, rst, enb: IN STD_LOGIC;
			done: OUT STD_LOGIC;
            
            TBactive : IN STD_LOGIC;
            WrenProg , WrenData : IN STD_LOGIC;
            WAddrProg , WAddrData , RAddrData : IN STD_LOGIC_Vector(AMwidth-1 DOWNTO 0);
            MemDataIn , MemProgIn : IN STD_LOGIC_Vector(Dwidth-1 DOWNTO 0);

            MemDataOut : OUT STD_LOGIC_Vector(Dwidth-1 DOWNTO 0)
			);
END Top;

ARCHITECTURE Top OF Top IS

    COMPONENT ControlUnit IS
        PORT ( 	clk, rst, enb: IN STD_LOGIC;
                done: OUT STD_LOGIC;

                op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn: IN STD_LOGIC;
                Nflag , Zflag , Cflag : IN STD_LOGIC;

                Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in : OUT STD_LOGIC;
                OPC : OUT STD_LOGIC_Vector(3 downto 0);
                RFaddr,PCsel : OUT STD_LOGIC_Vector(1 downto 0)
                );
    END COMPONENT;

    COMPONENT Datapath IS
        GENERIC (Dwidth: integer;
                AMwidth: integer;
                ARwidth: integer;
                dept:   integer);
        PORT (  Mem_wr, Mem_out,Mem_in, Cout,Cin,Ain,RFin,RFout,IRin,PCin,Imm1_in,Imm2_in : IN STD_LOGIC;
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
        
                op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn: OUT STD_LOGIC;
                Nflag , Zflag , Cflag : OUT STD_LOGIC
        );
    END COMPONENT;
    SIGNAL op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn , Nflag , Zflag , Cflag: STD_LOGIC;
    SIGNAL Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in : STD_LOGIC;
    SIGNAL OPC : STD_LOGIC_Vector(3 downto 0);
    SIGNAL RFaddr,PCsel : STD_LOGIC_Vector(1 downto 0);

BEGIN
    ControlUnitInst : ControlUnit  port map (clk , rst , enb ,
                                             done ,op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn ,
                                             Nflag , Zflag , Cflag , 
                                             Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in ,
                                             OPC , RFaddr , PCsel);
    
    DatapathInst : Datapath generic map (Dwidth , AMwidth , ARwidth , dept) 
                            port map (Mem_wr , Mem_out , Mem_in , Cout , Cin , Ain , RFin , RFout , IRin , PCin , Imm1_in , Imm2_in ,
                                      OPC , RFaddr , PCsel ,
                                      clk , rst ,
                                      MemProgIn , WrenProg , WAddrProg ,
                                      MemDataIn , WrenData , TBactive , WAddrData ,
                                      RAddrData , MemDataOut ,
                                      op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn ,
                                      Nflag , Zflag , Cflag);    
END Top;