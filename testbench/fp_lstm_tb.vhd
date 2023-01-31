-- Testbench for testing my fp_lstm
-- Dependencies:
-- 
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

library work;
use work.all;

-----------------------------------------------------------

entity fp_lstm_tb is
port(
    clk : out std_logic
    );
end entity ;

-----------------------------------------------------------
architecture rtl of fp_lstm_tb is
    constant C_CLK_PERIOD : time := 10 ns;      
    signal clock : std_logic := '0';
    signal reset : std_logic := '0';
    signal lstm_enable : std_logic := '0';

    -- I only test the behavior of 8bits fixed point data with 4 bits fractional parts.
    signal x_in : std_logic_vector(15 downto 0);
    signal y_out : std_logic_vector(15 downto 0);

    signal x_addr : std_logic_vector(3-1 downto 0);
    signal y_addr : std_logic_vector(5-1 downto 0);
    
    signal done : std_logic;
    type t_array_x is array (0 to 3*6-1) of std_logic_vector(16-1 downto 0);
    signal x_arr : t_array_x := (x"0011",x"0012",x"0013",x"0014",x"0015",x"0016",
                                 x"0021",x"0022",x"0023",x"0024",x"0025",x"0026",
                                 x"0031",x"0032",x"0033",x"0034",x"0035",x"0036");

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
            x_in <= x_arr(to_integer(unsigned(x_addr)));
        end if;
    end process ; -- data_read

    -----------------------------------------------------------
    -- Testbench Stimulus
    -----------------------------------------------------------
    test_main : process
    begin
        y_addr <= (others=>'0');
        lstm_enable <= '0';
        wait until reset='0';
        wait for C_CLK_PERIOD;
        lstm_enable <= '1';
        wait for C_CLK_PERIOD;
        wait until done='1';
        -- y_addr <= (others=>'0');
        -- wait for C_CLK_PERIOD;
        -- report "The correct value should be 17 while y_out is " & integer'image(to_integer(signed(y_out)));
        -- y_addr <= "1";
        -- wait for C_CLK_PERIOD;
        -- report "The correct value should be 33 while y_out is " & integer'image(to_integer(signed(y_out)));
        wait for C_CLK_PERIOD;
        report "Simulation finished";
        wait;
    end process ; -- test_main

    -----------------------------------------------------------
    -- Entity Under Test
    -----------------------------------------------------------
    uut: entity work.fp_lstm(rtl)
    -- Testbench DUT generics
    generic map (
        X_ADDR_WIDTH => 3,
        Y_ADDR_WIDTH => 5,
        DATA_WIDTH => 16,
        FRAC_WIDTH => 8,
        LSTM_INPUTS => 6,
        IN_FEATURE_NUM => 1,
        OUT_FEATURE_NUM => 20
        -- RESOURCE_OPTION => "auto"
    )
    port map (
        enable => lstm_enable,
        clock  => clock,
        x_addr => x_addr,
        y_addr => y_addr,
        
        x_in   => x_in,
        y_out   => y_out,

        done   => done
    );

end architecture;