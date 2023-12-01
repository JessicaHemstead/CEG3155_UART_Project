-- 3Bit counter
-- Jessica Hemstead
-- Used counter code from Rami 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY serialToParallelReg8 IS
	PORT(
		i_clear, i_RClk	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_data: IN STD_LOGIC;
		o_Q			: OUT	STD_LOGIC_VECTOR(7 downto 0);
		o_Value :OUT STD_LOGIC_VECTOR(7 downto 0));
END serialToParallelReg8;

ARCHITECTURE rtl OF serialToParallelReg8 IS
	SIGNAL int_Q : STD_LOGIC_VECTOR(7 downto 0);

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

Sa: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => i_data,
			  i_enable => '1', 
			  i_clock => i_clock,
			  o_q => int_Q(0));

Sb: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(0),
			  i_enable => '1', 
			  i_clock => i_clock,
			  o_q => int_Q(1));

Sc: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(1),
			  i_enable => '1', 
			  i_clock => i_clock,
			  o_q => int_Q(2));

Sd: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(2),
			  i_enable => '1', 
			  i_clock => i_clock,
			  o_q => int_Q(3));

Se: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(3),
			  i_enable => '1', 
			  i_clock => i_clock,
			  o_q => int_Q(4));

Sf: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(4),
			  i_enable => '1', 
			  i_clock => i_clock,
			  o_q => int_Q(5));

Sg: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(5),
			  i_enable => '1', 
			  i_clock => i_clock,
			  o_q => int_Q(6));

Sh: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(6),
			  i_enable => '1', 
			  i_clock => i_clock,
			  o_q => int_Q(7));

Pa: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(0),
			  i_enable => '1', 
			  i_clock => i_RClk,
			  o_q => o_Q(0));	

Pb: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(1),
			  i_enable => '1', 
			  i_clock => i_RClk,
			  o_q => o_Q(1));		  

Pc: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(2),
			  i_enable => '1', 
			  i_clock => i_RClk,
			  o_q => o_Q(2));	

Pd: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(3),
			  i_enable => '1', 
			  i_clock => i_RClk,
			  o_q => o_Q(3));	

Pe: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(4),
			  i_enable => '1', 
			  i_clock => i_RClk,
			  o_q => o_Q(4));	

Pf: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(5),
			  i_enable => '1', 
			  i_clock => i_RClk,
			  o_q => o_Q(5));				  
			  
Pg: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(6),
			  i_enable => '1', 
			  i_clock => i_RClk,
			  o_q => o_Q(6));	

Ph: enARdFF_2
	PORT MAP (i_resetBar => '1',
			  i_d => int_Q(7),
			  i_enable => '1', 
			  i_clock => i_RClk,
			  o_q => o_Q(7));	

END rtl;