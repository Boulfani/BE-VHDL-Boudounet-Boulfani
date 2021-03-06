Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage.all;

Entity pwm is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		freq	: in std_logic_vector (7 downto 0);
		duty	: in std_logic_vector (7 downto 0);
		
		pwm_out	: out std_logic
		--reset_cpt : out std_logic;
		--sortie_cpt	: out std_logic_vector (7 downto 0)
		);
End pwm;

Architecture ar of pwm is

Signal isortie_cpt : std_logic_vector (7 downto 0);
Signal ireset_cpt : std_logic;
Signal ipwm_out : std_logic;

Begin

comparateur_cpt_freq : comparateur
port map(
		clk 	=>	clk,
		araz 	=> 	araz,
		
		in1		=> 	isortie_cpt,
		in2		=>	freq,
		
		S		=>	ireset_cpt
		);

compteur : cpt_8bits
port map(
		clk 	=> clk,
		araz 	=> araz,
		reset 	=> ireset_cpt,
		
		S		=>	isortie_cpt
		);

comparateur_cpt_duty : comparateur_duty
port map(
		clk 	=> 	clk,
		araz 	=> 	araz,
		
		in1		=>	isortie_cpt,
		in2		=> 	duty,
		
		S		=>  ipwm_out
		);

--reset_cpt<=ireset_cpt;
--sortie_cpt<=isortie_cpt;
pwm_out<=  ipwm_out;
End ar;