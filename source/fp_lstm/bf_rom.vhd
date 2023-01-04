library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bf_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(5-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity bf_rom;
architecture rtl of bf_rom is
type bf_rom_array_t is array (0 to 2**5-1) of std_logic_vector(16-1 downto 0);
signal ROM : bf_rom_array_t:=(x"0041",x"ffe5",x"0000",x"00a8",x"00ca",x"fed1",x"00c4",x"003d",x"ffa0",x"00b9",x"0084",x"0083",x"ffaf",x"0016",x"0122",x"ffb0",x"00c8",x"0004",x"0108",x"00bd",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
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
