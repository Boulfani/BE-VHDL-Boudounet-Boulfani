Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;
Use ieee.std_logic_arith.all;
Use ieee.numeric_std.all;

Library work;
Use work.mypackage.all;

Entity comparateur is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		
		in1		: in std_logic_vector (7 downto 0);
		in2		: in std_logic_vector (7 downto 0);
		
		S	: out std_logic
		);
End comparateur;

Architecture ar of comparateur is

Signal S_temp : std_logic;
Signal in2_temp : std_logic_vector (7 downto 0);

--Signal --valeur cpt = (freq in / freq out)/2 -1
--Signal valt: integer:=in2/2;

Begin



Process (clk, araz)
	Begin
		if araz='0' then S_temp <= '0';
		elsif(clk'event and clk='1') then
			if in1 = in2-2 then S_temp<='1';
			else S_temp <= '0';
			end if;
		end if;
	End Process;

S <= S_temp;

End ar;