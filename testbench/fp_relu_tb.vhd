-- Behavior test of the fp_relu
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

entity fp_relu_tb is
port(
    clk : out std_logic
    );
end entity ;

-----------------------------------------------------------

architecture rtl of fp_relu_tb is
    constant C_CLK_PERIOD : time := 10 ns;		
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal relu_enable : std_logic := '0';

    -- I only test the behavior of 8bits fixed point data with 4 bits fractional parts.
    signal relu_input : std_logic_vector(7 downto 0);
    signal relu_output : std_logic_vector(7 downto 0);

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

    relu_enable <= not reset;
    clk <= clock;

	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
    test_main : process
    begin
        relu_input <= std_logic_vector(to_signed(0, 8));
        wait until reset='0';
        wait until clock='0';
        relu_input <= std_logic_vector(to_signed(-4, 8));
        wait for C_CLK_PERIOD*4;
        relu_input <= std_logic_vector(to_signed(0, 8));
        wait for C_CLK_PERIOD*4;
        relu_input <= std_logic_vector(to_signed(-128, 8));
        wait for C_CLK_PERIOD*4;
        relu_input <= std_logic_vector(to_signed(0, 8));
        wait for C_CLK_PERIOD*4;
        relu_input <= std_logic_vector(to_signed(1, 8));
        wait for C_CLK_PERIOD*4;
        relu_input <= std_logic_vector(to_signed(0, 8));
        wait for C_CLK_PERIOD*4;
        relu_input <= std_logic_vector(to_signed(127, 8));
        wait for C_CLK_PERIOD*4;
        relu_input <= std_logic_vector(to_signed(0, 8));
        wait;
    end process ; -- test_main

	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
    uut: entity work.fp_relu(rtl)
    -- Testbench DUT generics
    generic map (
        DATA_WIDTH => 8,     -- means, max integer will be 127, and minimum will be -128
        CLOCK_OPTION => false -- would cause some delay, but better timing
    )
    port map (
        enable => relu_enable,
        clock => clock,
        input => relu_input,
        output => relu_output
    );

end architecture;


