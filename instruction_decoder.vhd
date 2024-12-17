library ieee;
use ieee.std_logic_1164.all;

---entity
entity instruction_decoder is
	port(
		
		clk,aresetn:in std_logic;
		IRwrite:in std_logic;
		Read_instruction:in std_logic_vector(31 downto 0);
		address_rs:out std_logic_vector(4 downto 0);
		address_rt:out std_logic_vector(4 downto 0);
		address_rd:out std_logic_vector(4 downto 0);
		op_code:out std_logic_vector(5 downto 0);
		function_field:out std_logic_vector(5 downto 0);
		Branch_immediate:out std_logic_vector(15 downto 0);
		jump_immediate:out std_logic_vector(25 downto 0)
	
	
	);
	
end instruction_decoder;


architecture Behavioral of instruction_decoder is
component D_FlipFlop is
	generic(
		signal_length:integer:=32
	);
	port(
		clk,aresetn:in std_logic;
		EN:in std_logic;
		D:in std_logic_vector(signal_length-1 downto 0);
		Q:out std_logic_vector(signal_length-1 downto 0)
	);
end component;

Signal instruction_after_clock_edge:std_logic_vector(31 downto 0);

Begin
	
	u1:D_FlipFlop
	generic map(signal_length=>32)
	port map(clk,aresetn,IRwrite,Read_instruction,instruction_after_clock_edge);
	
	address_rs<=instruction_after_clock_edge(25 downto 21);
	address_rt<=instruction_after_clock_edge(20 downto 16);
	address_rd<=instruction_after_clock_edge(15 downto 11);
	op_code<=instruction_after_clock_edge(31 downto 26);
	function_field<=instruction_after_clock_edge(5 downto 0);
	Branch_immediate<=instruction_after_clock_edge(15 downto 0);
	jump_immediate<=instruction_after_clock_edge(25 downto 0);

end Behavioral;