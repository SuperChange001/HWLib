library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

library work;
use work.all;

entity fp_linear_1d_0 is -- layer_name is for distinguish same type of layers (with various weights) in one module
    generic (
        DATA_WIDTH   : integer := 8;
        FRAC_WIDTH   : integer := 4;
        X_ADDR_WIDTH : integer := 2;
        Y_ADDR_WIDTH : integer := 2;
        IN_FEATURE_NUM : integer := 3;
        OUT_FEATURE_NUM : integer := 4;
        RESOURCE_OPTION : string := "auto" -- can be "distributed", "block", or  "auto"
    );
    port (
        enable : in std_logic;
        clock  : in std_logic;
        x_addr : out std_logic_vector(X_ADDR_WIDTH-1 downto 0);
        y_addr : in std_logic_vector(Y_ADDR_WIDTH-1 downto 0);

        x_in   : in std_logic_vector(DATA_WIDTH-1 downto 0);
        y_out  : out std_logic_vector(DATA_WIDTH-1 downto 0);

        done   : out std_logic
    );
end fp_linear_1d_0;

architecture rtl of fp_linear_1d_0 is
    -----------------------------------------------------------
    -- Functions
    -----------------------------------------------------------
    -- macc
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

    -- Log2 funtion is for calculating the bitwidth of the address lines
    -- for bias and weights rom
    function log2(val : INTEGER) return natural is
        variable res : natural;
    begin
        for i in 0 to 31 loop
            if (val <= (2 ** i)) then
                res := i;
                exit;
            end if;
        end loop;
        return res;
    end function log2;

    -----------------------------------------------------------
    -- Signals
    -----------------------------------------------------------
    constant FP_ZERO : signed(DATA_WIDTH-1 downto 0) := (others=>'0');

    type t_state is (s_stop, s_forward, s_idle);

    signal n_clock : std_logic;
    signal w_in : std_logic_vector(DATA_WIDTH-1 downto 0) := (others=>'0');
    signal b_in : std_logic_vector(DATA_WIDTH-1 downto 0) := (others=>'0');

    signal addr_w : std_logic_vector(log2(IN_FEATURE_NUM*OUT_FEATURE_NUM)-1 downto 0) := (others=>'0');
    --signal addr_b : std_logic_vector((log2(OUT_FEATURE_NUM)-1) downto 0) := (others=>'0');
    signal addr_b : std_logic_vector(Y_ADDR_WIDTH-1 downto 0) := (others=>'0');

    signal fp_x, fp_w, fp_b, fp_y, macc_sum : signed(DATA_WIDTH-1 downto 0) := (others=>'0');

    signal reset : std_logic := '0';
    signal state : t_state;

    -- simple solution for the output buffer
    type t_y_array is array (0 to OUT_FEATURE_NUM) of std_logic_vector(DATA_WIDTH-1 downto 0);
    shared variable y_ram : t_y_array;
    attribute rom_style : string;
    attribute rom_style of y_ram : variable is RESOURCE_OPTION;

begin

    -- connecting signals to ports
    n_clock <= not clock;

    fp_w <= signed(w_in);
    fp_x <= signed(x_in);
    fp_b <= signed(b_in);

    -- connects ports
    reset <= not enable;

    linear_main : process (clock, enable)
        variable current_neuron_idx : integer range 0 to OUT_FEATURE_NUM-1 := 0;
        variable current_input_idx : integer  range 0 to IN_FEATURE_NUM-1 := 0;
        variable var_addr_w : integer range 0 to OUT_FEATURE_NUM*IN_FEATURE_NUM-1 := 0;
        variable var_sum : signed(DATA_WIDTH-1 downto 0);
        variable var_w, var_x, var_y : signed(DATA_WIDTH-1 downto 0);
        variable y_write_en : std_logic;
        variable var_y_write_idx : integer;
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

                if current_input_idx<IN_FEATURE_NUM-1 then
                    current_input_idx := current_input_idx + 1;
                    var_addr_w := var_addr_w + 1;
                else
                    current_input_idx := 0;

                    y_write_en := '1';
                    var_y_write_idx := current_neuron_idx;

                    if current_neuron_idx<OUT_FEATURE_NUM-1 then
                        current_neuron_idx := current_neuron_idx + 1;
                        var_addr_w := var_addr_w + 1;
                        state <= s_stop;
                    else
                        state <= s_idle;
                        current_neuron_idx := 0;
                    end if;

                end if;
            else
                done <= '1';
            end if;

            var_sum := multiply_accumulate(var_w, var_x, var_y);
            macc_sum <= var_sum;

            if y_write_en='1'then
                y_ram(var_y_write_idx) := std_logic_vector(var_sum);
                y_write_en := '0';
            end if;

        end if;

        x_addr <= std_logic_vector(to_unsigned(current_input_idx, x_addr'length));
        addr_w <= std_logic_vector(to_unsigned(var_addr_w, addr_w'length));
        addr_b <= std_logic_vector(to_unsigned(current_neuron_idx, addr_b'length));
    end process linear_main;

    y_reading : process (clock, state)
    begin
        if state=s_idle then
            if falling_edge(clock) then
                -- After the layer in at idle mode, y_out is readable
                -- but it only update at the rising edge of the clock
                y_out <= y_ram(to_integer(unsigned(y_addr)));
            end if;
        end if;
    end process y_reading;

    -- Weights
    rom_w : entity work.w_rom_fp_linear_1d_0(rtl)
    port map  (
        clk  => n_clock,
        en   => '1',
        addr => addr_w,
        data => w_in
    );

    -- Bias
    rom_b : entity work.b_rom_fp_linear_1d_0(rtl)
    port map  (
        clk  => n_clock,
        en   => '1',
        addr => addr_b,
        data => b_in
    );

end architecture rtl;