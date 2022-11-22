library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
entity w_rom_fp_linear_1d_1 is
    port (
        clk : in std_logic;
        en : in std_logic;
        addr : in std_logic_vector(2-1 downto 0);
        data : out std_logic_vector(8-1 downto 0)
    );
end entity w_rom_fp_linear_1d_1;
architecture rtl of w_rom_fp_linear_1d_1 is
    type w_rom_fp_linear_1d_1_array_t is array (0 to 2**2-1) of std_logic_vector(8-1 downto 0);
    signal ROM : w_rom_fp_linear_1d_1_array_t:=(x"ff",x"04",x"05",x"fe");
    attribute rom_style : string;
    attribute rom_style of ROM : signal is "auto";
begin
    ROM_process: process(clk)
    begin
        if rising_edge(clk) then
            if (en = '1') then
                data <= ROM(conv_integer(addr));
            end if;
        end if;
    end process ROM_process;
end architecture rtl;