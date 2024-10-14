LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------------------------
ENTITY FulldataMem IS
  GENERIC (Dwidth: integer:=16;
           Awidth: integer:=6;
           dept:   integer:=64);
  PORT (Memin,Memwr,TBactive: IN STD_LOGIC;
        TBreadAddr, TBwriteAddr: In STD_LOGIC_VECTOR (Awidth-1 DOWNTO 0);
        TBMemwr: IN STD_LOGIC;
        clk: IN STD_LOGIC;
        TBdataIn: IN STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        BUSIn :  IN  STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0);
        DataOut: OUT STD_LOGIC_VECTOR (Dwidth-1 DOWNTO 0)
  );
END FulldataMem;
--------------------------------------------------------
ARCHITECTURE FulldataMem OF FulldataMem IS
    COMPONENT dataMem is
        generic(Dwidth: integer;
                Awidth: integer;
                dept:   integer);
        port(	clk,memEn: in std_logic;	
                WmemData:	in std_logic_vector(Dwidth-1 downto 0);
                WmemAddr,RmemAddr:	
                            in std_logic_vector(Awidth-1 downto 0);
                RmemData: 	out std_logic_vector(Dwidth-1 downto 0)
        );
    end COMPONENT; 
    signal writeAddrBus: std_logic_vector(Awidth-1 downto 0);
    signal readAddr: std_logic_vector(Awidth-1 downto 0);
    signal writeAddr: std_logic_vector(Awidth-1 downto 0);
    signal dataIn: std_logic_vector(Dwidth-1 downto 0);
    signal wren: std_logic;
BEGIN
    readAddr <= TBreadAddr when TBactive = '1' else BUSIn(Awidth-1 downto 0);
    writeAddr <= TBwriteAddr when TBactive = '1' else writeAddrBus;
    dataIn <= TBdataIn when TBactive = '1' else BUSIn;
    wren <= TBMemwr when TBactive = '1' else Memwr;
    dataMemInst : dataMem generic map (Dwidth,Awidth,dept) port map (clk , wren , dataIn , writeAddr , readAddr, DataOut);
    PROCESS (clk)
    BEGIN
    if (clk'event and clk='1') then
      -- TODELETE
--      assert false 
--      report  "In DATA mem:   " &
--              "Reading from data in ADDRESS" & to_string(readAddr) & "\n" &
--              "The data that came: " & to_string(DataOut) & "]"
--      severity note;
	    if (Memin='1') then
		  	writeAddrBus <= BUSIn(Awidth-1 downto 0);   
	    end if;
	  end if;
    END PROCESS;
END FulldataMem;

