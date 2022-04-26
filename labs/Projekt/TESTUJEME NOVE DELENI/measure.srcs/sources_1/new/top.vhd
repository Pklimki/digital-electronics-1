library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;



entity top is
    Port(
        CLK100MHZ : in STD_LOGIC;
		SW 		  : in STD_LOGIC_VECTOR (15 downto 0);
		CA : out STD_LOGIC;
		CB : out STD_LOGIC;
		CC : out STD_LOGIC;
		CD : out STD_LOGIC;
		CE : out STD_LOGIC;
		CF : out STD_LOGIC;
		CG : out STD_LOGIC;
		DP : out STD_LOGIC;
		  
		AN : out STD_LOGIC_VECTOR (7 downto 0)  
    );
end entity top;


architecture Behavioral of top is

  -- Interni signaly pro rychlost
  signal s_v1       : real := 0.0 ;
  signal s_v2       : real := 0.0 ;
  signal s_v3       : real := 0.0 ;
  signal s_v        : real := 0.0 ;
  signal s_v_print  : real := 0.0 ;
  
  signal s_data0 : std_logic_vector(4 - 1 downto 0);
  signal s_data1 : std_logic_vector(4 - 1 downto 0);
  signal s_data2 : std_logic_vector(4 - 1 downto 0);
  signal s_data3 : std_logic_vector(4 - 1 downto 0);
  signal s_dp : std_logic_vector(4 - 1 downto 0);

begin	
	--------------------------------------------------------------------
	speed_measure_section_1 : entity work.speed_measure
      generic map(
          DELKA_USEKU => 20.0
      )
      port map(
      	  -- Priradim porty me krabicky k fyzickym signalum
          clk   => CLK100MHZ,
          en_i  => SW(15),
          dis_i => SW(14),
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
          clk   => CLK100MHZ,
          en_i  => SW(14),
          dis_i => SW(13),
		  reset => SW(15),
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
          clk   => CLK100MHZ,
          en_i  => SW(13),
          dis_i => SW(12),
		  reset => SW(15),
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
          clk   => CLK100MHZ,
          en_i  => SW(15),
          dis_i => SW(12),
          reset  => '0',
          -- Vystupni promenna
          v_o	 => s_v
      );
    --------------------------------------------------------------------
	speed_switch_print : entity work.speed_switch
		port map(
      
			clk   => CLK100MHZ,
			
			-- rychlosti ve vsech sektorech
			v1_i => s_v1,
			v2_i => s_v2,
			v3_i => s_v3,
			v_i  => s_v,
			
			s1_i => SW(0),
			s2_i => SW(1),
	 
			 -- vystup: jedna z rychlosti
			v_print_o => s_v_print
      
      );
      
    speed_print_prepare : entity work.real_to_7_seg  
		port map(
      
			clk   => CLK100MHZ,
			
			speed_i => s_v_print,
			data0_o => s_data0,
			data1_o => s_data1,
			data2_o => s_data2,
			data3_o => s_data3,
			dp_o    => s_dp
		);
      
    speed_driver_7s : entity work.driver_7seg_4digits
        
        port map(
            clk   		=> CLK100MHZ,
           	reset		=> '0',
            
            data0_i(3 downto 0)	=> s_data0(3 downto 0),
            data1_i(3 downto 0)	=> s_data1(3 downto 0),
            data2_i(3 downto 0)	=> s_data2(3 downto 0),
            data3_i(3 downto 0)	=> s_data3(3 downto 0),
            dp_i(3 downto 0)	=> s_dp(3 downto 0),
            
            seg_o(0)	=> CG,
            seg_o(1)	=> CF,
            seg_o(2)	=> CE,
            seg_o(3)	=> CD,
            seg_o(4)	=> CC,
            seg_o(5)	=> CB,
            seg_o(6)	=> CA,
            dp_o		=> DP,
            dig_o(3 downto 0) => AN(3 downto 0)
        );
        

        AN(7 downto 4) <= "1111";

end architecture Behavioral;