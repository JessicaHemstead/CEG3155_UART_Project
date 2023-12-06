library ieee;
USE ieee.std_logic_1164.ALL;

ENTITY FSM IS 
	PORT(
	i_x: IN STD_LOGIC;
	i_GClock: IN STD_LOGIC;
	o_MY, o_MG, o_SY, o_SG, o_MR, o_SR: OUT STD_LOGIC
	);
	
END FSM;

ARCHITECTURE RTL OF FSM IS 

SIGNAL int_Y1, int_Y0: STD_lOGIC;
SIGNAL int_Y10, int_Y11, int_Y12: STD_lOGIC;
SIGNAL int_Y00, int_Y01: STD_lOGIC;
SIGNAL int_MY, int_MG, int_SY, int_SG, int_SR, int_MR: STD_LOGIC;

component dFF_2
	PORT(
		i_d	: IN	STD_LOGIC;
		i_clock			: IN	STD_LOGIC;
		o_q, o_qBar		: OUT	STD_LOGIC);
end component;
	
BEGIN 
	mainStreet : DFF_2
	port map (
		i_d => int_Y1,
		i_clock => i_gClock,
		o_q => int_MR,
		o_qBar => int_SR
		);
	
	sideStreet : DFF_2
	port map (
		i_d => int_Y0,
		i_clock => i_gClock,
		o_q => int_SY,
		o_qBar => int_MG
		);
--input

int_Y1 <= (int_Y10 or int_Y11 or int_Y12);
int_Y10 <= (not i_x and int_MR );
int_Y11 <= (int_MR and int_MG);
int_Y12 <= (i_x and int_SR and int_SY);

int_Y0 <= (int_Y00 or int_Y01);
int_Y00 <= (int_MG and i_x);
int_Y01 <= (not i_x and int_SY);


--outputs 

o_MY <= int_SR and int_SY;
o_MG <= int_SR and int_MG;
o_MR <= int_MR;
o_SY <= int_SY and int_MR;
o_SG <= int_MG and int_MR;
o_SR <= int_SR;

END RTL;


