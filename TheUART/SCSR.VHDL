LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SCSR IS 
	PORT(
	i_TDRE, i_RDRF, i_OE, i_FE	:STD_LOGIC;
	i_Gclock							:STD_LOGIC;
	o_TDRE, o_RDRF, o_OE, o_FE	:STD_LOGIC;
	o_data							:STD_LOGIC_VECTOR (7 downto 0)
	);
END SCSR;

ARCHITECTURE rtl OF SCSR

SIGNAL	int_data :STD_LOGIC_VECTOR(7 downto 0);
SIGNAL

	COMPONENT reg8 
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock					: IN	STD_LOGIC;
			i_Value					: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_Value					: OUT	STD_LOGIC_vector (7 downto 0)
			);
	END COMPONENT;
	
BEGIN 

mySCSR	:reg8 
		PORT MAP(
			i_resetBar => '1',
			i_load => '1',
			i_clock => i_Gclock,
			i_Value(7),
			i_Value(6),
			i_Value(5),
			i_Value(4),
			i_Value(3),
			i_Value(2),
			i_Value(1),
			i_Value(0),
			o_Value => int_data,
			);


END rtl