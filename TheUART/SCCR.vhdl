LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY SCCR IS
	PORT(
		i_Value			: IN	STD_LOGIC_VECTOR (7 downto 0);
		i_clock, i_resetBar	: IN	STD_LOGIC;
		o_load			: IN	STD_LOGIC;
		o_TIE, o_RIE		: OUT	STD_LOGIC;
		o_SE			: OUT 	STD_LOGIC_VECTOR(2 downto 0);
		);
END SCCR;
ARCHITECTURE rtl OF SSCR IS

SIGNAL int_Q: STD_LOGIC_VECTOR (7 downto 0);

COMPONENT reg8
	PORT(
		i_clear		: IN	STD_LOGIC;
		i_clock		: IN	STD_LOGIC;
		i_data		: IN STD_LOGIC_VECTOR(7 downto 0);
		o_Q		: OUT	STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

BEGIN
my_SCCR : reg8

	PORT MAP(
		i_clear => i_reserBar,
		i_clock	=> i_clock,
		i_data => i_value,
		o_Q => intQ);

----------output--------------
 
o_TIE <= int_q(7);
o_RIE <= int_q(6);

o_SE(2) <= int_q(2); 
o_SE(1) <= int_q(1);
o_SE(0) <= int_q(0);

END rtl;
