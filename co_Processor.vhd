--co_Processor
-- crypto-coprocessor the complete code
-- VHDL project: Cryptographic coprocessor Design in VHDL
-- Complete Processor in VHDL

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity co_Processor is
	port ( 
		clock, reset: in std_logic; -- clock and reset
		CTRL: in std_logic_vector(3 downto 0); -- Control Opcode
		Ra, Rb, Rd: in std_logic_vector(3 downto 0) -- Ra, Rb: Source Registers, Rd: Destination Register
		
	  );
end co_Processor;

architecture Behavioral of co_Processor is
	-- Register file in VHDL 
	component register_file is
		port ( clock: in std_logic;
			reset: in std_logic;
			RdWEn: in std_logic; 
			RES : in std_logic_vector(15 downto 0); -- write value
			Ra,Rb,Rd: in std_logic_vector(3 downto 0); -- selected value of Registers Ra, Rb, Rd
			SRCa,SRCb: out std_logic_vector(15 downto 0) -- read value
	  );
	end component register_file;
	-- Combinational logic in VHDL
	component comb_logic is
		port ( A_BUS: in std_logic_vector(15 downto 0);
			B_BUS: in std_logic_vector(15 downto 0);
			CTRL: in std_logic_vector(3 downto 0);
			RESULT: out std_logic_vector(15 downto 0)
		  );
	end component comb_logic;
	
	signal Write_Enable: std_logic;
	signal read_data1,read_data2,write_data:std_logic_vector(15 downto 0);
	signal ctrl_tmp: std_logic_vector(3 downto 0);
	signal Rd_tmp: std_logic_vector(3 downto 0);
	
	begin
	-- 16x 16-bit Register file in VHDL 
	Register_file_16x16: register_file port map( clock=> clock, reset => reset  ,
					RdWEn => Write_Enable, RES => write_data, Ra => Ra, Rb => Rb, Rd => Rd_tmp,
					SRCa => read_data1, SRCb => read_data2);
	-- Combinational logic in VHDL
	Combinational_logic: comb_logic port map( A_BUS=>read_data1, B_BUS => read_data2, CTRL => ctrl_tmp,
					 RESULT => write_data);
					 
	--- input register VHDL
	process(clock,reset) 
		begin
			if(rising_edge(clock)) then
			 if(reset = '1') then
			  ctrl_tmp <= x"0";
			  Rd_tmp <= x"0";
			 else
			  Rd_tmp <= Rd;
			  ctrl_tmp <= CTRL;
			  if(ctrl_tmp = "0111") then -- NOP Instruction -- DO not allow to write to the Register file
				Write_Enable <= '0';
			  else
				Write_Enable <= '1';   
			  end if;
			 end if;
			end if;

	end process;
                        
end Behavioral;