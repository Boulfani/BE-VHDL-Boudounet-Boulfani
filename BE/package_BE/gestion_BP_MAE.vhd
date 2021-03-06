Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity gestion_BP_mae is
port	(
		clk			: in std_logic;
		arazb		: in std_logic;
		
		BP_B		: in std_logic;
		BP_T		: in std_logic;
		BP_STBY		: in std_logic;
		
		code_fct	: out std_logic_vector(3 downto 0)
		
		);
End gestion_BP_mae;

Architecture ar of gestion_BP_mae is

Type etat is (etat0, etat1, etat2, etat3, etat4, etat5);

Signal etat_present, etat_suivant: etat;

Begin

-- Evolution des ?tats
evolution : process(etat_present,mode,in_pwm,start_stop,timer_1s)
	begin
		case etat_present is
			when etat0 => 	if 		BP_B='1'						then etat_suivant<=etat1;
							elsif 	BP_T='1'						then etat_suivant<=etat2;
							elsif	BP_STBY='1'						then etat_suivant<=etat3;
							else									etat_suivant<=etat0;
							end if;
							
			when etat1 => 	if 		BP_B='1' 						then etat_suivant<=etat0;
							else									etat_suivant<=etat1;
							end if;
							
			when etat2 => 	if 		BP_B='1' 						then etat_suivant<=etat0;
							else									etat_suivant<=etat2;
							end if;
			when etat3 => 	if 		BP_B='1' 						then etat_suivant<=etat0;
							else									etat_suivant<=etat3;
							end if;									
		end case;
	end process;
	
--OK M?morisation ?tat pr?sent 
memo : process(clk,arazb)
	begin
		if arazb='0' then etat_present <= etat0;
		elsif clk'event and clk='1' then etat_present<=etat_suivant;
		end if;
	end process;
	
-- G?n?ration des actions

--=0000: pas d'action, le pilote est en veille
-- =0001: mode manuel action v?rin babord
-- =0010: mode manuel action v?rin tribord
-- =0011: mode pilote automatique/cap
-- =0100: incr?ment de 1? consigne de cap
-- =0101: incr?ment de 10? consigne de cap
-- =0111: d?cr?ment de 1? consigne de cap
-- =0110: d?cr?ment de 10? consigne de cap
code_fct <= "0000"	when etat_present=etat0 else 
			"0001" 	when etat_present=etat1 else 
			"0010"	when etat_present=etat2 else 
			"0011" when etat_present=etat3  else 
			"1111";
				
End ar;