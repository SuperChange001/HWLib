library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity wi_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(9-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity wi_rom;
architecture rtl of wi_rom is
type wi_rom_array_t is array (0 to 2**9-1) of std_logic_vector(16-1 downto 0);
signal ROM : wi_rom_array_t:=(x"ffcf",x"ffe4",x"ffe6",x"0023",x"ffec",x"0004",x"000a",x"fffb",x"ffd2",x"002a",x"0008",x"ffeb",x"0023",x"0004",x"ffd2",x"ffc7",x"0010",x"fff2",x"001d",x"ffcf",x"0004",x"ffa8",x"0008",x"ffcd",x"002c",x"000d",x"003e",x"ffaf",x"0000",x"ffe6",x"ffab",x"001a",x"0011",x"ffe5",x"ffaf",x"0028",x"fff2",x"ffdc",x"0027",x"0006",x"003b",x"0002",x"0049",x"ffe3",x"ffe4",x"00f6",x"ffb4",x"0145",x"0062",x"ff48",x"00ef",x"fffa",x"ff51",x"0103",x"ff53",x"0069",x"ff00",x"00ad",x"fff3",x"0115",x"ffb6",x"ffd9",x"ff71",x"0053",x"0034",x"ffcc",x"ffe1",x"ffd1",x"0028",x"fffa",x"ffe6",x"0034",x"0036",x"0022",x"0026",x"ffee",x"004c",x"0019",x"ffe3",x"ffc6",x"ffe7",x"0010",x"0000",x"fff8",x"0053",x"ffe6",x"ffe5",x"010c",x"ff7d",x"0044",x"0051",x"ff41",x"00de",x"fed3",x"ff1b",x"00c7",x"ff4e",x"005e",x"ff42",x"0021",x"003f",x"0103",x"0030",x"ff88",x"ffd5",x"0060",x"0000",x"ffc7",x"008b",x"0000",x"00a6",x"fff8",x"ff67",x"0037",x"0012",x"ff98",x"0079",x"ffc6",x"0049",x"ff60",x"004f",x"0010",x"003b",x"0021",x"ffd9",x"000a",x"004e",x"0031",x"ffe5",x"0027",x"ffc1",x"fe73",x"0074",x"001e",x"009e",x"ffca",x"01b2",x"0068",x"ff93",x"0090",x"008b",x"007c",x"ffaa",x"0034",x"004b",x"ffa2",x"ff83",x"005e",x"001e",x"0012",x"ffc3",x"ff78",x"ff5d",x"0041",x"00de",x"fff8",x"0041",x"00f5",x"ffff",x"ffcc",x"005e",x"011b",x"0034",x"fff9",x"001f",x"ffa1",x"ffb9",x"ffd7",x"0054",x"0010",x"ffaf",x"007a",x"ffe9",x"01f3",x"fff1",x"fe0d",x"0050",x"ffd2",x"fdca",x"0035",x"ffae",x"0011",x"feb1",x"0043",x"0061",x"002b",x"0046",x"ff71",x"ffcb",x"005a",x"ffdb",x"ffeb",x"009b",x"ff56",x"fa7d",x"00a7",x"ff85",x"0093",x"fb25",x"ff92",x"0077",x"ffc4",x"009f",x"ffb9",x"0068",x"000e",x"0050",x"001c",x"ffc8",x"ffb1",x"005d",x"0010",x"ffeb",x"ff77",x"ffb6",x"ff9b",x"0017",x"0068",x"ffb1",x"002e",x"00a7",x"ffb0",x"0008",x"003d",x"0088",x"0052",x"0000",x"ffde",x"ffb4",x"ffd7",x"ffbd",x"0053",x"fff2",x"0055",x"0006",x"ffa6",x"fe03",x"0044",x"015c",x"0085",x"ff7d",x"01e3",x"003e",x"ffcc",x"006a",x"00d0",x"0072",x"ffa4",x"0039",x"ffcb",x"ffae",x"ffc5",x"0074",x"ffd4",x"fff6",x"ffa2",x"ffcf",x"fe5f",x"0036",x"01e9",x"0001",x"0000",x"0187",x"ffd7",x"ffe3",x"0043",x"01a6",x"0025",x"000d",x"0000",x"ffc5",x"fff3",x"ffb4",x"0052",x"0014",x"ffd2",x"ffef",x"002e",x"fffa",x"0009",x"0008",x"0022",x"0026",x"0005",x"ffe1",x"ffee",x"ffef",x"ffde",x"002b",x"0019",x"ffd9",x"001c",x"0002",x"ffd4",x"0071",x"ffe7",x"fffb",x"fef8",x"ffc9",x"fe44",x"0064",x"0111",x"000a",x"0040",x"00ff",x"ffe2",x"ffe5",x"001d",x"01e8",x"0053",x"fffa",x"0009",x"0016",x"0001",x"ffba",x"ffc7",x"000e",x"ffe3",x"ffa5",x"0077",x"0101",x"ffb7",x"0003",x"ffd7",x"ffdb",x"ff01",x"ffea",x"0019",x"ffa8",x"ff8c",x"ffbd",x"0057",x"ffc4",x"002e",x"002e",x"0065",x"0058",x"0000",x"0035",x"0037",x"ffad",x"fdfa",x"0039",x"010c",x"0039",x"fe6a",x"0270",x"0020",x"ffd3",x"0097",x"00a5",x"0047",x"ffcd",x"0065",x"ffb3",x"ffdd",x"ffd1",x"003f",x"fff1",x"fffc",x"0119",x"ffb4",x"00d9",x"0023",x"fea7",x"004e",x"ffd4",x"ff38",x"009c",x"ff52",x"ffd9",x"fee3",x"001d",x"0007",x"007e",x"fffd",x"ff89",x"ffd2",x"0064",x"ffe8",x"001e",x"004c",x"ff8c",x"005e",x"0053",x"ffc6",x"006d",x"002e",x"0006",x"0016",x"ffeb",x"0054",x"ffbd",x"0053",x"ffce",x"006e",x"002f",x"ff86",x"ffaa",x"0065",x"0001",x"001a",x"ff86",x"ff81",x"fdeb",x"0040",x"00c0",x"0026",x"0013",x"0202",x"0016",x"ffda",x"0056",x"00e6",x"0052",x"0007",x"ffe1",x"0046",x"ffb0",x"ffe8",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
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
