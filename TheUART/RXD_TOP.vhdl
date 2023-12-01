LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY RXD_TOP IS
	PORT(
	i_clock	:IN STD_LOGIC;
	i_RXD		:IN STD_LOGIC;
	i_RDRF	:IN STD_logic;
	i_OE		:IN STD_LOGIC;		
	i_FE		:IN STD_LOGIC;
	o_OE		:OUT STD_LOGIC;
	o_FE		:OUT STD_LOGIC;		
	o_RDRF	:OUT STD_LOGIC;
	o_data	:OUT STD_LOGIC_VECTOR (7 downto 0);
	);
END RXD_TOP;

ARCHITECTURE rtl OF RXD_TOP

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
		io_RDRF, io_OE, io_FE:INOUT STD_LOGIC;
		i_BClkx8 :IN STD_LOGIC;
		i_resetBar:IN STD_LOGIC;
		o_shiftRSR: OUT STD_LOGIC;
		o_loadRDR:OUT STD_LOGIC
		);
END COMPONENT;

BEGIN

serialToParallelReg8
	PORT MAP(
		i_clear, 
		i_RClk,
		i_clock,
		i_data,
		o_Q,
		o_Value,
		);

RDR 	:reg8
	PORT MAP(
		i_resetBar, 
		i_load,
		i_clock,
		i_Value,
		o_Value
		);

RXC	:receiveCtrl
	PORT MAP(
		i_RxD,
		io_RDRF, 
		io_OE,
		io_FE,
		i_BClkx8,
		i_resetBar,
		o_shiftRSR,
		o_loadRDR,
		);
END rtl;