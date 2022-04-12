----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/12/2022 02:12:51 PM
-- Design Name: 
-- Module Name: tb_speed_measure - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_speed_measure is
--  Port ( );
end tb_speed_measure;

architecture Behavioral of tb_speed_measure is
     -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_senzor_1   : std_logic;
    signal s_senzor_2   : std_logic;
    signal s_senzor_3   : std_logic;
    signal s_senzor_4   : std_logic;
 
begin
    uut_speed_measure : entity work.speed_measure
        port map(
            clk     => s_clk_100MHz,

            senzor_1 => s_senzor_1,
            senzor_2 => s_senzor_2,
            senzor_3 => s_senzor_3,
            senzor_4 => s_senzor_4
        );
        
    p_clk_gen : process
    begin
        while now < 10000 ns loop -- 10 usec of simulation
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
    p_stimulus : process
    begin
        wait for 50 ns;
        s_senzor_1 <= '1';
        wait for 50 ns;
        s_senzor_1 <= '0';
        
        wait for 200 ns;
        s_senzor_2 <= '1';
        wait for 50 ns;
        s_senzor_2 <= '0';
        
        wait for 120 ns;
        s_senzor_3 <= '1';
        wait for 30 ns;
        s_senzor_3 <= '0';
        
        wait for 250 ns;
        s_senzor_4 <= '1';
        wait;
    end process p_stimulus;

end architecture Behavioral;


    
