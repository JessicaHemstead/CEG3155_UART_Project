--Lab1 Group 3 CEG3155
--Jessica Hemstead 300214909
--Alexander Wilson 300219585

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY eightBit3to1mux IS
	PORT(
		i_op0,i_op1,i_op2,i_op3,i_op4,i_op5,i_op6,i_op7:IN STD_LOGIC_VECTOR(7 downto 0);
		i_sel: IN STD_LOGIC_VECTOR(2 downto 0);
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
END eightBit3to1mux;

Architecture eightBit3to1mux_a OF eightBit3to1mux IS

BEGIN

	o_choice(0) <= ((i_op0(0)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op1(0)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op2(0)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op3(0)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op4(0)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op5(0)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op6(0)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op7(0)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	
	);
	
	o_choice(1) <= ((i_op0(1)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op1(1)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op2(1)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op3(1)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op4(1)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op5(1)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op6(1)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op7(1)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	
	);
	
	o_choice(2) <= ((i_op0(2)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op1(2)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op2(2)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op3(2)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op4(2)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op5(2)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op6(2)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op7(2)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	
	);
	
	o_choice(3) <= ((i_op0(3)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op1(3)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op2(3)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op3(3)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op4(3)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op5(3)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op6(3)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op7(3)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	
	);
	
	o_choice(4) <= ((i_op0(4)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op1(4)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op2(4)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op3(4)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op4(4)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op5(4)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op6(4)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op7(4)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	
	);
	
	o_choice(5) <= ((i_op0(5)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op1(5)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op2(5)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op3(5)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op4(5)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op5(5)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op6(5)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op7(5)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	
	);
	
	o_choice(6) <= ((i_op0(6)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op1(6)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op2(6)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op3(6)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op4(6)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op5(6)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op6(6)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op7(6)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	);
	
	o_choice(7) <= ((i_op0(7)and (not i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or --sel 000
						 (i_op1(7)and (not i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or     --sel 001
						 (i_op2(7)and (not i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or     --sel 010
						 (i_op3(7)and (not i_sel(2)) and (i_sel(1)) and (i_sel(0))) or         --sel 011
						 (i_op4(7)and (i_sel(2)) and (not i_sel(1)) and (not i_sel(0))) or     --sel 100
						 (i_op5(7)and (i_sel(2)) and (not i_sel(1)) and (i_sel(0))) or         --sel 101
						 (i_op6(7)and (i_sel(2)) and (i_sel(1)) and (not i_sel(0))) or         --sel 110
						 (i_op7(7)and (i_sel(2)) and (i_sel(1)) and (i_sel(0)))                --sel 111
	);
	

END eightBit3to1mux_a;