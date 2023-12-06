-- 8Bit counter
-- Jessica Hemstead
-- Used counter code from Rami 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY eightbitcounter IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
END eightbitcounter;

ARCHITECTURE rtl OF eightbitcounter IS
	SIGNAL int_Value : STD_LOGIC_VECTOR(3 downto 0);

	COMPONENT fourbitcounter
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
	END COMPONENT;

BEGIN

y0: fourbitcounter
	PORT MAP (i_resetBar => i_resetBar,
			  i_load => i_load,
			  i_clock => i_clock,  
			  o_Value => int_Value(3 downto 0));

y1: fourbitcounter
	PORT MAP (i_resetBar => i_resetBar,
			  i_load => i_load,
			  i_clock => int_Value(3),
			  o_Value => o_Value(7 downto 4));

o_Value(3 downto 0) <= int_Value;

	
END rtl;