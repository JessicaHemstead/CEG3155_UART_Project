-- 2-bit down counter
--Jessica Hemstead
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY twobitTimer IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_done			: OUT	STD_LOGIC);
END twobitTimer;

ARCHITECTURE rtl OF twobitTimer IS
	
	SIGNAL int_z0,int_z1:STD_LOGIC;
	
	COMPONENT downCounter
		PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Z			: OUT	STD_LOGIC_VECTOR(1 downto 0));
	END COMPONENT;

BEGIN

acounter: downCounter
	PORT MAP (
			i_resetBar => i_resetBar,
			i_load => i_load,
			i_clock => i_clock,
			o_z(0) => int_z0,
			o_z(1) => int_z1);
	
	o_done <= (int_z1 nor int_z0);

	

END rtl;
