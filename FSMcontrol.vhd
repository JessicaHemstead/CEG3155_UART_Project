

library ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FSMcontrol IS 
	PORT(
	i_SignalTimer: IN STD_LOGIC;
	i_CountExpired: IN STD_LOGIC;
	i_SSCS: IN STD_LOGIC;
	i_reset:IN STD_LOGIC;
	i_GClock: IN STD_LOGIC;
	o_MY, o_MG, o_SY, o_SG, o_MR, o_SR: OUT STD_LOGIC;
	o_stateA, o_stateB, o_stateC, o_stateD: OUT STD_LOGIC;
	o_setCounter, o_setTimer:OUT STD_LOGIC
	);
	
END FSMcontrol;

ARCHITECTURE RTL OF FSMcontrol IS 

	SIGNAL int_stateA, int_stateB, int_stateC, int_stateD :STD_LOGIC;
	SIGNAL int_MY, int_MG, int_SY, int_SG, int_MR, int_SR:STD_LOGIC;
	SIGNAL int2_MY, int2_MG, int2_SY, int2_SG, int2_MR, int2_SR:STD_LOGIC;

component FSM
	PORT(
	i_x: IN STD_LOGIC;
	i_GClock: IN STD_LOGIC;
	o_MY, o_MG, o_SY, o_SG, o_MR, o_SR: OUT STD_LOGIC
	);
end component;

component sixBitmux2to1
	PORT(
		i_op0:IN STD_LOGIC_VECTOR(5 downto 0);
		i_op1:IN STD_LOGIC_VECTOR(5 downto 0);
		i_selection: IN STD_LOGIC;
		o_choice:OUT STD_LOGIC_VECTOR(5 downto 0));
end component;
	
BEGIN 

	int_stateA <= int2_MG and int2_SR;
	int_stateB <= int2_MY and int2_SR;
	int_stateC <= int2_MR and int2_SG;
	int_stateD <= int2_MR and int2_SY;

	myFSM: FSM
	PORT MAP(
		i_x => ((i_SSCS and i_CountExpired)and int_stateA ) or (i_signalTimer and int_stateB) or (i_CountExpired and int_stateC) or (i_signalTimer and int_stateD),
		i_GClock => i_GClock,
		o_MY => int_MY,
		o_MG => int_MG,
		o_SY => int_SY,
		o_SG => int_SG,
		o_MR => int_MR, 
		o_SR => int_SR
		);
	
	
	myMux : sixBitmux2to1
	PORT	 MAP(
		--op0 = not reset
		--op1 = reset
		i_op0(0) => int_MY,
		i_op0(1) => int_MG,
		i_op0(2) => int_SY,
		i_op0(3) => int_SG,
		i_op0(4) => int_MR,
		i_op0(5) => int_SR,
		
		i_op1(0) => '0',
		i_op1(1) => '1',
		i_op1(2) => '0',
		i_op1(3) => '0',
		i_op1(4) => '0',
		i_op1(5) => '1',
		
		i_selection => i_reset,
		
		o_choice(0) => int2_MY,
		o_choice(1) => int2_MG,
		o_choice(2) => int2_SY,
		o_choice(3) => int2_SG,
		o_choice(4) => int2_MR,
		o_choice(5) => int2_SR
		
	
		);
		
		
	o_MY <= int2_MY;
	o_MG <= int2_MG;
	o_SY <= int2_SY;
	o_SG <= int2_SG;
	o_MR <= int2_MR;
	o_SR <= int2_SR;
	
	o_SetTimer <= (int_stateB or int_stateD);
	o_SetCounter <= (int_stateA or int_stateC);
	
	o_StateA <=int_stateA;
	o_StateB <= int_stateB;
	o_StateC <= int_stateC;
	o_StateD <= int_stateD;
	

END RTL;


