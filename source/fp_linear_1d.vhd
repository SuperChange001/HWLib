library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions

library work;
use work.all;

entity fp_linear_1d is
    generic (
        ADDR_X_WIDTH : integer;
        ADDR_W_WIDTH : integer;
        ADDR_Y_WIDTH : integer;
        DATA_WIDTH : integer;
        FRAC_WIDTH : integer;
        IN_FEATURE_COUNT : integer;
        OUT_FEATURE_COUNT : integer
    );
    port (
        enable : in std_logic;
        clock  : in std_logic;
        addr_x : out std_logic_vector(ADDR_X_WIDTH-1 downto 0);
        addr_w : out std_logic_vector(ADDR_W_WIDTH-1 downto 0);
        addr_y : in std_logic_vector(ADDR_Y_WIDTH-1 downto 0);

        x_in   : in std_logic_vector(DATA_WIDTH-1 downto 0);
        w_in   : in std_logic_vector(DATA_WIDTH-1 downto 0);
        b_in   : in std_logic_vector(DATA_WIDTH-1 downto 0);
        
        y_out  : out std_logic_vector(DATA_WIDTH-1 downto 0);
        done   : out std_logic
    );
end fp_linear_1d;

architecture rtl of fp_linear_1d is
    constant FP_ZERO : signed(DATA_WIDTH-1 downto 0) := (others=>'0');

    type t_state is (s_stop, s_forward, s_idle);

    signal fp_x, fp_w, fp_b, fp_y, macc_sum: signed(DATA_WIDTH-1 downto 0);

    signal reset : std_logic := '0';
    signal state : t_state;

    -----------------------------------------------------------
    -- functions
    -----------------------------------------------------------
    -- macc,
    function multiply_accumulate(w : in signed(DATA_WIDTH-1 downto 0);
                    x : in signed(DATA_WIDTH-1 downto 0);
                    y_0 : in signed(DATA_WIDTH-1 downto 0)
            ) return signed is

        variable TEMP : signed(DATA_WIDTH*2-1 downto 0) := (others=>'0');
        variable TEMP2 : signed(DATA_WIDTH-1 downto 0) := (others=>'0');
        variable TEMP3 : signed(FRAC_WIDTH-1 downto 0) := (others=>'0');
    begin
        TEMP := w * x;
        
        TEMP2 := TEMP(DATA_WIDTH+FRAC_WIDTH-1 downto FRAC_WIDTH);
        TEMP3 := TEMP(FRAC_WIDTH-1 downto 0);
        if TEMP2(DATA_WIDTH-1) = '1' and TEMP3 /= 0 then
            TEMP2 := TEMP2 + 1;
        end if;

        if TEMP>0 and TEMP2<0 then
            TEMP2 := ('0', others => '1');
        elsif TEMP<0 and TEMP2>0 then
            TEMP2 := ('1', others => '0');
        end if;
        return TEMP2+y_0;
    end function;

begin

    -- connecting signals to ports
    fp_w <= signed(w_in);
    fp_x <= signed(x_in);
    fp_b <= signed(b_in);

        
    -- connects ports
    reset <= not enable;

    linear_main : process (clock, enable)
        variable current_neuron_idx : integer := 0;
        variable current_input_idx : integer := 0;
        variable var_addr_w : integer := 0;
        variable var_sum : signed(DATA_WIDTH-1 downto 0);
        variable var_w, var_x, var_y : signed(DATA_WIDTH-1 downto 0);
    begin

        if (reset = '1') then
            state <= s_stop;
            done <= '0';

            current_neuron_idx := 0;
            current_input_idx := 0;

        elsif rising_edge(clock) then

            if state=s_stop then
                state <= s_forward;

                -- first add b accumulated sum
                var_y := fp_b;
                var_x := FP_ZERO;
                var_w := FP_ZERO;
            elsif state=s_forward then
                
                -- remapping to x and w 
                var_y := macc_sum;
                var_x := fp_x;
                var_w := fp_w;

                current_input_idx := current_neuron_idx + 1;
                var_addr_w := var_addr_w + 1;
                if current_input_idx=IN_FEATURE_COUNT then
                    current_input_idx := 0;
                    current_neuron_idx := current_neuron_idx + 1;
                    if current_neuron_idx=OUT_FEATURE_COUNT then
                        state <= s_idle;
                    else
                        state <= s_stop;
                    end if;
                end if;
            else
                done <= '1';
            end if;

            var_sum := multiply_accumulate(var_w, var_x, var_y);
            macc_sum <= var_sum;

        end if;

        addr_x <= std_logic_vector(to_unsigned(current_input_idx, addr_x'length));
        addr_w <= std_logic_vector(to_unsigned(var_addr_w, addr_x'length));
    end process linear_main;

end architecture rtl;