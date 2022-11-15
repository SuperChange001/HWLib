-- this b_rom is just for testing the linear layer
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity b_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(1-1 downto 0);
data : out std_logic_vector(8-1 downto 0)
);
end entity b_rom;
architecture rtl of b_rom is
type b_rom_array_t is array (0 to 2**1-1) of std_logic_vector(8-1 downto 0);
signal ROM : b_rom_array_t:=(x"03",x"01");
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
