library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_3bit_4to1 is
    port(
        sel_i         : in  std_logic_vector(2 - 1 downto 0);
        d_i           : in  std_logic_vector(3 - 1 downto 0);
        c_i           : in  std_logic_vector(3 - 1 downto 0);
        b_i           : in  std_logic_vector(3 - 1 downto 0);
        a_i           : in  std_logic_vector(3 - 1 downto 0);
        f_o           : out std_logic_vector(2 - 1 downto 0)
    );
end mux_3bit_4to1;

architecture Behavioral of mux_3bit_4to1 is 
begin
    f_o <= a_i when (sel_i = "00") else
           b_i when (sel_i = "01") else
           c_i when (sel_i = "10") else
           d_i when (sel_i = "11");
end Behavioral;ioral;
