-- vhdl code for the nonlinear lookup table implementation
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity non_linear_lookup is
	port (  
		LUTIN: in std_logic_vector(7 downto 0);
		LUTOUT: out std_logic_vector(7 downto 0)
	 );
end non_linear_lookup;

architecture Behavioral of non_linear_lookup is

	signal MSN_in,LSN_in,MSN_out,LSN_out: std_logic_vector(3 downto 0);

	begin
		MSN_in <= LUTIN(7 downto 4);
		LSN_in <= LUTIN(3 downto 0);
		
		SBOX_1: process(MSN_in) 
			begin
				case(MSN_in) is
				 when "0000" => MSN_out <= "0001";
				 when "0001" => MSN_out <= "1011";
				 when "0010" => MSN_out <= "1001";
				 when "0011" => MSN_out <= "1100";
				 when "0100" => MSN_out <= "1101";
				 when "0101" => MSN_out <= "0110";
				 when "0110" => MSN_out <= "1111";
				 when "0111" => MSN_out <= "0011";
				 when "1000" => MSN_out <= "1110";
				 when "1001" => MSN_out <= "1000";
				 when "1010" => MSN_out <= "0111";
				 when "1011" => MSN_out <= "0100";
				 when "1100" => MSN_out <= "1010";
				 when "1101" => MSN_out <= "0010";
				 when "1110" => MSN_out <= "0101";
				 when "1111" => MSN_out <= "0000";
				 when others => MSN_out <= "0000";
				end case;
		end process;
		
		SBOX_2: process(LSN_in) 
			begin
			case(LSN_in) is
			 when "0000" => LSN_out <= "1111";
			 when "0001" => LSN_out <= "0000";
			 when "0010" => LSN_out <= "1101";
			 when "0011" => LSN_out <= "0111";
			 when "0100" => LSN_out <= "1011";
			 when "0101" => LSN_out <= "1110";
			 when "0110" => LSN_out <= "0101";
			 when "0111" => LSN_out <= "1010";
			 when "1000" => LSN_out <= "1001";
			 when "1001" => LSN_out <= "0010";
			 when "1010" => LSN_out <= "1100";
			 when "1011" => LSN_out <= "0001";
			 when "1100" => LSN_out <= "0011";
			 when "1101" => LSN_out <= "0100";
			 when "1110" => LSN_out <= "1000";
			 when "1111" => LSN_out <= "0110";
			 when others => LSN_out <= "0000";
			end case;
		end process;
		
		LUTOUT <= MSN_out & LSN_out;
end Behavioral;