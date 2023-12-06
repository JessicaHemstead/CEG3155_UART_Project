

library ieee;
USE ieee.std_logic_1164.ALL;

ENTITY countCompare IS 
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
	
END countCompare;

ARCHITECTURE RTL OF countCompare IS 

	SIGNAL int_SSCounter, int_MSCounter: STD_LOGIC_VECTOR(3 downto 0); 
	SIGNAL int_currentCount, int_maxCount: STD_LOGIC_VECTOR(3 downto 0);
	

component fourBitmux2to1
	PORT(
		i_op0:IN STD_LOGIC_VECTOR(3 downto 0);
		i_op1:IN STD_LOGIC_VECTOR(3 downto 0);
		i_selection: IN STD_LOGIC;
		o_choice:OUT STD_LOGIC_VECTOR(3 downto 0));
end component;

component fourBitComparator
	PORT(
		i_Ai, i_Bi: IN	STD_LOGIC_VECTOR(3 downto 0);
		o_GT, o_LT, o_EQ: OUT	STD_LOGIC);
end component;

component fourbitcounter
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_Value			: OUT	STD_LOGIC_VECTOR(3 downto 0));
end component;

BEGIN 

SScounter: fourbitcounter
	PORT MAP(
		i_clock => i_clock,
		i_resetBar => not i_resetS,
		i_load => i_setCounterS,
		o_Value => int_SSCounter
		);
		
MScounter: fourbitcounter
	PORT MAP(
		i_clock => i_clock,
		i_resetBar => not i_resetM,
		i_load => i_setCounterM,
		o_Value => int_MSCounter
		);
		
countMux: fourBitmux2to1
	PORT MAP(
		i_op0 => int_MSCounter,
		i_op1 => int_SSCounter,
		i_selection => i_select,
		o_choice => int_currentCount
		);

maxValMux: fourBitmux2to1
	PORT MAP(
		i_op0 => i_MSCmax,
		i_op1 => i_SSCmax,
		i_selection => i_select,
		o_choice => int_maxCount
		);

acomparator: fourBitComparator
	PORT MAP(
		i_Ai => int_currentCount,
		i_Bi => int_maxCount,
		o_EQ => o_counterExpired
		);

	o_CurrentCount <= int_currentCount;
	o_sideCounter <=int_SSCounter;
	o_mainCounter <= int_MSCounter;


END RTL;


