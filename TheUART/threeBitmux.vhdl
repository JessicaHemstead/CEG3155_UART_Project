--Lab1 Group 3 CEG3155
--Jessica Hemstead 300214909
--Alexander Wilson 300219585

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY threeBitmux IS
	PORT(
		i_op:IN STD_LOGIC_VECTOR(7 downto 0);
		i_sel: IN STD_LOGIC_VECTOR(2 downto 0);
		o_choice:OUT STD_LOGIC);
END threeBitmux;

Architecture threeBitmux_a OF threeBitmux IS

BEGIN

	o_choice <= ((i_op(0)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op(1)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op(2)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op(3)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op(4)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op(5)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op(6)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op(7)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	
	);
	

END threeBitmux_a;