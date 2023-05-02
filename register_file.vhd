-- the regester file
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

-- VHDL project: Cryptographic coprocessor Design in VHDL
-- VHDL code for 16x16 bit Register File( Read/Write Synchronous)

entity register_file is
	port ( clock: in std_logic; -- clock 
		reset: in std_logic; -- reset
		RdWEn: in std_logic; -- write enable signal
		RES : in std_logic_vector(15 downto 0); -- write value
		Ra,Rb,Rd: in std_logic_vector(3 downto 0); -- selected value of Registers Ra, Rb, Rd
		SRCa,SRCb: out std_logic_vector(15 downto 0) -- read value
	  );
end register_file;

architecture Behavioral of register_file is

type mem_type is array(0 to 15) of std_logic_vector(15 downto 0);
signal REG_FILE: mem_type :=( 
-- memory initialization
  0 => x"0001", 
  1 => x"c505",
  2 => x"3c07",
  3 => x"4d05",
  4 => x"1186",
  5 => x"f407",
  6 => x"1086",
  7 => x"4706",
  8 => x"6808",
  9 => x"baa0",
  10 => x"c902",
  11 => x"100b",
  12 => x"c000",
  13 => x"c902",
  14 => x"100b",
  15 => x"B000",
  others => (others => '0')
  );
  
begin
----------------------------------
-- Write Operation (Synchronous)--
----------------------------------
write_operation: process(clock) 
	begin
		if(rising_edge(clock)) then
		 if(RdWEn='1') then -- Write when RdWEn = '1'
		  REG_FILE(to_integer(unsigned(Rd))) <= RES;
		 end if;
		end if;
end process;

----------------------------------
-- Read Operation (Synchronous)--
----------------------------------
read_operation: process(clock)
	begin
		if(rising_edge(clock)) then
		 if(reset='1') then
		  SRCa <= x"0000";
		  SRCb <= x"0000";
		 else
		  SRCa <= REG_FILE(to_integer(unsigned(Ra)));
		  SRCb <= REG_FILE(to_integer(unsigned(Rb)));
		 end if;
		end if;
end process;
end Behavioral;