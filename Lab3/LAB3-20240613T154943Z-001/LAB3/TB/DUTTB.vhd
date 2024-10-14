library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use STD.textio.all;
use ieee.std_logic_textio.all;
 
entity duttb is
    constant Dwidth : integer := 16;
    constant AMwidth : integer := 6;
    constant ARwidth : integer := 4;
    constant dept : integer := 64;
end duttb;
 
 
architecture duttb of duttb is

    component Top IS
    GENERIC (Dwidth: integer;
             AMwidth: integer;
             ARwidth: integer;
             dept:   integer);
	PORT ( 	clk, rst, enb: IN STD_LOGIC;
			done: OUT STD_LOGIC;
            
            TBactive : IN STD_LOGIC;
            WrenProg , WrenData : IN STD_LOGIC;
            WAddrProg , WAddrData , RAddrData : IN STD_LOGIC_Vector(AMwidth-1 DOWNTO 0);
            MemDataIn , MemProgIn : IN STD_LOGIC_Vector(Dwidth-1 DOWNTO 0);

            MemDataOut : OUT STD_LOGIC_Vector(Dwidth-1 DOWNTO 0)
			);
    END component;


    SIGNAL clk, rst, enb: STD_LOGIC := '0';
    SIGNAL done: STD_LOGIC := '0';
    SIGNAL TBactive : STD_LOGIC := '0';
    SIGNAL WrenProg , WrenData : STD_LOGIC := '0';
    SIGNAL WAddrProg , WAddrData , RAddrData : STD_LOGIC_Vector(AMwidth-1 DOWNTO 0) := (others => '0');
    SIGNAL MemDataIn , MemProgIn : STD_LOGIC_Vector(Dwidth-1 DOWNTO 0) := (others => '0');
    SIGNAL MemDataOut : STD_LOGIC_Vector(Dwidth-1 DOWNTO 0) := (others => '0');

    
    file ProgMemToLoad , DataMemToLoad , DataMemRead : text;

    SIGNAL writeProgMem_phase_start , writeDataMem_phase_start ,readDataMem_phase_start : boolean := false;
    SIGNAL writeProgMem_phase_finish , writeDataMem_phase_finish ,readDataMem_phase_finish : boolean := false;

begin

    
	top_unit : top generic map (Dwidth,AMwidth,ARwidth,dept)
               port map(clk , rst ,enb,
                        done ,
                        TBactive ,
                        WrenProg , WrenData ,
                        WAddrProg , WAddrData , RAddrData ,
                        MemDataIn , MemProgIn ,
                        MemDataOut);


	control_tb : process 
	begin
        wait until falling_edge(clk);
		rst <= '1';
		wait until falling_edge(clk);
		rst <= '0';

		wait until falling_edge(clk);
		TBactive <= '1';
		writeDataMem_phase_start <= true;
		wait until (writeDataMem_phase_finish'event and writeDataMem_phase_finish=true);
		TBactive <= '0';

		wait until falling_edge(clk);
		writeProgMem_phase_start <= true;
		wait until (writeProgMem_phase_finish'event and writeProgMem_phase_finish=true);

		wait until falling_edge(clk);
		rst <= '1';
		enb <= '1';
        wait until falling_edge(clk);
		rst <= '0';

		-- wait for done
		wait until (done'event and done='1');
		enb <= '0';
		wait until falling_edge(clk);

		-- read from data mem
		wait until falling_edge(clk);
		TBactive <= '1';
		readDataMem_phase_start <= true;
		wait until (readDataMem_phase_finish'event and readDataMem_phase_finish=true); 
	
		wait;
	end process;

        gen_clk : process	
        begin
		  clk <= '0';
		  wait for 50 ns;
		  clk <= not clk;
		  wait for 50 ns;
        end process;

	write_instructions : process
		variable line_entry : std_logic_vector(Dwidth-1 downto 0);
		variable good : boolean;
		variable L : line;
	begin
		file_open(ProgMemToLoad, "C:\Yoni\ModelSim\HW_ACCELERATORS_PROJ\Lab3\LAB3-20240613T154943Z-001\LAB3\InOutFiles\ITCMinit.txt", read_mode);
		wait until (writeProgMem_phase_start'event and writeProgMem_phase_start=true);
		wait until falling_edge(clk);

		while not endfile (ProgMemToLoad) loop
			readline(ProgMemToLoad, L);
			hread(L,line_entry,good);
			next when not good; 
			MemProgIn <= line_entry;
			WrenProg <= '1';
			wait until rising_edge(clk);
			wait until falling_edge(clk);
			WAddrProg <= WAddrProg + 1;
		end loop;
		WrenProg <= '0';
		writeProgMem_phase_finish <= true;
		file_close(ProgMemToLoad);
		wait;
	end process;


	write_data : process
		variable data_addr : std_logic_vector(AMwidth-1 downto 0) := (others => '0');
		variable line_entry : std_logic_vector(Dwidth-1 downto 0);
		variable good : boolean;
		variable L : line;
	begin
		file_open(DataMemToLoad, "C:\Yoni\ModelSim\HW_ACCELERATORS_PROJ\Lab3\LAB3-20240613T154943Z-001\LAB3\InOutFiles\DTCMinit.txt", read_mode);
		wait until (writeDataMem_phase_start'event and writeDataMem_phase_start=true); 
		wait until falling_edge(clk);

		while not endfile (DataMemToLoad) loop
			readline(DataMemToLoad, L);
			hread(L,line_entry,good);
			next when not good; 
			WAddrData <= data_addr;
			MemDataIn <= line_entry;
			WrenData <= '1';
			wait until rising_edge(clk);
			wait until falling_edge(clk);
			data_addr := data_addr + 1;
		end loop;
		WrenData <= '0';
		writeDataMem_phase_finish <= true;
		file_close(DataMemToLoad);
		wait;
	end process;


	read_data_from_memory : process
		variable data : std_logic_vector(Dwidth-1 downto 0) := (others => '0');
		variable address_data : std_logic_vector(AMwidth-1 downto 0) := (others => '0');
		variable L : line;
	begin
		file_open(DataMemRead, "C:\Yoni\ModelSim\HW_ACCELERATORS_PROJ\Lab3\LAB3-20240613T154943Z-001\LAB3\InOutFiles\DTCMcontent.txt", write_mode);
		wait until (readDataMem_phase_start'event and readDataMem_phase_start=true); 
		wait until falling_edge(clk);
		while address_data < 63 loop
			RAddrData <= address_data;
			wait until rising_edge(clk);
			wait until falling_edge(clk);
			address_data := address_data + 1;
			data := MemDataOut;
			hwrite(L, data, right, Dwidth/4);
			writeline(DataMemRead, L);
		end loop;
		readDataMem_phase_finish <= true;
		file_close(DataMemRead);
		wait;
	end process;
end duttb;
