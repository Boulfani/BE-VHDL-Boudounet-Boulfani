Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage.all;

Entity add_2x3 is
port	(
		A 		: in std_logic_vector (2 downto 0);
		B 		: in std_logic_vector (2 downto 0);
		Cin 	: in std_logic;
		
		S 		: out std_logic_vector (2 downto 0);
		Cout 	: out std_logic
		);
End add_2x3;

Architecture ar of add_2x3 is

Signal retenue : std_logic_vector (1 downto 0);

Begin

add_1bit_bit0 : add_2x1
port map(
		A		=>	A(0),
		B		=> 	B(0),
		Cin		=> 	Cin,
		
		S 		=>	S(0),	
		Cout 	=>	retenue(0)
		);

add_1bit_bit1 : add_2x1
port map(
		A		=>	A(1),
		B		=> 	B(1),
		Cin		=> 	retenue(0),
		
		S 		=>	S(1),	
		Cout 	=>	retenue(1)
		);

add_1bit_bit2 : add_2x1
port map(
		A		=>	A(2),
		B		=> 	B(2),
		Cin		=> 	retenue(1),
		
		S 		=>	S(2),	
		Cout 	=>	Cout
		);
End ar;