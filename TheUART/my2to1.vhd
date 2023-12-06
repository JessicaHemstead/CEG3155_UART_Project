--Lab1 Group 3 CEG3155
--Jessica Hemstead 300214909
--Alexander Wilson 300219585

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY my2to1 IS
	PORT(
		i_op0:IN STD_LOGIC;
		i_op1:IN STD_LOGIC;
		i_selection: IN STD_LOGIC;
		o_choice:OUT STD_LOGIC);
END my2to1;

Architecture my2to1_a OF my2to1 IS

BEGIN

	o_choice <= ((i_op0 and (i_selection)) or (i_op1 and (not i_selection)) );

END my2to1_a;