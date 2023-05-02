library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity N_bit_adder is
    generic(
        N : natural := 32 -- default value of 32 bits
    );
    port (
        input1, input2 : in std_logic_vector(N-1 downto 0);
        answer : out std_logic_vector(N-1 downto 0);
        carry_out : out std_logic
    );
end entity;

architecture Behavioral of N_bit_adder is
    -- component declarations
    component half_adder is
        port (
            x, y : in std_logic;
            s, c : out std_logic
        );
    end component;
    component full_adder is
        port (
            x, y, c_in : in std_logic;
            s, c_out : out std_logic
        );
    end component;

    -- signal declarations
    signal carry : std_logic_vector(N-1 downto 0);

begin
    -- generate adders
     gen_adders: for i in 0 to N-1 generate
    begin
      adderr: if i = 0 generate
        ha: half_adder port map (x => input1(0), y => input2(0), s => answer(0), c => carry(0));
      end generate adderr;
      
      adder: if i > 0 generate
        fa: full_adder port map (x => input1(i), y => input2(i), c_in => carry(i-1), s => answer(i), c_out => carry(i));
      end generate adder;
    end generate gen_adders;
    -- output carry
    carry_out <= carry(N-1);

end Behavioral;
