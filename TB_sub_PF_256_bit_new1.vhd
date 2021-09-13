
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
library std;
use std.textio.all; --include package textio.vhd
 
ENTITY TB_sub_PF_256_bit_new1 IS
END TB_sub_PF_256_bit_new1;
 
ARCHITECTURE behavior OF TB_sub_PF_256_bit_new1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sub_PF_256_bit_new1
    PORT(
         A : IN  std_logic_vector(255 downto 0);
         B : IN  std_logic_vector(255 downto 0);
         clk : IN  std_logic;
         reset : IN  std_logic;
         start : IN  std_logic;
		          done : OUT  std_logic;

         C : OUT  std_logic_vector(255 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(255 downto 0) := (others => '0');
   signal B : std_logic_vector(255 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal start : std_logic := '0';
   signal done : std_logic;

 	--Outputs
   signal C : std_logic_vector(255 downto 0);

   -- Clock period definitions
   constant clk_period : time := 1 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sub_PF_256_bit_new1 PORT MAP (
          A => A,
          B => B,
          clk => clk,
          reset => reset,
          start => start,
		            done => done,

          C => C
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
    file_open (fstatus, file1, "TB_MM_SQ_new.txt",write_mode);
	 
      reset <= '1';	
      wait for clk_period;
      reset <= '0';
		start <= '1';
--		A <= x"79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";
--		B <= x"79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798";
		
		A <= x"216936D3CD6E53FEC0A4E231FDD6DC5C692CC7609525A7B2C9562D608F25D51A";
		B <= x"6666666666666666666666666666666666666666666666666666666666666658";		
		wait for clk_period;
		
		
		write (buff, string '("A="));
      write (buff, A);
		writeline (file1, buff);
				
wait for 1.5 ns;
		
		write (buff, string '("C="));
      write (buff, C);
		writeline (file1, buff);
		
      wait;
   end process;	

END;


