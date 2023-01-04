library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bo_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(5-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity bo_rom;
architecture rtl of bo_rom is
type bo_rom_array_t is array (0 to 2**5-1) of std_logic_vector(16-1 downto 0);
signal ROM : bo_rom_array_t:=(x"003a",x"ffb7",x"00e8",x"008b",x"0042",x"0041",x"fe12",x"0121",x"0002",x"009d",x"00b9",x"fff8",x"007e",x"00e6",x"ff2e",x"ff7c",x"002c",x"0051",x"0069",x"001a",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
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
