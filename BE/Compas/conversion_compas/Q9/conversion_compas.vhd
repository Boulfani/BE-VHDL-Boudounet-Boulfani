Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity conversion_compas is
port	(
		in_pwm 		: in std_logic;
		clk 		: in std_logic;
		reset 		: in std_logic;
		
		cpt : out std_logic_vector(7 downto 0);
		etat_out : out std_logic_vector (1 downto 0);
		data_cap 	: out std_logic_vector (8 downto 0)
		);
End conversion_compas;

Architecture ar of conversion_compas is

Type etat is (etat0, etat1, etat2);

Signal etat_present, etat_suivant: etat;

Signal icpt : std_logic_vector(7 downto 0);

Begin

-- Evolution des états
evolution : process(etat_present,in_pwm,reset)
	begin
		case etat_present is
			when etat0 => 	if in_pwm='1'						then etat_suivant<=etat1;
							else									 etat_suivant<=etat0;
							end if;
			when etat1 => 	if in_pwm='0' 						then etat_suivant<=etat2;
							else									 etat_suivant<=etat1;
							end if;
			when etat2 => 	if reset='1' 						then etat_suivant<=etat0;
							else									 etat_suivant<=etat2;
							end if;
		end case;
	end process;
	
-- Mémorisation état présent
memo : process(clk)
	begin
		if clk'event and clk='1' then etat_present<=etat_suivant;
		end if;
	end process;
-- Génération des actions
icpt <=  icpt+1 	when etat_present=etat1 else
		icpt		when etat_present=etat2 else
		(others=>'0');
		
cpt<=icpt;		
		
data_cap <= (others=>'1') when etat_present=etat2 else
			(others=>'0');
		
etat_out <= "10" when etat_present =etat2 else "01"	when etat_present =etat1 else "00";	
End ar;