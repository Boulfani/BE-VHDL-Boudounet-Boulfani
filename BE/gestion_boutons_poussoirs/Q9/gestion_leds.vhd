Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.package_BE.all;

Entity gestion_leds is
port	(
		--entr?es 
		clk 			: in std_logic; 
		arazb			: in std_logic;
		 
		code_led0			: in std_logic_vector(2 downto 0);
		code_led1			: in std_logic_vector(2 downto 0);
		code_led2 			: in std_logic_vector(2 downto 0);
		
		chx_leds		: in std_logic_vector(2 downto 0);

		-- sorties 
		leds			: out std_logic_vector(2 downto 0);
		etat_mae0 : out std_logic_vector(1 downto 0);
		etat_mae1 : out std_logic_vector(1 downto 0);
		etat_mae2 : out std_logic_vector(1 downto 0);
		
		out_en: out std_logic;
		out_cpt: out std_logic_vector (8 downto 0);
		out_b: out std_logic_vector(15 downto 0);
		surv1, surv2, surv3  : out std_logic_vector(15 downto 0)	
						
		);
End gestion_leds;

Architecture ar of gestion_leds is

Signal ien_cpt0, ireset_cpt0 : std_logic;
Signal ien_cpt1, ireset_cpt1 : std_logic;
Signal ien_cpt2, ireset_cpt2 : std_logic;

Signal ien_D0, ien_D1,ien_D2 : std_logic;

Signal ival_cpt0: std_logic_vector (8 downto 0);
Signal ival_cpt1: std_logic_vector (8 downto 0);
Signal ival_cpt2: std_logic_vector (8 downto 0);

Signal ipwm0, ipwm1, ipwm2 : std_logic_vector(15 downto 0);
Signal isortie_basculeD0,isortie_basculeD1,isortie_basculeD2: std_logic_vector(15 downto 0);

Begin

MAE0 : mae_leds
port map(
		--entr?es 
		clk =>clk, arazb=>arazb, 
		code =>code_led0, 	cette_led => chx_leds(0),
		in_cpt=>ival_cpt0,		
		in_basculeD=>isortie_basculeD0,

		-- sorties
			--Compteur
		en_cpt=>ien_cpt0, reset_cpt=>ireset_cpt0,
		
			--PWM x3
		freq =>ipwm0(7 downto 0), duty =>ipwm0(15 downto 8),
		
			--Bascule D x3
		sortie_basculeD=>open,	
			
		etat_mae=>etat_mae0
		);
		
MAE1 : mae_leds
port map(
		--entr?es 
		clk =>clk, arazb=>arazb, 
		code =>code_led1,  cette_led => chx_leds(1),	
		in_cpt=>ival_cpt1,		
		in_basculeD=>isortie_basculeD1,

		-- sorties
			--Compteur
		en_cpt=>ien_cpt1, reset_cpt	=>ireset_cpt1,
		
			--PWM x3
		freq =>ipwm1(7 downto 0), duty =>ipwm1(15 downto 8),
		
			--Bascule D x3
		sortie_basculeD=>open,	
			
		etat_mae=>etat_mae1
		);
		
MAE2: mae_leds
port map(
		--entr?es 
		clk =>clk, arazb=>arazb, 
		code =>code_led2, 	cette_led => chx_leds(2),
		in_cpt=>ival_cpt2,		
		in_basculeD=>isortie_basculeD2,

		-- sorties
			--Compteur
		en_cpt=>ien_cpt2, reset_cpt	=>ireset_cpt2,
		
			--PWM x3
		freq =>ipwm2(7 downto 0), duty =>ipwm2(15 downto 8),
		
			--Bascule D x3
		sortie_basculeD=>open,	
			
		etat_mae=>etat_mae2
		);

Bascule0 : bascule_D_generic
generic map (n=>16)
port map(
		clk =>clk, arazb=>arazb, 
		
		en	=>ien_D0,
		D =>ipwm0,
		
		Q =>isortie_basculeD0
		);

Bascule1 : bascule_D_generic
generic map (n=>16)
port map(
		clk =>clk, arazb=>arazb, 
		
		en	=>ien_D1,
		D =>ipwm1,
		
		Q =>isortie_basculeD1
		);
		
Bascule2 : bascule_D_generic
generic map (n=>16)
port map(
		clk =>clk, arazb=>arazb, 
		
		en	=>ien_D2,
		D =>ipwm2,
		
		Q =>isortie_basculeD2
		);
		
compteur0 : cpt
port map(
		clk =>clk, arazb=>arazb, 
		reset=>ireset_cpt0, en=>ien_cpt0,	
		S=>ival_cpt0
		);
		
compteur1 : cpt
port map(
		clk =>clk, arazb=>arazb, 
		reset=>ireset_cpt1, en=>ien_cpt1,	
		S=>ival_cpt1
		);
		
compteur2 : cpt
port map(
		clk =>clk, arazb=>arazb, 
		reset=>ireset_cpt2, en=>ien_cpt2,	
		S=>ival_cpt2
		);
		
		
PWM0 : pwm
port map(
		clk =>clk, araz=>arazb, 
		freq	=>ipwm0(7 downto 0), duty=>ipwm0(15 downto 8),	
		pwm_out	=>leds(0)
		);


PWM1 : pwm
port map(
		clk =>clk, araz=>arazb, 
		freq=>ipwm1(7 downto 0), duty=>ipwm1(15 downto 8),
		pwm_out	=>leds(1)
		);


PWM2 : pwm
port map(
		clk =>clk, araz=>arazb,
		freq=>ipwm2(7 downto 0), duty=>ipwm2(15 downto 8),
		pwm_out	=>leds(2)
		);

ien_D0<='1' when chx_leds(0)='1' else '0';
ien_D1<='1' when chx_leds(1)='1' else '0';
ien_D2<='1' when chx_leds(2)='1' else '0';

Process(clk,chx_leds)
	Begin
	--if arazb='0' then ireset<=(others=>'0');
	if clk'event and clk='1' then --elsif clk'event and clk='1' then 
		
	end if;
	End Process;
		
surv1<=ipwm0;
surv2<=ipwm1;
surv3<=ipwm2;
out_en<=ien_D0;	
out_cpt<=ival_cpt0;
out_b<=isortie_basculeD0;
End ar;