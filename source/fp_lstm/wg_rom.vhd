library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity wg_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(9-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity wg_rom;
architecture rtl of wg_rom is
type wg_rom_array_t is array (0 to 2**9-1) of std_logic_vector(16-1 downto 0);
signal ROM : wg_rom_array_t:=(x"ffda",x"0027",x"ffc7",x"0024",x"ffe6",x"fff4",x"ffdb",x"0035",x"ffe2",x"fff9",x"0005",x"fff2",x"ffca",x"ffdb",x"0010",x"fff2",x"0024",x"0024",x"ffcb",x"ffcd",x"ffec",x"0036",x"0029",x"ffd5",x"ffda",x"0012",x"0013",x"002e",x"ffea",x"ffe0",x"001c",x"0001",x"0000",x"fff8",x"0027",x"0019",x"000e",x"ffe3",x"fff6",x"0003",x"ffcb",x"fff1",x"002b",x"0036",x"0023",x"fff1",x"0015",x"001b",x"000b",x"000b",x"0036",x"001e",x"0005",x"fff7",x"0020",x"0053",x"0023",x"000e",x"ffda",x"0032",x"fff0",x"ffff",x"ffcd",x"ffcd",x"ffd3",x"ffcf",x"ffc8",x"ffe0",x"ffe3",x"fff8",x"ffe2",x"0008",x"fff2",x"000f",x"0028",x"ffcf",x"ffe2",x"002b",x"ffc8",x"0041",x"0002",x"0017",x"001d",x"0022",x"003e",x"0000",x"002c",x"fffc",x"ffbb",x"0009",x"0048",x"ffed",x"ffdc",x"000a",x"ffca",x"ffe3",x"ffe9",x"001e",x"fff6",x"fff4",x"ffde",x"ffef",x"000e",x"0023",x"000c",x"005d",x"fffe",x"ffe6",x"0032",x"ff89",x"ff69",x"001a",x"004f",x"006d",x"ffef",x"003b",x"0062",x"ffb6",x"004c",x"0080",x"007d",x"ffef",x"0028",x"fff5",x"ffc4",x"ffe1",x"ffc8",x"0004",x"ffd2",x"ffd7",x"002e",x"ffdd",x"ffbb",x"ffcd",x"0018",x"ffc9",x"001b",x"002b",x"ffec",x"ffc0",x"000d",x"ffc3",x"0033",x"fffa",x"ffe3",x"fff3",x"ffea",x"002f",x"0006",x"0013",x"ffda",x"fff0",x"000c",x"0007",x"000e",x"fffe",x"ffca",x"0013",x"ffe1",x"002f",x"0030",x"0023",x"ffe5",x"0018",x"0025",x"0026",x"002d",x"ffcf",x"0033",x"ffdd",x"fffd",x"0028",x"ffd3",x"ffd2",x"002b",x"0005",x"ffe2",x"fffa",x"0002",x"001a",x"ffe9",x"0014",x"fff0",x"002c",x"ffcb",x"0011",x"0002",x"0006",x"001b",x"ffc4",x"0022",x"ffcc",x"ffc9",x"000c",x"0015",x"ffe0",x"002c",x"002e",x"0011",x"0015",x"002d",x"001f",x"ffe2",x"fffc",x"0017",x"ffcd",x"ffcb",x"ffd1",x"001d",x"fffe",x"0028",x"ffe4",x"001e",x"000f",x"ffee",x"001a",x"0007",x"ffce",x"000c",x"002a",x"ffe8",x"0035",x"ffb2",x"004e",x"ffd6",x"fff7",x"0006",x"0010",x"0021",x"0019",x"ffc5",x"ffa9",x"ffd1",x"001c",x"ff80",x"007e",x"ff90",x"ffb5",x"0038",x"ffb3",x"ff9d",x"0069",x"ff89",x"004f",x"ff7a",x"005f",x"ff8d",x"fffb",x"ff54",x"ffe4",x"0057",x"0071",x"002a",x"ffd5",x"001e",x"002b",x"000e",x"ffe1",x"0043",x"fff7",x"002f",x"002f",x"ffea",x"002f",x"ffaf",x"001d",x"ffe9",x"fff5",x"ffe3",x"ffed",x"0019",x"fffd",x"fffe",x"ffd2",x"ffd8",x"ffd2",x"0021",x"0035",x"ffce",x"fff3",x"ffcf",x"ffe3",x"0011",x"0035",x"0001",x"ffee",x"0002",x"ffcd",x"ffc8",x"002a",x"0006",x"fff7",x"0014",x"ffd1",x"0037",x"ffcb",x"001c",x"fff6",x"ffca",x"ffcc",x"ffd5",x"fff8",x"0034",x"ffd3",x"ffe1",x"ffdd",x"0013",x"001c",x"ffe3",x"002b",x"000c",x"ffca",x"0033",x"fff4",x"000e",x"ffd3",x"0013",x"0021",x"001f",x"0011",x"fff7",x"ffde",x"0033",x"fff6",x"000b",x"fff4",x"ffd6",x"ffe3",x"0016",x"ffd1",x"ffc9",x"000c",x"0032",x"ffff",x"ffcf",x"ffe6",x"0037",x"0012",x"0003",x"ffcb",x"001a",x"000f",x"ffcc",x"0008",x"ffd0",x"ffe2",x"ffea",x"0020",x"ffdb",x"ffe9",x"0021",x"000c",x"ffd5",x"ffda",x"ffd2",x"0023",x"0004",x"001d",x"ffdd",x"fffd",x"005c",x"ffb7",x"003f",x"fff5",x"0001",x"0053",x"0034",x"ffd1",x"ffef",x"ffe2",x"fff9",x"ffbe",x"0043",x"ffe3",x"003d",x"ffbb",x"0038",x"ffe5",x"ffcc",x"ffcb",x"ffc3",x"ffdc",x"0049",x"0186",x"fffe",x"ff02",x"ffb2",x"ffeb",x"fe9e",x"0002",x"000d",x"ffb8",x"ff3e",x"ffde",x"0058",x"ffd3",x"0055",x"0005",x"002b",x"ffc8",x"ffe3",x"fff6",x"ffda",x"0027",x"ffdd",x"0019",x"ffca",x"ffe3",x"ffee",x"0014",x"002c",x"0013",x"0013",x"fffc",x"0038",x"0036",x"ffca",x"0000",x"ffe5",x"ffeb",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
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
