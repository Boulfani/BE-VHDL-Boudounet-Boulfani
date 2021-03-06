Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;


Entity div_freq is
port	(
		clk : in std_logic;
		
		clk_out : out std_logic
		);
end div_freq;

Architecture ar of div_freq is

-- freq in: 50 MHz //test 50Mhz //test 2
-- freq out: 1 Hz //25 mhz //test 2 12.5
-- valeur cpt = (freq in / freq out)/2 -1

signal compteur: integer:=0;
signal var_temp : std_logic := '0';

Begin  
  
Process(clk)
	begin
		if(clk'event and clk='1') then
			
			if (compteur = 24999999) then --/4 = 1
				var_temp <= NOT var_temp;
				compteur <= 0;
			else compteur <=compteur+1;
			end if;
			end if;
	end process;
	
clk_out <= var_temp;	
End ar;