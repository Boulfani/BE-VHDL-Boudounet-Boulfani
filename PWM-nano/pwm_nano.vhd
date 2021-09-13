Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.std_logic_unsigned.all;

Library work;
Use work.mypackage.all;

Entity pwm_nano is
port	(
		clk 	: in std_logic;
		araz 	: in std_logic;
		
		pwm_out	: out std_logic
		);
End pwm_nano;

Architecture ar of pwm_nano is

Begin

pwm1 : pwm
port	map(
		clk 		=> clk,
		araz 		=> araz,
		freq		=> "10000000",
		duty		=> "00000010",

		pwm_out	=> pwm_out
);


End ar;