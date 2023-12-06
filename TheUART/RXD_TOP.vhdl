LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RXD_TOP IS
	PORT(
	i_clock	:IN STD_LOGIC;
	i_RXD		:IN STD_LOGIC;
	i_RDRF	:IN STD_logic;
	i_OE		:IN STD_LOGIC;		
	i_FE		:IN STD_LOGIC;
	i_load	:IN STD_LOGIC;
	o_OE		:OUT STD_LOGIC;
	o_FE		:OUT STD_LOGIC;		
	o_RDRF	:OUT STD_LOGIC;
	o_data	:OUT STD_LOGIC_VECTOR (7 downto 0)
	);
END RXD_TOP;

ARCHITECTURE rtl OF RXD_TOP IS

SIGNAL int_data : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL int_OE, int_FE, int_RDRF: STD_LOGIC;
SIGNAL int_loadRDR, int_shiftRSR : STD_LOGIC;

COMPONENT serialToParallelReg8
	PORT(
		i_clear, i_RClk	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_data: IN STD_LOGIC;
		o_Q			: OUT	STD_LOGIC_VECTOR(7 downto 0);
		o_Value :OUT STD_LOGIC_VECTOR(7 downto 0));
END COMPONENT;

COMPONENT reg8
	PORT(
		i_resetBar, i_load	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
		o_Value			: OUT	STD_LOGIC_vector (7 downto 0)
		);
END COMPONENT;

COMPONENT receiveCtrl
	PORT(
		i_RxD	: IN	STD_LOGIC;
		i_RDRF, i_OE, i_FE:IN STD_LOGIC;
		o_RDRF, o_OE, o_FE:OUT STD_LOGIC;
		i_BClkx8 :IN STD_LOGIC;
		i_resetBar:IN STD_LOGIC;
		o_shiftRSR: OUT STD_LOGIC;
		o_loadRDR:OUT STD_LOGIC
		);
END COMPONENT;

BEGIN

RSR : serialToParallelReg8
	PORT MAP(
		i_clear => '1', 
		i_RClk => i_clock,
		i_clock => int_shiftRSR,
		i_data => i_rXD,
		o_Q => int_data,
		o_Value => int_data
		);

RDR 	:reg8
	PORT MAP(
		i_resetBar => '1', 
		i_load => int_loadRDR,
		i_clock => i_clock,
		i_Value => int_data,
		o_Value => o_data
		);

RXC	:receiveCtrl
	PORT MAP(
		i_RxD => i_RXD,
		i_RDRF => int_RDRF,
		o_RDRF => int_RDRF, 
		i_OE => int_OE,
		o_OE => int_OE,
		i_FE => int_FE,
		o_FE => int_FE,
		i_BClkx8 => i_clock,
		i_resetBar => '1',
		o_shiftRSR => int_shiftRSR,
		o_loadRDR => int_loadRDR
		);
		
-- input --
int_loadRDR <= i_load;
END rtl;