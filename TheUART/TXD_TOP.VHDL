LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TXD_TOP IS
	PORT(
		i_resetBar, i_load, i_TDRE: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_Value			: OUT	STD_LOGIC;
		o_regVal			:OUT STD_LOGIC_VECTOR(7 downto 0)
		);
END TXD_TOP;

ARCHITECTURE rtl OF TXD_TOP IS
	SIGNAL int_TDRval: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_shift: STD_LOGIC;
	
	COMPONENT Shiftreg8
		PORT(
			i_resetBar, i_load, i_shift: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_Value			: OUT	STD_LOGIC);
	END COMPONENT;
		
	COMPONENT txd
		PORT(
			i_TDRE			: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			o_shift			: OUT	STD_LOGIC
			);
	END COMPONENT;
		
	COMPONENT reg8 
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_Value			: OUT	STD_LOGIC_vector (7 downto 0)
			);
	END COMPONENT;
	
	COMPONENT enARdFF_2
		PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
	END COMPONENT;
	
BEGIN

	TSR: Shiftreg8
		PORT MAP(
			i_resetBar => i_resetBar,
			i_load => '1',
			i_shift => int_shift,
			i_clock => i_clock,
			i_Value => int_TDRval,
			o_Value => o_value
		);
		
	TSControl : txd
		PORT MAP(
			i_TDRE => i_TDRE,
			i_clock => i_clock,
			o_shift => int_shift
		);
	
		
	TDR : reg8 
		PORT MAP(
			i_resetBar => i_resetBar, 
			i_load => i_load,
			i_clock => i_clock,
			i_Value => i_value,
			o_Value => int_TDRval
			);
---
o_regVal <= int_TDRval;

END rtl;
