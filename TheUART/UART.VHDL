LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY UART IS
	PORT(
	i_select :IN STD_logic;
	i_data	:IN STD_logic_VECTOR (7 downto 0);
	i_Addr	:IN STD_logic_VECTOR (1 downto 0);
	i_rw		:IN STD_logic;
	i_RXD		:IN STD_logic;
	i_Gclock	:IN STD_logic;
	o_IRQ		:OUT STD_logic;
	o_data	:OUT STD_logic_VECTOR (7 downto 0);
	o_TXD		:OUT STD_logic
		);
END UART;

ARCHITECTURE rtl OF UART IS 

SIGNAL int_data,int_dataSCCR,int_dataRXD, int_DataVAL, int_dataTXD : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL int_sel : STD_LOGIC_VECTOR (2 downto 0);
SIGNAL int_BClk, int_BClkx8, int_dataaddr : STD_LOGIC;
SIGNAL int_DBtoTDR, int_RDRtoDB, int_SCSRtoDB, int_SCCRtoDB : STD_LOGIC;
SIGNAL int_RDRF, int_TDRE, int_FE, int_OE : STD_LOGIC;

	COMPONENT addressDecoder
		PORT(
			i_address	: IN	STD_LOGIC_VECTOR(1 downto 0);
			i_RW:IN STD_LOGIC;
			
			o_RDRtoDB		: OUT	STD_LOGIC;
			o_DBtoTDR : OUT	STD_LOGIC;
			o_SCSRtoDB : OUT	STD_LOGIC;
			o_ZtoDB : OUT	STD_LOGIC;
			o_SCCRtoDB : OUT	STD_LOGIC;
			o_DBtoSCCR : OUT	STD_LOGIC);
	END COMPONENT;
	
	COMPONENT RXD_TOP
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
	END COMPONENT;
	
	COMPONENT SCSR 
		PORT(
		i_TDRE, i_RDRF, i_OE, i_FE	:IN STD_LOGIC;
		i_Gclock							:IN STD_LOGIC;
		i_load							:IN STD_LOGIC;
		o_TDRE, o_RDRF, o_OE, o_FE	:OUT STD_LOGIC;
		o_data							:OUT STD_LOGIC_VECTOR (7 downto 0)
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
			i_load			: IN	STD_LOGIC;
			o_TIE, o_RIE		: OUT	STD_LOGIC;
			o_SE			: OUT 	STD_LOGIC_VECTOR(2 downto 0)
			);
	END COMPONENT;
	
	
BEGIN 

	ADDR: addressDecoder
		PORT MAP(
			i_address => i_addr,
			i_RW => i_RW,
			o_RDRtoDB => int_RDRtoDB,
			o_DBtoTDR => int_DBtoTDR,
			o_SCSRtoDB => int_SCSRtoDB,
			o_ZtoDB => int_dataaddr,
			o_SCCRtoDB => int_SCCRtoDB,
			o_DBtoSCCR => int_SCCRtoDB
			);

	RECEIVER	 :RXD_TOP
		PORT MAP(
		i_clock => int_BClkx8,
		i_RXD => i_RXD,
		i_RDRF => int_RDRF,
		i_OE => int_OE,	
		i_FE => int_FE,
		i_load => int_RDRtoDB,
		o_OE => int_OE,
		o_FE => int_FE,
		o_RDRF => int_RDRF,
		o_data => int_dataRXD
		);
	
	SCSRreg	:SCSR 
		PORT MAP(
		i_TDRE => int_TDRE, 
		i_RDRF => int_RDRF, 
		i_OE => int_OE, 
		i_FE => int_FE,
		i_Gclock => i_Gclock,
		i_load => int_SCSRtoDB,
		o_TDRE => int_TDRE, 
		o_RDRF => int_RDRF, 
		o_OE => int_OE, 
		o_FE => int_FE,
		o_data => int_data
		);

	BAUDgen	:myBaud
		PORT MAP(
			i_resetBar => '1', 
			i_load => '1',
			i_clock => i_Gclock,
			i_sel => int_sel,
			o_BClk => int_BClk,
			o_BClkx8 => int_BClkx8
			);
		
	transmitter	: TXD_TOP
		PORT MAP(
			i_resetBar => '1',
			i_load => int_DBtoTDR,
			i_TDRE => int_TDRE,
			i_clock => int_BClk,
			i_Value => int_dataTXD,
			o_Value => o_TXD,
			o_regVal => int_dataVAL
			);
		
	SCCRreg : SCCR
		PORT MAP(
			i_Value => int_dataSCCR,
			i_clock => i_Gclock,
			i_resetBar => '1', 
			i_load => int_SCCRtoDB,

			o_SE => int_sel
			);
	
END rtl;