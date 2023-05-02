--VHDL code for 16-bit ALU 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
-- 16-bit ALU 
entity ALU is
	 port (
		ABUS: in std_logic_vector(15 downto 0); -- ABUS data input of the 16-bit ALU
		BBUS: in std_logic_vector(15 downto 0); -- BBUS data input of the 16-bit ALU
		ALUctrl: in std_logic_vector(3 downto 0); -- ALUctrl control input of the 16-bit ALU 
		ALUOUT: out std_logic_vector(15 downto 0)  -- 16-bit data output of the 16-bit ALU 
		);
end ALU;

architecture Behavioral of ALU is
	-- N-bit Adder in Verilog 
	component N_bit_adder is
		generic (
			 N: integer:=32
			);
		port( 
		  input1: in std_logic_vector(N-1 downto 0);
		  input2: in std_logic_vector(N-1 downto 0);
		  answer: out std_logic_vector(N-1 downto 0)
		 );
	end component N_bit_adder;
	
	signal BBUS_not: std_logic_vector(16-1 downto 0);
	signal tmp_out1: std_logic_vector(16-1 downto 0);
	signal tmp_out2: std_logic_vector(16-1 downto 0);
	signal tmp: std_logic_vector(16-1 downto 0);
	
	begin
		-- instantiate Verilog N-bit Adder in VHDL code 
		u1_N_bit_adder: N_bit_adder generic map ( N => 16) -- ABUS + BBUS
			  port map( input1 => ABUS, input2 => BBUS,answer => tmp_out1 ); 
			  
		u2_N_bit_adder: N_bit_adder generic map ( N => 16) -- ABUS + (~BBUS)
			  port map( input1 => ABUS, input2 => BBUS_not,answer => tmp_out2 ); 
			  
		u3_N_bit_adder: N_bit_adder generic map ( N => 16) -- ABUS + (~BBUS) + 1 = ABUS - BBUS
			  port map( input1 => tmp_out2, input2 => x"0001",answer => tmp ); 
		BBUS_not <= not BBUS;  
		
	-- Other instructions of the 16-bit ALU in VHDL 
	process(ALUctrl,ABUS,BBUS,tmp_out1,tmp)
		begin 
			case(ALUctrl) is
			 when "0000" =>  ALUOUT <= tmp_out1;  -- ADD
			 when "0001" =>  ALUOUT <= tmp ;-- SUB 
			 when "0010" =>  ALUOUT <= ABUS and BBUS; -- AND
			 when "0011" =>  ALUOUT <= ABUS or BBUS; -- OR
			 when "0100" =>  ALUOUT <= ABUS xor BBUS; -- XOR
			 when "0101" =>  ALUOUT <= not ABUS; -- NOT
			 when "0110" =>  ALUOUT <= ABUS; -- MOVE
			 when others => ALUOUT <= tmp_out1; 
			 end case;
	end process;

end Behavioral;