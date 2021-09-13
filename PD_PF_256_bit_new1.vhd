
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity PD_PF_256_bit_new1 is
	 generic ( K : integer := 256);
    Port ( 
	        X1 : in  STD_LOGIC_vector(k-1 downto 0);
           Y1 : in  STD_LOGIC_vector(k-1 downto 0);
			  Z1 : in  STD_LOGIC_vector(k-1 downto 0);
           X3 : out  STD_LOGIC_vector(k-1 downto 0);
           Y3 : out  STD_LOGIC_vector(k-1 downto 0);
			  Z3 : out  STD_LOGIC_vector(k-1 downto 0);

			  clk  : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  start : in STD_LOGIC);
end PD_PF_256_bit_new1;

architecture Behavioral of PD_PF_256_bit_new1 is



signal  A1,A2,A3,S1,S2,S3,M1,M2,M3,M4,SQ1,SQ2,SQ3: STD_LOGIC_vector(k-1 downto 0);
signal d1, d2, d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13: STD_LOGIC;
signal l1, l2: STD_LOGIC;

component add_PF_256_bit_new1
  port (A: in STD_LOGIC_vector(k-1 downto 0);
		  B: in STD_LOGIC_vector(k-1 downto 0);
		  C: out STD_LOGIC_vector(k-1 downto 0);
		  clk  : in  STD_LOGIC;
        reset : in  STD_LOGIC;
		  start: in  STD_LOGIC;
		  done: out  STD_LOGIC);
end component;

component sub_PF_256_bit_new1
  port (A: in STD_LOGIC_vector(k-1 downto 0);
		  B: in STD_LOGIC_vector(k-1 downto 0);
		  C: out STD_LOGIC_vector(k-1 downto 0);
		  clk  : in  STD_LOGIC;
        reset: in  STD_LOGIC;
		  start: in  STD_LOGIC;
		  done: out  STD_LOGIC);
end component;

component mult_PF_256_bit_new1
  port (A: in STD_LOGIC_vector(k-1 downto 0);
		  B: in STD_LOGIC_vector(k-1 downto 0);
		  C: out STD_LOGIC_vector(k-1 downto 0);
		  clk  : in  STD_LOGIC;
        reset: in  STD_LOGIC;
		  start: in  STD_LOGIC;
		  done: out  STD_LOGIC);
end component;

component SQ_PF_256_bit_new1
  port (A: in STD_LOGIC_vector(k-1 downto 0);
		  C: out STD_LOGIC_vector(k-1 downto 0);
		  clk  : in  STD_LOGIC;
        reset: in  STD_LOGIC;
		  start: in  STD_LOGIC;
		  done: out  STD_LOGIC);
end component;

begin
----Level 1

MSQ1_PD : SQ_PF_256_bit_new1  port map (A=>Y1,  C=>SQ1, clk=>clk, reset=>reset, start=>start, done=>d1);
MSQ2_PD : SQ_PF_256_bit_new1  port map (A=>X1, C=>SQ2, clk=>clk, reset=>reset, start=>start, done=>d2);
MSQ3_PD : SQ_PF_256_bit_new1  port map (A=>Z1, C=>SQ3, clk=>clk, reset=>reset, start=>start, done=>d3);
MM1_PD : mult_PF_256_bit_new1  port map (A=>X1, B=>Y1, C=>M1, clk=>clk, reset=>reset,  start=>start,done=>d4);
l1<=d1 and d2 and d3 and d4;

----Level 2
MA1_PD : add_PF_256_bit_new1  port map (A=>SQ2, B=>SQ1, C=>A1, clk=>clk, reset=>reset, start=>l1);
MS1_PD : sub_PF_256_bit_new1  port map (A=>SQ2, B=>SQ1, C=>S1, clk=>clk, reset=>reset,  start=>l1);
MS2_PD : sub_PF_256_bit_new1  port map (A=>SQ1, B=>SQ2, C=>S2, clk=>clk, reset=>reset,  start=>l1,done=>d7);
MA2_PD : add_PF_256_bit_new1  port map (A=>SQ3, B=>SQ3, C=>A2, clk=>clk, reset=>reset, start=>l1,done=>d8);
MA3_PD : add_PF_256_bit_new1  port map (A=>M1, B=>M1, C=>A3, clk=>clk, reset=>reset, start=>l1);
l2<=d7 and d8 ;

----Level 3

MS3_PD : sub_PF_256_bit_new1  port map (A=>S2, B=>A2, C=>S3, clk=>clk, reset=>reset,  start=>l2,done=>d10);



----Level 4

MM2_PD : mult_PF_256_bit_new1  port map (A=>A1, B=>S1, C=>M2, clk=>clk, reset=>reset, start=>d10 );
MM3_PD : mult_PF_256_bit_new1  port map (A=>S2, B=>S3, C=>M3, clk=>clk, reset=>reset, start=>d10);
MM4_PD : mult_PF_256_bit_new1  port map (A=>A3, B=>S3, C=>M4, clk=>clk, reset=>reset, start=>d10);


control_PD_256_Jac:process( M2, M3, M4,d11,d12,d13)
begin	

			X3 <= M4;
			Y3 <= M2;
			Z3 <= M3;
			
end process;
end Behavioral;
