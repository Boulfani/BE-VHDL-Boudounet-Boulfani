Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity gestion_boutons_poussoirs is
port	(
		--entrées 
		clk_50M 		: in std_logic; 
		raz_n			: in std_logic;
		 
		BP_Babord		: in std_logic; 						
		BP_Tribord		: in std_logic;  						
		BP_STBY			: in std_logic;  						

		-- sorties 
		codeFonction	: out std_logic_vector(3 downto 0);  	
		ledBabord		: out std_logic;   						
		ledTribord		: out std_logic;  						
		ledSTBY			: out std_logic;  						
		out_bip			: out std_logic							
		);
End gestion_boutons_poussoirs;

Architecture ar of gestion_boutons_poussoirs is


Begin



End ar;