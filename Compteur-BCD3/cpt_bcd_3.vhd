Library	ieee;
Use		ieee.std_logic_1164.all;
Use		ieee.std_logic_unsigned.all;

Entity cpt_bcd_3 is
Port	(
		clk		: in std_logic;
		reset	: in std_logic;
		C		: in std_logic;
		load	: in std_logic;
		data	: in std_logic_vector(3 downto 0);
		
		S 		: out std_logic_vector(3 downto 0)
		);
End Entity;

Architecture ar of cpt_bcd_3 is

Signal nombre : std_logic_vector(3 downto 0);

Begin

Process (clk, reset)
	Begin
		if reset='1' then nombre <= (others =>'0');
		elsif(clk'event and clk='1') then
			if load='1' then nombre<=data;
			elsif C='1' then
				if nombre=9 then nombre <= (others =>'0');
				else nombre <= nombre+1;
				end if;
			elsif C='0' then
				if nombre=0 then nombre <= "1001";
				else nombre <= nombre-1;
				end if;
			end if;
		end if;
	End Process;
S<=nombre;
End ar;