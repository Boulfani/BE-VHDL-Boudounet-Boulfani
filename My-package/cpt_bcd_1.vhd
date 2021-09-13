Library	ieee;
Use		ieee.std_logic_1164.all;
Use		ieee.std_logic_unsigned.all;

Entity cpt_bcd_1 is
Port	(
		clk		: in std_logic;
		S 		: out std_logic_vector(3 downto 0)
		);
End Entity;

Architecture ar of cpt_bcd_1 is

Signal nombre : std_logic_vector(3 downto 0);

Begin

Process (clk)
	Begin
		if(clk'event and clk='1') then
			if nombre=9 then nombre <= (others =>'0');
			else nombre <= nombre+1;
			end if;
		end if;
	End Process;
S<=nombre;
End ar;