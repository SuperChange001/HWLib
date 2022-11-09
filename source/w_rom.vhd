-- this w_rom is just for testing the linear layer
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity w_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(3-1 downto 0);
data : out std_logic_vector(8-1 downto 0)
);
end entity w_rom;
architecture rtl of w_rom is
type w_rom_array_t is array (0 to 2**3-1) of std_logic_vector(8-1 downto 0);
signal ROM : w_rom_array_t:=(x"01",x"02",x"03",x"04",x"05",x"06",x"00",x"00");
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
