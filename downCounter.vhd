-- 2-bit down counter
--Jessica Hemstead
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY downCounter IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Z			: OUT	STD_LOGIC_VECTOR(1 downto 0));
END downCounter;

ARCHITECTURE rtl OF downCounter IS
	
	SIGNAL int_y1, int_y1bar, int_y0, int_y0bar : STD_LOGIC;

	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;

BEGIN

msb: enARdFF_2
	PORT MAP (
			i_resetBar => i_resetBar,
			i_d => ((int_y1bar and int_y0bar)or(int_y1 and int_y0)),
			i_enable => i_load, 
			i_clock => i_clock,
			o_q => int_y1,
	      o_qBar => int_y1bar);

lsb: enARdFF_2
	PORT MAP (
			i_resetBar => i_resetBar,
			i_d => int_y0bar, 
			i_enable => i_load,
			i_clock => i_clock,
			o_q => int_y0,
	      o_qBar => int_y0bar);
	
	o_z(1)<= int_y1;
	o_z(0)<=int_y0;

	

END rtl;
