Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity generateur_bip is
port	(
		--entr?es 
		clk 			: in std_logic; 
		arazb			: in std_logic;
		en 			    : in std_logic;
		
		-- sorties 
		bip				: out std_logic	
		
		);
End generateur_bip;

Architecture ar of generateur_bip is

Signal ibip : std_logic;

Begin

Process(clk,arazb)
	begin
		if arazb='0' then ibip<='0';
		elsif clk'event and clk='1' then
			if(en='1') then
			ibip<= NOT ibip;
			end if;
		end if;
	end process;
bip<= ibip;
End ar;