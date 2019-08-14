LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY test_bench IS
END test_bench;
 
ARCHITECTURE behavior OF test_bench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT memory_block
    PORT(
         rst : IN  std_logic;
         clk : IN  std_logic;
         interface_one_addr : IN  std_logic_vector(7 downto 0);
         interface_one_data_in : IN  std_logic_vector(7 downto 0);
         interface_one_data_out : OUT  std_logic_vector(7 downto 0);
         interface_one_control_in : IN  std_logic_vector(3 downto 0);
         interface_one_control_out : OUT  std_logic_vector(2 downto 0);
         interface_two_addr : IN  std_logic_vector(7 downto 0);
         interface_two_data_in : IN  std_logic_vector(7 downto 0);
         interface_two_data_out : OUT  std_logic_vector(7 downto 0);
         interface_two_control_in : IN  std_logic_vector(3 downto 0);
         interface_two_control_out : OUT  std_logic_vector(2 downto 0);
         interface_three_addr : IN  std_logic_vector(7 downto 0);
         interface_three_data_in : IN  std_logic_vector(7 downto 0);
         interface_three_data_out : OUT  std_logic_vector(7 downto 0);
         interface_three_control_in : IN  std_logic_vector(3 downto 0);
         interface_three_control_out : OUT  std_logic_vector(2 downto 0);
         interface_four_addr : IN  std_logic_vector(7 downto 0);
         interface_four_data_in : IN  std_logic_vector(7 downto 0);
         interface_four_data_out : OUT  std_logic_vector(7 downto 0);
         interface_four_control_in : IN  std_logic_vector(3 downto 0);
         interface_four_control_out : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal rst : std_logic := '0';
   signal clk : std_logic := '0';
   signal interface_one_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal interface_one_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal interface_one_control_in : std_logic_vector(3 downto 0) := (others => '0');
   signal interface_two_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal interface_two_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal interface_two_control_in : std_logic_vector(3 downto 0) := (others => '0');
   signal interface_three_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal interface_three_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal interface_three_control_in : std_logic_vector(3 downto 0) := (others => '0');
   signal interface_four_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal interface_four_data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal interface_four_control_in : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal interface_one_data_out : std_logic_vector(7 downto 0);
   signal interface_one_control_out : std_logic_vector(2 downto 0);
   signal interface_two_data_out : std_logic_vector(7 downto 0);
   signal interface_two_control_out : std_logic_vector(2 downto 0);
   signal interface_three_data_out : std_logic_vector(7 downto 0);
   signal interface_three_control_out : std_logic_vector(2 downto 0);
   signal interface_four_data_out : std_logic_vector(7 downto 0);
   signal interface_four_control_out : std_logic_vector(2 downto 0);
	
	signal interface_1_control_in : std_logic_vector(3 downto 0);
	signal interface_2_control_in : std_logic_vector(3 downto 0);
	signal interface_3_control_in : std_logic_vector(3 downto 0);
	signal interface_4_control_in : std_logic_vector(3 downto 0);
	
	signal interface_1_addr : std_logic_vector(7 downto 0);
	signal interface_2_addr : std_logic_vector(7 downto 0);
	signal interface_3_addr : std_logic_vector(7 downto 0);
	signal interface_4_addr : std_logic_vector(7 downto 0);
	
	signal interface_1_data_in : std_logic_vector(7 downto 0);
	signal interface_2_data_in : std_logic_vector(7 downto 0);
	signal interface_3_data_in : std_logic_vector(7 downto 0);
	signal interface_4_data_in : std_logic_vector(7 downto 0);
	
	signal control_in_read : std_logic_vector(3 downto 0) := "0010";
	signal control_in_write : std_logic_vector(3 downto 0) := "1001";
	signal none_data_in : std_logic_vector(7 downto 0) := "ZZZZZZZZ";

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: memory_block PORT MAP (
          rst => rst,
          clk => clk,
          interface_one_addr => interface_one_addr,
          interface_one_data_in => interface_one_data_in,
          interface_one_data_out => interface_one_data_out,
          interface_one_control_in => interface_one_control_in,
          interface_one_control_out => interface_one_control_out,
          interface_two_addr => interface_two_addr,
          interface_two_data_in => interface_two_data_in,
          interface_two_data_out => interface_two_data_out,
          interface_two_control_in => interface_two_control_in,
          interface_two_control_out => interface_two_control_out,
          interface_three_addr => interface_three_addr,
          interface_three_data_in => interface_three_data_in,
          interface_three_data_out => interface_three_data_out,
          interface_three_control_in => interface_three_control_in,
          interface_three_control_out => interface_three_control_out,
          interface_four_addr => interface_four_addr,
          interface_four_data_in => interface_four_data_in,
          interface_four_data_out => interface_four_data_out,
          interface_four_control_in => interface_four_control_in,
          interface_four_control_out => interface_four_control_out
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	-- Reset
	rst <= '1', '0' after clk_period;

   -- Stimulus process
   stim_proc: process
   begin		
      wait for clk_period; -- ALL INTERFACES WANT TO READ
		interface_1_addr <= "00000000"; -- interface one
		interface_1_control_in <= control_in_read;
		interface_1_data_in <= none_data_in;
		interface_2_addr <= "00000001"; -- interface two
		interface_2_control_in <= control_in_read;
		interface_2_data_in <= none_data_in;
		interface_3_addr <= "00000010"; -- interface three
		interface_3_control_in <= control_in_read;
		interface_3_data_in <= none_data_in;
		interface_4_addr <= "00000011"; -- interface four
		interface_4_control_in <= control_in_read;
		interface_4_data_in <= none_data_in;
		
		wait for clk_period; -- ALL INTERFACES WANT TO WRITE
		interface_1_addr <= "00000100"; -- interface one
		interface_1_control_in <= control_in_write;
		interface_1_data_in <= "11001100";
		interface_2_addr <= "00000101"; -- interface two
		interface_2_control_in <= control_in_write;
		interface_2_data_in <= "11001100";
		interface_3_addr <= "00000110"; -- interface three
		interface_3_control_in <= control_in_write;
		interface_3_data_in <= "11001100";
		interface_4_addr <= "00000111"; -- interface four
		interface_4_control_in <= control_in_write;
		interface_4_data_in <= "11001100";
		
		wait for clk_period; -- FIRST TWO INTERFACES WANT TO READ (ONE ADDRESS). LAST TWO INTEACESS WANT TO WRITE (DIFFERENT ADDRESES)
		interface_1_addr <= "00000000"; -- interface one
		interface_1_control_in <= control_in_read;
		interface_1_data_in <= none_data_in;
		interface_2_addr <= "00000000"; -- interface two
		interface_2_control_in <= control_in_read;
		interface_2_data_in <= none_data_in;
		interface_3_addr <= "00000110"; -- interface three
		interface_3_control_in <= control_in_write;
		interface_3_data_in <= "11111111";
		interface_4_addr <= "00000111"; -- interface four
		interface_4_control_in <= control_in_write;
		interface_4_data_in <= "11111111";
		
		wait for clk_period; -- FIRST INTERFACE WNAT TO READ. NEXT ALL WANT TO WRITE (ONE ADDRES)
		interface_1_addr <= "00000111"; -- interface one
		interface_1_control_in <= control_in_read;
		interface_1_data_in <= none_data_in;
		interface_2_addr <= "00000111"; -- interface two
		interface_2_control_in <= control_in_write;
		interface_2_data_in <= "11110000";
		interface_3_addr <= "00000111"; -- interface three
		interface_3_control_in <= control_in_write;
		interface_3_data_in <= "11111000";
		interface_4_addr <= "00000111"; -- interface four
		interface_4_control_in <= control_in_write;
		interface_4_data_in <= "11111100";
		
      wait;
   end process;
	
	interface_one_addr <= interface_1_addr;
	interface_two_addr <= interface_2_addr;
	interface_three_addr <= interface_3_addr;
	interface_four_addr <= interface_4_addr;
	
	interface_one_control_in <= interface_1_control_in;
	interface_two_control_in <= interface_2_control_in;
	interface_three_control_in <= interface_3_control_in;
	interface_four_control_in <= interface_4_control_in;
	
	interface_one_data_in <= interface_1_data_in;
	interface_two_data_in <= interface_2_data_in;
	interface_three_data_in <= interface_3_data_in;
	interface_four_data_in <= interface_4_data_in;

END;