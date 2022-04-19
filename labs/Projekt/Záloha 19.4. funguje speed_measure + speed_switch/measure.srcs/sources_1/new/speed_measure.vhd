library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity speed_measure is
	 generic(
        DELKA_USEKU : real := 20.0 -- Number of bits for counter
    );

    port(
    	-- hodinovy signal z desky
        clk         : in  std_logic;
        -- vystupni signaly ze senzoru
        en_i        : in  std_logic;
        dis_i       : in  std_logic;
        reset       : in  std_logic;
        -- Vystupni promenna
        v_o	        : out real := 0.0
    
    );
end speed_measure;

architecture Behavioral of speed_measure is

    -- Cas straveny v useku
    -- zaciname na 1, abychom neprisli o prvni inkrementaci na nabezne hrane clk
    signal s_cnt        : natural := 1; 
   
    -- Stav mereni
    signal s_merime     : std_logic := '0';
   
   	-- promena pro reset
    --signal s_reset      : std_logic := '0';

begin

    p_measure : process(clk)
    begin
    
        if rising_edge(clk) then
        
        	-- Reset
        	if (reset = '1') then
        		s_merime <= '0';
                s_cnt <= 0;
				v_o <= 0.0;
            else
        
        	  -- en_i mereni
              if (en_i = '1') then
                  if (s_merime = '0') then
                      s_merime <= '1';
                      s_cnt <= 1;
					  v_o <= 0.0;
                  end if;
              end if;

		  	  -- Konec mereni
              if (dis_i = '1') then
                  if (s_merime = '1') then
                      s_merime <= '0';
                      -- rychlost v m/s
                      v_o <= ((DELKA_USEKU) / Real(s_cnt))*1000000.0;
                  end if;
              end if;

              if (s_merime = '1') then
                  s_cnt <= s_cnt + 1;
              end if;
          end if;
      end if;
      end process p_measure;
    
end architecture Behavioral;