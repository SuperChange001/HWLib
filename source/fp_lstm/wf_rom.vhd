library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity wf_rom is
port (
clk : in std_logic;
en : in std_logic;
addr : in std_logic_vector(9-1 downto 0);
data : out std_logic_vector(16-1 downto 0)
);
end entity wf_rom;
architecture rtl of wf_rom is
type wf_rom_array_t is array (0 to 2**9-1) of std_logic_vector(16-1 downto 0);
signal ROM : wf_rom_array_t:=(x"ffcf",x"0001",x"0006",x"ffd9",x"0034",x"ffe6",x"0015",x"0000",x"fff0",x"002f",x"0033",x"fffc",x"ffe2",x"0023",x"002f",x"0008",x"ffd1",x"ffcb",x"0000",x"fff7",x"001b",x"002a",x"0006",x"fff2",x"0038",x"0019",x"ffd9",x"0002",x"ffce",x"001a",x"ffd5",x"0027",x"fff3",x"002c",x"ffb0",x"fff6",x"0016",x"fff7",x"000b",x"fff0",x"ffd1",x"0046",x"0055",x"fff3",x"0011",x"0023",x"0017",x"0030",x"0007",x"fffc",x"fff0",x"0034",x"ffcc",x"ffca",x"ffeb",x"003d",x"ffe9",x"0024",x"ffe7",x"ffe4",x"0009",x"001f",x"ffee",x"004f",x"001d",x"0029",x"ffc0",x"ffe3",x"ffb8",x"0020",x"004d",x"ffd9",x"004a",x"0030",x"ffbd",x"ffca",x"007b",x"003b",x"0052",x"0015",x"ffe4",x"000d",x"0011",x"ff7d",x"005b",x"0024",x"ffda",x"00b5",x"ff67",x"0070",x"006c",x"ff5f",x"008a",x"f789",x"ff57",x"004c",x"ff96",x"0086",x"ff74",x"0065",x"ffef",x"0077",x"0007",x"ff58",x"ff77",x"ffb1",x"002d",x"ffdb",x"fed3",x"003c",x"fef4",x"ffa8",x"00fb",x"ff97",x"ff54",x"0130",x"ff82",x"0052",x"ffa4",x"012a",x"ff72",x"fff4",x"ff83",x"ffee",x"0058",x"0042",x"0066",x"ffc9",x"fff7",x"0087",x"ffbb",x"fdf3",x"0083",x"000d",x"009b",x"fe74",x"01cb",x"003c",x"ffb0",x"0073",x"0022",x"009b",x"0000",x"004e",x"0036",x"ff5d",x"ff96",x"004d",x"0030",x"0020",x"ffe8",x"ffab",x"0033",x"0010",x"001e",x"ffef",x"002b",x"fffa",x"ffe4",x"000c",x"002c",x"001c",x"fff4",x"ffa7",x"0025",x"0019",x"001b",x"ffd3",x"ffca",x"ffdf",x"000f",x"ffe5",x"00b2",x"0021",x"0008",x"004b",x"ff56",x"ffef",x"ff8c",x"ffa3",x"00d0",x"ffae",x"ffd7",x"ffa0",x"ffe6",x"ff7c",x"0028",x"fff6",x"0010",x"005f",x"0038",x"ffe1",x"0064",x"ffc9",x"f881",x"0032",x"ffaa",x"0043",x"fdd5",x"ff93",x"005e",x"ff7e",x"0058",x"ffc4",x"0045",x"0000",x"0074",x"fe3c",x"ff79",x"ff7e",x"0057",x"0019",x"0003",x"ffa5",x"ff9c",x"ff19",x"0068",x"00ec",x"0011",x"fecc",x"0129",x"ffc9",x"ffea",x"0061",x"00d9",x"0002",x"0000",x"0035",x"0000",x"0024",x"ffcf",x"0041",x"0025",x"0036",x"0000",x"ffd4",x"0034",x"005d",x"ffdb",x"0027",x"0007",x"fff5",x"0037",x"fff2",x"0049",x"ffef",x"0068",x"ffac",x"0060",x"ffee",x"002d",x"ffea",x"ffad",x"ffd5",x"0042",x"ff6d",x"0025",x"fe84",x"ffe1",x"01b9",x"ffd5",x"ff1f",x"01d1",x"ffa6",x"004a",x"fff4",x"014c",x"fff9",x"ffd2",x"ffbc",x"ffba",x"0046",x"fffc",x"0052",x"002a",x"ffe9",x"001b",x"ffe3",x"fff8",x"0010",x"ffce",x"0011",x"001c",x"fff7",x"ffdf",x"fff7",x"0041",x"ffd1",x"0029",x"fff8",x"0000",x"fffc",x"ffde",x"fff2",x"0055",x"ffd7",x"001e",x"0053",x"ffaa",x"fe93",x"007e",x"0136",x"0094",x"fdfe",x"01c1",x"0084",x"ffb5",x"0052",x"00e4",x"007a",x"fff5",x"002e",x"000d",x"ffcc",x"ffce",x"ffca",x"0027",x"fffa",x"0008",x"0050",x"0000",x"ffc7",x"0023",x"ffbd",x"ffe7",x"0013",x"ffea",x"003a",x"ffbc",x"0024",x"ffde",x"0015",x"fff5",x"0029",x"ffae",x"002b",x"0053",x"0004",x"ffe4",x"0012",x"ffa1",x"000c",x"000e",x"ffcf",x"0031",x"002b",x"000f",x"fff6",x"0013",x"0069",x"ffec",x"001a",x"ffa9",x"0036",x"ffd0",x"ffde",x"ffa7",x"0010",x"0011",x"ffee",x"00b6",x"ff4f",x"00f5",x"001a",x"feec",x"00e8",x"001c",x"fed5",x"00ba",x"ff21",x"0030",x"ff00",x"ffef",x"fff9",x"00f9",x"003e",x"ff84",x"0015",x"003d",x"0013",x"0015",x"00ca",x"ffa0",x"0042",x"0077",x"ff10",x"00e9",x"f774",x"ff26",x"00cd",x"fedc",x"0032",x"ff35",x"0084",x"0014",x"0103",x"0018",x"ff71",x"ff99",x"004c",x"0013",x"0029",x"0074",x"ff75",x"f94f",x"007d",x"ffab",x"00b6",x"ff0e",x"ffbc",x"00b5",x"ff94",x"007a",x"ff4f",x"0082",x"fffa",x"00b2",x"ff7b",x"ff5b",x"ff7b",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000",x"0000");
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
