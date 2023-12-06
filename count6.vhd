-- 6Bit counter with IRQ
-- Jessica Hemstead
-- Used counter code from Rami 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY count6 IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_IRQ:IN STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(2 downto 0));
END count6;

ARCHITECTURE rtl OF count6 IS
	SIGNAL int_y0, int_ny0,int_y1, int_ny1,int_y2, int_ny2,int_y3, int_ny3 : STD_LOGIC;

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

y2: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => ((not i_IRQ and int_y2) or (int_y2 and int_ny1 and int_ny0) or (i_IRQ and int_y1 and int_y0)),
			  i_enable => i_load, 
			  i_clock => i_clock,
			  o_q => int_y2,
	        o_qBar => int_ny2);

y1: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => ((i_IRQ and int_ny1 and int_ny1 and int_y0) or (int_y1 and int_ny0) or ((not i_IRQ)and int_y1)),
			  i_enable => i_load, 
			  i_clock => i_clock,
			  o_q => int_y1,
	          o_qBar => int_ny1);
y0: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => ((i_IRQ and int_ny0)or ((not i_IRQ) and int_y0)),
			  i_enable => i_load, 
			  i_clock => i_clock,
			  o_q => int_y0,
	        o_qBar => int_ny0);

				 
	o_value(0) <= int_y0;
	o_value(1) <= int_y1;
	o_value(2) <= int_y2;

	
END rtl;