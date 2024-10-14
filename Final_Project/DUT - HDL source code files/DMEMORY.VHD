						--  Dmemory module (implements the data
						--  memory for the MIPS computer)
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;

ENTITY dmemory IS
	GENERIC (ModelSim			: BOOLEAN := true;
			 adressSize			: INTEGER := 9);
	PORT(	read_data 			: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	address 			: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
        	write_data 			: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
	   		MemRead, Memwrite 	: IN 	STD_LOGIC;
            clock,reset			: IN 	STD_LOGIC );
END dmemory;

ARCHITECTURE behavior OF dmemory IS
SIGNAL write_clock : STD_LOGIC;
SIGNAL real_address : STD_LOGIC_VECTOR(adressSize-1 DOWNTO 0);
BEGIN
	modelSimCase : if (ModelSim = TRUE) GENERATE
		real_address <= address(11 DOWNTO 2);
	END GENERATE;
	QuartusCase : if (ModelSim = FALSE) GENERATE
		real_address <= address;
	END GENERATE;
	data_memory : altsyncram
	GENERIC MAP  (operation_mode 		 => "SINGLE_PORT",
				  width_a 				 => 32,
				  widthad_a 			 => adressSize,
				  numwords_a 			 => 2**adressSize,
				  lpm_hint 				 => "ENABLE_RUNTIME_MOD = YES,INSTANCE_NAME = DTCM",
				  lpm_type 				 => "altsyncram",
				  outdata_reg_a 		 => "UNREGISTERED",
				  init_file 			 => "C:\Yoni\ModelSim\HW_ACCELERATORS_PROJ\Final_Project\TestMem\DriveTests\Interrupt based IO\test3\DTCM.hex",
				  intended_device_family => "Cyclone")
	PORT MAP (wren_a 	=> memwrite,
			  clock0 	=> write_clock,
			  address_a => real_address,
			  data_a 	=> write_data,
			  q_a 		=> read_data);
-- Load memory address register with write clock
		write_clock <= NOT clock;
END behavior;

