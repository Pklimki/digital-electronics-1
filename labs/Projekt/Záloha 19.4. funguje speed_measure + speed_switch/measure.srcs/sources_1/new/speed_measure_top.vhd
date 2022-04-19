library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity speed_measure_top is
    port(
        clk       : in  std_logic;
		SENZOR1   : in STD_LOGIC;
		SENZOR2   : in STD_LOGIC;
		SENZOR3   : in STD_LOGIC;
		SENZOR4   : in STD_LOGIC;
		reset     : in STD_LOGIC;
		switch1   : in STD_LOGIC;
		switch2   : in STD_LOGIC;
		v_print_o : out real
    );
end entity speed_measure_top;


architecture Behavioral of speed_measure_top is

  -- Interni signaly pro rychlost
  signal s_v1       : real := 0.0 ;
  signal s_v2       : real := 0.0 ;
  signal s_v3       : real := 0.0 ;
  signal s_v        : real := 0.0 ;
  signal s_v_print  : real := 0.0 ;
  
begin	
	--------------------------------------------------------------------
	speed_measure_section_1 : entity work.speed_measure
      generic map(
          DELKA_USEKU => 20.0
      )
      port map(
      	  -- Priradim porty me krabicky k fyzickym signalum
          clk   => clk,
          en_i  => SENZOR1,
          dis_i => SENZOR2,
          reset => '0',
          -- Vystupni promenna
          v_o	 => s_v1
      );
	--------------------------------------------------------------------
    speed_measure_section_2 : entity work.speed_measure
      generic map(
          DELKA_USEKU => 20.0
      )
      port map(
      	  -- Priradim porty me krabicky k fyzickym signalum
          clk   => clk,
          en_i  => SENZOR2,
          dis_i => SENZOR3,
          reset => SENZOR1,
          -- Vystupni promenna
          v_o	 => s_v2
      );
	--------------------------------------------------------------------
    speed_measure_section_3 : entity work.speed_measure
      generic map(
          DELKA_USEKU => 20.0
      )
      port map(
      	  -- Priradim porty me krabicky k fyzickym signalum
          clk   => clk,
          en_i  => SENZOR3,
          dis_i => SENZOR4,
          reset => SENZOR2,
          -- Vystupni promenna
          v_o	 => s_v3
      );
	--------------------------------------------------------------------
	speed_measure_avg : entity work.speed_measure
      generic map(
          DELKA_USEKU => 20.0+20.0+20.0
      )
      port map(
      	  -- Priradim porty me krabicky k fyzickym signalum
          clk   => clk,
          en_i => SENZOR1,
          dis_i => SENZOR4,
          reset  => '0',
          -- Vystupni promenna
          v_o	 => s_v
      );
    --------------------------------------------------------------------
	speed_switch_print : entity work.speed_switch
      port map(
      
         clk   => clk,
        
        -- rychlosti ve vsech sektorech
         v1_i => s_v1,
         v2_i => s_v2,
         v3_i => s_v3,
         v_i  => s_v,
        
         s1_i => switch1,
         s2_i => switch2,
 
        -- vystup: jedna z rychlosti
        v_print_o => v_print_o
      
      );  

end architecture Behavioral;