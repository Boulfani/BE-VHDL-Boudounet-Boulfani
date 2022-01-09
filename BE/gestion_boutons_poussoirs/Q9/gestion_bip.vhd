Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity gestion_bip is
port	(
		--entrées 
		clk 			: in std_logic; 
		arazb			: in std_logic;	
		code			: in std_logic_vector(1 downto 0);

		-- sorties
		etat		: out std_logic_vector(1 downto 0);	 							
		out_bip			: out std_logic				
		);
End gestion_bip;

Architecture ar of gestion_bip is

Signal ien_cpt, ireset_cpt : std_logic;
Signal ival_cpt : std_logic_vector(8 downto 0);
Signal ien_generateur : std_logic;

Begin


gene : generateur_bip
port map(
		--entrées 
		clk 			=> clk,
		arazb			=> arazb,
		en 			    => ien_generateur,
		
		-- sorties 
		bip				=> out_bip
		);


MAE : mae_bip 
port map(
		--entrées 
		clk 			=> clk,
		arazb			=> arazb,
		 
		code 			=> code,
		in_cpt			=> ival_cpt,

		-- sorties 
		en_gene			=> ien_generateur,
		en_cpt			=> ien_cpt,
		reset_cpt		=> ireset_cpt,	
		etat_mae		=> etat	
		);
		
compteur : cpt
port map(
		clk 	=> clk,
		arazb 	=> arazb,
		reset 	=> ireset_cpt,
		en 		=> ien_cpt,
		
		S		=>ival_cpt
		);
	

End ar;