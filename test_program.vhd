LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- VHDL project: Cryptographic coprocessor Design in VHDL
-- VHDL Testbench Code to verify the coprocessor
 
ENTITY test_program IS
END test_program;
 
ARCHITECTURE behavior OF test_program IS 
    -- Component Declaration for the coprocessor
    COMPONENT Co_Processor
    PORT(
         clock : IN  std_logic;
         reset : IN  std_logic;
         CTRL : IN  std_logic_vector(3 downto 0);
         Ra : IN  std_logic_vector(3 downto 0);
         Rb : IN  std_logic_vector(3 downto 0);
         Rd : IN  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
   --Inputs
   signal clock : std_logic := '0';
   signal reset : std_logic := '0';
   signal CTRL : std_logic_vector(3 downto 0) := (others => '0');
   signal Ra : std_logic_vector(3 downto 0) := (others => '0');
   signal Rb : std_logic_vector(3 downto 0) := (others => '0');
   signal Rd : std_logic_vector(3 downto 0) := (others => '0');
   -- Clock period definitions
   constant clock_period : time := 20 ns;
BEGIN
 -- fpga4student.com: FPGA projects, Verilog projects, VHDL projects
 -- VHDL project: Cryptographic coprocessor Design in VHDL
 -- Instantiate the coprocessor
   uut: Co_Processor PORT MAP (
          clock => clock,
          reset => reset,
          CTRL => CTRL,
          Ra => Ra,
          Rb => Rb,
          Rd => Rd
        );
   -- Clock process definitions
   clock_process :process
   begin
  clock <= '0';
  wait for clock_period/2;
  clock <= '1';
  wait for clock_period/2;
   end process;
   stim_proc: process
   begin  
      -- hold reset state for 100 ns.
  reset <= '1';
  Ra <= "0000";
  Rb <= "0000";
  Rd <= "0000";
  CTRL <= "0111";
      wait for 100 ns; 
  reset <= '0';--- ADD R5,R4, R12
  Ra <= "0101";
  Rb <= "0100";
  Rd <= "1100";
  CTRL <= "0000";
      wait for clock_period;
  Ra <= "0001"; --- XOR R1,R8,R7
  Rb <= "1000";
  Rd <= "0111";
  CTRL <= "0100";
      wait for clock_period;
  Ra <= "0001"; --- ROR4 R12,R0
  Rb <= "1100";
  Rd <= "0000";
  CTRL <= "1001";
      wait for clock_period;    
  Ra <= "0001"; --- SLL8 R9,R3
  Rb <= "1001";
  Rd <= "0011";
  CTRL <= "1010";
      wait for clock_period;
  Ra <= "0000"; --- ADD R0,R7,R10
  Rb <= "0111";
  Rd <= "1010";
  CTRL <= "0000";
      wait for clock_period;
  Ra <= "0111"; --- SUB R7,R3,R12
  Rb <= "0011";
  Rd <= "1100";
  CTRL <= "0001";
  --- NOP
 -- CTRL <= "0111";
      wait for clock_period;
  Ra <= "1100"; --- AND R12,R10,R9
  Rb <= "1010";
  Rd <= "1001";
  CTRL <= "0010";
  --- NOP
 -- CTRL <= "0111";
      wait for clock_period;
  Ra <= "1001"; --- LUT R9,R2
  Rb <= "1010";
  Rd <= "0010";
  CTRL <= "1011";  
      wait;
   end process;

END;