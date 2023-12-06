-- 6Bit counter with IRQ
-- Jessica Hemstead
-- Used counter code from Rami 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY addressDecoder IS
	PORT(
		i_address	: IN	STD_LOGIC_VECTOR(1 downto 0);
		i_RW:IN STD_LOGIC;
		
		o_RDRtoDB		: OUT	STD_LOGIC;
		o_DBtoTDR : OUT	STD_LOGIC;
		o_SCSRtoDB : OUT	STD_LOGIC;
		o_ZtoDB : OUT	STD_LOGIC;
		o_SCCRtoDB : OUT	STD_LOGIC;
		o_DBtoSCCR : OUT	STD_LOGIC);
END addressDecoder;

ARCHITECTURE rtl OF addressDecoder IS
	
BEGIN

		o_RDRtoDB  <= ((not i_address(1)) and (not i_address(0)) and i_RW);
		o_DBtoTDR  <= ((not i_address(1)) and (not i_address(0)) and (not i_RW));
		o_SCSRtoDB <= ((not i_address(1)) and (i_address(0)) and i_RW);
		o_ZtoDB    <= ((not i_address(1)) and (i_address(0)) and (not i_RW));
		o_SCCRtoDB <= (i_address(1)  and i_RW);
		o_DBtoSCCR <= (i_address(1)  and (not i_RW));


	
END rtl;