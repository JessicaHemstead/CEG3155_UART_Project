--UART FSM 
-- Jessica Hemstead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UARTfsm IS
	PORT(
		i_state :IN STD_LOGIC_VECTOR(1 downto 0);
		i_clock			: IN	STD_LOGIC;
		i_clear: IN STD_LOGIC;
		i_select:IN STD_LOGIC_VECTOR(2 downto 0);
		o_Value			: OUT	STD_LOGIC_VECTOR(7 downto 0);
		i_IRQ: IN STD_LOGIC;
		o_maxCount:OUT STD_LOGIC;
		o_RW :OUT STD_LOGIC;
		o_select: OUT STD_LOGIC_VECTOR(2 downto 0));
END UARTfsm;

ARCHITECTURE rtl OF UARTfsm IS

	SIGNAL int_M, int_S, int_r, int_y, int_g, int_CR, int_dash:STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_count:STD_LOGIC_VECTOR(2 downto 0);
	SIGNAL int_m1, int_m2, int_m3, int_m4:STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL int_maxCount:STD_LOGIC;
	

	COMPONENT count6
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_IRQ:IN STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(2 downto 0));
	END COMPONENT;
	
	COMPONENT reg8 
	PORT(
		i_clear	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_data: IN STD_LOGIC_VECTOR(7 downto 0);
		o_Q			: OUT	STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT;
	
	COMPONENT eightBit3to1mux 
	PORT(
		i_op0,i_op1,i_op2,i_op3,i_op4,i_op5,i_op6,i_op7:IN STD_LOGIC_VECTOR(7 downto 0);
		i_sel: IN STD_LOGIC_VECTOR(2 downto 0);
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT;
	
	COMPONENT fourBytemux2to1
	PORT(
		i_op0, i_op1, i_op2, i_op3:IN STD_LOGIC_VECTOR(7 downto 0);
		i_selection: IN STD_LOGIC_VECTOR(1 downto 0);
		o_choice:OUT STD_LOGIC_VECTOR(7 downto 0));
	END COMPONENT;

BEGIN

count: count6
	PORT MAP(
		i_resetBar => '1',
		i_load => '1',
		i_IRQ => i_IRQ,
		i_clock => i_clock,		
		o_Value => int_count
	);

int_maxCount <= (int_count(2) and (not int_count(1)) and int_count(0));
o_maxCount <= int_maxCount;

RM: reg8
	PORT MAP(
		i_clear=> i_clear,
		i_clock => i_clock,
		i_data(7)=> '0',
		i_data(6)=> '1',
		i_data(5)=> '0',
		i_data(4)=> '0',
		i_data(3)=> '1',
		i_data(2)=> '1',
		i_data(1)=> '0',
		i_data(0)=> '1',
		
		o_Q	=> int_M);

Rg: reg8
	PORT MAP(
		i_clear=> i_clear,
		i_clock => i_clock,
		i_data(7)=> '0',
		i_data(6)=> '1',
		i_data(5)=> '1',
		i_data(4)=> '0',
		i_data(3)=> '0',
		i_data(2)=> '1',
		i_data(1)=> '1',
		i_data(0)=> '1',
		
		o_Q	=> int_g);


Rdash: reg8
	PORT MAP(
		i_clear=> i_clear,
		i_clock => i_clock,
		i_data(7)=> '0',
		i_data(6)=> '1',
		i_data(5)=> '0',
		i_data(4)=> '1',
		i_data(3)=> '1',
		i_data(2)=> '1',
		i_data(1)=> '1',
		i_data(0)=> '1',
		
		o_Q	=> int_dash);

		
RS: reg8
	PORT MAP(
		i_clear=> i_clear,
		i_clock => i_clock,
		i_data(7)=> '0',
		i_data(6)=> '1',
		i_data(5)=> '0',
		i_data(4)=> '1',
		i_data(3)=> '0',
		i_data(2)=> '0',
		i_data(1)=> '1',
		i_data(0)=> '1',
		
		o_Q	=> int_S);

		
Rr: reg8
	PORT MAP(
		i_clear=> i_clear,
		i_clock => i_clock,
		i_data(7)=> '0',
		i_data(6)=> '1',
		i_data(5)=> '0',
		i_data(4)=> '1',
		i_data(3)=> '0',
		i_data(2)=> '0',
		i_data(1)=> '1',
		i_data(0)=> '0',
		
		o_Q	=> int_r);

		
RCR: reg8
	PORT MAP(
		i_clear=> i_clear,
		i_clock => i_clock,
		i_data(7)=> '0',
		i_data(6)=> '0',
		i_data(5)=> '0',
		i_data(4)=> '0',
		i_data(3)=> '1',
		i_data(2)=> '1',
		i_data(1)=> '0',
		i_data(0)=> '1',
		
		o_Q	=> int_CR);

		
Ry: reg8
	PORT MAP(
		i_clear=> i_clear,
		i_clock => i_clock,
		i_data(7)=> '0',
		i_data(6)=> '1',
		i_data(5)=> '1',
		i_data(4)=> '1',
		i_data(3)=> '1',
		i_data(2)=> '0',
		i_data(1)=> '0',
		i_data(0)=> '1',
		
		o_Q	=> int_y);
		
m1 : eightBit3to1mux
	PORT MAP(
		i_op0 => int_M,
		i_op1 => int_g,
		i_op2 => int_dash,
		i_op3 => int_S,
		i_op4 => int_r,
		i_op5 => int_CR,
		i_op6 => (others => '0'),
		i_op7 => (others => '0'),
		i_sel => int_count,
		o_choice => int_m1
		);

m2 : eightBit3to1mux
	PORT MAP(
		i_op0 => int_M,
		i_op1 => int_y,
		i_op2 => int_dash,
		i_op3 => int_S,
		i_op4 => int_r,
		i_op5 => int_CR,
		i_op6 => (others => '0'),
		i_op7 => (others => '0'),
		i_sel => int_count,
		o_choice => int_m2
		);

m3 : eightBit3to1mux
	PORT MAP(
		i_op0 => int_M,
		i_op1 => int_r,
		i_op2 => int_dash,
		i_op3 => int_S,
		i_op4 => int_g,
		i_op5 => int_CR,
		i_op6 => (others => '0'),
		i_op7 => (others => '0'),
		i_sel => int_count,
		o_choice => int_m3
		);
		
m4 : eightBit3to1mux
	PORT MAP(
		i_op0 => int_M,
		i_op1 => int_g,
		i_op2 => int_dash,
		i_op3 => int_S,
		i_op4 => int_y,
		i_op5 => int_CR,
		i_op6 => (others => '0'),
		i_op7 => (others => '0'),
		i_sel => int_count,
		o_choice => int_m4
		);
		

m5: fourBytemux2to1	
	PORT MAP(
		i_op0 => int_m1,
		i_op1 => int_m2,
		i_op2 => int_m3,
		i_op3 => int_m4,
		i_selection => i_state,
		o_choice => o_Value
	);

o_select <= i_select;
o_RW <= int_maxCount;
	
END rtl;