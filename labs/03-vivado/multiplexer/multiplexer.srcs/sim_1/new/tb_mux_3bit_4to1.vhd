library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_mux_3bit_4to1 is
end tb_mux_3bit_4to1;

architecture Behavioral of tb_mux_3bit_4to1 is

    signal s_a           : std_logic_vector(3 - 1 downto 0);
    signal s_b           : std_logic_vector(3 - 1 downto 0);
    signal s_c           : std_logic_vector(3 - 1 downto 0);
    signal s_d           : std_logic_vector(3 - 1 downto 0);
    signal s_sel         : std_logic_vector(2 - 1 downto 0);
    signal s_f           : std_logic_vector(3 - 1 downto 0);

begin
    uut_comparator_4bit : entity work.comparator_4bit
        port map(
            sel_i         => s_sel,
            d_i           => s_d,
            c_i           => s_c,
            b_i           => s_b,
            a_i           => s_a,
            f_o           => s_f
        );
    p_stimulus : process
    begin
        
       

        s_d <= "010";
        s_c <= "011";
        s_b <= "001";
        s_a <= "000";
        
        s_sel <= "00";
        wait for 100 ns;
        
        s_sel <= "01";
        wait for 100 ns;
        
        s_sel <= "10";
        wait for 100 ns;
        
        s_sel <= "11";
        wait for 100 ns;
        
        wait; -- Data generation process is suspended forever
    end process p_stimulus;
    
end Behavioral;
