Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity mae_bip is
port	(
		--entr?es 
		clk 			: in std_logic; 
		arazb			: in std_logic;
		 
		code 			: in std_logic_vector(1 downto 0);
		in_cpt			: in std_logic_vector(8 downto 0);

		-- sorties 
		en_gene			: out std_logic;
		en_cpt			: out std_logic;
		reset_cpt		: out std_logic;	
		etat_mae		: out std_logic_vector(1 downto 0)	
		);
End mae_bip;

Architecture ar of mae_bip is

Type etat is (etat0, etat1, etat2);

Signal etat_present, etat_suivant: etat;
Signal cpt : integer :=0;
Signal ibip : std_logic;
Begin

-- Evolution des ?tats
evolution : process(etat_present,code,in_cpt)
	begin
		case etat_present is
			when etat0 => 	if 		code="01"					then etat_suivant<=etat1;
							elsif	code="10"					then etat_suivant<=etat2;
							else									 etat_suivant<=etat0;
							end if;
							
			when etat1 => 	if 		in_cpt="0000000001"				then etat_suivant<=etat0;
							else										 etat_suivant<=etat1;
							end if;
								
			when etat2 => 	if 		in_cpt="0000000011"				then etat_suivant<=etat0;
							else									 	etat_suivant<=etat2;
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
--cpt 	<= 	0 	when etat_present=etat0 else cpt+1;

en_gene <=	'1' when etat_present=etat1 or etat_present=etat2 else
			'0';
			
en_cpt	<=	'1' when etat_present=etat1 or etat_present=etat2 else
			'0';		
reset_cpt <='1' when etat_present=etat0 else '0';
			

etat_mae <= "01" when 	etat_present=etat1 else	
			"10" when 	etat_present=etat2 else
			"00";
End ar;