-- Sync LSTM Cell, and scalable

LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.lstm_common.all;

entity lstm_cell is
    generic (
        DATA_WIDTH  : integer := 8;    -- that fixed point data has 16bits
        FRAC_WIDTH  : integer := 4;     -- and 8bits is for the factional part

        INPUT_SIZE  : integer := 5;     -- same as input_size of the lstm_cell in PyTorch
        HIDDEN_SIZE : integer := 3;     -- same as hidden_size of the lstm_cell in PyTorch

        X_ADDR_WIDTH : integer := 3;  -- equals to ceil(log2(input_size+hidden_size))
        HIDDEN_ADDR_WIDTH : integer := 3  -- equals to ceil(log2(hidden_size))

        );
    port (
        clock     : in std_logic;
--        clk_hadamard     : in std_logic;
        reset     : in std_logic;
        enable    : in std_logic;    -- start computing when it is '1'
        zero_state : in std_logic;   -- first_round so h_t is zero, c_t is also zero
        x_addr  : out std_logic_vector(INPUT_SIZE-1 downto 0); -- each rising_edge update x_data
        x_data  : in std_logic_vector(DATA_WIDTH-1 downto 0);

        done      : out std_logic;

        h_out_en   : in std_logic;
        h_out_addr : in std_logic_vector(HIDDEN_ADDR_WIDTH-1 downto 0); -- each rising_edge update h_out_data
        h_out_data : out std_logic_vector(DATA_WIDTH-1 downto 0)  --  accordingly when h_out_en is high
    );
end lstm_cell;

architecture rtl of lstm_cell is

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

    constant VECTOR_LENGTH : integer := INPUT_SIZE + HIDDEN_SIZE;
    constant MATRIX_LENGHT : integer := (INPUT_SIZE + HIDDEN_SIZE) * HIDDEN_SIZE;
    constant W_ADDR_WIDTH : integer := log2((INPUT_SIZE+HIDDEN_SIZE)*HIDDEN_SIZE);     -- equals to ceil(log2((input_size+hidden_size)*hidden_size)

    signal n_clock : std_logic;
    signal clk_hadamard_internal:std_logic;
    
    -- The state machine controls the gate component to be reused over time
    type state_t is (s_gates, s_i, s_f, s_g, s_o, s_c, s_h,s_update, idle);
    signal cell_state : state_t;

    signal std_x_h_read_addr : std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    signal std_x_h_read_data : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_c_read_addr : std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    signal std_c_read_data : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal x_h_read_data      : signed(DATA_WIDTH-1 downto 0):= (others => '0');
    signal c_read_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');

    signal c_t_addr,h_t_addr,h_t_addr_update : unsigned(HIDDEN_ADDR_WIDTH-1 downto 0):= (others => '0');

    signal x_h_config_we, c_config_we : std_logic;
    signal c_config_addr : std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    signal c_config_data : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal x_h_config_addr : std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    signal x_h_config_data : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');

    signal gates_out_valid : std_logic;
    signal gate_process_enable : std_logic;
    signal gate_process_done : std_logic;
    signal vector_hadamard_product_done: std_logic;
    signal i_gate_out, f_gate_out, g_gate_out, o_gate_out : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal i_gate_act, f_gate_act, g_gate_act, o_gate_act : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal new_c, new_c_act : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal new_h : signed((DATA_WIDTH-1) downto 0):= (others => '0');

    signal idx_hidden_out : integer range 0 to HIDDEN_SIZE;
    
    signal test_matrix_idx_s : integer range 0 to MATRIX_LENGHT;
    signal test_hidden_idx_s  : integer range 0 to HIDDEN_SIZE;
    signal test_running_state : integer range 0 to 7;
    signal test_dot_sum_i: signed((2*DATA_WIDTH-1) downto 0):= (others => '0');

    signal w_i_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal w_f_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal w_g_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal w_o_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_wi_out : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_wf_out : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_wg_out : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_wo_out : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_w_read_addr : std_logic_vector((W_ADDR_WIDTH-1) downto 0):= (others => '0');

    signal b_i_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal b_f_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal b_g_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal b_o_data : signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_bi_out : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_bf_out : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_bg_out : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_bo_out : std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal std_b_read_addr : std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    
    signal state_update_we:std_logic:='0';
    signal state_update_x_h_addr:std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    signal state_update_x_h_data:std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal state_update_cell_addr:std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    signal state_update_cell_data:std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    
    signal sigmoid_in, sigmoid_out :signed((DATA_WIDTH-1) downto 0):= (others => '0');
    signal tanh_in, tanh_out :signed((DATA_WIDTH-1) downto 0):= (others => '0');
    
    signal temp_h_config_addr, temp_h_read_addr, temp_h_update_addr:std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    
    signal temp_h_config_data, std_temp_h_read_data :std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal temp_h_config_we:std_logic;
    
    signal temp_c_config_addr, temp_c_read_addr, temp_c_update_addr:std_logic_vector((HIDDEN_ADDR_WIDTH-1) downto 0):= (others => '0');
    
    signal temp_c_config_data, std_temp_c_read_data :std_logic_vector((DATA_WIDTH-1) downto 0):= (others => '0');
    signal temp_c_config_we:std_logic;
begin

n_clock <= not clock;

-- only for power estimation
-- clk_hadamard_internal <= clk_hadamard;

--------------------------------------------------------
-- for clock scaling basically
clk_hadamard_internal <= clock;

-- process(clock)
-- variable cnt:unsigned(3 downto 0):="0000";
-- begin
--   if rising_edge(clock) then
--           cnt := cnt+1;
--           clk_hadamard_internal <= cnt(2);
--   end if;
-- end process;
--------------------------------------------------------

-- Instantiation x input buffer
buffer_h : entity work.dual_port_2_clock_ram(rtl)
generic map (
    RAM_WIDTH => DATA_WIDTH,
    RAM_DEPTH_WIDTH => HIDDEN_ADDR_WIDTH,
    RAM_PERFORMANCE => "LOW_LATENCY",
    INIT_FILE => ""--"/home/chao/git/lstm/data/x_h.dat" -- so relative path also xil_defaultlibs for ghdl, this path is relative to the path of the makefile, e.g "data/xx.dat"
)
port map  (
    addra  => x_h_config_addr,
    addrb  => std_x_h_read_addr,
    dina   => x_h_config_data,
    clka   => clock,
    clkb   => n_clock,
    wea    => x_h_config_we,
    enb    => '1',
    rstb   => '0',
    regceb => '0',
    doutb  => std_x_h_read_data
);
x_h_read_data <= signed(std_x_h_read_data);

x_h_config_addr <= state_update_x_h_addr;
x_h_config_data <= state_update_x_h_data;
x_h_config_we <= state_update_we;

buffer_c : entity work.dual_port_2_clock_ram(rtl)
generic map (
    RAM_WIDTH => DATA_WIDTH,
    RAM_DEPTH_WIDTH => HIDDEN_ADDR_WIDTH,
    RAM_PERFORMANCE => "LOW_LATENCY",
    INIT_FILE => "" --"/home/chao/git/lstm/data/c.dat"
)
port map  (
    addra  => c_config_addr,
    addrb  => std_c_read_addr,
    dina   => c_config_data,
    clka   => clock,
    clkb   => clk_hadamard_internal,
    wea    => c_config_we,
    enb    => '1',
    rstb   => '0',
    regceb => '0',
    doutb  => std_c_read_data
);

std_c_read_addr <= std_logic_vector(c_t_addr);
c_read_data <= signed(std_c_read_data);

c_config_addr <= state_update_cell_addr;
c_config_data <= state_update_cell_data;
c_config_we <= state_update_we;


temp_h : entity work.dual_port_2_clock_ram(rtl)
generic map (
    RAM_WIDTH => DATA_WIDTH,
    RAM_DEPTH_WIDTH => HIDDEN_ADDR_WIDTH,
    RAM_PERFORMANCE => "LOW_LATENCY",
    INIT_FILE => ""--"/home/chao/git/lstm/data/x_h.dat" -- so relative path also xil_defaultlibs for ghdl, this path is relative to the path of the makefile, e.g "data/xx.dat"
)
port map  (
    addra  => temp_h_config_addr,
    addrb  => temp_h_read_addr,
    dina   => temp_h_config_data,
    clka   => clock,
    clkb   => n_clock,
    wea    => temp_h_config_we,
    enb    => '1',
    rstb   => '0',
    regceb => '0',
    doutb  => std_temp_h_read_data
);


temp_c : entity work.dual_port_2_clock_ram(rtl)
generic map (
    RAM_WIDTH => DATA_WIDTH,
    RAM_DEPTH_WIDTH => HIDDEN_ADDR_WIDTH,
    RAM_PERFORMANCE => "LOW_LATENCY",
    INIT_FILE => ""--"/home/chao/git/lstm/data/x_h.dat" -- so relative path also xil_defaultlibs for ghdl, this path is relative to the path of the makefile, e.g "data/xx.dat"
)
port map  (
    addra  => temp_c_config_addr,
    addrb  => temp_c_read_addr,
    dina   => temp_c_config_data,
    clka   => n_clock,
    clkb   => n_clock,
    wea    => temp_c_config_we,
    enb    => '1',
    rstb   => '0',
    regceb => '0',
    doutb  => std_temp_c_read_data
);

MAIN_PROCESS : process(clock, enable, reset)
begin
    if reset = '1' then
        cell_state <= s_gates;
        done <= '0';
        gate_process_enable <= '0';
    elsif enable = '1' then
        if rising_edge(clock) then
            if cell_state = s_gates then
                gate_process_enable <= '1';
                if vector_hadamard_product_done ='1' then
                    cell_state <= idle;
                end if;
            else
                done <= '1';    
            end if;
        end if;
    end if;
end process;

gate_process : process(clock, gate_process_enable, reset)
    variable var_x_h_idx : integer range 0 to VECTOR_LENGTH;
    variable is_data_prefetched : std_logic;
    variable dot_sum_i, dot_sum_f,dot_sum_g, dot_sum_o : signed(2*DATA_WIDTH-1 downto 0);
    variable mul_i, mul_f, mul_g, mul_o : signed(2*DATA_WIDTH-1 downto 0);
    variable var_matrix_idx : integer range 0 to MATRIX_LENGHT;
    variable var_hidden_idx : integer range 0 to HIDDEN_SIZE;
    variable var_x_h_data : signed(DATA_WIDTH-1 downto 0); 
    variable var_w_i_data : signed(DATA_WIDTH-1 downto 0); 
    variable var_w_g_data : signed(DATA_WIDTH-1 downto 0); 
    variable var_w_o_data : signed(DATA_WIDTH-1 downto 0); 
    variable var_w_f_data : signed(DATA_WIDTH-1 downto 0); 
begin

        if reset = '1' then
            var_x_h_idx := 0;
            var_matrix_idx := 0;
            var_hidden_idx := 0;
            gate_process_done <= '0';
            gates_out_valid <= '0';
            is_data_prefetched := '0';
            dot_sum_i := (others=>'0');
            dot_sum_f := (others=>'0');
            dot_sum_g := (others=>'0');
            dot_sum_o := (others=>'0');
       elsif rising_edge(clock) then
         
            if gate_process_enable = '1' and gate_process_done='0' then
                if is_data_prefetched ='0' then
                    is_data_prefetched := '1';
                    if var_x_h_idx = 0 then
                        var_x_h_data := signed(x_data);
                    else
                        if zero_state = '1' then
                            var_x_h_data := (others=>'0');
                        else
                            var_x_h_data := x_h_read_data;
                        end if;
                    end if;
                    var_w_f_data := w_f_data;
                    var_w_i_data := w_i_data;
                    var_w_g_data := w_g_data;
                    var_w_o_data := w_o_data;
                    
                else
    
                     if var_x_h_idx = 1 then   -- 1,2,4,8 for 100MHz, 50MHz, 25MHz, 12.5MHz
                        gates_out_valid <= '0';
                     end if;
    
                    mul_i := multiply_16_8_without_cut(var_x_h_data, var_w_i_data);
                    mul_f := multiply_16_8_without_cut(var_x_h_data, var_w_f_data);
                    mul_g := multiply_16_8_without_cut(var_x_h_data, var_w_g_data);
                    mul_o := multiply_16_8_without_cut(var_x_h_data, var_w_o_data);
            
                    dot_sum_i := dot_sum_i + mul_i;
                    dot_sum_f := dot_sum_f + mul_f;
                    dot_sum_g := dot_sum_g + mul_g;
                    dot_sum_o := dot_sum_o + mul_o;
                    
                    var_x_h_idx := var_x_h_idx + 1;
                    var_matrix_idx := var_matrix_idx + 1;
                    is_data_prefetched := '0';
                    if var_x_h_idx = VECTOR_LENGTH then
                        gates_out_valid <= '1';
                        dot_sum_i := dot_sum_i;
                        dot_sum_f := dot_sum_f;
                        dot_sum_g := dot_sum_g;
                        dot_sum_o := dot_sum_o;
                        
                        i_gate_out <= cut_16_to_8(dot_sum_i)+b_i_data;
                        f_gate_out <= cut_16_to_8(dot_sum_f)+b_f_data;
                        g_gate_out <= cut_16_to_8(dot_sum_g)+b_g_data;
                        o_gate_out <= cut_16_to_8(dot_sum_o)+b_o_data;
                        
                        idx_hidden_out <= var_hidden_idx;
                        var_x_h_idx := 0;
                        
                        var_hidden_idx := var_hidden_idx +1;
                        if var_hidden_idx=HIDDEN_SIZE then
                            -- finished all gates
                            gate_process_done <= '1';
                        else
                            dot_sum_i := (others=>'0');
                            dot_sum_f := (others=>'0');
                            dot_sum_g := (others=>'0');
                            dot_sum_o := (others=>'0');
                        end if;
                    end if;
                end if;
            end if;
            std_x_h_read_addr <= std_logic_vector(to_unsigned(var_x_h_idx-1, std_x_h_read_addr'length));
            std_w_read_addr <= std_logic_vector(to_unsigned(var_matrix_idx, std_w_read_addr'length));
            std_b_read_addr <= std_logic_vector(to_unsigned(var_hidden_idx, std_b_read_addr'length));
        
            test_matrix_idx_s <= var_matrix_idx;
            test_hidden_idx_s <= var_hidden_idx;
            test_dot_sum_i <= dot_sum_i;
        end if;
    
end process;

SHARED_SIGMOID : entity work.sigmoid(rtl_256)
port map (
    sigmoid_in,
    sigmoid_out
);

SHARED_TANH : entity work.tanh(rtl_256)
port map (
    tanh_in,
    tanh_out
);

vector_hadamard_product: process(reset, clk_hadamard_internal, gates_out_valid)
    variable var_running_state : integer range 0 to 7;
    variable mul_f_c, mul_i_g: signed(DATA_WIDTH-1 downto 0);
    variable var_new_c,var_new_h : signed(DATA_WIDTH-1 downto 0);
    variable new_c_idx, new_h_idx, update_cnt : integer range 0 to HIDDEN_SIZE;
    variable var_c_read_data, var_f_gate_act, var_i_gate_act, var_g_gate_act, var_o_gate_act : signed(DATA_WIDTH-1 downto 0);
    variable var_new_c_act : signed(DATA_WIDTH-1 downto 0);
    variable fms_act : integer:=0;
    variable fms_update : integer:=0;
begin
        if reset = '1' then
            var_running_state := 0;
            new_c_idx := 0;
            new_h_idx := 0;
            update_cnt := 0;
            vector_hadamard_product_done <='0';
            state_update_we <= '0';
            fms_act := 0;
        elsif rising_edge(clk_hadamard_internal) then

            if gates_out_valid='1' and var_running_state = 0 then
                temp_h_config_we <= '0';
                
                if fms_act = 0 then
                    if zero_state = '1' then
                        var_c_read_data := (others=>'0');
                    else
                        var_c_read_data := c_read_data;
                    end if;
                    sigmoid_in <= f_gate_out;
                    tanh_in <= g_gate_out;
                elsif fms_act =1 then
                    var_f_gate_act := sigmoid_out;
                    var_g_gate_act := tanh_out;
                    
                    sigmoid_in <= i_gate_out;
                elsif fms_act =2 then
                    mul_f_c := multiply_16_8(var_f_gate_act, var_c_read_data);
                    var_i_gate_act := sigmoid_out;
                    
                    sigmoid_in <= o_gate_out;
                    
                elsif fms_act =3 then    
                    mul_i_g := multiply_16_8(var_i_gate_act,var_g_gate_act);
                    var_running_state := 2;
                end if;
                
                fms_act := fms_act+1;

            elsif var_running_state=2 then    
                var_new_c := (mul_f_c + mul_i_g);
                tanh_in <= var_new_c;
                var_running_state := 3;
                temp_c_config_addr <= std_logic_vector(to_unsigned(new_c_idx, HIDDEN_ADDR_WIDTH));
                temp_c_config_data <= std_logic_vector(var_new_c);
                temp_c_config_we <= '1';
                new_c_idx := new_c_idx + 1;
            elsif var_running_state=3 then
                var_running_state :=4;
                var_o_gate_act := sigmoid_out;
                var_new_c_act := tanh_out;
            elsif var_running_state=4 then
                
                
                
                var_new_h := multiply_16_8(var_o_gate_act, var_new_c_act);
                new_h <= var_new_h;
--                var_buffer_h_t(new_h_idx) := var_new_h;
                temp_h_config_addr <= std_logic_vector(to_unsigned(new_h_idx, X_ADDR_WIDTH));
                temp_h_config_data <= std_logic_vector(var_new_h);
                temp_h_config_we <= '1';
                new_h_idx := new_h_idx+1;
                fms_act := 0;
                if gate_process_done='0' then
                    var_running_state := 0;
                else
                    var_running_state := 5;
                    fms_update :=0;
                    update_cnt := 0;
                end if;
            elsif var_running_state=5 then -- update the temp data to mem
                temp_h_config_we <= '0';
                temp_c_config_we <= '0';
                state_update_we<='1';

                if fms_update=0 then
                    state_update_cell_addr <= std_logic_vector(to_unsigned(update_cnt, state_update_cell_addr'length));
                    state_update_x_h_addr <= std_logic_vector(to_unsigned(update_cnt, state_update_x_h_addr'length));
                    temp_h_update_addr <= std_logic_vector(to_unsigned(update_cnt, temp_h_update_addr'length));
                    temp_c_read_addr <= std_logic_vector(to_unsigned(update_cnt, temp_c_read_addr'length));
                    fms_update := 1;
                else
                    fms_update := 0;
                    state_update_cell_data <=  std_temp_c_read_data;
                    state_update_x_h_data <=  std_temp_h_read_data;
                    update_cnt := update_cnt+1;
                    if update_cnt=HIDDEN_SIZE then
                        
                        var_running_state := 6;
                        
                    end if;
                end if;
                
                
            elsif var_running_state=6 then
                state_update_we<='0';
                vector_hadamard_product_done <='1';
            end if;
        end if;

    c_t_addr <= to_unsigned(new_c_idx, c_t_addr'length);
    test_running_state <= var_running_state;
end process;


temp_h_read_addr <= h_out_addr when cell_state=idle else
                temp_h_update_addr;
h_out_data <= std_temp_h_read_data;

-- weights
-- [Wii,Whi]
rom_wi : entity work.wi_rom(rtl)
port map  (
    clk  => n_clock,
    en   => '1', -- todo can be optimized
    addr => std_w_read_addr,
    data => std_wi_out
);
w_i_data <= signed(std_wi_out);

-- [Wif,Whf]
rom_wf : entity work.wf_rom(rtl)
port map  (
    clk  => n_clock,
    en   => '1', -- todo can be optimized
    addr => std_w_read_addr,
    data => std_wf_out
);
w_f_data <= signed(std_wf_out);

-- [Wig,Whg]
rom_wg : entity work.wg_rom(rtl)
port map  (
    clk  => n_clock,
    en   => '1', -- todo can be optimized
    addr => std_w_read_addr,
    data => std_wg_out
);
w_g_data <= signed(std_wg_out);

-- [Wif,Whf]
rom_wo : entity work.wo_rom(rtl)
port map  (
    clk  => n_clock,
    en   => '1', -- todo can be optimized
    addr => std_w_read_addr,
    data => std_wo_out
);
w_o_data <= signed(std_wo_out);

-- biases
-- [Bii+Bhi]
rom_bi : entity work.bi_rom(rtl)
port map  (
    clk  => clock,
    en   => '1', -- todo can be optimized
    addr => std_b_read_addr,
    data => std_bi_out
);
b_i_data <= signed(std_bi_out); 

-- [Bif+Bhf]
rom_bf : entity work.bf_rom(rtl)
port map  (
    clk  => clock,
    en   => '1', -- todo can be optimized
    addr => std_b_read_addr,
    data => std_bf_out
);
b_f_data <= signed(std_bf_out);

-- [Big+Bhg]
rom_bg : entity work.bg_rom(rtl)
port map  (
    clk  => clock,
    en   => '1', -- todo can be optimized
    addr => std_b_read_addr,
    data => std_bg_out
);
b_g_data <= signed(std_bg_out);

-- [Bio+Bho]
rom_bo : entity work.bo_rom(rtl)
port map  (
    clk  => clock,
    en   => '1', -- todo can be optimized
    addr => std_b_read_addr,
    data => std_bo_out
);
b_o_data <= signed(std_bo_out);

end rtl;
