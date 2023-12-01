-- 8 bit shift register

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Shiftreg8 IS
	PORT(
		i_resetBar, i_load, i_shift: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_Value			: OUT	STD_LOGIC);
END Shiftreg8;

ARCHITECTURE rtl OF Shiftreg8 IS
	SIGNAL int_Value, int_notValue, int_muxval: STD_LOGIC_VECTOR(7 downto 0);
	
	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
	COMPONENT my2to1
		PORT(
			i_op0:IN STD_LOGIC;
			i_op1:IN STD_LOGIC;
			i_selection: IN STD_LOGIC;
			o_choice:OUT STD_LOGIC);
	END COMPONENT;
	
BEGIN
am : my2to1
		PORT map(
			i_op0 => '1',
			i_op1 => i_value(0),
			i_selection => i_shift,
			o_choice => int_muxval(7));
			
a: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxval(7), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(7),
	        o_qBar => int_notValue(7));
bm : my2to1
		PORT map(
			i_op0 => int_Value(7),
			i_op1=> i_value(1),
			i_selection=> i_shift,
			o_choice => int_muxval(6));
b: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxval(6), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(6),
	          o_qBar => int_notValue(6));
cm : my2to1
		PORT map(
			i_op0=> int_Value(6),
			i_op1 => i_value(2),
			i_selection => i_shift,
			o_choice =>int_muxval(5));
c: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxval(5), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(5),
	          o_qBar => int_notValue(5));
dm : my2to1
		PORT map(
			i_op0 => int_Value(5),
			i_op1 => i_value(3),
			i_selection => i_shift,
			o_choice => int_muxval(4));
d: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxval(4), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(4),
	          o_qBar => int_notValue(4));
em : my2to1
		PORT map(
			i_op0 => int_Value(4),
			i_op1 => i_value(4),
			i_selection => i_shift,
			o_choice => int_muxval(3));
e: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxval(3), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(3),
	          o_qBar => int_notValue(3));
fm : my2to1
		PORT map(
			i_op0 => int_Value(3),
			i_op1  => i_value(5),
			i_selection => i_shift,
			o_choice => int_muxval(2));
f: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxval(2),
			  i_enable => i_load, 
			  i_clock => i_clock,
			  o_q => int_Value(2),
	          o_qBar => int_notValue(2));
gm : my2to1
		PORT map(
			i_op0 => int_Value(2),
			i_op1 => i_value(6),
			i_selection => i_shift,
			o_choice => int_muxval(1));
g: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxval(1),
			  i_enable => i_load, 
			  i_clock => i_clock,
			  o_q => int_Value(1),
	          o_qBar => int_notValue(1));
hm : my2to1
		PORT map(
			i_op0 => int_Value(1),
			i_op1 => i_value(7),
			i_selection => i_shift,
			o_choice => int_muxval(0));
h: enARdFF_2
	PORT MAP (i_resetBar => i_resetBar,
			  i_d => int_muxval(0), 
			  i_enable => i_load,
			  i_clock => i_clock,
			  o_q => int_Value(0),
	        o_qBar => int_notValue(0));

	-- Output Driver
	o_Value	<= int_Value(0);

END rtl;
