library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fp_lstm is
    generic (
        X_ADDR_WIDTH : integer;
        Y_ADDR_WIDTH : integer;
        DATA_WIDTH : integer;
        FRAC_WIDTH : integer;
        LSTM_INPUTS : integer;
        IN_FEATURE_NUM : integer;
        OUT_FEATURE_NUM : integer
        -- RESOURCE_OPTION : string
    );
    port (
        enable : in std_logic;
        clock : in std_logic;

        x_addr : out std_logic_vector(X_ADDR_WIDTH-1 downto 0);
        y_addr : in std_logic_vector(Y_ADDR_WIDTH-1 downto 0);

        x_in   : in std_logic_vector(DATA_WIDTH-1 downto 0);
        y_out  : out std_logic_vector(DATA_WIDTH-1 downto 0);

        done   : out std_logic
    );
end entity fp_lstm;

architecture rtl of fp_lstm is

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
    
    --
    -- Constants
    --
    constant lstm_cell_hidden_size : integer := OUT_FEATURE_NUM;
    constant LSTM_CELL_X_ADDR_WIDTH : integer := log2(IN_FEATURE_NUM);
    constant LSTM_CELL_HIDDEN_ADDR_WIDTH : integer := log2(OUT_FEATURE_NUM);
    signal lstm_cell_done : std_logic;
    signal lstm_cell_reset: std_logic;
    signal lstm_cell_enable: std_logic;
    signal lstm_cell_zero_state : std_logic;
    signal lstm_cell_x_addr : std_logic_vector(LSTM_CELL_X_ADDR_WIDTH-1 downto 0):=(others=>'0');
    signal lstm_cell_x_data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal lstm_cell_out_data : std_logic_vector(DATA_WIDTH-1 downto 0);
    signal lstm_cell_out_addr : std_logic_vector(Y_ADDR_WIDTH-1 downto 0);
    signal lstm_cell_out_en : std_logic;

begin
    lstm_cell_out_addr <= y_addr;
    lstm_cell_x_data <= x_in;
    y_out <= lstm_cell_out_data;

    cell_iteration: process(clock)
        variable lstm_cell_counter : integer range 0 to LSTM_INPUTS := 0;
        variable x_addr_offset : integer range 0 to LSTM_INPUTS*IN_FEATURE_NUM-1 := 0;
        variable var_x_addr : integer range 0 to LSTM_INPUTS*IN_FEATURE_NUM-1 := 0;
    begin
        if rising_edge(clock) then
            if enable='0' then
                -- reset the counter
                lstm_cell_counter := 0;
                x_addr_offset := 0;
                lstm_cell_zero_state <= '1';

                -- disable the LSTM cell
                lstm_cell_out_en <= '0';
                lstm_cell_reset <= '1';
                lstm_cell_enable <= '0';
                
                -- done='1' means next layer can start computation
                done <='0';
            else
                -- enable the LSTM cell
                lstm_cell_enable <= '1';

                if lstm_cell_reset='1' then
                    lstm_cell_reset <= '0';
                else
                    if lstm_cell_done ='1' then
                        lstm_cell_zero_state <= '0';
                        if lstm_cell_counter = LSTM_INPUTS-1 then
                            done <='1';
                            lstm_cell_out_en<='1';
                        else
                            lstm_cell_counter := lstm_cell_counter + 1;
                            x_addr_offset := x_addr_offset + IN_FEATURE_NUM;
                            lstm_cell_reset <= '1';
                        end if;
                    end if; 
                end if;

            end if;
            -- supports multiple input features and multiple input time steps
            var_x_addr := x_addr_offset + to_integer(unsigned(lstm_cell_x_addr));
            x_addr <= std_logic_vector(to_unsigned(var_x_addr, x_addr'length));
        end if;
    end process; -- cell_iteration

    -- fake_lstm_cell: process(clock, lstm_cell_reset)
    -- variable inside_counter : integer range 0 to 3 := 0; 
    -- begin
    --     if rising_edge(clock) then
    --         if lstm_cell_reset='1' or enable = '0' then
    --             if lstm_cell_reset='1' then
    --                 inside_counter := 0;
    --                 lstm_cell_done <= '0';
    --                 lstm_cell_x_addr <= (others => '0');
    --             end if;
    --         else
    --             inside_counter := inside_counter + 1;
    --             if inside_counter = 3 then
    --                 lstm_cell_done <= '1';
    --                 inside_counter := 0;
    --             end if;
    --         end if;
    --         lstm_cell_x_addr <= std_logic_vector(to_unsigned(inside_counter, lstm_cell_x_addr'length));
    --     end if;
    -- end process;

    i_lstm_cell: entity work.lstm_cell(rtl)
    generic map (
        DATA_WIDTH => DATA_WIDTH,
        FRAC_WIDTH => FRAC_WIDTH,
        INPUT_SIZE => IN_FEATURE_NUM,
        HIDDEN_SIZE => LSTM_CELL_HIDDEN_SIZE,
        X_ADDR_WIDTH => LSTM_CELL_X_ADDR_WIDTH,
        HIDDEN_ADDR_WIDTH => LSTM_CELL_HIDDEN_ADDR_WIDTH
        -- W_ADDR_WIDTH => LSTM_CELL_W_ADDR_WIDTH
        )
        port map (
        clock => clock,
        reset => lstm_cell_reset,
        enable => lstm_cell_enable,
        zero_state => lstm_cell_zero_state,
        x_addr => lstm_cell_x_addr,
        x_data => lstm_cell_x_data,
        done => lstm_cell_done,
        h_out_en => lstm_cell_out_en,
        h_out_data => lstm_cell_out_data,
        h_out_addr => lstm_cell_out_addr
    );


end architecture rtl;