Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage.all;

Entity comparateur_duty is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		
		in1		: in std_logic_vector (7 downto 0);
		in2		: in std_logic_vector (7 downto 0);
		
		S	: out std_logic
		);
End comparateur_duty;

Architecture ar of comparateur_duty is

Signal S_temp : std_logic;

Begin

Process (clk, araz)
	Begin
		if araz='0' then S_temp <= '0';
		elsif(clk'event and clk='1') then
			if in1 < in2 then S_temp<='1';
			else S_temp <= '0';
			end if;
		end if;
	End Process;

S <= S_temp;

End ar;