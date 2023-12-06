LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SCSR IS 
	PORT(
	i_TDRE, i_RDRF, i_OE, i_FE	: IN STD_LOGIC;
	i_Gclock							: IN STD_LOGIC;
	i_load							: IN STD_LOGIC;
	o_TDRE, o_RDRF, o_OE, o_FE	: OUT STD_LOGIC;
	o_data							: OUT STD_LOGIC_VECTOR (7 downto 0)
	);
END SCSR;

ARCHITECTURE rtl OF SCSR IS

SIGNAL	int_data :STD_LOGIC_VECTOR(7 downto 0);


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
			i_load => i_load,
			i_clock => i_Gclock,
			i_Value(7) => i_TDRE,
			i_Value(6) => i_RDRF, 
			i_Value(5) => '0',
			i_Value(4) =>'0',
			i_Value(3) => '0',
			i_Value(2) => '0',
			i_Value(1) => i_OE,
			i_Value(0) => i_FE,
			o_Value => int_data
			);
-- output --
o_TDRE <= int_data(7);
o_RDRF <= int_data(6);
o_OE <= int_data(1);
o_FE <= int_data(0);

END rtl;