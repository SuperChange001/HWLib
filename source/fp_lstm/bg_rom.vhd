library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bg_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(5-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity bg_rom;
architecture rtl of bg_rom is
type bg_rom_array_t is array (0 to 2**5-1) of std_logic_vector(16-1 downto 0);
signal ROM : bg_rom_array_t:=(x"0041",x"001d",x"006f",x"ffc2",x"ffeb",x"0091",x"ffd1",x"ffdb",x"ffeb",x"ffe5",x"0053",x"ff70",x"0024",x"fff7",x"ffdb",x"ffe1",x"001a",x"0028",x"ff64",x"0014",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
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
