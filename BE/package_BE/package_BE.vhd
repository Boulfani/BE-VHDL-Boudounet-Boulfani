Library ieee;
Use ieee.std_logic_1164.all;

Package package_BE is

Component comparateur is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		
		in1		: in std_logic_vector (7 downto 0);
		in2		: in std_logic_vector (7 downto 0);
		
		S	: out std_logic
		);
End Component;

Component comparateur_duty is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		
		in1		: in std_logic_vector (7 downto 0);
		in2		: in std_logic_vector (7 downto 0);
		
		S	: out std_logic
		);
End Component;

Component cpt_8bits is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		reset 	: in std_logic;
		
		S		: out std_logic_vector (7 downto 0)
		);
End Component;

Component pwm is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		freq	: in std_logic_vector (7 downto 0);
		duty	: in std_logic_vector (7 downto 0);
		
		pwm_out	: out std_logic
		--reset_cpt : out std_logic;
		--sortie_cpt	: out std_logic_vector (7 downto 0)
		);
End Component;

Component bascule_D is
port	(
		clk : in std_logic;
		arazb : in std_logic;
		
		en	: in std_logic;
		D : in std_logic_vector(8 downto 0);
		
		Q : out std_logic_vector(8 downto 0)
		);
end Component;
		
Component cpt is
port	(
		clk 	: in std_logic;
		arazb 	: in std_logic;
		reset 	: in std_logic;
		en 		: in std_logic;
		
		S		: out std_logic_vector (8 downto 0)
		);
End Component;

Component prediv_us is
port	(
		clk_in		: in std_logic;
		
		clk_out		: out std_logic
		);
End Component;

Component timer_1s is
port	(
		clk : in std_logic;
		arazb : in std_logic;
		en	: in std_logic;
		reset : in std_logic;
		
		clk_out : out std_logic
		);
end Component;

Component cap_mae is
port	(
		clk			: in std_logic;
		arazb		: in std_logic;
		
		in_pwm		: in std_logic;
		mode		: in std_logic;
		start_stop	: in std_logic;
		
		val_cpt		: in std_logic_vector (8 downto 0);
		timer_1s	: in std_logic;
		
		en_cpt		: out std_logic;
		reset_cpt	: out std_logic;
		en_timer	: out std_logic;
		reset_timer : out std_logic;
		
		data_valid	: out std_logic;
		out_1s		: out std_logic;
		data_compas	: out std_logic_vector(8 downto 0);
		
		etat_pres	: out std_logic_vector(2 downto 0)
		);
End Component;

Component generateur_bip is
port	(
		clk 			: in std_logic; 
		arazb			: in std_logic;
		en 			    : in std_logic;
		
		bip				: out std_logic		
		);
End Component;

Component mae_bip is
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
End Component;

Component gestion_bip is
port	(
		--entr?es 
		clk 			: in std_logic; 
		arazb			: in std_logic;	
		code			: in std_logic_vector(1 downto 0);

		-- sorties
		etat		: out std_logic_vector(1 downto 0);	 							
		out_bip			: out std_logic				
		);
End Component;

Component mae_leds is
port	(
		--entr?es 
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
End Component;

Component bascule_D_generic is
generic (n :natural :=5);
port	(
		clk : in std_logic;
		arazb : in std_logic;
		
		en	: in std_logic;
		D : in std_logic_vector(n-1 downto 0);
		
		Q : out std_logic_vector(n-1 downto 0)
		);
end Component;


Component gestion_leds is
port	(
		--entr?es 
		clk 			: in std_logic; 
		arazb			: in std_logic;
		 
		code 			: in std_logic_vector(2 downto 0);
		chx_leds		: in std_logic_vector(2 downto 0);

		-- sorties 
		leds			: out std_logic_vector(2 downto 0);
		etat : out std_logic_vector(1 downto 0);
		
		surv1, surv2, surv3  : out std_logic_vector(15 downto 0)	
						
		);
End Component;

End package_BE;