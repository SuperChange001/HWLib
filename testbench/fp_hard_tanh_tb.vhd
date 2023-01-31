-- Behavior test of the fp_hard_tanh, 
-- you should notice that the tanh output changes at the rising edge of the clock signal.
-- Version: 1.0
-- Created by: Chao
-- Last modified date: 2022.11.06

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.all;

-----------------------------------------------------------

entity fp_hard_tanh_tb is
port(
    clk : out std_logic
    );
end entity ;

-----------------------------------------------------------

architecture rtl of fp_hard_tanh_tb is
    constant C_CLK_PERIOD : time := 10 ns;      
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal tanh_enable : std_logic := '0';

    -- I only test the behavior of 8bits fixed point data with 4 bits fractional parts.
    signal tahn_input : std_logic_vector(7 downto 0);
    signal tahn_output : std_logic_vector(7 downto 0);

begin
    -----------------------------------------------------------
    -- Clocks and Reset
    -----------------------------------------------------------
    CLK_GEN : process
    begin
        clock <= '1';
        wait for C_CLK_PERIOD/2;
        clock <= '0';
        wait for C_CLK_PERIOD/2;
    end process CLK_GEN;

    RESET_GEN : process
    begin
        reset <= '1',
                 '0' after 20.0*C_CLK_PERIOD;
    wait;
    end process RESET_GEN;

    tanh_enable <= not reset;
    clk <= clock;

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    test_main : process
    begin
        tahn_input <= std_logic_vector(to_signed(0, 8));
        wait until reset='0';
        wait until clock='0';

        tahn_input <= std_logic_vector(to_signed(-24, 8));
        wait for C_CLK_PERIOD*4;
        report "The correct value should be -16 while sigmoid_output is " & integer'image(to_integer(signed(tahn_output)));

        tahn_input <= std_logic_vector(to_signed(-16, 8));
        wait for C_CLK_PERIOD*4;
        report "The correct value should be -16 while sigmoid_output is " & integer'image(to_integer(signed(tahn_output)));

        tahn_input <= std_logic_vector(to_signed(-8, 8));
        wait for C_CLK_PERIOD*4;
        report "The correct value should be -8 while sigmoid_output is " & integer'image(to_integer(signed(tahn_output)));

        tahn_input <= std_logic_vector(to_signed(0, 8));
        wait for C_CLK_PERIOD*4;
        report "The correct value should be 0 while sigmoid_output is " & integer'image(to_integer(signed(tahn_output)));

        tahn_input <= std_logic_vector(to_signed(8, 8));
        wait for C_CLK_PERIOD*4;
        report "The correct value should be 8 while sigmoid_output is " & integer'image(to_integer(signed(tahn_output)));

        tahn_input <= std_logic_vector(to_signed(16, 8));
        wait for C_CLK_PERIOD*4;
        report "The correct value should be 16 while sigmoid_output is " & integer'image(to_integer(signed(tahn_output)));

        tahn_input <= std_logic_vector(to_signed(24, 8));
        wait for C_CLK_PERIOD*4;
        report "The correct value should be 16 while sigmoid_output is " & integer'image(to_integer(signed(tahn_output)));

        wait;
    end process ; -- test_main

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    uut: entity work.fp_hard_tanh(rtl)
    -- Testbench DUT generics
    generic map (
        DATA_WIDTH => 8,    -- means, max integer will be 127, and minimum will be -128
        FRAC_WIDTH => 4,    -- means, 16 == 1.0, 1 == 0.0625
        MIN_VAL => -16,
        MAX_VAL => 16
    )
    port map (
        enable => tanh_enable,
        clock => clock,
        input => tahn_input,
        output => tahn_output
    );

end architecture;


