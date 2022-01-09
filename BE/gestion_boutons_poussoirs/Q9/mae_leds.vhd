Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity mae_leds is
port	(
		--entrées 
		clk 			: in std_logic; 
		arazb			: in std_logic;
		 
		code 			: in std_logic_vector(2 downto 0);
		cette_led		: in std_logic;
		in_cpt			: in std_logic_vector(8 downto 0);
		
		in_basculeD: in std_logic_vector(15 downto 0);


		-- sorties
			--Compteur
		en_cpt			: out std_logic;
		reset_cpt		: out std_logic;
		
			--PWM x3
		freq : out std_logic_vector (7 downto 0);
		duty : out std_logic_vector (7 downto 0);
		

		
			--Bascule D x3
		sortie_basculeD:out std_logic_vector(15 downto 0);
		
			
		etat_mae		: out std_logic_vector(1 downto 0)	
		);
End mae_leds;

Architecture ar of mae_leds is

Type etat is (etat0, etat1, etat2);

Signal etat_present, etat_suivant: etat;
Signal cpt : integer :=0;
Signal ibip : std_logic;

Signal ipwm : std_logic_vector(15 downto 0);
Begin

-- Evolution des états
evolution : process(etat_present,code,in_cpt)
	begin
		case etat_present is
			when etat0 => 	if 		code="001" and cette_led='1'then etat_suivant<=etat1;
							elsif	code="010" and cette_led='1'then etat_suivant<=etat2;
							else									 etat_suivant<=etat0;
							end if;
							
			when etat1 => 	if 		in_cpt="0000000100"				then etat_suivant<=etat0;
							else										 etat_suivant<=etat1;
							end if;
								
			when etat2 => 	if 		in_cpt="0000001000"				then etat_suivant<=etat0;
							else									 	etat_suivant<=etat2;
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

--PWM

ipwm(7 downto 0) <=	"00000100" when cette_led='1' and etat_present=etat0  else
			"00000100"	when cette_led='1' and ((etat_present=etat1) or (etat_present=etat2)) else
			in_basculeD(7 downto 0);	

ipwm(15 downto 8)  <=	(others=>'0')	when  cette_led='1' and (etat_present=etat0  and code="000") else --off
			"00000100"			when cette_led='1' and etat_present=etat0  and code="111" else --on
			"00000001"			when cette_led='1' and etat_present=etat0  and code="100" else --on faible
			"00000010"			when  cette_led='1' and etat_present=etat0  and code="011" else --cligno non stop
			"00000010"			when  ((etat_present=etat1) or (etat_present=etat2)) else --cligno x1 ou x2
			(others=>'0')		when cette_led='0' and ((code="010" or code="001") and etat_present=etat0) else
			in_basculeD(15 downto 8);
				

	--Compteur
en_cpt	<=	'1' when etat_present=etat1 or etat_present=etat2 else
			'0';					
reset_cpt <='1' when etat_present=etat0 else '0';
			
	--Etats MAE
etat_mae <= "01" when 	etat_present=etat1 else	
			"10" when 	etat_present=etat2 else
			"00";
	--PWM		
duty<=ipwm(15 downto 8);
freq<=ipwm(7 downto 0);

	
	--Bascule D		
sortie_basculeD<=ipwm;
	
End ar;