LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY TXD IS
	PORT(
		i_TDRE			: IN	STD_LOGIC;
		i_clock, i_resetBar: IN	STD_LOGIC;
		o_shift			: OUT	STD_LOGIC;
		o_load			: OUT STD_LOGIC;
		o_count: OUT STD_LOGIC_VECTOR(2 downto 0); 
		o_DD	: OUT STD_LOGIC_VECTOR(1 downto 0)
		);
END TXD;

ARCHITECTURE rtl OF TXD IS

SIGNAL int_D0, int_D1, int_count : Std_LOGIC;
SIGNAL int_c: STD_LOGIC_VECTOR (2 downto 0);
SIGNAL int_D, int_notD: Std_LOGIC_VECTOR (1 downto 0);
	
COMPONENT counter3
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(2 downto 0));
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

d0 :enARdFF_2
	PORT MAP(
		i_resetBar => i_resetBar,
		i_d => int_D0,
		i_enable => '1',
		i_clock => i_clock,
		o_q => int_D(0),
		o_qBar => int_notD(0));

d1 : enARdFF_2
	PORT MAP(
		i_resetBar => i_resetBar,
		i_d => int_D1,
		i_enable => '1',
		i_clock => i_clock,
		o_q => int_D(1), 
		o_qBar => int_notD(1));
		
count1 : counter3
	PORT MAP(
		i_resetBar => (int_D(0) and int_D(1)),
		i_load => (int_D0 and int_D1),
		i_clock => i_clock,
		o_Value => int_c
		);
		
-- inputs --
int_D0 <= (int_D(1));
int_D1 <= (((int_notD(0) and i_TDRE)or(int_notD(0)and int_D(1))) or (int_D(1) and (not int_count)));
int_count <= (((int_c(0) and int_c(1))) and int_c(2));

o_load <= (int_notD(0) and int_D(1));
o_shift <= (int_D(0) and int_D(1)) ;
o_count <= int_c;
o_DD <= int_D;

END rtl;