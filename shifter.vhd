-- VHDL code  for the shifter
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shifter is
  generic ( 
		N: integer:=16
  );
    Port ( 
		SHIFTINPUT : in  STD_LOGIC_VECTOR(N-1 downto 0);
		SHIFT_Ctrl : in  STD_LOGIC_VECTOR(3 downto 0); 
		SHIFTOUT: out  STD_LOGIC_VECTOR(N-1 downto 0)
  );
end shifter;

architecture Behavioral of shifter is
begin
	process(SHIFTINPUT,SHIFT_Ctrl)
		begin
			case(SHIFT_Ctrl) is
			when "1000" => SHIFTOUT <= SHIFTINPUT(7 downto 0)&SHIFTINPUT(15 downto 8);-- ROR8
			when "1001" => SHIFTOUT <= SHIFTINPUT(3 downto 0)&SHIFTINPUT(15 downto 4);-- ROR4
			when "1010" => SHIFTOUT <= SHIFTINPUT(7 downto 0) & "00000000"; -- SLL8
			when others => SHIFTOUT <= x"0000";
			end case;
end process;

end Behavioral;