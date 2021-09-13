
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mult_PF_256_bit_new1 is
	 generic ( k : integer := 256);
    Port ( A : in  std_logic_vector(k-1 downto 0);
           B : in  std_logic_vector(k-1 downto 0);
           C : out  std_logic_vector(k-1 downto 0);
           CLK : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  start: in  STD_LOGIC;
			  done : out  STD_LOGIC
			  );
end mult_PF_256_bit_new1;

architecture Behavioral of mult_PF_256_bit_new1 is
constant P: std_logic_vector(k downto 0):='0'&x"7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFED"; --for 256 bit
constant P2: std_logic_vector(k downto 0):='0'&x"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDA"; --for 256 bit

signal sel: std_logic_vector(1 downto 0);
signal temp1: std_logic_vector(k downto 0);


signal temp2,prod,prod1, prod2, prod3,prod4: std_logic_vector(k downto 0);

signal first: std_logic;
 
begin
 with temp1(k) select
		prod1 <= prod + temp2 when '1',
		         prod when others;

				
prod2<=prod1-P;
prod3<=prod1-P2;
sel<=prod3(k)&prod2(k);
with sel select
		prod4 <= prod1  when "11",
					prod1-P when "10",
					prod1-P2 when others;
 

 
process(CLK, reset, start)

begin
	if reset = '1' then
		done <= '0';
		first<='1';
		prod<=(others => '0');

--		   C <= x"0000000000000000000000000000000000000000000000000000000000000000";

		 
	elsif (CLK'event and CLK = '1' and start= '1')  then
		if first = '1' then
		
							temp1 <= B&'1';

			temp2<='0'&A;

		
			first <= '0';
		else
			
           if temp1( k-1 downto 0)=x"8000000000000000000000000000000000000000000000000000000000000000" then
			   C <= prod4( k-1 downto 0);	
				done <= '1';
  


           else
           prod <= prod4(k-1 downto 0) & '0';
           temp1 <= temp1(k-1 downto 0) & '0';

			end if;
		end if;
	end if;
end process;
end Behavioral;


