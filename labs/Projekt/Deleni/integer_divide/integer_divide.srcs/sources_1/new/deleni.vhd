----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/26/2022 01:54:51 PM
-- Design Name: 
-- Module Name: deleni - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity deleni is
    generic(
        g_CNT_WIDTH : natural := 4 -- Number of bits for counter
    );
    port(
        
        clk      : in  std_logic;  -- Main clock
        reset    : in  std_logic;  -- Synchronous reset
        en_i     : in  std_logic;  -- Enable input
        cnt_up_i : in  std_logic;  -- Direction of the counter
        cnt_o    : out std_logic_vector(g_CNT_WIDTH - 1 downto 0)
    );
end entity deleni;


architecture Behavioral of deleni is

    signal const_val : std_logic_vector(g_CNT_WIDTH - 1 downto 0)


begin
    

constant const_val : unsigned(14 downto 0) := to_unsigned(1927,15);
signal val_in               : unsigned( 7 downto 0);
signal valIn_x_const_val    : unsigned(22 downto 0);
signal val_out              : unsigned( 7 downto 0);
begin
  valIn_x_const_val <= val_in * const_val;
-- right shift by 15
  val_out           <= valIn_x_const_val(22 downto 15);
end;



end Behavioral;
