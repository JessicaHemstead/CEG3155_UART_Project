library ieee;
USE ieee.std_logic_1164.ALL;

ENTITY trafficLightController IS 
	PORT(
	i_Gclock:IN STD_LOGIC;
	i_SSCS:IN STD_LOGIC;
	i_MSC, i_SSC:IN STD_LOGIC_VECTOR(3 downto 0);
	i_Greset:IN STD_LOGIC;
	o_carSwitch:OUT STD_LOGIC;
	o_MSTL, o_SSTL: OUT STD_LOGIC_VECTOR(2 downto 0);
	o_state : OUT STD_LOGIC_VECTOR(3 downto 0);
	o_BCD1,o_BCD2: OUT STD_LOGIC_VECTOR(6 downto 0)
	);
	
END trafficLightController;

ARCHITECTURE RTL OF trafficLightController IS 

	SIGNAL int_Gclock, int_SSCS: STD_LOGIC;
	SIGNAL int_MG, int_MY, int_MR, int_SG, int_SY, int_SR :STD_LOGIC;
	SIGNAL int_currentCount: STD_LOGIC_VECTOR(3 downto 0);

component lightControl
	PORT(
	i_Gclock:IN STD_LOGIC;
	i_carSensor:IN STD_LOGIC;
	i_SSCmax, i_MSCmax:IN STD_LOGIC_VECTOR(3 downto 0);
	i_Greset:IN STD_LOGIC;
	o_MY, o_MG, o_SY, o_SG, o_MR, o_SR: OUT STD_LOGIC;
	o_state : OUT STD_LOGIC_VECTOR(3 downto 0);
	o_currentCount, o_mainCounter, o_sideCounter: OUT STD_LOGIC_VECTOR(3 downto 0)
	);
end component;

component debouncer_2
	PORT(
		i_resetBar		: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_raw				: IN	STD_LOGIC;
		o_clean			: OUT	STD_LOGIC);
end component;

component clk_div
	PORT(
		clock_25Mhz				: IN	STD_LOGIC;
		clock_1MHz				: OUT	STD_LOGIC;
		clock_100KHz			: OUT	STD_LOGIC;
		clock_10KHz				: OUT	STD_LOGIC;
		clock_1KHz				: OUT	STD_LOGIC;
		clock_100Hz				: OUT	STD_LOGIC;
		clock_10Hz				: OUT	STD_LOGIC;
		clock_1Hz				: OUT	STD_LOGIC);
end component;

component DECBCD
	PORT(i_Digit	: IN STD_LOGIC_VECTOR(3 downto 0);
	     o_seg_a1, o_seg_b1, o_seg_c1, o_seg_d1, o_seg_e1, o_seg_f1, o_seg_g1 : OUT STD_LOGIC;
		  o_seg_a2, o_seg_b2, o_seg_c2, o_seg_d2, o_seg_e2, o_seg_f2, o_seg_g2 : OUT STD_LOGIC);
end component;
	
BEGIN 

aclock: clk_div
	PORT MAP(
		clock_25Mhz => i_Gclock,
		clock_1MHz => int_Gclock
		);

adebouncer: debouncer_2
	PORT MAP(
		i_resetBar => not i_Greset,
		i_clock => int_Gclock, --int_Gclock
		i_raw => i_SSCS,
		o_clean => int_SSCS
		);

TLC: lightControl
	PORT MAP(
		i_Gclock => int_Gclock, --int_Gclock
		i_carSensor => int_SSCS,
		i_SSCmax => i_SSC,
		i_MSCmax => i_MSC,
		i_Greset => i_Greset,
		o_MY => int_MY,
		o_MG => int_MG,
		o_SY => int_SY,
		o_SG => int_SG,
		o_MR => int_MR,
		o_SR => int_SR,
		o_state => o_state,
		o_currentCount => int_currentCount
		);
		

myBCD: DECBCD
			PORT MAP(
				i_Digit => int_currentCount,
				o_seg_a1 => o_BCD1(0),
				o_seg_b1 => o_BCD1(1),
				o_seg_c1 => o_BCD1(2),
				o_seg_d1 => o_BCD1(3),
				o_seg_e1 => o_BCD1(4),
				o_seg_f1 => o_BCD1(5),
				o_seg_g1 => o_BCD1(6),
				
				o_seg_a2 => o_BCD2(0),
				o_seg_b2 => o_BCD2(1),
				o_seg_c2 => o_BCD2(2),
				o_seg_d2 => o_BCD2(3),
				o_seg_e2 => o_BCD2(4),
				o_seg_f2 => o_BCD2(5),
				o_seg_g2 => o_BCD2(6)
				);
	
		
	o_MSTL(0) <= int_MG;
	o_MSTL(1) <= int_MY;
	o_MSTL(2) <= int_MR;
	
	o_SSTL(0) <= int_SG;
	o_SSTL(1) <= int_SY;
	o_SSTL(2) <= int_SR;
	
	o_carSwitch <= int_SSCS;
	
		

END RTL;


