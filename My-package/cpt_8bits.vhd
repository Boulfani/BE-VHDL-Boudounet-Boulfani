Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage.all;

Entity cpt_8bits is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		reset 	: in std_logic;
		
		S		: out std_logic_vector (7 downto 0)
		);
End cpt_8bits;

Architecture ar of cpt_8bits is

Signal nombre : std_logic_vector(7 downto 0);

Begin

Process (clk, araz)
	Begin
		if araz='0' then nombre <= (others =>'0');
		elsif(clk'event and clk='1') then
			if reset='1' then nombre <= (others =>'0');
			elsif nombre=255 then nombre <= (others =>'0');
			else nombre <= nombre+1;
			end if;
		end if;
	End Process;
	
S<=nombre;

End ar;