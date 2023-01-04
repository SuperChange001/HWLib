library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity wo_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(9-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity wo_rom;
architecture rtl of wo_rom is
type wo_rom_array_t is array (0 to 2**9-1) of std_logic_vector(16-1 downto 0);
signal ROM : wo_rom_array_t:=(x"ffb3",x"0029",x"001c",x"fff7",x"ffef",x"002c",x"fff0",x"fffd",x"ffee",x"ffc9",x"fff9",x"ffe8",x"000b",x"ffd1",x"ffda",x"ffdd",x"0020",x"0004",x"0023",x"fff1",x"fffc",x"ffbe",x"ffe9",x"0037",x"fffb",x"0027",x"fff7",x"ffbc",x"0016",x"0021",x"ffe7",x"0013",x"0030",x"000c",x"000f",x"0021",x"ffdb",x"003b",x"000e",x"003a",x"002e",x"0061",x"0072",x"ffe0",x"0023",x"ffe7",x"ff6a",x"fde3",x"0087",x"ffe5",x"0058",x"f96d",x"0230",x"003f",x"ff93",x"008a",x"0020",x"0082",x"ff8d",x"007c",x"000b",x"ffad",x"ff91",x"0063",x"002e",x"000a",x"ff7d",x"ffca",x"fee3",x"007e",x"00cf",x"0032",x"0032",x"0109",x"0006",x"fff7",x"0085",x"0083",x"0059",x"ffe2",x"003f",x"ffef",x"0024",x"ff98",x"0064",x"ffdf",x"0000",x"000b",x"0000",x"0024",x"fff9",x"001d",x"0022",x"ffe9",x"fffb",x"0039",x"000c",x"0013",x"ffd3",x"fff7",x"ffdb",x"0028",x"fff3",x"0010",x"ffb3",x"004d",x"ffcf",x"ffe9",x"0054",x"ffaa",x"ffe2",x"0049",x"0000",x"0012",x"ffd9",x"ffff",x"002d",x"ffed",x"fff2",x"ffed",x"ffff",x"0002",x"003d",x"0042",x"ffa8",x"ffdc",x"006b",x"ffde",x"ffe5",x"ff26",x"00fd",x"fc1e",x"fef6",x"ffb6",x"ff27",x"f8f0",x"03cd",x"feee",x"012e",x"ff3d",x"011e",x"fecd",x"02c6",x"ff14",x"fd8b",x"013b",x"00c1",x"006f",x"ffd5",x"ffe0",x"0052",x"ff88",x"fe7d",x"0063",x"0068",x"005d",x"fd79",x"0145",x"0092",x"ffbb",x"004d",x"0084",x"0068",x"ffff",x"0054",x"0013",x"ffe9",x"ff5a",x"ffc5",x"0030",x"ffca",x"0149",x"ffa5",x"0309",x"007c",x"fb97",x"00e2",x"0073",x"fd2f",x"0117",x"fee8",x"005a",x"fdc6",x"0086",x"ffe2",x"00d7",x"0063",x"ff2e",x"ff7d",x"006d",x"ffd1",x"0028",x"0070",x"ffa1",x"fb71",x"0071",x"ffb6",x"0059",x"f711",x"ffea",x"009c",x"ff9c",x"003b",x"ffa8",x"0033",x"0015",x"0081",x"ff3c",x"ff76",x"ffaa",x"0054",x"000f",x"ffe7",x"0053",x"ffc8",x"feae",x"0051",x"00aa",x"0028",x"000d",x"01be",x"004f",x"ff6e",x"0080",x"0061",x"004e",x"ff9f",x"0055",x"002c",x"ffcb",x"ff94",x"0058",x"0018",x"ffcb",x"ffe1",x"ffb6",x"0009",x"0031",x"ffe9",x"ffeb",x"0019",x"0024",x"002b",x"ffc4",x"003b",x"ffec",x"fffa",x"ffe3",x"0001",x"ffea",x"0015",x"ffee",x"005e",x"ffd9",x"ffeb",x"0001",x"ffa0",x"feb5",x"0063",x"004c",x"ffd8",x"ffe4",x"008e",x"fff3",x"ffd5",x"002c",x"0054",x"006c",x"ffb0",x"0019",x"ffcf",x"fff9",x"ffb6",x"004d",x"fffc",x"0025",x"006e",x"ff64",x"fe32",x"0034",x"ff92",x"008e",x"0029",x"0229",x"0044",x"ff5c",x"005a",x"ff9e",x"0036",x"fffd",x"004d",x"fffe",x"ff83",x"ff7b",x"0014",x"ffc9",x"ffcd",x"ff99",x"005c",x"ffa3",x"ffc4",x"fcd7",x"ffd2",x"ff97",x"006a",x"ffbf",x"0041",x"ffc2",x"0095",x"ff53",x"ffe1",x"ffa7",x"fee8",x"00d0",x"005c",x"0020",x"0034",x"ffcf",x"006b",x"0024",x"010a",x"0006",x"ff25",x"000a",x"008b",x"ff24",x"0036",x"0010",x"0000",x"ff2a",x"0005",x"0038",x"002a",x"0031",x"ffb5",x"fff4",x"0057",x"fff2",x"0030",x"ffdd",x"ffcf",x"ffe9",x"002f",x"0038",x"000c",x"002b",x"ffce",x"0037",x"002f",x"0021",x"000b",x"0032",x"001e",x"000a",x"0010",x"0004",x"0017",x"ffcf",x"fff4",x"ffe8",x"009f",x"000b",x"00a7",x"fff8",x"ff00",x"006e",x"ffe7",x"ff62",x"003d",x"ff9b",x"002d",x"ff11",x"ffe3",x"0000",x"004a",x"ffd4",x"ffe7",x"0017",x"0079",x"0000",x"ffe2",x"0019",x"ffe4",x"0062",x"001c",x"ff5e",x"fffe",x"ffc4",x"ffb4",x"0009",x"ffd6",x"004b",x"ff83",x"006a",x"ffcb",x"0059",x"0020",x"ffc0",x"fffb",x"006b",x"0011",x"0036",x"0034",x"ffe7",x"fff7",x"0043",x"ff85",x"0032",x"ffe8",x"fffd",x"003f",x"ffdf",x"ffed",x"ffb1",x"0026",x"ffdf",x"0037",x"fff5",x"ffc0",x"ffbe",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
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
