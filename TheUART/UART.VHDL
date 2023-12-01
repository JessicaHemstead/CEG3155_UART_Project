LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UART IS
	PORT(
	i_select :IN STD_logic;
	i_data	:IN STD_logic_VECTOR (7 downto 0);
	i_Addr	:IN STD_logic_VECTOR (7 downto 0);
	i_rw		:IN STD_logic;
	i_RXD		:IN STD_logic;
	i_Gclock	:IN STD_logic;
	o_IRQ		:OUT STD_logic;
	o_data	:OUT STD_logic_VECTOR (7 downto 0);
	o_TXD		:OUT STD_logic;
		);
END UART;

ARCHITECTURE rtl OF UART IS
	SIGNAL 
	

	COMPONENT RXD_TOP
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
	END COMPONENT;
	
	COMPONENT SCSR 
		PORT(
		i_TDRE, i_RDRF, i_OE, i_FE	:STD_LOGIC;
		i_Gclock							:STD_LOGIC;
		o_TDRE, o_RDRF, o_OE, o_FE	:STD_LOGIC;
		o_data							:STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;

	
	COMPONENT myBaud
		PORT(
			i_resetBar, i_load	: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_sel :IN STD_LOGIC_VECTOR(2 downto 0);
			o_BClk, o_BClkx8	: OUT	STD_LOGIC);
	END COMPONENT;
	
	COMPONENT TXD_TOP
		PORT(
			i_resetBar, i_load, i_TDRE: IN	STD_LOGIC;
			i_clock			: IN	STD_LOGIC;
			i_Value			: IN	STD_LOGIC_VECTOR(7 downto 0);
			o_Value			: OUT	STD_LOGIC;
			o_regVal			:OUT STD_LOGIC_VECTOR(7 downto 0)
			);
	END COMPONENT;
		
	COMPONENT SCCR
		PORT(
			i_Value			: IN	STD_LOGIC_VECTOR (7 downto 0);
			i_clock, i_resetBar	: IN	STD_LOGIC;
			o_load			: IN	STD_LOGIC;
			o_TIE, o_RIE		: OUT	STD_LOGIC;
			o_SE			: OUT 	STD_LOGIC_VECTOR(2 downto 0);
			);
	END COMPONENT;
	
	
BEGIN 
	RECEIVER	 :RXD_TOP
		PORT MAP(
		i_clock,
		i_RXD,
		i_RDRF,
		i_OE,	
		i_FE,
		o_OE,
		o_FE,
		o_RDRF,
		o_data
		);
	
	SCSRreg	:SCSR 
		PORT MAP(
		i_TDRE, 
		i_RDRF, 
		i_OE, 
		i_FE,
		i_Gclock,
		o_TDRE, 
		o_RDRF, 
		o_OE, 
		o_FE,
		o_data
		);

	BAUDgen	:myBaud
		PORT MAP(
			i_resetBar, 
			i_load,
			i_clock,
			i_sel,
			o_BClk,
			o_BClkx8
			);
		
	transmitter	: TXD_TOP
		PORT MAP(
			i_resetBar,
			i_load,
			i_TDRE,
			i_clockIN,
			i_Value,
			o_Value,
			o_regVal,
			);
		
	SCCRreg : SCCR
		PORT MAP(
			i_Value,
			i_clock,
			i_resetBar,
			o_load,
			o_TIE,
			o_RIE,
			o_SE
			);
	
END rtl;