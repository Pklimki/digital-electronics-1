# Lab 2: PETR KLÍMA

### 2-bit comparator

1. Karnaugh maps for other two functions:

   ![K-maps](images/KMap.png)

2. Equations of simplified SoP (Sum of the Products) form of the "greater than" function and simplified PoS (Product of the Sums) form of the "less than" function.

   ![Logic functions](images/KMapMinimal.png)

### 4-bit comparator

1. Listing of VHDL stimulus process from testbench file (`testbench.vhd`) with at least one assert (use BCD codes of your student ID digits as input combinations). Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:

   Last two digits of my student ID: **xxxx86**

```vhdl
    p_stimulus : process
    begin
        -- Report a note at the beginning of stimulus process
        report "Stimulus process started" severity note;

         -- First test case
        s_b <= "1000"; 			   -- Such as "1000" if ID = xxxx86
        s_a <= "0110";        	-- Such as "0110" if ID = xxxx86
        wait for 100 ns;
        -- Expected output
        assert ((s_B_greater_A = '1') and
                (s_B_equals_A  = '0') and
                (s_B_less_A    = '0'))
        -- If false, then report an error
        report "Input combination 1000, 0110 FAILED" severity error;

        s_b <= "0000"; s_a <= "0001"; wait for 100 ns;
        assert ((s_B_greater_A = '0') and
                (s_B_equals_A  = '0') and
                (s_B_less_A    = '1'))
        report "Input combination 0000, 0001 FAILED" severity error;
        
        s_b <= "1001"; s_a <= "0101"; wait for 100 ns;
        assert ((s_B_greater_A = '1') and
                (s_B_equals_A  = '0') and
                (s_B_less_A    = '0'))
        report "Input combination 1001, 0101 FAILED" severity error;

        -- Report a note at the end of stimulus process
        report "Stimulus process finished" severity note;
        wait; -- Data generation process is suspended forever
    end process p_stimulus;
```

2. Text console screenshot during your simulation, including reports.

   ![OK stav](images/NoError.png)
   
   ![Error](images/Error.png)


3. Link to your public EDA Playground example:

   [https://www.edaplayground.com/x/K8N9](https://www.edaplayground.com/x/K8N9)
