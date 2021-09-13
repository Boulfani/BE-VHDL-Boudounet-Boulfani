Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Entity deco_7seg is
port	(
		E 		: in std_logic_vector (3 downto 0);		
		S 		: out std_logic_vector (6 downto 0)
		);
End deco_7seg;

Architecture ar of deco_7seg is
Begin
S <= 	(NOT "0111111")	when E="0000"	else --0
		(NOT "0000110")	when E="0001"	else --1
		(NOT "1011011")	when E="0010"	else --2
		(NOT "1001111")	when E="0011"	else --3
		(NOT "1100110")	when E="0100"	else --4
		(NOT "1101101")	when E="0101"	else --5
		(NOT "1111101")	when E="0110"	else --6
		(NOT "1000111")	when E="0111"	else --7
		(NOT "1111111")	when E="1000"	else --8
		(NOT "1101111")	when E="1001"	else --9
		(NOT "1110111")	when E="1010"	else --A
		(NOT "1111100")	when E="1011"	else --B
		(NOT "0111001")	when E="1100"	else --C
		(NOT "1011110")	when E="1101"	else --D
		(NOT "1111001")	when E="1110"	else --E
		(NOT "1110001")	when E="1111"	else --F
		(NOT "0000000");
		

End ar;