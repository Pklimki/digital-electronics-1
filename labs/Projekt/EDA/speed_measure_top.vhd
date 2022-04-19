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
		switch    : std_logic_vector(1 downto 0);
		v_print_o : out real;
		BTNC      : in STD_LOGIC)
    );
end entity speed_measure_top;


architecture Behavioral of speed_measure_top is

  -- Interni signaly pro rychlost
  signal s_v1  : real := 0.0 ;
  signal s_v2  : real := 0.0 ;
  signal s_v3  : real := 0.0 ;
  signal s_v   : real := 0.0 ;
  
begin	
	--------------------------------------------------------------------
	speed_measure_section_1 : entity speed_measure
      generic map(
          DELKA_USEKU => 20
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
    speed_measure_section_2 : entity speed_measure
      generic map(
          DELKA_USEKU => 15
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
    speed_measure_section_3 : entity speed_measure
      generic map(
          DELKA_USEKU => 30
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
	speed_measure_avg : entity speed_measure
      generic map(
          DELKA_USEKU => 20+15+30
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
	  
	p_switch : process(clk)
    begin
        if rising_edge(clk) then
			case switch is
				when "00" =>
					v_o <= s_v;

				when "01" =>
					v_o <= s_v1;

				when "10" =>
					v_o <= s_v2;

				when others =>
					v_o <= s_v3;
			end case;
        end if;
    end process p_mux;

end architecture Behavioral;