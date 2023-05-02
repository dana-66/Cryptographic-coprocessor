library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder is
    port (
        x, y, c_in : in std_logic;
        s, c_out : out std_logic
    );
end entity;

architecture Behavioral of full_adder is
begin
    s <= (x xor y) xor c_in;
    c_out <= (y and c_in) or (x and y) or (x and c_in);
end Behavioral;
