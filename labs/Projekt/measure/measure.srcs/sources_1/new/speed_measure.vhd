library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity speed_measure is
    port(
        clk         : in  std_logic;
        senzor_1    : in  std_logic;
        senzor_2    : in  std_logic;
        senzor_3    : in  std_logic;
        senzor_4    : in  std_logic;
        reset       : in  std_logic
    
    );
end speed_measure;

architecture Behavioral of speed_measure is
    -- Cas straveny v useku
    signal s_cnt_1      : natural;
    signal s_cnt_2      : natural;
    signal s_cnt_3      : natural;
    
    -- Zapocate mereni
    signal s_merime     : std_logic;
    
    -- Zapocete mereni v danem useku
    signal s_usek1      : std_logic;
    signal s_usek2      : std_logic;
    signal s_usek3      : std_logic;
    
    -- Rychlost
    signal v1           : unsigned(15 downto 0);
    signal v1_dp        : unsigned(3 downto 0);
    signal v2           : unsigned(15 downto 0);
    signal v2_dp        : unsigned(3 downto 0);
    signal v3           : unsigned(15 downto 0);
    signal v3_dp        : unsigned(3 downto 0);
    signal v_avg        : unsigned(15 downto 0);
    signal v_avg_dp     : unsigned(3 downto 0);
   

    -- Delka useku v cm
    constant c_DELKA_USEK_1 : unsigned(7 downto 0) := b"0000_0010";


begin

--p_reset : process(reset)
--begin
--    if (reset = '1') then
--        s_merime <= '0';
   
--        s_cnt_1 <= 0;
--        s_cnt_2 <= 0;
--        s_cnt_3 <= 0;
--        s_cnt_2 <= 0;
           
--        s_usek1 <= '0';
--        s_usek2 <= '0';
--        s_usek3 <= '0';

--    end if;
--end process p_reset;

p_measure : process(clk)
begin
    if rising_edge(clk) then
        if (s_merime = '1') then
            if (s_usek1 = '1') then
                s_cnt_1 <= s_cnt_1 + 1;
                
            elsif (s_usek2 = '1') then
                s_cnt_2 <= s_cnt_2 + 1;
                
            elsif (s_usek3 = '1') then
                s_cnt_3 <= s_cnt_3 + 1;
                
            end if;
        end if;
    end if;
end process p_measure;

p_measure_1_enable : process(senzor_1)
begin
    if (senzor_1 = '1') then
    
        -- reset
        if (s_merime = '1') then
            --reset <= '1';
            s_merime <= '0';
   
            s_cnt_1 <= 0;
            s_cnt_2 <= 0;
            s_cnt_3 <= 0;
            s_cnt_2 <= 0;
               
            s_usek1 <= '0';
            s_usek2 <= '0';
            s_usek3 <= '0';
        else
            s_merime <= '1';
            s_usek1 <= '1';
        end if;
    end if;          
end process p_measure_1_enable;

p_measure_2_enable : process(senzor_2)
begin
    if (senzor_2 = '1') then
        if (s_merime = '1') then
            -- Vyhodnoceni prvniho useku
            if (s_usek1 = '1') then
                --v1 <= c_DELKA_USEK_1/(s_cnt_1*100000000);
                s_usek1 <= '0';
            end if;
            s_usek2 <= '1';
        end if;
    end if;          
end process p_measure_2_enable;

--p_measure_3_enable : process(senzor_3)
--begin
--    if (senzor_3 = '1') then
--        if (s_merime = '1') then
--            -- Vyhodnoceni druheho useku
--            if (s_usek2 = '1') then
--                --v2 <= c_DELKA_USEK_1/(s_cnt_2*100000000);
--                s_usek2 <= '0';
--            end if;
--            s_usek3 <= '1';
--        end if;
--    end if;          
--end process p_measure_3_enable;

--p_measure_vyhodnoceni : process(senzor_4)
--begin
--    if (senzor_4 = '1') then
--        if (s_merime = '1') then
--            -- Vyhodnoceni tretiho useku
--            if (s_usek3 = '1') then
--                --v3 <= c_DELKA_USEK_1/(s_cnt_3*100000000);
--                s_usek3 <= '0';
--                --v_avg <= (v1+v2+v3)/3;
--            end if;
--        end if;
--    end if;          
--end process p_measure_vyhodnoceni;
    
end architecture Behavioral;
