
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ECC_PM_PF_256_bit_new1 is
	 generic ( k : integer := 256);
    Port ( 
           key : in  std_logic_vector(k-1 downto 0);
           QX : out  std_logic_vector(k-1 downto 0);
           QY : out  std_logic_vector(k-1 downto 0);
			  QZ : out  std_logic_vector(k-1 downto 0);
			  done : out  std_logic;

			  CLK : in  std_logic;
		
			  reset : in  std_logic);
end ECC_PM_PF_256_bit_new1;


architecture Behavioral of ECC_PM_PF_256_bit_new1 is


signal DX1,DX2,DY1,DY2,DZ1,DZ2,AX1,AX2,AX3,AY1,AY2,AY3,AZ1,AZ2,AZ3 : std_logic_vector(k-1 downto 0);


signal  count: integer range 0 to k;
signal  done1, done2: std_logic; 
signal  start1, reset1: std_logic; 
signal  first, check: std_logic; 

component PD_PF_256_bit_new1
    Port ( X1 : in STD_LOGIC_vector(k-1 downto 0);
           Y1 : in  STD_LOGIC_vector(k-1 downto 0);
			  Z1 : in  STD_LOGIC_vector(k-1 downto 0);
           X3 : out  STD_LOGIC_vector(k-1 downto 0);
           Y3 : out  STD_LOGIC_vector(k-1 downto 0);
			  Z3 : out STD_LOGIC_vector(k-1 downto 0);
			  CLK  : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  start : in STD_LOGIC);
end component;
--component Reg_PDPA_new 
--    generic (k : integer := 256);
--    Port ( D : in  STD_LOGIC_VECTOR (k-1 downto 0);
--           clk, reset : in  STD_LOGIC;
--			  start: in std_logic;
--			  done : out std_logic;
--           Q : out  STD_LOGIC_VECTOR (k-1 downto 0));
--end component;

component PA_PF_256_bit_new1
    Port ( X1 : in STD_LOGIC_vector(k-1 downto 0);
           Y1 : in  STD_LOGIC_vector(k-1 downto 0);
			  Z1 : in  STD_LOGIC_vector(k-1 downto 0);
			  X2 : in STD_LOGIC_vector(k-1 downto 0);
           Y2 : in  STD_LOGIC_vector(k-1 downto 0);
			  Z2 : in  STD_LOGIC_vector(k-1 downto 0);
           X3 : out  STD_LOGIC_vector(k-1 downto 0);
           Y3 : out  STD_LOGIC_vector(k-1 downto 0);
			  Z3 : out  STD_LOGIC_vector(k-1 downto 0);
			  CLK  : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  done : out STD_LOGIC;
			  start : in STD_LOGIC);
end component;
constant PX : std_logic_vector(255 downto 0):= x"216936D3CD6E53FEC0A4E231FDD6DC5C692CC7609525A7B2C9562D608F25D51A";
constant PY : std_logic_vector(255 downto 0):= x"6666666666666666666666666666666666666666666666666666666666666658";
constant PZ : std_logic_vector(255 downto 0):= x"0000000000000000000000000000000000000000000000000000000000000001";
constant PX2 : std_logic_vector(255 downto 0):= x"4EDBE2246583DAB515DDB478484F06F677913E22058E9DA4854579B3E7CFF596";
constant PY2 : std_logic_vector(255 downto 0):= x"4CDB67B39336CC2496487D03C536AE09F5B85599D441CDE36DB4D326A1D28016";
constant PZ2 : std_logic_vector(255 downto 0):= x"16793A8694A883A8BF672E05C4BD9D6D142C9EFFCC6D662E9C8B56C2FD872182";

begin
PD_PF_256_Jac : PD_PF_256_bit_new1 port map (X1=>DX1, Y1=>DY1, Z1 => DZ1, X3=>DX2, Y3=>DY2, Z3 => DZ2, CLK=>CLK, reset=>reset1,  start=>start1);
PA_PF_256_Jac : PA_PF_256_bit_new1 port map (X1=>AX1, Y1=>AY1, Z1 => AZ1, X2=>AX2, Y2=>AY2, Z2 => AZ2, X3=>AX3, Y3=>AY3, Z3 => AZ3, CLK=>CLK, reset=>reset1, done=>done1, start=>start1);

--R1Q_PD : Reg_PDPA_new generic map(k=>256)  port map (D=>Q2X, Q=>QQ2X, clk=>clk, reset=>reset, start=>done1,done=>d1);
--R2Q_PD : Reg_PDPA_new generic map(k=>256)  port map (D=>Q2Y, Q=>QQ2Y, clk=>clk, reset=>reset, start=>done1,done=>d2);
--R3Q_PD : Reg_PDPA_new generic map(k=>256)  port map (D=>Q2Z, Q=>QQ2Z, clk=>clk, reset=>reset, start=>done1,done=>d3);

--R1Q_PD : Reg_PDPA_new generic map(k=>256)  port map (D=>Q2pX, Q=>QQX, clk=>clk, reset=>reset, start=>done2,done=>d1);
--R2Q_PD : Reg_PDPA_new generic map(k=>256)  port map (D=>Q2pY, Q=>QQY, clk=>clk, reset=>reset, start=>done2,done=>d2);
--R3Q_PD : Reg_PDPA_new generic map(k=>256)  port map (D=>Q2pZ, Q=>QQZ, clk=>clk, reset=>reset, start=>done2,done=>d3);
control_unit: process (CLK, reset,reset1)
begin

if (reset = '1') then
	count <= k;

    done<= '0';
	check <= '1';




elsif(reset1 = '1') then
	reset1 <= '0';



	done2 <= '0';


	
elsif (CLK'event and CLK = '1') then

if(done2 = '0' ) then
                  if(check = '1') then
--                   if (key(count-1)='1') then
						 if(key(count-2) = '1') then	
			
	                        DX1 <= PX2;
	                        DY1 <= PY2;
	                        DZ1 <= PZ2;
									
							  else		 

		                     DX1 <= PX;
	                         DY1 <= PY;
	                         DZ1 <= PZ;
	                      end if;
							 AX1 <= PX;
	                         AY1 <= PY;
	                         AZ1 <= PZ;
	                         AX2 <= PX2;
	                         AY2 <= PY2;
	                         AZ2 <= PZ2;
                        start1 <= '1';
                        reset1 <= '1';
                        check <= '0';

	
--                    else
--					count<=count-1;
--					end if;
              
                    else
                         
	                   done2<= done1;
				    end if;
	                

else




 if( count > 2) then
 
    if( (key(count-2) xor key(count -3)) = '1') then	

	    AX1 <= DX2;
	    AY1 <= DY2;
	    AZ1 <= DZ2;
	    AX2 <= AX3;
	    AY2 <= AY3;
	    AZ2 <= AZ3;		 
	    DX1 <= AX3;
	    DY1 <= AY3;
	    DZ1 <= AZ3;	 

    else
		AX1 <= DX2;
	    AY1 <= DY2;
	    AZ1 <= DZ2;
	    AX2 <= AX3;
	    AY2 <= AY3;
	    AZ2 <= AZ3;		 
	    DX1 <= DX2;
	    DY1 <= DY2;
	    DZ1 <= DZ2;

     end if;
		  count <= count - 1;
			reset1 <= '1';
 else
			if(key(0) = '1')then
				QX <= AX3;
				QY <= AY3;
				QZ <= AZ3;
			else
				QX <= DX2;
				QY <= DY2;	
				QZ <= DZ2;
			end if;
			
			done<= done1;

 end if;
end if;


   end if;

end process control_unit;
end Behavioral;


