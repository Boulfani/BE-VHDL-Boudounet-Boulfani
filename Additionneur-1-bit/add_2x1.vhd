Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Entity add_2x1 is
port	(
		A 		: in std_logic;
		B 		: in std_logic;
		Cin 	: in std_logic;
		
		S 		: out std_logic;
		Cout 	: out std_logic
		);
End add_2x1;

Architecture ar of add_2x1 is

Signal resultat : std_logic_vector (1 downto 0);

Begin

resultat <= ('0'& A) + ('0'& B) + ('0'& Cin);
S<= resultat(0);
Cout<= resultat(1);

End ar;