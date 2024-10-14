ENTITY MIPS_tb IS
END MIPS_tb ;

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
use work.aux_package.all;

ARCHITECTURE struct OF MIPS_tb IS
        SIGNAL reset, clock             : STD_LOGIC := '0'; 
        SIGNAL INTR                     : STD_LOGIC := '0';
        SIGNAL INTA 			        : STD_LOGIC := '0';
        SIGNAL MemReadOut, MemWriteOut	: STD_LOGIC := '0';
        SIGNAL Addr						: STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
        SIGNAL data						: STD_LOGIC_VECTOR(31 DOWNTO 0) := (others => '0');
                -- ModuleWare signal declarations(v1.9) for instance 'U_0' of 'clk'
        SIGNAL mw_U_0clk : std_logic;
        SIGNAL mw_U_0disable_clk : boolean := FALSE;

        -- ModuleWare signal declarations(v1.9) for instance 'U_1' of 'pulse'
        SIGNAL mw_U_1pulse : std_logic :='0';
BEGIN

    u_0clk_proc: PROCESS
    BEGIN
    WHILE NOT mw_U_0disable_clk LOOP
        mw_U_0clk <= '0', '1' AFTER 50 ns;
        WAIT FOR 100 ns;
    END LOOP;
    WAIT;
    END PROCESS u_0clk_proc;
    mw_U_0disable_clk <= TRUE AFTER 3000 ns;
    clock <= mw_U_0clk;

-- ModuleWare code(v1.9) for instance 'U_1' of 'pulse'
    reset <= mw_U_1pulse;
    u_1pulse_proc: PROCESS
    BEGIN
    mw_U_1pulse <= 
        '0',
        '1' AFTER 20 ns,
        '0' AFTER 120 ns;
    WAIT;
    END PROCESS u_1pulse_proc;

    U_0 : MIPS
      GENERIC MAP (ModelSim => TRUE,
                   adressSize => 9)
      PORT MAP (
         reset           => reset,
         clock           => clock,
         INTR            => INTR,
         INTA            => INTA,
         MemReadOut      => MemReadOut,
         MemWriteOut     => MemWriteOut,
         Addr            => Addr,
         data            => data);

END struct;
