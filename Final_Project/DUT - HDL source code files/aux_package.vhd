library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package aux_package is
---------------------------------------------------------	
	component HEXdecode IS
		PORT (Xin: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			  Xout: OUT STD_LOGIC_VECTOR (6 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component BidirPin is
		generic( width: integer);
		port(Dout: IN STD_LOGIC_VECTOR (width-1 downto 0);
			 en: IN	STD_LOGIC;
			 Din: OUT STD_LOGIC_VECTOR (width-1 downto 0);
			 IOpin:	INOUT STD_LOGIC_VECTOR (width-1 downto 0));
	end component;
-----------------------------------------------------------------
	component OutputPort IS
		PORT(reset, clock                   : IN        STD_LOGIC;  
			 CS, A0, MemWrite, MemRead      : IN        STD_LOGIC; 
			 Data                           : INOUT     STD_LOGIC_VECTOR (31 DOWNTO 0);
			 PortOut                        : OUT       STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component InputPort IS
		PORT(CS, MemRead	: IN 	STD_LOGIC; 
			 InPort			: IN 	STD_LOGIC_VECTOR (7 DOWNTO 0);
			 Data			: OUT 	STD_LOGIC_VECTOR (31 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component AddressDecoder IS
		PORT(A                          : IN STD_LOGIC_VECTOR (4 DOWNTO 0); 
			 CS                         : OUT STD_LOGIC_VECTOR (4 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component GPIOwrap IS
		PORT(reset, clock				: IN 	STD_LOGIC; 
			 MemWrite, MemRead			: IN 	STD_LOGIC;
			 Address					: IN STD_LOGIC_VECTOR (5 DOWNTO 0); 
			 Data						: INOUT STD_LOGIC_VECTOR (31 DOWNTO 0);
			 SW							: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
			 HEX0, HEX1, HEX2, HEX3, HEX4, HEX5: OUT STD_LOGIC_VECTOR (6 DOWNTO 0); 
			 LEDs						: OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component BTCNT IS
		PORT(rst, clk, EN: IN STD_LOGIC;
			 BTCCR0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			 currentTimer: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			 nextTimer: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component BTCNTwrap IS
		PORT(rst: IN STD_LOGIC;
			 MCLK: IN STD_LOGIC;
			 BTSSEL: IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			 BTHOLD: IN STD_LOGIC;
			 BTCCR0: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			 currentTimer: IN STD_LOGIC_VECTOR(31 DOWNTO 0);
			 nextTimer: OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component TimerOutputUnit IS
		PORT(BTCCR0, BTCCR1		: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			 BTOUTEN, BTOUTMD	: IN 	STD_LOGIC;
			 timer				: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			 PWMout				: OUT 	STD_LOGIC);
	end component;
-----------------------------------------------------------------
	component Timer IS
		PORT(rst, clk			: IN 	 STD_LOGIC;
			 MemWrite, MemRead	: IN 	 STD_LOGIC;
			 addr				: IN 	 STD_LOGIC_VECTOR(11 DOWNTO 0);
			 data				: INOUT  STD_LOGIC_VECTOR(31 DOWNTO 0);
			 set_BTIFG , PWMout	: OUT	 STD_LOGIC);
	end component;
-----------------------------------------------------------------
	component Divider IS
		PORT(rst, clk, EN										: IN 	STD_LOGIC;
			 Data												: IN 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			 setDividend, setDivisor							: IN	STD_LOGIC;
			 OutQuatient, OutResidue, OutDivisor, OutDividend	: OUT 	unsigned(31 DOWNTO 0);
			 DivIFG												: OUT 	STD_LOGIC);
	end component;
-----------------------------------------------------------------    
	component DividerWrap IS
		PORT(rst, clk			: IN 		STD_LOGIC;
			 MemWrite, MemRead	: IN 		STD_LOGIC;
			 addr				: IN 		STD_LOGIC_VECTOR(11 DOWNTO 0);
			 data				: INOUT 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			 DivIFG				: OUT 		STD_LOGIC);
	end component;
-----------------------------------------------------------------    
	component INTBitReg IS
		PORT(rst, clk, setIFG, clr_irq, eint	: IN 	 STD_LOGIC; 
			 irq								: BUFFER STD_LOGIC;
			 IFGx								: OUT 	 STD_LOGIC);
	end component;
-----------------------------------------------------------------    
	component INTReg IS
		PORT(rst, clk				: IN 	 STD_LOGIC; 
	 		 setIFG, clr_irq, eint	: IN 	 STD_LOGIC_VECTOR(7 downto 0); 
			 GIE					: IN 	 STD_LOGIC; 
			 IFG					: BUFFER STD_LOGIC_VECTOR(7 downto 0); 
			 INTR					: OUT 	 STD_LOGIC;
			 irq					: OUT 	 STD_LOGIC_VECTOR(7 downto 0));
	end component;
-----------------------------------------------------------------   
	component InterruptController IS
		PORT(rst, clk		: IN 	 STD_LOGIC;
			 setIFG, clr_irq: IN	 STD_LOGIC_VECTOR(7 downto 0);
			 data			: IN	 STD_LOGIC_VECTOR(7 downto 0);
			 writeIE		: IN 	 STD_LOGIC;  
			 GIE			: IN	 STD_LOGIC;  
			 INTR			: OUT	 STD_LOGIC;
			 irq			: OUT	 STD_LOGIC_VECTOR(7 downto 0);
			 OutType		: OUT	 STD_LOGIC_VECTOR(7 downto 0);
			 IFG, IE		: BUFFER STD_LOGIC_VECTOR(7 downto 0));
	end component;
-----------------------------------------------------------------   
	component InterruptControllerWrap IS
		PORT(rst, clk		: IN 	STD_LOGIC;
			 MemWrite, MemRead: IN 	STD_LOGIC;
			 irq			: IN 	STD_LOGIC_VECTOR(7 downto 0);
			 addr			: IN 	STD_LOGIC_VECTOR(11 downto 0);
			 GIE			: IN 	STD_LOGIC;  
			 INTA			: IN 	STD_LOGIC;
			 TXBUFRead		: IN	STD_LOGIC;
			 RXBUFRead		: IN 	STD_LOGIC;
			 INTR			: OUT 	STD_LOGIC;
			 data			: INOUT STD_LOGIC_VECTOR(31 downto 0));
	end component;
-----------------------------------------------------------------   
	component control IS
		PORT(Opcode 		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
			 FuncOpcode		: IN 	STD_LOGIC_VECTOR( 5 DOWNTO 0 );
			 RegDst 		: OUT 	STD_LOGIC;
			 ALUSrc 		: OUT 	STD_LOGIC;
			 MemtoReg 		: OUT 	STD_LOGIC;
			 RegWrite 		: OUT 	STD_LOGIC;
			 MemRead 		: OUT 	STD_LOGIC;
			 MemWrite 		: OUT 	STD_LOGIC;
			 BranchOut 		: OUT 	STD_LOGIC;
			 Jump			: OUT 	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			 JAL		 	: OUT 	STD_LOGIC;
			 ALUControl 	: OUT 	STD_LOGIC_VECTOR( 3 DOWNTO 0 ));
	end component;
-----------------------------------------------------------------   
	component Idecode IS
		PORT(read_data_1	: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 read_data_2	: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 Instruction 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 read_data 		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 ALU_result		: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 PCPlus4		: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 ); -- to mux for ra (jal)
			 RegWrite 		: IN 	STD_LOGIC;
			 JALctl			: IN	STD_LOGIC; -- for mux to ra 
			 MemtoReg 		: IN 	STD_LOGIC;
			 RegDst 		: IN 	STD_LOGIC;
			 Sign_extend 	: OUT 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 clock,reset	: IN 	STD_LOGIC;
			 GIE 			: OUT 	STD_LOGIC;
			 GIEOff      	: IN 	STD_LOGIC;
			 StorePC		: IN 	STD_LOGIC;
			 SavedPC		: IN	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
			 GIEOn      	: IN 	STD_LOGIC);
	end component;
-----------------------------------------------------------------
	component Shifter IS
		GENERIC (n : INTEGER;
			     k : INTEGER);
		PORT(Y				: IN 	STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 X				: IN 	STD_LOGIC_VECTOR (n-1 DOWNTO 0);
			 dir			: IN	STD_LOGIC;
			 cout			: OUT	STD_LOGIC;
			 res			: OUT	STD_LOGIC_VECTOR (n-1 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component  Execute IS
		PORT(Read_data_1 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 Read_data_2 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 Sign_extend 	: IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 ALUControl 	: IN 	STD_LOGIC_VECTOR( 3 DOWNTO 0 );
			 ALUSrc 		: IN 	STD_LOGIC;
			 bCond 			: OUT	STD_LOGIC;
			 ALU_Result 	: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 Add_Result 	: OUT	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
			 PC_plus_4 		: IN 	STD_LOGIC_VECTOR( 11 DOWNTO 0 ));
	end component;
-----------------------------------------------------------------
	component Ifetch IS
		GENERIC (ModelSim			: BOOLEAN;
				 adressSize			: INTEGER);
		PORT(InstructionOut 			: OUT	STD_LOGIC_VECTOR( 31 DOWNTO 0 );
        	 PC_plus_4_out 				: OUT	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
			 NxtPCOut					: OUT	STD_LOGIC_VECTOR( 11 DOWNTO 0 );
        	 Add_result 				: IN 	STD_LOGIC_VECTOR( 9 DOWNTO 0 );
        	 Branch 					: IN 	STD_LOGIC;
        	 bCond 						: IN 	STD_LOGIC;
			 Jump						: IN  	STD_LOGIC_VECTOR( 1 DOWNTO 0 );
			 read_data_1  				: IN    STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 InterruptInstructionValid  : IN 	STD_LOGIC;
             InterruptInstruction       : IN 	STD_LOGIC_VECTOR( 31 DOWNTO 0);
        	 clock, reset 				: IN 	STD_LOGIC);
	end component;
-----------------------------------------------------------------
	component dmemory IS
		GENERIC (ModelSim			: BOOLEAN;
				 adressSize			: INTEGER);
		PORT(read_data 			: OUT STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 address 			: IN  STD_LOGIC_VECTOR( 11 DOWNTO 0 );
			 write_data 		: IN  STD_LOGIC_VECTOR( 31 DOWNTO 0 );
			 MemRead, Memwrite 	: IN  STD_LOGIC;
			 clock,reset		: IN  STD_LOGIC);
	end component;
-----------------------------------------------------------------
	component MipsInterruptHandler IS
        PORT(clock,reset	            : IN  STD_LOGIC;
             instruction		        : IN  STD_LOGIC_VECTOR(31 downto 0);	-- from IFETCH
             NxtPCOut                   : IN  STD_LOGIC_VECTOR( 11 DOWNTO 0);
             INTR                       : IN  STD_LOGIC;
             INTA                       : OUT STD_LOGIC;
             InterruptInstructionValid  : OUT STD_LOGIC;
             GIEOff                     : OUT STD_LOGIC;
             GIEOn                      : OUT STD_LOGIC;
             StorePC                    : OUT STD_LOGIC;
             SavedPC                    : OUT STD_LOGIC_VECTOR( 11 DOWNTO 0);
             InterruptInstruction       : OUT STD_LOGIC_VECTOR( 31 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component MIPS IS
		GENERIC (ModelSim			: BOOLEAN := true;
				 adressSize			: INTEGER := 9);
		PORT(reset, clock				: IN 	STD_LOGIC; 
			 INTR						: IN 	STD_LOGIC;
			 INTA 						: OUT	STD_LOGIC;
			 GIEOut						: OUT 	STD_LOGIC;
			 MemReadOut, MemWriteOut	: OUT	STD_LOGIC;
			 Addr						: OUT 	STD_LOGIC_VECTOR(31 DOWNTO 0);
			 data						: INOUT STD_LOGIC_VECTOR(31 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component TOP IS
		PORT(InClock				     		 : IN  STD_LOGIC; 
			--  DIVClk                              : IN  STD_LOGIC;
			 RXUART			                  	 : IN  STD_LOGIC;
			 TXUART			                  	 : IN  STD_LOGIC;
			 SW                                  : IN  STD_LOGIC_VECTOR (7 DOWNTO 0);
			 KEY             					 : IN  STD_LOGIC_VECTOR (3 downto 0);
			 PWMout                              : OUT STD_LOGIC;
			 HEX0, HEX1, HEX2, HEX3, HEX4, HEX5  : OUT STD_LOGIC_VECTOR (6 DOWNTO 0); 
			 LEDs                                : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
	end component;
-----------------------------------------------------------------
	component PLL is
		port (
			refclk   : in  std_logic := '0'; --  refclk.clk
			rst      : in  std_logic := '0'; --   reset.reset
			outclk_0 : out std_logic;        -- outclk0.clk
			outclk_1 : out std_logic;        -- outclk1.clk
			locked   : out std_logic         --  locked.export
		);
	end component;
-----------------------------------------------------------------
end aux_package;