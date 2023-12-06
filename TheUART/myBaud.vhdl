-- 8Bit counter
-- Jessica Hemstead
-- Used counter code from Rami 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY myBaud IS
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_sel :IN STD_LOGIC_VECTOR(2 downto 0);
		o_BClk, o_BClkx8	: OUT	STD_LOGIC);
END myBaud;

ARCHITECTURE rtl OF myBaud IS
	SIGNAL int_Value: STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_mux: STD_LOGIC;

	COMPONENT eightbitcounter
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT;
	
COMPONENT threeBitmux
		PORT(
		i_op:IN STD_LOGIC_VECTOR(7 downto 0);
		i_sel: IN STD_LOGIC_VECTOR(2 downto 0);
		o_choice:OUT STD_LOGIC);
	END COMPONENT;
	
COMPONENT fourbitcounter
		PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
	END COMPONENT;

BEGIN

y0: eightbitcounter
	PORT MAP (i_resetBar => i_resetBar,
			  i_load => i_load,
			  i_clock => i_clock,  
			  o_Value => int_Value(7 downto 0));

y1: threeBitmux
	PORT MAP (
			i_op => int_Value,
			i_sel => i_sel,
			o_choice => int_mux);

y2: fourbitcounter
		PORT MAP(i_resetBar => i_resetBar,
			  i_load => i_load,
			  i_clock => int_mux,
			  o_Value(2) => o_BClk);

o_BClkx8 <= int_mux;
	
END rtl;