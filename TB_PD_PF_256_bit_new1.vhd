
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
library std;
use std.textio.all; --include package textio.vhd
 
ENTITY TB_PD_PF_256_bit_new1 IS
END TB_PD_PF_256_bit_new1;
 
ARCHITECTURE behavior OF TB_PD_PF_256_bit_new1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PD_PF_256_bit_new1
    PORT(
         X1 : IN  std_logic_vector(255 downto 0);
         Y1 : IN  std_logic_vector(255 downto 0);
         Z1 : IN  std_logic_vector(255 downto 0);
         X3 : OUT  std_logic_vector(255 downto 0);
         Y3 : OUT  std_logic_vector(255 downto 0);
         Z3 : OUT  std_logic_vector(255 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X1 : std_logic_vector(255 downto 0) := (others => '0');
   signal Y1 : std_logic_vector(255 downto 0) := (others => '0');
   signal Z1 : std_logic_vector(255 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';

 	--Outputs
   signal X3 : std_logic_vector(255 downto 0);
   signal Y3 : std_logic_vector(255 downto 0);
   signal Z3 : std_logic_vector(255 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PD_PF_256_bit_new1 PORT MAP (
          X1 => X1,
          Y1 => Y1,
          Z1 => Z1,
          X3 => X3,
          Y3 => Y3,
          Z3 => Z3,
          clk => clk,
          reset => reset,
          start => start
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 


-- Stimulus process
   stim_proc: process
	file file1: text;
	variable fstatus : File_open_status;
	variable buff : line;
	
   begin		
    file_open (fstatus, file1, "TB_PD_PF_256_bit_new1_jac.txt",write_mode);
	 
      reset <= '1';	
      wait for clk_period;
      reset <= '0';
		start <= '1';
		
		X1 <= x"216936D3CD6E53FEC0A4E231FDD6DC5C692CC7609525A7B2C9562D608F25D51A";
		Y1 <= x"6666666666666666666666666666666666666666666666666666666666666658"; --1px,y,z
		Z1 <= x"0000000000000000000000000000000000000000000000000000000000000001";
		
	
		
--		X1 <=x"4EDBE2246583DAB515DDB478484F06F677913E22058E9DA4854579B3E7CFF596";
--      Y1 <=x"4CDB67B39336CC2496487D03C536AE09F5B85599D441CDE36DB4D326A1D28016";--2px,y,z
--      Z1 <=x"16793A8694A883A8BF672E05C4BD9D6D142C9EFFCC6D662E9C8B56C2FD872182";
--	X1 <=x"31241DDB9A7C254AEA224B87B7B0F909886EC1DDFA71625B7ABA864C18300A57";
--  Y1 <=x"3324984C6CC933DB69B782FC3AC951F60A47AA662BBE321C924B2CD95E2D7FD7";--2px,y,z
--  Z1 <=x"6986C5796B577C574098D1FA3B426292EBD36100339299D16374A93D0278DE6B";
		
		wait for clk_period;	
		
--      start <= '0';
		


		
		write (buff, string '("X1="));
      write (buff, X1);
		writeline (file1, buff);
		
		write (buff, string '("Y1="));
      write (buff, Y1);
		writeline (file1, buff);
		
		write (buff, string '("Z1="));
      write (buff, Z1);
		writeline (file1, buff);
		
		
wait for 800 ns;
		
		write (buff, string '("X3="));
      write (buff, X3);
		writeline (file1, buff);
		
		write (buff, string '("Y3="));
      write (buff, Y3);
		writeline (file1, buff);
		
		write (buff, string '("Z3="));
      write (buff, Z3);
		writeline (file1, buff);
				
      wait;
   end process;	

END;

