library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.math_real.all;

entity memory_block is
    Port ( rst : in  STD_LOGIC;
           clk : in  STD_LOGIC;
			  -- interface one
			  interface_one_addr : in std_logic_vector(7 downto 0);
			  interface_one_data_in : in std_logic_vector(7 downto 0);
			  interface_one_data_out : out std_logic_vector(7 downto 0);
			  interface_one_control_in : in std_logic_vector(3 downto 0); -- READ(0010); WRITE(1001)
			  interface_one_control_out : out std_logic_vector(2 downto 0); -- READ(110); WRITE(001)
			   -- interface two
			  interface_two_addr : in std_logic_vector(7 downto 0);
			  interface_two_data_in : in std_logic_vector(7 downto 0);
			  interface_two_data_out : out std_logic_vector(7 downto 0);
			  interface_two_control_in : in std_logic_vector(3 downto 0); -- READ(0010); WRITE(1001)
			  interface_two_control_out : out std_logic_vector(2 downto 0); -- READ(110); WRITE(001)
			   -- interface three
			  interface_three_addr : in std_logic_vector(7 downto 0);
			  interface_three_data_in : in std_logic_vector(7 downto 0);
			  interface_three_data_out : out std_logic_vector(7 downto 0);
			  interface_three_control_in : in std_logic_vector(3 downto 0); -- READ(0010); WRITE(1001)
			  interface_three_control_out : out std_logic_vector(2 downto 0); -- READ(110); WRITE(001)
			   -- interface four
			  interface_four_addr : in std_logic_vector(7 downto 0);
			  interface_four_data_in : in std_logic_vector(7 downto 0);
			  interface_four_data_out : out std_logic_vector(7 downto 0);
			  interface_four_control_in : in std_logic_vector(3 downto 0); -- READ(0010); WRITE(1001)
			  interface_four_control_out : out std_logic_vector(2 downto 0)); -- READ(110); WRITE(001)
end memory_block;

architecture Behavioral of memory_block is
	type MEMORY_ARRAY is array (0 to 7) of std_logic_vector(7 downto 0);
	signal content: MEMORY_ARRAY;
	
	signal none_data_out : std_logic_vector(7 downto 0) := "ZZZZZZZZ";
	signal control_out_read : std_logic_vector(2 downto 0) := "110"; -- READ(110)
	signal control_out_write : std_logic_vector(2 downto 0) := "001"; -- WRITE(001)
	
	signal interface_1_data_out : std_logic_vector(7 downto 0);
	signal interface_2_data_out : std_logic_vector(7 downto 0);
	signal interface_3_data_out : std_logic_vector(7 downto 0);
	signal interface_4_data_out : std_logic_vector(7 downto 0);
	
	signal interface_1_control_out : std_logic_vector(2 downto 0);
	signal interface_2_control_out : std_logic_vector(2 downto 0);
	signal interface_3_control_out : std_logic_vector(2 downto 0);
	signal interface_4_control_out : std_logic_vector(2 downto 0);
	
	
begin

	process (rst, clk)
		variable memory_cell : integer range 0 to 8;
	begin
		if (rst = '1') then
		memory_cell := 0;
			for i in 0 to 7
			loop
				content(i) <= std_logic_vector(to_unsigned(memory_cell, 8));
				memory_cell := memory_cell + 1;
			end loop;
		elsif rising_edge (clk) then
		-- READ DATA
			if	(interface_one_control_in = "0010") then -- interface one
				interface_1_data_out <= content(to_integer (unsigned (interface_one_addr)));
				interface_1_control_out <= control_out_read;
			else
				interface_1_data_out <= none_data_out;
			end if;
			if	(interface_two_control_in = "0010") then -- interface two
				interface_2_data_out <= content(to_integer (unsigned (interface_two_addr)));
				interface_2_control_out <= control_out_read;
			else
				interface_2_data_out <= none_data_out;
			end if;
			if	(interface_three_control_in = "0010") then -- interface three
				interface_3_data_out <= content(to_integer (unsigned (interface_three_addr)));
				interface_3_control_out <= control_out_read;
			else
				interface_3_data_out <= none_data_out;
			end if;
			if	(interface_four_control_in = "0010") then -- interface four
				interface_4_data_out <= content(to_integer (unsigned (interface_four_addr)));
				interface_4_control_out <= control_out_read;
			else
				interface_4_data_out <= none_data_out;
			end if;	
			
		-- WRITE DATA
			if	(interface_one_control_in = "1001") then -- interface one
				content(to_integer(unsigned(interface_one_addr))) <= interface_one_data_in;
				interface_1_control_out <= control_out_write;
			end if;
			if	(interface_two_control_in = "1001") then -- interface two
				if (interface_one_control_in = "0010") then
					content(to_integer(unsigned(interface_two_addr))) <= interface_two_data_in;
					interface_2_control_out <= control_out_write;
				elsif (interface_one_control_in = "1001" and (interface_one_addr /= interface_two_addr)) then
					content(to_integer(unsigned(interface_two_addr))) <= interface_two_data_in;
					interface_2_control_out <= control_out_write;
				end if;
			end if;
			if	(interface_three_control_in = "1001") then -- interface three
				if ((interface_one_control_in = "0010") and (interface_two_control_in = "0010")) then
					content(to_integer(unsigned(interface_three_addr))) <= interface_three_data_in;
					interface_3_control_out <= control_out_write;
				elsif (interface_one_control_in = "0010" and interface_two_control_in = "1001" and (interface_two_addr /= interface_three_addr)) then
					content(to_integer(unsigned(interface_three_addr))) <= interface_three_data_in;
					interface_3_control_out <= control_out_write;
				elsif (interface_one_control_in = "1001" and interface_two_control_in = "0010" and (interface_one_addr /= interface_three_addr)) then
					content(to_integer(unsigned(interface_three_addr))) <= interface_three_data_in;
					interface_3_control_out <= control_out_write;
				elsif (interface_one_control_in = "1001" and interface_two_control_in = "1001" and (interface_one_addr /= interface_three_addr)and (interface_two_addr /= interface_three_addr)) then
					content(to_integer(unsigned(interface_three_addr))) <= interface_three_data_in;
					interface_3_control_out <= control_out_write;
				end if;
			end if;
			if	(interface_four_control_in = "1001") then -- interface three
				if (interface_one_control_in = "0010" and interface_two_control_in = "0010" and interface_three_control_in = "0010") then
					content(to_integer(unsigned(interface_four_addr))) <= interface_four_data_in;
					interface_4_control_out <= control_out_write;
				elsif (interface_one_control_in = "0010" and interface_two_control_in = "0010" and interface_three_control_in = "1001" and interface_three_addr /= interface_four_addr) then
					content(to_integer(unsigned(interface_four_addr))) <= interface_four_data_in;
					interface_4_control_out <= control_out_write;
				elsif (interface_one_control_in = "0010" and interface_two_control_in = "1001" and interface_three_control_in = "0010" and interface_two_addr /= interface_four_addr) then
					content(to_integer(unsigned(interface_four_addr))) <= interface_four_data_in;
					interface_4_control_out <= control_out_write;
				elsif (interface_one_control_in = "1001" and interface_two_control_in = "0010" and interface_three_control_in = "0010" and interface_one_addr /= interface_four_addr) then
					content(to_integer(unsigned(interface_four_addr))) <= interface_four_data_in;
					interface_4_control_out <= control_out_write;
				elsif (interface_one_control_in = "0010" and interface_two_control_in = "1001" and interface_three_control_in = "1001" and interface_three_addr /= interface_four_addr and interface_two_addr /= interface_four_addr) then
					content(to_integer(unsigned(interface_four_addr))) <= interface_four_data_in;
					interface_4_control_out <= control_out_write;
				elsif (interface_one_control_in = "1001" and interface_two_control_in = "0010" and interface_three_control_in = "1001" and interface_three_addr /= interface_four_addr and interface_one_addr /= interface_four_addr) then
					content(to_integer(unsigned(interface_four_addr))) <= interface_four_data_in;
					interface_4_control_out <= control_out_write;
				elsif (interface_one_control_in = "1001" and interface_two_control_in = "1001" and interface_three_control_in = "0010" and interface_two_addr /= interface_four_addr and interface_one_addr /= interface_four_addr) then
					content(to_integer(unsigned(interface_four_addr))) <= interface_four_data_in;
					interface_4_control_out <= control_out_write;
				elsif (interface_one_control_in = "1001" and interface_two_control_in = "1001" and interface_three_control_in = "1001" and interface_three_addr /= interface_four_addr and interface_two_addr /= interface_four_addr and interface_one_addr /= interface_four_addr) then
					content(to_integer(unsigned(interface_four_addr))) <= interface_four_data_in;
					interface_4_control_out <= control_out_write;
				end if;
			end if;
		end if;
	end process;
	
	interface_one_data_out <= interface_1_data_out;
	interface_two_data_out <= interface_2_data_out;
	interface_three_data_out <= interface_3_data_out;
	interface_four_data_out <= interface_4_data_out;
	
	interface_one_control_out <= interface_1_control_out;
	interface_two_control_out <= interface_2_control_out;
	interface_three_control_out <= interface_3_control_out;
	interface_four_control_out <= interface_4_control_out;

end Behavioral;
