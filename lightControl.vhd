

library ieee;
USE ieee.std_logic_1164.ALL;

ENTITY lightControl IS 
	PORT(
	i_Gclock:IN STD_LOGIC;
	i_carSensor:IN STD_LOGIC;
	i_SSCmax, i_MSCmax:IN STD_LOGIC_VECTOR(3 downto 0);
	i_Greset:IN STD_LOGIC;
	o_MY, o_MG, o_SY, o_SG, o_MR, o_SR: OUT STD_LOGIC;
	o_state : OUT STD_LOGIC_VECTOR(3 downto 0);
	o_currentCount, o_mainCounter, o_sideCounter: OUT STD_LOGIC_VECTOR(3 downto 0)
	);
	
END lightControl;

ARCHITECTURE RTL OF lightControl IS 

	SIGNAL int_stateA, int_stateB, int_stateC, int_stateD:STD_LOGIC;
	SIGNAL int_setCounter, int_setTimer:STD_LOGIC;
	SIGNAL int_counterExpired:STD_LOGIC;
	SIGNAL int_timerDone :STD_LOGIC;

component FSMcontrol
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
end component;

component countCompare
	PORT(
		i_clock:IN STD_LOGIC;
		i_setCounterM:IN STD_LOGIC;
		i_setCounterS:IN STD_LOGIC;
		i_SSCmax, i_MSCmax : IN STD_LOGIC_VECTOR(3 downto 0);
		i_select:IN STD_LOGIC;
		i_resetM, i_resetS: IN STD_LOGIC;
		o_counterExpired:OUT STD_LOGIC;
		o_currentCount, o_mainCounter, o_sideCounter: OUT STD_LOGIC_VECTOR(3 downto 0)
		);
end component;

component twobitTimer
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_done			: OUT	STD_LOGIC);
end component;
	

BEGIN 

myTimer: twobitTimer
	PORT MAP(
		i_resetBar => ((not i_Greset)or int_setTimer),
		i_load => int_setTimer,
		i_clock => i_GClock,
		o_done => int_timerDone
		);

myCountCompare: countCompare
	PORT MAP(
		i_clock => i_Gclock,
		i_setCounterM=> (int_stateA and (not int_counterExpired)) ,
		i_setCounters=> (int_stateC and (not int_counterExpired)),
		i_SSCmax => i_SSCmax,
		i_MSCmax => i_MSCmax,
		i_select => int_stateC,
		i_resetM => (i_Greset or int_stateB),
		i_resetS => (i_Greset or int_stateD),
		o_counterExpired => int_counterExpired,
		o_currentCount => o_currentCount,
		o_mainCounter => o_mainCounter,
		o_sideCounter => o_sideCounter
		);


aFSM: FSMcontrol
	PORT MAP(
		i_SignalTimer =>int_timerDone,
		i_CountExpired => int_counterExpired,
		i_SSCS => i_carSensor,
		i_reset => i_Greset,
		i_GClock => i_GClock,
		o_MY => o_MY,
		o_MG => o_MG,
		o_SY => o_SY,
		o_SG => o_SG,
		o_MR => o_MR, 
		o_SR => o_SR,
		
		o_stateA => int_stateA,
		o_stateB => int_stateB,
		o_stateC => int_stateC,
		o_stateD => int_stateD,
		
		o_setCounter => int_setCounter,
		o_setTimer => int_setTimer
		
		);

o_state(0) <= int_stateA;
o_state(1) <= int_stateB;
o_state(2) <= int_stateC;
o_state(3) <= int_stateD;

END RTL;

