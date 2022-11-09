-- Testbench for testing my fp_linear_1d
-- this test covers the configured linear layer with 3 inputs and 2 outputs
-- b_rom.vhd and w_rom.vhd are the dependency of my fp_linear_1d, they must be generated accordingly
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.all;

-----------------------------------------------------------

entity fp_linear_1d_tb is
port(
    clk : out std_logic
    );
end entity ;

-----------------------------------------------------------
architecture rtl of fp_linear_1d_tb is
    constant C_CLK_PERIOD : time := 10 ns;      
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal linear_enable : std_logic := '0';

    -- I only test the behavior of 8bits fixed point data with 4 bits fractional parts.
    signal x_in : std_logic_vector(7 downto 0);
    signal y_out : std_logic_vector(7 downto 0);

    signal addr_x : std_logic_vector(1 downto 0);
    signal addr_y : std_logic_vector(0 downto 0);
    
    signal done : std_logic;
    type t_array_x is array (0 to 3-1) of std_logic_vector(8-1 downto 0);
    signal x_arr : t_array_x := (x"10",x"20",x"30");

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

    clk <= clock;


    data_read : process( clock )
    begin
        if falling_edge(clock) then
            x_in <= x_arr(to_integer(unsigned(addr_x)));
        end if;
    end process ; -- data_read

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    test_main : process
    begin
        addr_y <= (others=>'0');
        linear_enable <= '0';
        wait until reset='0';
        wait for C_CLK_PERIOD;
        linear_enable <= '1';
        wait for C_CLK_PERIOD;
        wait until done='1';
        addr_y <= (others=>'0');
        wait for C_CLK_PERIOD;
        addr_y <= "1";
        wait;
    end process ; -- test_main

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    uut: entity work.fp_linear_1d(rtl)
    -- Testbench DUT generics
    generic map (
        ADDR_X_WIDTH => 2,
        ADDR_Y_WIDTH => 1,
        DATA_WIDTH => 8,
        FRAC_WIDTH => 4,
        IN_FEATURE_COUNT => 3,
        OUT_FEATURE_COUNT => 2,
        OUT_BUF_TYPE => "auto"
    )
    port map (
        enable => linear_enable,
        clock  => clock,
        addr_x => addr_x,
        addr_y => addr_y,
        
        x_in   => x_in,
        y_out   => y_out,

        done   => done
    );

end architecture;