Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage.all;

Entity ecoulement_secondes is
port	(
		Clk 	: in std_logic;
		
		S 		: out std_logic_vector (6 downto 0)
		);
End ecoulement_secondes;

Architecture ar of ecoulement_secondes is

Signal sig_clk_out : std_logic;
Signal sortie_bcd : std_logic_vector(3 downto 0);

Begin

div : div_freq
port map(
		clk =>	Clk,	
		clk_out => sig_clk_out
		);
		
cpt_BCD : cpt_bcd_1
port map(
		clk => sig_clk_out,
		S => sortie_bcd
		);

decodeur : deco_7seg
port map(
		E => sortie_bcd,	
		S => S
		);

End ar;