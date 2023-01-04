library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity bi_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(5-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity bi_rom;
architecture rtl of bi_rom is
type bi_rom_array_t is array (0 to 2**5-1) of std_logic_vector(16-1 downto 0);
signal ROM : bi_rom_array_t:=(x"ffee",x"ff95",x"00c7",x"0026",x"002f",x"00ad",x"0124",x"00a6",x"0032",x"00e0",x"006c",x"00f0",x"009e",x"003c",x"00d0",x"ff2a",x"00e9",x"ffe2",x"0093",x"0085",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
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
