Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity MAE is
port	(
		clk			: in std_logic;
		arazb		: in std_logic;
		
		-- Entrées
		
		-- Sorties
		etat_mae	: out std_logic_vector(n downto 0);
		);
End MAE;

Architecture ar of gestion_BP_mae is

Type etat is (etat0, etat1, etat2, etat3, etat4, etat5);

Signal etat_present, etat_suivant: etat;

Begin

-- Evolution des états
evolution : process(etat_present, transition)
	begin
		case etat_present is
			when etat0 => 	if 								then etat_suivant<=etat1;
							else									 etat_suivant<=etat0;
							end if;
							
			when etat1 => 	if 								then etat_suivant<=etat0;
							else									 etat_suivant<=etat1;
							end if;
							
			when etat2 => 	if 		 						then etat_suivant<=etat0;
							else									 etat_suivant<=etat2;
							end if;
										
		end case;
	end process;
	
--OK Mémorisation état présent 
memo : process(clk,arazb)
	begin
		if arazb='0' then etat_present <= etat0;
		elsif clk'event and clk='1' then etat_present<=etat_suivant;
		end if;
	end process;
	
-- Génération des actions

				
End ar;