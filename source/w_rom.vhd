-- this w_rom is just for testing the linear layer
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity w_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(3-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity w_rom;
architecture rtl of w_rom is
type w_rom_array_t is array (0 to 2**3-1) of std_logic_vector(16-1 downto 0);
signal ROM : w_rom_array_t:=(x"0001",x"0002",x"0003",x"0004",x"0005",x"0006",x"0000",x"0000");
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
