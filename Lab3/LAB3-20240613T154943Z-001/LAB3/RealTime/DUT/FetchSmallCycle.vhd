LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY FetchSmallCycle IS
  GENERIC (Dwidth: integer:=16;
           AMwidth: integer:=6;
           ARwidth: integer:=4;
           dept:   integer:=64);
  PORT (RFInData: IN STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        clk,rst: IN STD_LOGIC;

        TBwren: IN STD_LOGIC;
        TBdatain: IN STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        TBwriteAddr: IN STD_LOGIC_VECTOR (AMwidth-1 DOWNTO 0);

        RFin , IRin, PCin: IN STD_LOGIC;
        RFaddr, PCsel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);

        op_st,op_ld,op_mov,op_done,op_add,op_sub,op_jmp,op_jc,op_and,op_or,op_xor,op_jnc,op_jn: OUT std_logic;

        SignExt4, SignExt8: OUT STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        RFOutData: OUT STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0)

  );
END FetchSmallCycle;
--------------------------------------------------------
ARCHITECTURE FetchSmallCycle OF FetchSmallCycle IS

    component RF is
    generic( Dwidth: integer;
             Awidth: integer);
    port(	clk,rst,WregEn: in std_logic;	
            WregData:	in std_logic_vector(Dwidth-1 downto 0);
            WregAddr,RregAddr:	
                        in std_logic_vector(Awidth-1 downto 0);
            RregData: 	out std_logic_vector(Dwidth-1 downto 0)
    );
    end component; 
    
    component OPCDecoder is
    port(	opcode:	in std_logic_vector(3 downto 0);
                op_st,op_ld,op_mov,op_done,op_add,op_sub,op_jmp,op_jc,op_and,op_or,op_xor,op_jnc,op_jn: out std_logic
        );
    end component;   
    
    component ProgMem is
    generic( Dwidth: integer;
                Awidth: integer;
                dept:   integer);
    port(	clk,memEn: in std_logic;	
            WmemData:	in std_logic_vector(Dwidth-1 downto 0);
            WmemAddr,RmemAddr:	
                        in std_logic_vector(Awidth-1 downto 0);
            RmemData: 	out std_logic_vector(Dwidth-1 downto 0)
    );
    end component;

    component PCCount IS
    GENERIC (Dwidth: integer);
    PORT (clk: IN STD_LOGIC;
          PC: buffer STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
          PCin: IN STD_LOGIC;
          PCsel: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
          IRreg: IN STD_LOGIC_VECTOR (7 DOWNTO 0)
    );
    END component;

    signal RFAddrIn : std_logic_vector(ARwidth-1 downto 0);
    signal ProgMemRAddr : std_logic_vector(Dwidth-1 downto 0);
    signal ProgMemDataOut : std_logic_vector(Dwidth-1 downto 0);
    signal IROut : std_logic_vector(Dwidth-1 downto 0);


    
BEGIN
    RFInst : RF generic map (Dwidth,ARwidth) port map (clk , rst , RFin , RFInData , RFAddrIn, RFAddrIn, RFOutData);
    OPCDecInst : OPCDecoder port map (IROut(Dwidth-1 downto Dwidth-4) , op_st , op_ld , op_mov , op_done , op_add , op_sub , op_jmp , op_jc , op_and , op_or , op_xor , op_jnc , op_jn);
    ProgMemInst : ProgMem generic map (Dwidth,AMwidth,dept) port map (clk=>clk , memEn=>TBwren , WmemData=>TBdatain , WmemAddr=>TBwriteAddr , RmemAddr=>ProgMemRAddr(AMwidth-1 DOWNTO 0), RmemData=>ProgMemDataOut);
    PCCountInst : PCCount generic map (Dwidth) port map (clk , ProgMemRAddr , PCin , PCsel , IROut(7 downto 0));
    
    SignExt4(3 downto 0) <= IROut(3 downto 0);
    SignExt4(Dwidth-1 downto 4) <= (others => IROut(3));
    SignExt8(7 downto 0) <= IROut(7 downto 0);
    --    SignExt8(Dwidth-1 downto 8) <= (others => IROut(8));
    SignExt8(Dwidth-1 downto 8) <= (others => IROut(7));


    with RFaddr select
    RFAddrIn <= IROut(3 downto 0)    when "00",
                IROut(7 downto 4)    when "01",
                IROut(11 downto 8)   when "10",
                (others => '0')    when others;    

    PROCESS (clk)
    BEGIN
    if (clk'event and clk='1') then
          -- TODELETE
--          assert false 
--          report  "[time =" & to_string(now) & "]" &
--                  "[RFOutData is " & to_string(RFOutData) & "]" &
--                  "[RFaddr is " & to_string(RFaddr) & "]" &
--                  "[RFAddrIn is " & to_string(RFAddrIn) & "]" &
--                  "[PC value is " & to_string(ProgMemRAddr) & "]" &
--                  "[IR now is " & to_string(IROut) & "]" &
--                  "[IR is set to " & to_string(ProgMemDataOut) & "]" &
--                  "[If IRin : " & to_string(IRin) & "]" 
--          severity note;
      if (IRin='1') then
			  IROut <= ProgMemDataOut;
	    end if;
	end if;
    END PROCESS;
END FetchSmallCycle;
