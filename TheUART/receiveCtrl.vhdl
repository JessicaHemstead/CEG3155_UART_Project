-- 8Bit counter
-- Jessica Hemstead
-- Used counter code from Rami 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY receiveCtrl IS
	PORT(
		i_RxD	: IN	STD_LOGIC;
		i_RDRF, i_OE, i_FE:IN STD_LOGIC;
		o_RDRF, o_OE, o_FE:OUT STD_LOGIC;
		i_BClkx8 :IN STD_LOGIC;
		i_resetBar:IN STD_LOGIC;
		o_shiftRSR: OUT STD_LOGIC;
		o_loadRDR:OUT STD_LOGIC);
		
END receiveCtrl;

ARCHITECTURE rtl OF receiveCtrl IS
	SIGNAL int_x0, int_x1: STD_LOGIC;
	SIGNAL int_y2, int_ny2, int_y1, int_ny1, int_y0, int_ny0: STD_LOGIC;
	SIGNAL int_countStart, int_countEnd :STD_LOGIC;
	SIGNAL int_counter : STD_LOGIC_VECTOR(2 downto 0);

	COMPONENT counter3
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			o_Value			: OUT	STD_LOGIC_VECTOR(2 downto 0));
	END COMPONENT;
	
COMPONENT threeBitmux
		PORT(
		i_op:IN STD_LOGIC_VECTOR(7 downto 0);
		i_sel: IN STD_LOGIC_VECTOR(2 downto 0);
		o_choice:OUT STD_LOGIC);
	END COMPONENT;
	
COMPONENT enARdFF_2
	PORT(
			i_resetBar	: IN	STD_LOGIC;
			i_d		: IN	STD_LOGIC;
			i_enable	: IN	STD_LOGIC;
			i_clock		: IN	STD_LOGIC;
			o_q, o_qBar	: OUT	STD_LOGIC);
END component;
	

BEGIN

int_x0 <= ((((int_ny2 and int_ny1) and int_ny0) and (not i_RxD)) or (int_ny2 and int_ny1 and int_y0 and int_countStart) or (int_ny2 and int_y1 and int_ny0 and int_countEnd)or(int_ny2 and int_y1 and int_y0 and i_RxD));
int_x1 <= (i_FE or i_OE);

int_countEnd <= (int_counter(0) and int_counter(1) and int_counter(2));
int_countStart <= (int_counter(0) or int_counter(1) or int_counter(2));

o_RDRF <= (int_ny2 and int_y1 and int_y0);

y2: enARdFF_2
	PORT MAP(
		i_resetBar => i_resetBar,
		i_d => int_x1,
		i_enable => '1',
		i_clock => i_BClkx8,
		o_q => int_y2,
		o_qBar => int_ny2
		);

y1: enARdFF_2
	PORT MAP(
		i_resetBar => i_resetBar,
		i_d => ((int_ny1 and int_y0)or((not int_x1) and int_y1 and int_ny0) or ((not int_x1) and (not int_x0) and int_y1)),
		i_enable => '1',
		i_clock => i_BClkx8,
		o_q => int_y1,
		o_qBar => int_ny1
		);
	
y0: enARdFF_2
	PORT MAP(
		i_resetBar => i_resetBar,
		i_d => (((not int_x0)and int_ny2 and int_ny1 and int_ny0) or ((not int_x0) and int_y1 and int_y0)or ((not int_x1) and int_x0 and int_y1 and int_ny0)),
		i_enable => '1',
		i_clock => i_BClkx8,
		o_q => int_y0,
		o_qBar => int_ny0
		);
		
c0: counter3
	PORT MAP(
			i_resetBar => (int_ny2 and int_ny1 and int_ny0),
			i_load => '1',	
			i_clock => i_BClkx8,
			o_Value => int_counter);
	
END rtl;