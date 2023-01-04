-- A LUT version of sigmoid
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity sigmoid is
    port (
        x : in signed(15 downto 0);
        y : out signed(15 downto 0)
    );

end sigmoid;

architecture rtl_64 of sigmoid is
begin
    
    sigmoid_process:process(x)
    begin
        if x<="1111101101000110" then
            y <= "0000000000000000"; -- 0
        elsif x<="1111110001100100" then
            y <= "0000000000000101"; -- 5
        elsif x<="1111110011100011" then
            y <= "0000000000001001"; -- 9
        elsif x<="1111110100111000" then
            y <= "0000000000001101"; -- 13
        elsif x<="1111110101111010" then
            y <= "0000000000010001"; -- 17
        elsif x<="1111110110110000" then
            y <= "0000000000010101"; -- 21
        elsif x<="1111110111011110" then
            y <= "0000000000011001"; -- 25
        elsif x<="1111111000000110" then
            y <= "0000000000011101"; -- 29
        elsif x<="1111111000101001" then
            y <= "0000000000100001"; -- 33
        elsif x<="1111111001001010" then
            y <= "0000000000100101"; -- 37
        elsif x<="1111111001101000" then
            y <= "0000000000101001"; -- 41
        elsif x<="1111111010000011" then
            y <= "0000000000101101"; -- 45
        elsif x<="1111111010011101" then
            y <= "0000000000110001"; -- 49
        elsif x<="1111111010110110" then
            y <= "0000000000110101"; -- 53
        elsif x<="1111111011001101" then
            y <= "0000000000111001"; -- 57
        elsif x<="1111111011100011" then
            y <= "0000000000111101"; -- 61
        elsif x<="1111111011111000" then
            y <= "0000000001000001"; -- 65
        elsif x<="1111111100001101" then
            y <= "0000000001000101"; -- 69
        elsif x<="1111111100100000" then
            y <= "0000000001001001"; -- 73
        elsif x<="1111111100110011" then
            y <= "0000000001001101"; -- 77
        elsif x<="1111111101000110" then
            y <= "0000000001010001"; -- 81
        elsif x<="1111111101011000" then
            y <= "0000000001010101"; -- 85
        elsif x<="1111111101101010" then
            y <= "0000000001011001"; -- 89
        elsif x<="1111111101111011" then
            y <= "0000000001011101"; -- 93
        elsif x<="1111111110001100" then
            y <= "0000000001100001"; -- 97
        elsif x<="1111111110011101" then
            y <= "0000000001100101"; -- 101
        elsif x<="1111111110101101" then
            y <= "0000000001101001"; -- 105
        elsif x<="1111111110111110" then
            y <= "0000000001101101"; -- 109
        elsif x<="1111111111001110" then
            y <= "0000000001110001"; -- 113
        elsif x<="1111111111011110" then
            y <= "0000000001110101"; -- 117
        elsif x<="1111111111101110" then
            y <= "0000000001111001"; -- 121
        elsif x<="1111111111111110" then
            y <= "0000000001111101"; -- 125
        elsif x<="0000000000001110" then
            y <= "0000000010000001"; -- 129
        elsif x<="0000000000011110" then
            y <= "0000000010000101"; -- 133
        elsif x<="0000000000101110" then
            y <= "0000000010001001"; -- 137
        elsif x<="0000000000111110" then
            y <= "0000000010001101"; -- 141
        elsif x<="0000000001001110" then
            y <= "0000000010010001"; -- 145
        elsif x<="0000000001011111" then
            y <= "0000000010010101"; -- 149
        elsif x<="0000000001110000" then
            y <= "0000000010011001"; -- 153
        elsif x<="0000000010000001" then
            y <= "0000000010011101"; -- 157
        elsif x<="0000000010010010" then
            y <= "0000000010100001"; -- 161
        elsif x<="0000000010100100" then
            y <= "0000000010100101"; -- 165
        elsif x<="0000000010110110" then
            y <= "0000000010101001"; -- 169
        elsif x<="0000000011001000" then
            y <= "0000000010101101"; -- 173
        elsif x<="0000000011011011" then
            y <= "0000000010110001"; -- 177
        elsif x<="0000000011101110" then
            y <= "0000000010110101"; -- 181
        elsif x<="0000000100000011" then
            y <= "0000000010111001"; -- 185
        elsif x<="0000000100011000" then
            y <= "0000000010111101"; -- 189
        elsif x<="0000000100101101" then
            y <= "0000000011000001"; -- 193
        elsif x<="0000000101000100" then
            y <= "0000000011000101"; -- 197
        elsif x<="0000000101011100" then
            y <= "0000000011001001"; -- 201
        elsif x<="0000000101110110" then
            y <= "0000000011001101"; -- 205
        elsif x<="0000000110010001" then
            y <= "0000000011010001"; -- 209
        elsif x<="0000000110101110" then
            y <= "0000000011010101"; -- 213
        elsif x<="0000000111001110" then
            y <= "0000000011011001"; -- 217
        elsif x<="0000000111110001" then
            y <= "0000000011011101"; -- 221
        elsif x<="0000001000011000" then
            y <= "0000000011100001"; -- 225
        elsif x<="0000001001000100" then
            y <= "0000000011100101"; -- 229
        elsif x<="0000001001111000" then
            y <= "0000000011101001"; -- 233
        elsif x<="0000001010110110" then
            y <= "0000000011101101"; -- 237
        elsif x<="0000001100000101" then
            y <= "0000000011110001"; -- 241
        elsif x<="0000001101110110" then
            y <= "0000000011110101"; -- 245
        elsif x<="0000010001001001" then
            y <= "0000000011111001"; -- 249
        else
            y <= "0000000100000000"; -- 256
        end if;
        
    end process;
end rtl_64;

architecture rtl_128 of sigmoid is
begin
        
    sigmoid_process:process(x)
    begin
        if x<="1111101100000011" then
            y <= "0000000000000000"; -- 0
        elsif x<="1111101111010011" then
            y <= "0000000000000010"; -- 2
        elsif x<="1111110001000001" then
            y <= "0000000000000100"; -- 4
        elsif x<="1111110010001110" then
            y <= "0000000000000110"; -- 6
        elsif x<="1111110011001010" then
            y <= "0000000000001000"; -- 8
        elsif x<="1111110011111100" then
            y <= "0000000000001010"; -- 10
        elsif x<="1111110100100101" then
            y <= "0000000000001100"; -- 12
        elsif x<="1111110101001010" then
            y <= "0000000000001110"; -- 14
        elsif x<="1111110101101010" then
            y <= "0000000000010000"; -- 16
        elsif x<="1111110110000111" then
            y <= "0000000000010010"; -- 18
        elsif x<="1111110110100010" then
            y <= "0000000000010100"; -- 20
        elsif x<="1111110110111010" then
            y <= "0000000000010110"; -- 22
        elsif x<="1111110111010001" then
            y <= "0000000000011000"; -- 24
        elsif x<="1111110111100110" then
            y <= "0000000000011010"; -- 26
        elsif x<="1111110111111010" then
            y <= "0000000000011100"; -- 28
        elsif x<="1111111000001101" then
            y <= "0000000000011110"; -- 30
        elsif x<="1111111000011111" then
            y <= "0000000000100000"; -- 32
        elsif x<="1111111000110000" then
            y <= "0000000000100010"; -- 34
        elsif x<="1111111001000000" then
            y <= "0000000000100100"; -- 36
        elsif x<="1111111001010000" then
            y <= "0000000000100110"; -- 38
        elsif x<="1111111001011110" then
            y <= "0000000000101000"; -- 40
        elsif x<="1111111001101101" then
            y <= "0000000000101010"; -- 42
        elsif x<="1111111001111011" then
            y <= "0000000000101100"; -- 44
        elsif x<="1111111010001000" then
            y <= "0000000000101110"; -- 46
        elsif x<="1111111010010101" then
            y <= "0000000000110000"; -- 48
        elsif x<="1111111010100001" then
            y <= "0000000000110010"; -- 50
        elsif x<="1111111010101101" then
            y <= "0000000000110100"; -- 52
        elsif x<="1111111010111001" then
            y <= "0000000000110110"; -- 54
        elsif x<="1111111011000101" then
            y <= "0000000000111000"; -- 56
        elsif x<="1111111011010000" then
            y <= "0000000000111010"; -- 58
        elsif x<="1111111011011011" then
            y <= "0000000000111100"; -- 60
        elsif x<="1111111011100110" then
            y <= "0000000000111110"; -- 62
        elsif x<="1111111011110000" then
            y <= "0000000001000000"; -- 64
        elsif x<="1111111011111011" then
            y <= "0000000001000010"; -- 66
        elsif x<="1111111100000101" then
            y <= "0000000001000100"; -- 68
        elsif x<="1111111100001111" then
            y <= "0000000001000110"; -- 70
        elsif x<="1111111100011001" then
            y <= "0000000001001000"; -- 72
        elsif x<="1111111100100010" then
            y <= "0000000001001010"; -- 74
        elsif x<="1111111100101100" then
            y <= "0000000001001100"; -- 76
        elsif x<="1111111100110101" then
            y <= "0000000001001110"; -- 78
        elsif x<="1111111100111110" then
            y <= "0000000001010000"; -- 80
        elsif x<="1111111101001000" then
            y <= "0000000001010010"; -- 82
        elsif x<="1111111101010001" then
            y <= "0000000001010100"; -- 84
        elsif x<="1111111101011001" then
            y <= "0000000001010110"; -- 86
        elsif x<="1111111101100010" then
            y <= "0000000001011000"; -- 88
        elsif x<="1111111101101011" then
            y <= "0000000001011010"; -- 90
        elsif x<="1111111101110100" then
            y <= "0000000001011100"; -- 92
        elsif x<="1111111101111100" then
            y <= "0000000001011110"; -- 94
        elsif x<="1111111110000101" then
            y <= "0000000001100000"; -- 96
        elsif x<="1111111110001101" then
            y <= "0000000001100010"; -- 98
        elsif x<="1111111110010101" then
            y <= "0000000001100100"; -- 100
        elsif x<="1111111110011110" then
            y <= "0000000001100110"; -- 102
        elsif x<="1111111110100110" then
            y <= "0000000001101000"; -- 104
        elsif x<="1111111110101110" then
            y <= "0000000001101010"; -- 106
        elsif x<="1111111110110110" then
            y <= "0000000001101100"; -- 108
        elsif x<="1111111110111110" then
            y <= "0000000001101110"; -- 110
        elsif x<="1111111111000110" then
            y <= "0000000001110000"; -- 112
        elsif x<="1111111111001111" then
            y <= "0000000001110010"; -- 114
        elsif x<="1111111111010111" then
            y <= "0000000001110100"; -- 116
        elsif x<="1111111111011111" then
            y <= "0000000001110110"; -- 118
        elsif x<="1111111111100111" then
            y <= "0000000001111000"; -- 120
        elsif x<="1111111111101111" then
            y <= "0000000001111010"; -- 122
        elsif x<="1111111111110111" then
            y <= "0000000001111100"; -- 124
        elsif x<="1111111111111110" then
            y <= "0000000001111110"; -- 126
        elsif x<="0000000000000101" then
            y <= "0000000010000000"; -- 128
        elsif x<="0000000000001101" then
            y <= "0000000010000010"; -- 130
        elsif x<="0000000000010101" then
            y <= "0000000010000100"; -- 132
        elsif x<="0000000000011101" then
            y <= "0000000010000110"; -- 134
        elsif x<="0000000000100101" then
            y <= "0000000010001000"; -- 136
        elsif x<="0000000000101101" then
            y <= "0000000010001010"; -- 138
        elsif x<="0000000000110101" then
            y <= "0000000010001100"; -- 140
        elsif x<="0000000000111110" then
            y <= "0000000010001110"; -- 142
        elsif x<="0000000001000110" then
            y <= "0000000010010000"; -- 144
        elsif x<="0000000001001110" then
            y <= "0000000010010010"; -- 146
        elsif x<="0000000001010110" then
            y <= "0000000010010100"; -- 148
        elsif x<="0000000001011110" then
            y <= "0000000010010110"; -- 150
        elsif x<="0000000001100110" then
            y <= "0000000010011000"; -- 152
        elsif x<="0000000001101111" then
            y <= "0000000010011010"; -- 154
        elsif x<="0000000001110111" then
            y <= "0000000010011100"; -- 156
        elsif x<="0000000010000000" then
            y <= "0000000010011110"; -- 158
        elsif x<="0000000010001000" then
            y <= "0000000010100000"; -- 160
        elsif x<="0000000010010001" then
            y <= "0000000010100010"; -- 162
        elsif x<="0000000010011001" then
            y <= "0000000010100100"; -- 164
        elsif x<="0000000010100010" then
            y <= "0000000010100110"; -- 166
        elsif x<="0000000010101011" then
            y <= "0000000010101000"; -- 168
        elsif x<="0000000010110100" then
            y <= "0000000010101010"; -- 170
        elsif x<="0000000010111101" then
            y <= "0000000010101100"; -- 172
        elsif x<="0000000011000110" then
            y <= "0000000010101110"; -- 174
        elsif x<="0000000011001111" then
            y <= "0000000010110000"; -- 176
        elsif x<="0000000011011001" then
            y <= "0000000010110010"; -- 178
        elsif x<="0000000011100010" then
            y <= "0000000010110100"; -- 180
        elsif x<="0000000011101100" then
            y <= "0000000010110110"; -- 182
        elsif x<="0000000011110110" then
            y <= "0000000010111000"; -- 184
        elsif x<="0000000100000000" then
            y <= "0000000010111010"; -- 186
        elsif x<="0000000100001010" then
            y <= "0000000010111100"; -- 188
        elsif x<="0000000100010101" then
            y <= "0000000010111110"; -- 190
        elsif x<="0000000100011111" then
            y <= "0000000011000000"; -- 192
        elsif x<="0000000100101010" then
            y <= "0000000011000010"; -- 194
        elsif x<="0000000100110101" then
            y <= "0000000011000100"; -- 196
        elsif x<="0000000101000001" then
            y <= "0000000011000110"; -- 198
        elsif x<="0000000101001101" then
            y <= "0000000011001000"; -- 200
        elsif x<="0000000101011001" then
            y <= "0000000011001010"; -- 202
        elsif x<="0000000101100101" then
            y <= "0000000011001100"; -- 204
        elsif x<="0000000101110010" then
            y <= "0000000011001110"; -- 206
        elsif x<="0000000101111111" then
            y <= "0000000011010000"; -- 208
        elsif x<="0000000110001100" then
            y <= "0000000011010010"; -- 210
        elsif x<="0000000110011010" then
            y <= "0000000011010100"; -- 212
        elsif x<="0000000110101001" then
            y <= "0000000011010110"; -- 214
        elsif x<="0000000110111000" then
            y <= "0000000011011000"; -- 216
        elsif x<="0000000111001000" then
            y <= "0000000011011010"; -- 218
        elsif x<="0000000111011000" then
            y <= "0000000011011100"; -- 220
        elsif x<="0000000111101010" then
            y <= "0000000011011110"; -- 222
        elsif x<="0000000111111100" then
            y <= "0000000011100000"; -- 224
        elsif x<="0000001000001111" then
            y <= "0000000011100010"; -- 226
        elsif x<="0000001000100100" then
            y <= "0000000011100100"; -- 228
        elsif x<="0000001000111010" then
            y <= "0000000011100110"; -- 230
        elsif x<="0000001001010010" then
            y <= "0000000011101000"; -- 232
        elsif x<="0000001001101011" then
            y <= "0000000011101010"; -- 234
        elsif x<="0000001010000111" then
            y <= "0000000011101100"; -- 236
        elsif x<="0000001010100110" then
            y <= "0000000011101110"; -- 238
        elsif x<="0000001011001000" then
            y <= "0000000011110000"; -- 240
        elsif x<="0000001011101111" then
            y <= "0000000011110010"; -- 242
        elsif x<="0000001100011100" then
            y <= "0000000011110100"; -- 244
        elsif x<="0000001101010010" then
            y <= "0000000011110110"; -- 246
        elsif x<="0000001110010101" then
            y <= "0000000011111000"; -- 248
        elsif x<="0000001111110000" then
            y <= "0000000011111010"; -- 250
        elsif x<="0000010001111110" then
            y <= "0000000011111100"; -- 252
        else
            y <= "0000000100000000"; -- 256
        end if;        
    end process;
end rtl_128;

architecture rtl_256 of sigmoid is
begin
    
    sigmoid_process:process(x)
    begin
        if x<="1111101011001111" then
            y <= "0000000000000000"; -- 0
        elsif x<="1111101101011100" then
            y <= "0000000000000001"; -- 1
        elsif x<="1111101110110101" then
            y <= "0000000000000010"; -- 2
        elsif x<="1111101111110111" then
            y <= "0000000000000011"; -- 3
        elsif x<="1111110000101100" then
            y <= "0000000000000100"; -- 4
        elsif x<="1111110001011000" then
            y <= "0000000000000101"; -- 5
        elsif x<="1111110001111110" then
            y <= "0000000000000110"; -- 6
        elsif x<="1111110010011111" then
            y <= "0000000000000111"; -- 7
        elsif x<="1111110010111101" then
            y <= "0000000000001000"; -- 8
        elsif x<="1111110011010111" then
            y <= "0000000000001001"; -- 9
        elsif x<="1111110011110000" then
            y <= "0000000000001010"; -- 10
        elsif x<="1111110100000110" then
            y <= "0000000000001011"; -- 11
        elsif x<="1111110100011011" then
            y <= "0000000000001100"; -- 12
        elsif x<="1111110100101110" then
            y <= "0000000000001101"; -- 13
        elsif x<="1111110101000000" then
            y <= "0000000000001110"; -- 14
        elsif x<="1111110101010010" then
            y <= "0000000000001111"; -- 15
        elsif x<="1111110101100010" then
            y <= "0000000000010000"; -- 16
        elsif x<="1111110101110001" then
            y <= "0000000000010001"; -- 17
        elsif x<="1111110101111111" then
            y <= "0000000000010010"; -- 18
        elsif x<="1111110110001101" then
            y <= "0000000000010011"; -- 19
        elsif x<="1111110110011011" then
            y <= "0000000000010100"; -- 20
        elsif x<="1111110110100111" then
            y <= "0000000000010101"; -- 21
        elsif x<="1111110110110100" then
            y <= "0000000000010110"; -- 22
        elsif x<="1111110110111111" then
            y <= "0000000000010111"; -- 23
        elsif x<="1111110111001011" then
            y <= "0000000000011000"; -- 24
        elsif x<="1111110111010110" then
            y <= "0000000000011001"; -- 25
        elsif x<="1111110111100000" then
            y <= "0000000000011010"; -- 26
        elsif x<="1111110111101010" then
            y <= "0000000000011011"; -- 27
        elsif x<="1111110111110100" then
            y <= "0000000000011100"; -- 28
        elsif x<="1111110111111110" then
            y <= "0000000000011101"; -- 29
        elsif x<="1111111000000111" then
            y <= "0000000000011110"; -- 30
        elsif x<="1111111000010001" then
            y <= "0000000000011111"; -- 31
        elsif x<="1111111000011010" then
            y <= "0000000000100000"; -- 32
        elsif x<="1111111000100010" then
            y <= "0000000000100001"; -- 33
        elsif x<="1111111000101011" then
            y <= "0000000000100010"; -- 34
        elsif x<="1111111000110011" then
            y <= "0000000000100011"; -- 35
        elsif x<="1111111000111011" then
            y <= "0000000000100100"; -- 36
        elsif x<="1111111001000011" then
            y <= "0000000000100101"; -- 37
        elsif x<="1111111001001011" then
            y <= "0000000000100110"; -- 38
        elsif x<="1111111001010010" then
            y <= "0000000000100111"; -- 39
        elsif x<="1111111001011010" then
            y <= "0000000000101000"; -- 40
        elsif x<="1111111001100001" then
            y <= "0000000000101001"; -- 41
        elsif x<="1111111001101000" then
            y <= "0000000000101010"; -- 42
        elsif x<="1111111001101111" then
            y <= "0000000000101011"; -- 43
        elsif x<="1111111001110110" then
            y <= "0000000000101100"; -- 44
        elsif x<="1111111001111101" then
            y <= "0000000000101101"; -- 45
        elsif x<="1111111010000011" then
            y <= "0000000000101110"; -- 46
        elsif x<="1111111010001010" then
            y <= "0000000000101111"; -- 47
        elsif x<="1111111010010000" then
            y <= "0000000000110000"; -- 48
        elsif x<="1111111010010111" then
            y <= "0000000000110001"; -- 49
        elsif x<="1111111010011101" then
            y <= "0000000000110010"; -- 50
        elsif x<="1111111010100011" then
            y <= "0000000000110011"; -- 51
        elsif x<="1111111010101001" then
            y <= "0000000000110100"; -- 52
        elsif x<="1111111010101111" then
            y <= "0000000000110101"; -- 53
        elsif x<="1111111010110101" then
            y <= "0000000000110110"; -- 54
        elsif x<="1111111010111011" then
            y <= "0000000000110111"; -- 55
        elsif x<="1111111011000001" then
            y <= "0000000000111000"; -- 56
        elsif x<="1111111011000110" then
            y <= "0000000000111001"; -- 57
        elsif x<="1111111011001100" then
            y <= "0000000000111010"; -- 58
        elsif x<="1111111011010010" then
            y <= "0000000000111011"; -- 59
        elsif x<="1111111011010111" then
            y <= "0000000000111100"; -- 60
        elsif x<="1111111011011101" then
            y <= "0000000000111101"; -- 61
        elsif x<="1111111011100010" then
            y <= "0000000000111110"; -- 62
        elsif x<="1111111011100111" then
            y <= "0000000000111111"; -- 63
        elsif x<="1111111011101101" then
            y <= "0000000001000000"; -- 64
        elsif x<="1111111011110010" then
            y <= "0000000001000001"; -- 65
        elsif x<="1111111011110111" then
            y <= "0000000001000010"; -- 66
        elsif x<="1111111011111100" then
            y <= "0000000001000011"; -- 67
        elsif x<="1111111100000001" then
            y <= "0000000001000100"; -- 68
        elsif x<="1111111100000110" then
            y <= "0000000001000101"; -- 69
        elsif x<="1111111100001011" then
            y <= "0000000001000110"; -- 70
        elsif x<="1111111100010000" then
            y <= "0000000001000111"; -- 71
        elsif x<="1111111100010101" then
            y <= "0000000001001000"; -- 72
        elsif x<="1111111100011010" then
            y <= "0000000001001001"; -- 73
        elsif x<="1111111100011111" then
            y <= "0000000001001010"; -- 74
        elsif x<="1111111100100011" then
            y <= "0000000001001011"; -- 75
        elsif x<="1111111100101000" then
            y <= "0000000001001100"; -- 76
        elsif x<="1111111100101101" then
            y <= "0000000001001101"; -- 77
        elsif x<="1111111100110001" then
            y <= "0000000001001110"; -- 78
        elsif x<="1111111100110110" then
            y <= "0000000001001111"; -- 79
        elsif x<="1111111100111011" then
            y <= "0000000001010000"; -- 80
        elsif x<="1111111100111111" then
            y <= "0000000001010001"; -- 81
        elsif x<="1111111101000100" then
            y <= "0000000001010010"; -- 82
        elsif x<="1111111101001000" then
            y <= "0000000001010011"; -- 83
        elsif x<="1111111101001101" then
            y <= "0000000001010100"; -- 84
        elsif x<="1111111101010001" then
            y <= "0000000001010101"; -- 85
        elsif x<="1111111101010110" then
            y <= "0000000001010110"; -- 86
        elsif x<="1111111101011010" then
            y <= "0000000001010111"; -- 87
        elsif x<="1111111101011111" then
            y <= "0000000001011000"; -- 88
        elsif x<="1111111101100011" then
            y <= "0000000001011001"; -- 89
        elsif x<="1111111101100111" then
            y <= "0000000001011010"; -- 90
        elsif x<="1111111101101100" then
            y <= "0000000001011011"; -- 91
        elsif x<="1111111101110000" then
            y <= "0000000001011100"; -- 92
        elsif x<="1111111101110100" then
            y <= "0000000001011101"; -- 93
        elsif x<="1111111101111000" then
            y <= "0000000001011110"; -- 94
        elsif x<="1111111101111101" then
            y <= "0000000001011111"; -- 95
        elsif x<="1111111110000001" then
            y <= "0000000001100000"; -- 96
        elsif x<="1111111110000101" then
            y <= "0000000001100001"; -- 97
        elsif x<="1111111110001001" then
            y <= "0000000001100010"; -- 98
        elsif x<="1111111110001101" then
            y <= "0000000001100011"; -- 99
        elsif x<="1111111110010010" then
            y <= "0000000001100100"; -- 100
        elsif x<="1111111110010110" then
            y <= "0000000001100101"; -- 101
        elsif x<="1111111110011010" then
            y <= "0000000001100110"; -- 102
        elsif x<="1111111110011110" then
            y <= "0000000001100111"; -- 103
        elsif x<="1111111110100010" then
            y <= "0000000001101000"; -- 104
        elsif x<="1111111110100110" then
            y <= "0000000001101001"; -- 105
        elsif x<="1111111110101010" then
            y <= "0000000001101010"; -- 106
        elsif x<="1111111110101110" then
            y <= "0000000001101011"; -- 107
        elsif x<="1111111110110010" then
            y <= "0000000001101100"; -- 108
        elsif x<="1111111110110111" then
            y <= "0000000001101101"; -- 109
        elsif x<="1111111110111011" then
            y <= "0000000001101110"; -- 110
        elsif x<="1111111110111111" then
            y <= "0000000001101111"; -- 111
        elsif x<="1111111111000011" then
            y <= "0000000001110000"; -- 112
        elsif x<="1111111111000111" then
            y <= "0000000001110001"; -- 113
        elsif x<="1111111111001011" then
            y <= "0000000001110010"; -- 114
        elsif x<="1111111111001111" then
            y <= "0000000001110011"; -- 115
        elsif x<="1111111111010011" then
            y <= "0000000001110100"; -- 116
        elsif x<="1111111111010111" then
            y <= "0000000001110101"; -- 117
        elsif x<="1111111111011011" then
            y <= "0000000001110110"; -- 118
        elsif x<="1111111111011111" then
            y <= "0000000001110111"; -- 119
        elsif x<="1111111111100011" then
            y <= "0000000001111000"; -- 120
        elsif x<="1111111111100111" then
            y <= "0000000001111001"; -- 121
        elsif x<="1111111111101011" then
            y <= "0000000001111010"; -- 122
        elsif x<="1111111111101111" then
            y <= "0000000001111011"; -- 123
        elsif x<="1111111111110011" then
            y <= "0000000001111100"; -- 124
        elsif x<="1111111111110111" then
            y <= "0000000001111101"; -- 125
        elsif x<="1111111111111011" then
            y <= "0000000001111110"; -- 126
        elsif x<="1111111111111110" then
            y <= "0000000001111111"; -- 127
        elsif x<="0000000000000001" then
            y <= "0000000001111111"; -- 127
        elsif x<="0000000000000101" then
            y <= "0000000010000000"; -- 128
        elsif x<="0000000000001001" then
            y <= "0000000010000001"; -- 129
        elsif x<="0000000000001101" then
            y <= "0000000010000010"; -- 130
        elsif x<="0000000000010001" then
            y <= "0000000010000011"; -- 131
        elsif x<="0000000000010101" then
            y <= "0000000010000100"; -- 132
        elsif x<="0000000000011001" then
            y <= "0000000010000101"; -- 133
        elsif x<="0000000000011101" then
            y <= "0000000010000110"; -- 134
        elsif x<="0000000000100001" then
            y <= "0000000010000111"; -- 135
        elsif x<="0000000000100101" then
            y <= "0000000010001000"; -- 136
        elsif x<="0000000000101001" then
            y <= "0000000010001001"; -- 137
        elsif x<="0000000000101101" then
            y <= "0000000010001010"; -- 138
        elsif x<="0000000000110001" then
            y <= "0000000010001011"; -- 139
        elsif x<="0000000000110101" then
            y <= "0000000010001100"; -- 140
        elsif x<="0000000000111001" then
            y <= "0000000010001101"; -- 141
        elsif x<="0000000000111101" then
            y <= "0000000010001110"; -- 142
        elsif x<="0000000001000001" then
            y <= "0000000010001111"; -- 143
        elsif x<="0000000001000101" then
            y <= "0000000010010000"; -- 144
        elsif x<="0000000001001001" then
            y <= "0000000010010001"; -- 145
        elsif x<="0000000001001101" then
            y <= "0000000010010010"; -- 146
        elsif x<="0000000001010010" then
            y <= "0000000010010011"; -- 147
        elsif x<="0000000001010110" then
            y <= "0000000010010100"; -- 148
        elsif x<="0000000001011010" then
            y <= "0000000010010101"; -- 149
        elsif x<="0000000001011110" then
            y <= "0000000010010110"; -- 150
        elsif x<="0000000001100010" then
            y <= "0000000010010111"; -- 151
        elsif x<="0000000001100110" then
            y <= "0000000010011000"; -- 152
        elsif x<="0000000001101010" then
            y <= "0000000010011001"; -- 153
        elsif x<="0000000001101110" then
            y <= "0000000010011010"; -- 154
        elsif x<="0000000001110010" then
            y <= "0000000010011011"; -- 155
        elsif x<="0000000001110111" then
            y <= "0000000010011100"; -- 156
        elsif x<="0000000001111011" then
            y <= "0000000010011101"; -- 157
        elsif x<="0000000001111111" then
            y <= "0000000010011110"; -- 158
        elsif x<="0000000010000011" then
            y <= "0000000010011111"; -- 159
        elsif x<="0000000010001000" then
            y <= "0000000010100000"; -- 160
        elsif x<="0000000010001100" then
            y <= "0000000010100001"; -- 161
        elsif x<="0000000010010000" then
            y <= "0000000010100010"; -- 162
        elsif x<="0000000010010100" then
            y <= "0000000010100011"; -- 163
        elsif x<="0000000010011001" then
            y <= "0000000010100100"; -- 164
        elsif x<="0000000010011101" then
            y <= "0000000010100101"; -- 165
        elsif x<="0000000010100001" then
            y <= "0000000010100110"; -- 166
        elsif x<="0000000010100110" then
            y <= "0000000010100111"; -- 167
        elsif x<="0000000010101010" then
            y <= "0000000010101000"; -- 168
        elsif x<="0000000010101111" then
            y <= "0000000010101001"; -- 169
        elsif x<="0000000010110011" then
            y <= "0000000010101010"; -- 170
        elsif x<="0000000010111000" then
            y <= "0000000010101011"; -- 171
        elsif x<="0000000010111100" then
            y <= "0000000010101100"; -- 172
        elsif x<="0000000011000001" then
            y <= "0000000010101101"; -- 173
        elsif x<="0000000011000101" then
            y <= "0000000010101110"; -- 174
        elsif x<="0000000011001010" then
            y <= "0000000010101111"; -- 175
        elsif x<="0000000011001111" then
            y <= "0000000010110000"; -- 176
        elsif x<="0000000011010011" then
            y <= "0000000010110001"; -- 177
        elsif x<="0000000011011000" then
            y <= "0000000010110010"; -- 178
        elsif x<="0000000011011101" then
            y <= "0000000010110011"; -- 179
        elsif x<="0000000011100001" then
            y <= "0000000010110100"; -- 180
        elsif x<="0000000011100110" then
            y <= "0000000010110101"; -- 181
        elsif x<="0000000011101011" then
            y <= "0000000010110110"; -- 182
        elsif x<="0000000011110000" then
            y <= "0000000010110111"; -- 183
        elsif x<="0000000011110101" then
            y <= "0000000010111000"; -- 184
        elsif x<="0000000011111010" then
            y <= "0000000010111001"; -- 185
        elsif x<="0000000011111111" then
            y <= "0000000010111010"; -- 186
        elsif x<="0000000100000100" then
            y <= "0000000010111011"; -- 187
        elsif x<="0000000100001001" then
            y <= "0000000010111100"; -- 188
        elsif x<="0000000100001110" then
            y <= "0000000010111101"; -- 189
        elsif x<="0000000100010011" then
            y <= "0000000010111110"; -- 190
        elsif x<="0000000100011001" then
            y <= "0000000010111111"; -- 191
        elsif x<="0000000100011110" then
            y <= "0000000011000000"; -- 192
        elsif x<="0000000100100011" then
            y <= "0000000011000001"; -- 193
        elsif x<="0000000100101001" then
            y <= "0000000011000010"; -- 194
        elsif x<="0000000100101110" then
            y <= "0000000011000011"; -- 195
        elsif x<="0000000100110100" then
            y <= "0000000011000100"; -- 196
        elsif x<="0000000100111010" then
            y <= "0000000011000101"; -- 197
        elsif x<="0000000100111111" then
            y <= "0000000011000110"; -- 198
        elsif x<="0000000101000101" then
            y <= "0000000011000111"; -- 199
        elsif x<="0000000101001011" then
            y <= "0000000011001000"; -- 200
        elsif x<="0000000101010001" then
            y <= "0000000011001001"; -- 201
        elsif x<="0000000101010111" then
            y <= "0000000011001010"; -- 202
        elsif x<="0000000101011101" then
            y <= "0000000011001011"; -- 203
        elsif x<="0000000101100011" then
            y <= "0000000011001100"; -- 204
        elsif x<="0000000101101001" then
            y <= "0000000011001101"; -- 205
        elsif x<="0000000101110000" then
            y <= "0000000011001110"; -- 206
        elsif x<="0000000101110110" then
            y <= "0000000011001111"; -- 207
        elsif x<="0000000101111101" then
            y <= "0000000011010000"; -- 208
        elsif x<="0000000110000011" then
            y <= "0000000011010001"; -- 209
        elsif x<="0000000110001010" then
            y <= "0000000011010010"; -- 210
        elsif x<="0000000110010001" then
            y <= "0000000011010011"; -- 211
        elsif x<="0000000110011000" then
            y <= "0000000011010100"; -- 212
        elsif x<="0000000110011111" then
            y <= "0000000011010101"; -- 213
        elsif x<="0000000110100110" then
            y <= "0000000011010110"; -- 214
        elsif x<="0000000110101110" then
            y <= "0000000011010111"; -- 215
        elsif x<="0000000110110101" then
            y <= "0000000011011000"; -- 216
        elsif x<="0000000110111101" then
            y <= "0000000011011001"; -- 217
        elsif x<="0000000111000101" then
            y <= "0000000011011010"; -- 218
        elsif x<="0000000111001101" then
            y <= "0000000011011011"; -- 219
        elsif x<="0000000111010101" then
            y <= "0000000011011100"; -- 220
        elsif x<="0000000111011110" then
            y <= "0000000011011101"; -- 221
        elsif x<="0000000111100110" then
            y <= "0000000011011110"; -- 222
        elsif x<="0000000111101111" then
            y <= "0000000011011111"; -- 223
        elsif x<="0000000111111000" then
            y <= "0000000011100000"; -- 224
        elsif x<="0000001000000010" then
            y <= "0000000011100001"; -- 225
        elsif x<="0000001000001011" then
            y <= "0000000011100010"; -- 226
        elsif x<="0000001000010101" then
            y <= "0000000011100011"; -- 227
        elsif x<="0000001000100000" then
            y <= "0000000011100100"; -- 228
        elsif x<="0000001000101010" then
            y <= "0000000011100101"; -- 229
        elsif x<="0000001000110101" then
            y <= "0000000011100110"; -- 230
        elsif x<="0000001001000001" then
            y <= "0000000011100111"; -- 231
        elsif x<="0000001001001100" then
            y <= "0000000011101000"; -- 232
        elsif x<="0000001001011001" then
            y <= "0000000011101001"; -- 233
        elsif x<="0000001001100101" then
            y <= "0000000011101010"; -- 234
        elsif x<="0000001001110011" then
            y <= "0000000011101011"; -- 235
        elsif x<="0000001010000000" then
            y <= "0000000011101100"; -- 236
        elsif x<="0000001010001111" then
            y <= "0000000011101101"; -- 237
        elsif x<="0000001010011110" then
            y <= "0000000011101110"; -- 238
        elsif x<="0000001010101110" then
            y <= "0000000011101111"; -- 239
        elsif x<="0000001010111111" then
            y <= "0000000011110000"; -- 240
        elsif x<="0000001011010010" then
            y <= "0000000011110001"; -- 241
        elsif x<="0000001011100101" then
            y <= "0000000011110010"; -- 242
        elsif x<="0000001011111010" then
            y <= "0000000011110011"; -- 243
        elsif x<="0000001100010000" then
            y <= "0000000011110100"; -- 244
        elsif x<="0000001100101000" then
            y <= "0000000011110101"; -- 245
        elsif x<="0000001101000011" then
            y <= "0000000011110110"; -- 246
        elsif x<="0000001101100001" then
            y <= "0000000011110111"; -- 247
        elsif x<="0000001110000010" then
            y <= "0000000011111000"; -- 248
        elsif x<="0000001110100111" then
            y <= "0000000011111001"; -- 249
        elsif x<="0000001111010011" then
            y <= "0000000011111010"; -- 250
        elsif x<="0000010000001000" then
            y <= "0000000011111011"; -- 251
        elsif x<="0000010001001010" then
            y <= "0000000011111100"; -- 252
        elsif x<="0000010010100100" then
            y <= "0000000011111101"; -- 253
        else
            y <= "0000000100000000"; -- 256
        end if;
        
    end process;
end rtl_256;