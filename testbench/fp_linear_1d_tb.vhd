library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.all;

-----------------------------------------------------------

entity fp_linear_fp_tb is
port(
    clk : out std_logic
    );
end entity ;

-----------------------------------------------------------

architecture rtl of fp_linear_fp_tb is
    constant C_CLK_PERIOD : time := 10 ns;      
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal linear_enable : std_logic := '0';

    -- I only test the behavior of 8bits fixed point data with 4 bits fractional parts.
    signal x_in : std_logic_vector(7 downto 0);
    signal w_in : std_logic_vector(7 downto 0);
    signal b_in : std_logic_vector(7 downto 0);
    signal y_out : std_logic_vector(7 downto 0);

    signal addr_x : std_logic_vector(8 downto 0);
    signal addr_w : std_logic_vector(8 downto 0);
    signal addr_y : std_logic_vector(8 downto 0);
    
    signal done : std_logic;

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

    linear_enable <= not reset;
    clk <= clock;

    x_in <= std_logic_vector(to_signed(to_integer(signed(addr_x))*16, x_in'length));
    w_in <= std_logic_vector(to_signed(to_integer(signed(addr_w)), x_in'length));
    b_in <= std_logic_vector(to_signed(1, b_in'length));

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    test_main : process
    begin
        --linear_input <= std_logic_vector(to_signed(0, 8));
        --wait until reset='0';
        --wait until clock='0';
        --linear_input <= std_logic_vector(to_signed(0, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(-4, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(0, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(4, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(0, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(-48, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(0, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(48, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(0, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(-24, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(0, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(24, 8));
        --wait for C_CLK_PERIOD*4;
        --linear_input <= std_logic_vector(to_signed(0, 8));
        --wait for C_CLK_PERIOD*4;
        wait;
    end process ; -- test_main

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    uut: entity work.fp_linear_1d(rtl)
    -- Testbench DUT generics
    generic map (
        ADDR_X_WIDTH => 5,
        ADDR_W_WIDTH => 5,
        ADDR_Y_WIDTH => 5,
        DATA_WIDTH => 8,
        FRAC_WIDTH => 4,
        IN_FEATURE_COUNT => 5,
        OUT_FEATURE_COUNT => 4
    )
    port map (
        enable => linear_enable,
        clock  => clock,
        addr_x => addr_x,
        addr_w => addr_w,
        x_in   => x_in,
        w_in   => w_in,
        b_in   => b_in,

        y_out  => y_out,
        done   => done
    );

end architecture;