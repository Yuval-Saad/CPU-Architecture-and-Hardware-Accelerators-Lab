LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY Datapath IS
  GENERIC (Dwidth: integer:=16;
           AMwidth: integer:=6;
           ARwidth: integer:=4;
           dept:   integer:=64);
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

        op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn: OUT STD_LOGIC;
        Nflag , Zflag , Cflag : OUT STD_LOGIC

  );

END Datapath;
--------------------------------------------------------
ARCHITECTURE Datapath OF Datapath IS

    component FullALU IS
    GENERIC (Dwidth: integer);
    PORT (Ain,Cin: IN STD_LOGIC;
        opcode: IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        clk:  in std_logic;  
        ALUIn: IN STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        ALUOut: OUT STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        Cflag,Zflag,Nflag: OUT STD_LOGIC);
    END component;

    component FetchSmallCycle IS
    GENERIC (Dwidth: integer;
             AMwidth: integer;
             ARwidth: integer;
             dept:   integer);
    PORT    (RFInData: IN STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
            clk,rst: IN STD_LOGIC;

            TBwren: IN STD_LOGIC;
            TBdatain: IN STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
            TBwriteAddr: IN STD_LOGIC_VECTOR (AMwidth-1 DOWNTO 0);

            RFin , IRin, PCin: IN STD_LOGIC;
            RFaddr, PCsel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);

            op_st,op_ld,op_mov,op_done,op_add,op_sub,op_jmp,op_jc,op_and,op_or,op_xor,op_jnc,op_jn: OUT std_logic;

            SignExt4, SignExt8: OUT STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
            RFOutData: Out STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0)
            );
    END component;   

    component FulldataMem IS
    GENERIC (Dwidth: integer;
            Awidth: integer;
            dept:   integer);
    PORT    (Memin,Memwr,TBactive: IN STD_LOGIC;
             TBreadAddr, TBwriteAddr: In STD_LOGIC_VECTOR (Awidth-1 DOWNTO 0);
             TBMemwr: IN STD_LOGIC;
             clk: IN STD_LOGIC;
             TBdataIn: IN STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
             BUSIn :  IN  STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
             DataOut: OUT STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0)
            );
    END component;

    signal MainBus : STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);

    signal AluOut : STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal RFOutData : STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal SignExt4 : STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
    signal SignExt8 : STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0); 
    signal DataMemInOut : STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
   
    
BEGIN
    FullALUInst : FullALU generic map (Dwidth) port map (Ain , Cin , OPC , clk , MainBus, AluOut , Cflag, Zflag,Nflag);   
    FetchSmallCycleInst : FetchSmallCycle generic map (Dwidth,AMwidth,ARwidth,dept) port map (RFInData=>MainBus ,
                                                                                              clk=>clk , rst=>rst ,
                                                                                              TBwren=>WrenProgIn ,
                                                                                              TBdatain => MemProgIn,
                                                                                              TBwriteAddr => WAddrProgIn,
                                                                                              RFin => RFin, IRin => IRin, PCin => PCin ,
                                                                                              RFaddr => RFaddr , PCsel => PCsel ,
                                                                                              op_st=>op_st , op_ld=>op_ld , op_mov=>op_mov ,
                                                                                              op_done=>op_done , op_add=>op_add , op_sub=>op_sub ,
                                                                                              op_jmp=>op_jmp , op_jc=>op_jc , op_and=>op_and ,
                                                                                              op_or=>op_or , op_xor=>op_xor , op_jnc=>op_jnc , op_jn=>op_jn ,
                                                                                              SignExt4=>SignExt4 , SignExt8=>SignExt8 , 
                                                                                              RFOutData => RFOutData);
    
    FulldataMemInst : FulldataMem generic map (Dwidth,AMwidth,dept) port map (Memin =>Mem_in , Memwr => Mem_wr , TBactive => TBactive ,
                                                                              TBreadAddr => RAddrDataIn , TBwriteAddr => WAddrDataIn ,
                                                                              TBMemwr => WrenDataIn , clk => clk ,
                                                                              TBdataIn => MemDataIn ,
                                                                              BUSIn => MainBus ,
										                                      -- ******change
                                                                              --DataOut => MemDataOut
										                                    DataOut => DataMemInOut
										                                    );
    
    MemDataOut <= DataMemInOut;

   
    MainBus <= RFOutData       when RFout   = '1' else
               AluOut          when Cout    = '1' else
               SignExt4        when Imm2_in = '1' else 
               SignExt8        when Imm1_in = '1' else
               DataMemInOut    when Mem_out = '1' else
               (others => 'Z');

	process (MainBus)
	begin
	      -- TODELETE
--		  assert false 
--		  report "time = " & to_string(now) &
--                 " [RFout " & to_string(RFout) & "]" &
--                 " [Cout " & to_string(Cout) & "]" &
--                 " [Imm2_in " & to_string(Imm2_in) & "]" &
--                 " [Imm1_in " & to_string(Imm1_in) & "]" &
--                 " [Mem_out " & to_string(Mem_out) & "]" &
--				 " [MainBus " & to_string(MainBus) & "]"
--		  severity note;
	end process;

END Datapath;
