-- BCD sev seg dec display
-----------------------------------------------------------
-- a1 = B'D' + A'C + BD + AC'
-- b1 = B' + C'D' + AC' + AD' + A'CD
-- c1 = D + A'C' + BC + AB'
-- d1 = B'D' + AC' + A'B'C + A'CD' + BC'D + ABD
-- e1 = B'D' + A'CD' + AC'D'
-- f1 = A'C'D' + A'BC' + A'BD' + AB'C' + AB'D' + ABC
-- g1 = BC' + BD' + AC' + AB + A'B'C
-----------------------------------------------------------
-- a2 = A' + B'C'
-- b2 = 1
-- c2 = 1
-- d2 = A' + B'C'
-- e2 = A' + B'C'
-- f2 = A' + B'C'
-- g2 = 0
-----------------------------------------------------------
library ieee;
use  ieee.std_logic_1164.all;

ENTITY DECBCD IS
	PORT(i_Digit	: IN STD_LOGIC_VECTOR(3 downto 0);
	     o_seg_a1, o_seg_b1, o_seg_c1, o_seg_d1, o_seg_e1, o_seg_f1, o_seg_g1 : OUT STD_LOGIC;
		  o_seg_a2, o_seg_b2, o_seg_c2, o_seg_d2, o_seg_e2, o_seg_f2, o_seg_g2 : OUT STD_LOGIC);
END DECBCD;

ARCHITECTURE rtl OF DECBCD IS

	SIGNAL int_A, int_B, int_C, int_D: Std_LOGIC;
	SIGNAL int_An, int_Bn, int_Cn, int_Dn: Std_LOGIC;
	
BEGIN

int_A <= i_digit(3);
int_B <= i_digit(2);
int_C <= i_digit(1);
int_D <= i_digit(0);
int_An <= not i_digit(3);
int_Bn <= not i_digit(2);
int_Cn <= not i_digit(1);
int_Dn <= not i_digit(0);

o_seg_a1 <= (not (((int_Bn and int_Dn) or (int_An and int_C)) or ((int_B and int_D) or (int_A and int_Cn))));
o_seg_b1 <= (not (int_Bn or (((int_Cn and int_Dn) or (int_A and int_Cn)) or ((int_A and int_Dn) or (int_An and (int_C and int_D))))));
o_seg_c1 <= (not (int_D or ((int_An) and (int_Cn)) or (int_B and int_C) or (int_A and ( int_Bn))));
o_seg_d1 <= (not ((((int_Bn and int_Dn)or (int_A and int_Cn)) or ((int_An and int_Bn) and int_C)) or ((((int_An and int_C) and int_Dn) or ((int_B and int_Cn) and int_D)) or ((int_A and int_B) and int_D))));
o_seg_e1 <= (not (((int_Bn) and (int_Dn)) or ((int_An) and int_C and (int_Dn)) or (int_A and (int_Cn) and (int_Dn))));
o_seg_f1 <= (not (((int_An) and (int_Cn) and (int_Dn)) or ((int_An) and int_B and (int_Cn)) or ((int_An) and int_B and (int_Dn)) or (int_A and (int_Bn) and (int_Cn)) or (int_A and (int_Bn) and (int_Dn)) or (int_A and int_B and int_C)));
o_seg_g1 <= (not ((int_B and (int_Cn)) or (int_B and (int_Dn)) or (int_A and (int_Cn)) or (int_A and int_B) or ((int_An) and (int_Bn) and int_C)));


o_seg_a2 <= (not ((int_An) or ((int_Bn)and(int_Cn))));
o_seg_b2 <= '0';
o_seg_c2 <= '0';
o_seg_d2 <= (not ((int_An) or ((int_Bn)and(int_Cn))));
o_seg_e2 <= (not ((int_An) or ((int_Bn)and(int_Cn))));
o_seg_f2 <= (not ((int_An) or ((int_Bn)and(int_Cn))));
o_seg_g2 <= '1';
END RTL;