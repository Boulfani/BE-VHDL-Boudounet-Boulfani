Library ieee;
Use ieee.std_logic_1164.all;

Package mypackage is

Component add_2x1 is
port	(
		A 		: in std_logic;
		B 		: in std_logic;
		Cin 	: in std_logic;
		
		S 		: out std_logic;
		Cout 	: out std_logic
		);
End Component;

Component add_2x3 is
port	(
		A 		: in std_logic_vector (2 downto 0);
		B 		: in std_logic_vector (2 downto 0);
		Cin 	: in std_logic;
		
		S 		: out std_logic_vector (2 downto 0);
		Cout 	: out std_logic
		);
End Component;

Component deco_7seg is
port	(
		E 		: in std_logic_vector (3 downto 0);		
		S 		: out std_logic_vector (6 downto 0)
		);
End Component;

Component cpt_bcd_1 is
Port	(
		clk		: in std_logic;
		S 		: out std_logic_vector(3 downto 0)
		);
End Component;

Component cpt_bcd_2 is
Port	(
		clk		: in std_logic;
		reset	: in std_logic;
		C		: in std_logic;
		S 		: out std_logic_vector(3 downto 0)
		);
End Component;

Component cpt_bcd_3 is
Port	(
		clk		: in std_logic;
		reset	: in std_logic;
		C		: in std_logic;
		load	: in std_logic;
		data	: in std_logic_vector(3 downto 0);
		
		S 		: out std_logic_vector(3 downto 0)
	);
End Component;

Component div_freq is
port	(
		clk : in std_logic;
		
		clk_out : out std_logic
	);
end Component;

Component cpt_8bits is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		reset 	: in std_logic;
		
		S		: out std_logic_vector (7 downto 0)
		);
End Component;

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

Component pwm is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		freq	: in std_logic_vector (7 downto 0);
		duty	: in std_logic_vector (7 downto 0);
		
		pwm_out	: out std_logic
		);
End Component;

End mypackage;