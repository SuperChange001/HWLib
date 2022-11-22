library ieee;
    use ieee.std_logic_1164.all;
    use ieee.std_logic_unsigned.all;
entity w_rom_fp_linear_1d_0 is
    port (
        clk : in std_logic;
        en : in std_logic;
        addr : in std_logic_vector(4-1 downto 0);
        data : out std_logic_vector(8-1 downto 0)
    );
end entity w_rom_fp_linear_1d_0;
architecture rtl of w_rom_fp_linear_1d_0 is
    type w_rom_fp_linear_1d_0_array_t is array (0 to 2**4-1) of std_logic_vector(8-1 downto 0);
    signal ROM : w_rom_fp_linear_1d_0_array_t:=(x"fe",x"03",x"fd",x"f7",x"02",x"fb",x"08",x"03",x"05",x"04",x"04",x"03",x"00",x"00",x"00",x"00");
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