------------------------------------------------------------
--
-- Template for 4-digit 7-segment display driver testbench.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno Univ. of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

------------------------------------------------------------
-- Entity declaration for testbench
------------------------------------------------------------
entity tb_speed_measure_top is
    -- Entity of testbench is always empty
end entity tb_speed_measure_top;

------------------------------------------------------------
-- Architecture body for testbench
------------------------------------------------------------
architecture testbench of tb_speed_measure_top is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;
    constant c_MAX               : natural := 3;

    -- Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset : std_logic;
    signal s_senzor1 : std_logic;
    signal s_senzor2 : std_logic;
    signal s_senzor3 : std_logic;
    signal s_senzor4 : std_logic;
    signal s_switch1 : std_logic;
    signal s_switch2 : std_logic;
    --signal s_v_o     : real;


begin
    -- Connecting testbench signals with driver_7seg_4digits
    -- entity (Unit Under Test)
    -- MAP I/O PORTS FROM ENTITY TO LOCAL SIGNALS
    -- uut_driver_7seg_4digits : entity work....
    uut_speed_measure_top : entity work.speed_measure_top
        port map(
            clk         => s_clk_100MHz,
            reset       => s_reset,
			SENZOR1     => s_senzor1,
            SENZOR2     => s_senzor2,
            SENZOR3     => s_senzor3,
            SENZOR4     => s_senzor4,
			switch1     => s_switch1,
			switch2     => s_switch2
            --v_print_o   => s_v_o
        );

    -- Connecting testbench signals with clock_enable entity
    -- (Unit Under Test)
    --uut_clock_enable : entity work.clock_enable

    --------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 200 ms loop -- 75 periods of 100MHz clock
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_switch_gen : process
    begin
        while now < 200 ms loop -- 75 periods of 100MHz clock
            s_switch1  <= '1';
            s_switch2  <= '0';
            wait for 25 ms;
            s_switch1  <= '0';
            s_switch2  <= '1';
            wait for 25 ms;
            s_switch1  <= '1';
            s_switch2  <= '1';
            wait for 25 ms;
            s_switch1  <= '0';
            s_switch2  <= '0';
            wait for 25 ms;
           
        end loop;
        wait;
    end process p_switch_gen;

    --------------------------------------------------------
    -- Data generation process
    --------------------------------------------------------
  p_stimulus : process
  begin
        
		s_senzor1 <= '0';
		s_senzor2 <= '0';
		s_senzor3 <= '0';
		s_senzor4 <= '0';
		
		
		wait for 50 ns;
		s_senzor1 <= '1';
		wait for 10 ns;
		s_senzor1 <= '0';
		
		wait for 10 ms;
		s_senzor2 <= '1';
		wait for 20 ns;
		s_senzor2 <= '0';
		
		
		wait for 15 ms;
		s_senzor3 <= '1';
		wait for 15 ns;
		s_senzor3 <= '0';
		
		
		wait for 20 ms;
		s_senzor4 <= '1';
		wait for 10 ns;
		s_senzor4 <= '0';
		
--		wait for 250 ns;
--		s_senzor1 <= '1';
--		wait for 75 ns;
--		s_senzor1 <= '0';
		
--		wait for 65 ns;
--		s_senzor2 <= '1';
--		wait for 160 ns;
--		s_senzor2 <= '0';
		
--		wait for 35 ns;
--		s_senzor3 <= '1';
--		wait for 56 ns;
--		s_senzor3 <= '0';
--		wait for 120 ns;
		
--		s_senzor4 <= '1';
--		wait for 120 ns;
--		s_senzor4 <= '0';
--		wait for 50 ns;
		
        wait;
    end process p_stimulus;

end architecture testbench;

    
