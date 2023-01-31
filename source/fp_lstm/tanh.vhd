-- A LUT version of tanh
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;               -- for type conversions

entity tanh is
    port (
        x : in signed(15 downto 0);
        y : out signed(15 downto 0)
    );

end tanh;


architecture rtl_64 of tanh is
    begin
        
        tanh_process:process(x)
        begin
            if x<="1111110110100100" then
                y <= "1111111100000000"; -- -256
            elsif x<="1111111000110011" then
                y <= "1111111100010011"; -- -237
            elsif x<="1111111001110010" then
                y <= "1111111100011011"; -- -229
            elsif x<="1111111010011101" then
                y <= "1111111100100011"; -- -221
            elsif x<="1111111010111110" then
                y <= "1111111100101011"; -- -213
            elsif x<="1111111011011001" then
                y <= "1111111100110011"; -- -205
            elsif x<="1111111011110000" then
                y <= "1111111100111011"; -- -197
            elsif x<="1111111100000100" then
                y <= "1111111101000011"; -- -189
            elsif x<="1111111100010110" then
                y <= "1111111101001011"; -- -181
            elsif x<="1111111100100110" then
                y <= "1111111101010011"; -- -173
            elsif x<="1111111100110101" then
                y <= "1111111101011011"; -- -165
            elsif x<="1111111101000011" then
                y <= "1111111101100011"; -- -157
            elsif x<="1111111101010000" then
                y <= "1111111101101100"; -- -148
            elsif x<="1111111101011100" then
                y <= "1111111101110100"; -- -140
            elsif x<="1111111101101000" then
                y <= "1111111101111100"; -- -132
            elsif x<="1111111101110011" then
                y <= "1111111110000100"; -- -124
            elsif x<="1111111101111101" then
                y <= "1111111110001100"; -- -116
            elsif x<="1111111110001000" then
                y <= "1111111110010100"; -- -108
            elsif x<="1111111110010001" then
                y <= "1111111110011100"; -- -100
            elsif x<="1111111110011011" then
                y <= "1111111110100100"; -- -92
            elsif x<="1111111110100100" then
                y <= "1111111110101100"; -- -84
            elsif x<="1111111110101101" then
                y <= "1111111110110100"; -- -76
            elsif x<="1111111110110110" then
                y <= "1111111110111100"; -- -68
            elsif x<="1111111110111111" then
                y <= "1111111111000100"; -- -60
            elsif x<="1111111111001000" then
                y <= "1111111111001100"; -- -52
            elsif x<="1111111111010000" then
                y <= "1111111111010101"; -- -43
            elsif x<="1111111111011000" then
                y <= "1111111111011101"; -- -35
            elsif x<="1111111111100001" then
                y <= "1111111111100101"; -- -27
            elsif x<="1111111111101001" then
                y <= "1111111111101101"; -- -19
            elsif x<="1111111111110001" then
                y <= "1111111111110101"; -- -11
            elsif x<="1111111111111001" then
                y <= "1111111111111101"; -- -3
            elsif x<="0000000000000000" then
                y <= "0000000000000100"; -- 4
            elsif x<="0000000000001000" then
                y <= "0000000000001100"; -- 12
            elsif x<="0000000000010000" then
                y <= "0000000000010100"; -- 20
            elsif x<="0000000000011000" then
                y <= "0000000000011100"; -- 28
            elsif x<="0000000000100001" then
                y <= "0000000000100100"; -- 36
            elsif x<="0000000000101001" then
                y <= "0000000000101100"; -- 44
            elsif x<="0000000000110001" then
                y <= "0000000000110101"; -- 53
            elsif x<="0000000000111010" then
                y <= "0000000000111101"; -- 61
            elsif x<="0000000001000010" then
                y <= "0000000001000101"; -- 69
            elsif x<="0000000001001011" then
                y <= "0000000001001101"; -- 77
            elsif x<="0000000001010100" then
                y <= "0000000001010101"; -- 85
            elsif x<="0000000001011101" then
                y <= "0000000001011101"; -- 93
            elsif x<="0000000001100110" then
                y <= "0000000001100101"; -- 101
            elsif x<="0000000001110000" then
                y <= "0000000001101101"; -- 109
            elsif x<="0000000001111010" then
                y <= "0000000001110101"; -- 117
            elsif x<="0000000010000100" then
                y <= "0000000001111101"; -- 125
            elsif x<="0000000010001111" then
                y <= "0000000010000101"; -- 133
            elsif x<="0000000010011010" then
                y <= "0000000010001101"; -- 141
            elsif x<="0000000010100101" then
                y <= "0000000010010101"; -- 149
            elsif x<="0000000010110010" then
                y <= "0000000010011110"; -- 158
            elsif x<="0000000010111111" then
                y <= "0000000010100110"; -- 166
            elsif x<="0000000011001101" then
                y <= "0000000010101110"; -- 174
            elsif x<="0000000011011100" then
                y <= "0000000010110110"; -- 182
            elsif x<="0000000011101100" then
                y <= "0000000010111110"; -- 190
            elsif x<="0000000011111110" then
                y <= "0000000011000110"; -- 198
            elsif x<="0000000100010011" then
                y <= "0000000011001110"; -- 206
            elsif x<="0000000100101010" then
                y <= "0000000011010110"; -- 214
            elsif x<="0000000101000110" then
                y <= "0000000011011110"; -- 222
            elsif x<="0000000101100111" then
                y <= "0000000011100110"; -- 230
            elsif x<="0000000110010100" then
                y <= "0000000011101110"; -- 238
            elsif x<="0000000111011000" then
                y <= "0000000011110110"; -- 246
            elsif x<="0000001010010000" then
                y <= "0000000011111111"; -- 255
            else
                y <= "0000000100000000"; -- 256
            end if;            
        end process;
    end rtl_64;


architecture rtl_128 of tanh is
begin
    
    tanh_process:process(x)
    begin
        if x<="1111110110000010" then
            y <= "1111111100000000"; -- -256
        elsif x<="1111110111101010" then
            y <= "1111111100001011"; -- -245
        elsif x<="1111111000100010" then
            y <= "1111111100001111"; -- -241
        elsif x<="1111111001001000" then
            y <= "1111111100010011"; -- -237
        elsif x<="1111111001100110" then
            y <= "1111111100010111"; -- -233
        elsif x<="1111111001111111" then
            y <= "1111111100011011"; -- -229
        elsif x<="1111111010010100" then
            y <= "1111111100011111"; -- -225
        elsif x<="1111111010100110" then
            y <= "1111111100100011"; -- -221
        elsif x<="1111111010110110" then
            y <= "1111111100100111"; -- -217
        elsif x<="1111111011000101" then
            y <= "1111111100101011"; -- -213
        elsif x<="1111111011010010" then
            y <= "1111111100101111"; -- -209
        elsif x<="1111111011011110" then
            y <= "1111111100110011"; -- -205
        elsif x<="1111111011101010" then
            y <= "1111111100110111"; -- -201
        elsif x<="1111111011110100" then
            y <= "1111111100111011"; -- -197
        elsif x<="1111111011111110" then
            y <= "1111111100111111"; -- -193
        elsif x<="1111111100001000" then
            y <= "1111111101000011"; -- -189
        elsif x<="1111111100010001" then
            y <= "1111111101000111"; -- -185
        elsif x<="1111111100011001" then
            y <= "1111111101001011"; -- -181
        elsif x<="1111111100100001" then
            y <= "1111111101001111"; -- -177
        elsif x<="1111111100101001" then
            y <= "1111111101010011"; -- -173
        elsif x<="1111111100110000" then
            y <= "1111111101010111"; -- -169
        elsif x<="1111111100110111" then
            y <= "1111111101011011"; -- -165
        elsif x<="1111111100111110" then
            y <= "1111111101011111"; -- -161
        elsif x<="1111111101000101" then
            y <= "1111111101100011"; -- -157
        elsif x<="1111111101001100" then
            y <= "1111111101100111"; -- -153
        elsif x<="1111111101010010" then
            y <= "1111111101101011"; -- -149
        elsif x<="1111111101011000" then
            y <= "1111111101101111"; -- -145
        elsif x<="1111111101011110" then
            y <= "1111111101110011"; -- -141
        elsif x<="1111111101100100" then
            y <= "1111111101110111"; -- -137
        elsif x<="1111111101101001" then
            y <= "1111111101111011"; -- -133
        elsif x<="1111111101101111" then
            y <= "1111111101111111"; -- -129
        elsif x<="1111111101110100" then
            y <= "1111111110000011"; -- -125
        elsif x<="1111111101111001" then
            y <= "1111111110000111"; -- -121
        elsif x<="1111111101111111" then
            y <= "1111111110001011"; -- -117
        elsif x<="1111111110000100" then
            y <= "1111111110001111"; -- -113
        elsif x<="1111111110001001" then
            y <= "1111111110010011"; -- -109
        elsif x<="1111111110001110" then
            y <= "1111111110010111"; -- -105
        elsif x<="1111111110010010" then
            y <= "1111111110011011"; -- -101
        elsif x<="1111111110010111" then
            y <= "1111111110011111"; -- -97
        elsif x<="1111111110011100" then
            y <= "1111111110100011"; -- -93
        elsif x<="1111111110100001" then
            y <= "1111111110100111"; -- -89
        elsif x<="1111111110100101" then
            y <= "1111111110101011"; -- -85
        elsif x<="1111111110101010" then
            y <= "1111111110101111"; -- -81
        elsif x<="1111111110101110" then
            y <= "1111111110110011"; -- -77
        elsif x<="1111111110110011" then
            y <= "1111111110110111"; -- -73
        elsif x<="1111111110110111" then
            y <= "1111111110111011"; -- -69
        elsif x<="1111111110111011" then
            y <= "1111111110111111"; -- -65
        elsif x<="1111111111000000" then
            y <= "1111111111000011"; -- -61
        elsif x<="1111111111000100" then
            y <= "1111111111000111"; -- -57
        elsif x<="1111111111001000" then
            y <= "1111111111001011"; -- -53
        elsif x<="1111111111001100" then
            y <= "1111111111001111"; -- -49
        elsif x<="1111111111010000" then
            y <= "1111111111010011"; -- -45
        elsif x<="1111111111010100" then
            y <= "1111111111010111"; -- -41
        elsif x<="1111111111011001" then
            y <= "1111111111011011"; -- -37
        elsif x<="1111111111011101" then
            y <= "1111111111011111"; -- -33
        elsif x<="1111111111100001" then
            y <= "1111111111100011"; -- -29
        elsif x<="1111111111100101" then
            y <= "1111111111100111"; -- -25
        elsif x<="1111111111101001" then
            y <= "1111111111101011"; -- -21
        elsif x<="1111111111101101" then
            y <= "1111111111101111"; -- -17
        elsif x<="1111111111110001" then
            y <= "1111111111110011"; -- -13
        elsif x<="1111111111110101" then
            y <= "1111111111110111"; -- -9
        elsif x<="1111111111111001" then
            y <= "1111111111111011"; -- -5
        elsif x<="1111111111111101" then
            y <= "1111111111111111"; -- -1
        elsif x<="0000000000000000" then
            y <= "0000000000000010"; -- 2
        elsif x<="0000000000000100" then
            y <= "0000000000000110"; -- 6
        elsif x<="0000000000001000" then
            y <= "0000000000001010"; -- 10
        elsif x<="0000000000001100" then
            y <= "0000000000001110"; -- 14
        elsif x<="0000000000010000" then
            y <= "0000000000010010"; -- 18
        elsif x<="0000000000010100" then
            y <= "0000000000010110"; -- 22
        elsif x<="0000000000011000" then
            y <= "0000000000011010"; -- 26
        elsif x<="0000000000011100" then
            y <= "0000000000011110"; -- 30
        elsif x<="0000000000100000" then
            y <= "0000000000100010"; -- 34
        elsif x<="0000000000100100" then
            y <= "0000000000100110"; -- 38
        elsif x<="0000000000101000" then
            y <= "0000000000101010"; -- 42
        elsif x<="0000000000101101" then
            y <= "0000000000101110"; -- 46
        elsif x<="0000000000110001" then
            y <= "0000000000110010"; -- 50
        elsif x<="0000000000110101" then
            y <= "0000000000110110"; -- 54
        elsif x<="0000000000111001" then
            y <= "0000000000111010"; -- 58
        elsif x<="0000000000111101" then
            y <= "0000000000111110"; -- 62
        elsif x<="0000000001000010" then
            y <= "0000000001000010"; -- 66
        elsif x<="0000000001000110" then
            y <= "0000000001000110"; -- 70
        elsif x<="0000000001001010" then
            y <= "0000000001001010"; -- 74
        elsif x<="0000000001001111" then
            y <= "0000000001001110"; -- 78
        elsif x<="0000000001010011" then
            y <= "0000000001010010"; -- 82
        elsif x<="0000000001010111" then
            y <= "0000000001010110"; -- 86
        elsif x<="0000000001011100" then
            y <= "0000000001011010"; -- 90
        elsif x<="0000000001100001" then
            y <= "0000000001011110"; -- 94
        elsif x<="0000000001100101" then
            y <= "0000000001100010"; -- 98
        elsif x<="0000000001101010" then
            y <= "0000000001100110"; -- 102
        elsif x<="0000000001101111" then
            y <= "0000000001101010"; -- 106
        elsif x<="0000000001110100" then
            y <= "0000000001101110"; -- 110
        elsif x<="0000000001111001" then
            y <= "0000000001110010"; -- 114
        elsif x<="0000000001111110" then
            y <= "0000000001110110"; -- 118
        elsif x<="0000000010000011" then
            y <= "0000000001111010"; -- 122
        elsif x<="0000000010001000" then
            y <= "0000000001111110"; -- 126
        elsif x<="0000000010001101" then
            y <= "0000000010000010"; -- 130
        elsif x<="0000000010010011" then
            y <= "0000000010000110"; -- 134
        elsif x<="0000000010011000" then
            y <= "0000000010001010"; -- 138
        elsif x<="0000000010011110" then
            y <= "0000000010001110"; -- 142
        elsif x<="0000000010100100" then
            y <= "0000000010010010"; -- 146
        elsif x<="0000000010101010" then
            y <= "0000000010010110"; -- 150
        elsif x<="0000000010110000" then
            y <= "0000000010011010"; -- 154
        elsif x<="0000000010110110" then
            y <= "0000000010011110"; -- 158
        elsif x<="0000000010111101" then
            y <= "0000000010100010"; -- 162
        elsif x<="0000000011000011" then
            y <= "0000000010100110"; -- 166
        elsif x<="0000000011001010" then
            y <= "0000000010101010"; -- 170
        elsif x<="0000000011010001" then
            y <= "0000000010101110"; -- 174
        elsif x<="0000000011011001" then
            y <= "0000000010110010"; -- 178
        elsif x<="0000000011100001" then
            y <= "0000000010110110"; -- 182
        elsif x<="0000000011101001" then
            y <= "0000000010111010"; -- 186
        elsif x<="0000000011110010" then
            y <= "0000000010111110"; -- 190
        elsif x<="0000000011111011" then
            y <= "0000000011000010"; -- 194
        elsif x<="0000000100000100" then
            y <= "0000000011000110"; -- 198
        elsif x<="0000000100001110" then
            y <= "0000000011001010"; -- 202
        elsif x<="0000000100011001" then
            y <= "0000000011001110"; -- 206
        elsif x<="0000000100100101" then
            y <= "0000000011010010"; -- 210
        elsif x<="0000000100110001" then
            y <= "0000000011010110"; -- 214
        elsif x<="0000000100111111" then
            y <= "0000000011011010"; -- 218
        elsif x<="0000000101001110" then
            y <= "0000000011011110"; -- 222
        elsif x<="0000000101011110" then
            y <= "0000000011100010"; -- 226
        elsif x<="0000000101110001" then
            y <= "0000000011100110"; -- 230
        elsif x<="0000000110000111" then
            y <= "0000000011101010"; -- 234
        elsif x<="0000000110100001" then
            y <= "0000000011101110"; -- 238
        elsif x<="0000000111000000" then
            y <= "0000000011110010"; -- 242
        elsif x<="0000000111101010" then
            y <= "0000000011110110"; -- 246
        elsif x<="0000001000101000" then
            y <= "0000000011111010"; -- 250
        elsif x<="0000001010110110" then
            y <= "0000000011111111"; -- 255
        else
            y <= "0000000100000000"; -- 256
        end if;        
    end process;
end rtl_128;

architecture rtl_256 of tanh is
    begin
        
        tanh_process:process(x)
        begin
            if x<="1111110110000010" then
                y <= "1111111100000000"; -- -256
            elsif x<="1111110111101010" then
                y <= "1111111100001011"; -- -245
            elsif x<="1111111000100010" then
                y <= "1111111100001111"; -- -241
            elsif x<="1111111001001000" then
                y <= "1111111100010011"; -- -237
            elsif x<="1111111001100110" then
                y <= "1111111100010111"; -- -233
            elsif x<="1111111001111111" then
                y <= "1111111100011011"; -- -229
            elsif x<="1111111010010100" then
                y <= "1111111100011111"; -- -225
            elsif x<="1111111010100110" then
                y <= "1111111100100011"; -- -221
            elsif x<="1111111010110110" then
                y <= "1111111100100111"; -- -217
            elsif x<="1111111011000101" then
                y <= "1111111100101011"; -- -213
            elsif x<="1111111011010010" then
                y <= "1111111100101111"; -- -209
            elsif x<="1111111011011110" then
                y <= "1111111100110011"; -- -205
            elsif x<="1111111011101010" then
                y <= "1111111100110111"; -- -201
            elsif x<="1111111011110100" then
                y <= "1111111100111011"; -- -197
            elsif x<="1111111011111110" then
                y <= "1111111100111111"; -- -193
            elsif x<="1111111100001000" then
                y <= "1111111101000011"; -- -189
            elsif x<="1111111100010001" then
                y <= "1111111101000111"; -- -185
            elsif x<="1111111100011001" then
                y <= "1111111101001011"; -- -181
            elsif x<="1111111100100001" then
                y <= "1111111101001111"; -- -177
            elsif x<="1111111100101001" then
                y <= "1111111101010011"; -- -173
            elsif x<="1111111100110000" then
                y <= "1111111101010111"; -- -169
            elsif x<="1111111100110111" then
                y <= "1111111101011011"; -- -165
            elsif x<="1111111100111110" then
                y <= "1111111101011111"; -- -161
            elsif x<="1111111101000101" then
                y <= "1111111101100011"; -- -157
            elsif x<="1111111101001100" then
                y <= "1111111101100111"; -- -153
            elsif x<="1111111101010010" then
                y <= "1111111101101011"; -- -149
            elsif x<="1111111101011000" then
                y <= "1111111101101111"; -- -145
            elsif x<="1111111101011110" then
                y <= "1111111101110011"; -- -141
            elsif x<="1111111101100100" then
                y <= "1111111101110111"; -- -137
            elsif x<="1111111101101001" then
                y <= "1111111101111011"; -- -133
            elsif x<="1111111101101111" then
                y <= "1111111101111111"; -- -129
            elsif x<="1111111101110100" then
                y <= "1111111110000011"; -- -125
            elsif x<="1111111101111001" then
                y <= "1111111110000111"; -- -121
            elsif x<="1111111101111111" then
                y <= "1111111110001011"; -- -117
            elsif x<="1111111110000100" then
                y <= "1111111110001111"; -- -113
            elsif x<="1111111110001001" then
                y <= "1111111110010011"; -- -109
            elsif x<="1111111110001110" then
                y <= "1111111110010111"; -- -105
            elsif x<="1111111110010010" then
                y <= "1111111110011011"; -- -101
            elsif x<="1111111110010111" then
                y <= "1111111110011111"; -- -97
            elsif x<="1111111110011100" then
                y <= "1111111110100011"; -- -93
            elsif x<="1111111110100001" then
                y <= "1111111110100111"; -- -89
            elsif x<="1111111110100101" then
                y <= "1111111110101011"; -- -85
            elsif x<="1111111110101010" then
                y <= "1111111110101111"; -- -81
            elsif x<="1111111110101110" then
                y <= "1111111110110011"; -- -77
            elsif x<="1111111110110011" then
                y <= "1111111110110111"; -- -73
            elsif x<="1111111110110111" then
                y <= "1111111110111011"; -- -69
            elsif x<="1111111110111011" then
                y <= "1111111110111111"; -- -65
            elsif x<="1111111111000000" then
                y <= "1111111111000011"; -- -61
            elsif x<="1111111111000100" then
                y <= "1111111111000111"; -- -57
            elsif x<="1111111111001000" then
                y <= "1111111111001011"; -- -53
            elsif x<="1111111111001100" then
                y <= "1111111111001111"; -- -49
            elsif x<="1111111111010000" then
                y <= "1111111111010011"; -- -45
            elsif x<="1111111111010100" then
                y <= "1111111111010111"; -- -41
            elsif x<="1111111111011001" then
                y <= "1111111111011011"; -- -37
            elsif x<="1111111111011101" then
                y <= "1111111111011111"; -- -33
            elsif x<="1111111111100001" then
                y <= "1111111111100011"; -- -29
            elsif x<="1111111111100101" then
                y <= "1111111111100111"; -- -25
            elsif x<="1111111111101001" then
                y <= "1111111111101011"; -- -21
            elsif x<="1111111111101101" then
                y <= "1111111111101111"; -- -17
            elsif x<="1111111111110001" then
                y <= "1111111111110011"; -- -13
            elsif x<="1111111111110101" then
                y <= "1111111111110111"; -- -9
            elsif x<="1111111111111001" then
                y <= "1111111111111011"; -- -5
            elsif x<="1111111111111101" then
                y <= "1111111111111111"; -- -1
            elsif x<="0000000000000000" then
                y <= "0000000000000010"; -- 2
            elsif x<="0000000000000100" then
                y <= "0000000000000110"; -- 6
            elsif x<="0000000000001000" then
                y <= "0000000000001010"; -- 10
            elsif x<="0000000000001100" then
                y <= "0000000000001110"; -- 14
            elsif x<="0000000000010000" then
                y <= "0000000000010010"; -- 18
            elsif x<="0000000000010100" then
                y <= "0000000000010110"; -- 22
            elsif x<="0000000000011000" then
                y <= "0000000000011010"; -- 26
            elsif x<="0000000000011100" then
                y <= "0000000000011110"; -- 30
            elsif x<="0000000000100000" then
                y <= "0000000000100010"; -- 34
            elsif x<="0000000000100100" then
                y <= "0000000000100110"; -- 38
            elsif x<="0000000000101000" then
                y <= "0000000000101010"; -- 42
            elsif x<="0000000000101101" then
                y <= "0000000000101110"; -- 46
            elsif x<="0000000000110001" then
                y <= "0000000000110010"; -- 50
            elsif x<="0000000000110101" then
                y <= "0000000000110110"; -- 54
            elsif x<="0000000000111001" then
                y <= "0000000000111010"; -- 58
            elsif x<="0000000000111101" then
                y <= "0000000000111110"; -- 62
            elsif x<="0000000001000010" then
                y <= "0000000001000010"; -- 66
            elsif x<="0000000001000110" then
                y <= "0000000001000110"; -- 70
            elsif x<="0000000001001010" then
                y <= "0000000001001010"; -- 74
            elsif x<="0000000001001111" then
                y <= "0000000001001110"; -- 78
            elsif x<="0000000001010011" then
                y <= "0000000001010010"; -- 82
            elsif x<="0000000001010111" then
                y <= "0000000001010110"; -- 86
            elsif x<="0000000001011100" then
                y <= "0000000001011010"; -- 90
            elsif x<="0000000001100001" then
                y <= "0000000001011110"; -- 94
            elsif x<="0000000001100101" then
                y <= "0000000001100010"; -- 98
            elsif x<="0000000001101010" then
                y <= "0000000001100110"; -- 102
            elsif x<="0000000001101111" then
                y <= "0000000001101010"; -- 106
            elsif x<="0000000001110100" then
                y <= "0000000001101110"; -- 110
            elsif x<="0000000001111001" then
                y <= "0000000001110010"; -- 114
            elsif x<="0000000001111110" then
                y <= "0000000001110110"; -- 118
            elsif x<="0000000010000011" then
                y <= "0000000001111010"; -- 122
            elsif x<="0000000010001000" then
                y <= "0000000001111110"; -- 126
            elsif x<="0000000010001101" then
                y <= "0000000010000010"; -- 130
            elsif x<="0000000010010011" then
                y <= "0000000010000110"; -- 134
            elsif x<="0000000010011000" then
                y <= "0000000010001010"; -- 138
            elsif x<="0000000010011110" then
                y <= "0000000010001110"; -- 142
            elsif x<="0000000010100100" then
                y <= "0000000010010010"; -- 146
            elsif x<="0000000010101010" then
                y <= "0000000010010110"; -- 150
            elsif x<="0000000010110000" then
                y <= "0000000010011010"; -- 154
            elsif x<="0000000010110110" then
                y <= "0000000010011110"; -- 158
            elsif x<="0000000010111101" then
                y <= "0000000010100010"; -- 162
            elsif x<="0000000011000011" then
                y <= "0000000010100110"; -- 166
            elsif x<="0000000011001010" then
                y <= "0000000010101010"; -- 170
            elsif x<="0000000011010001" then
                y <= "0000000010101110"; -- 174
            elsif x<="0000000011011001" then
                y <= "0000000010110010"; -- 178
            elsif x<="0000000011100001" then
                y <= "0000000010110110"; -- 182
            elsif x<="0000000011101001" then
                y <= "0000000010111010"; -- 186
            elsif x<="0000000011110010" then
                y <= "0000000010111110"; -- 190
            elsif x<="0000000011111011" then
                y <= "0000000011000010"; -- 194
            elsif x<="0000000100000100" then
                y <= "0000000011000110"; -- 198
            elsif x<="0000000100001110" then
                y <= "0000000011001010"; -- 202
            elsif x<="0000000100011001" then
                y <= "0000000011001110"; -- 206
            elsif x<="0000000100100101" then
                y <= "0000000011010010"; -- 210
            elsif x<="0000000100110001" then
                y <= "0000000011010110"; -- 214
            elsif x<="0000000100111111" then
                y <= "0000000011011010"; -- 218
            elsif x<="0000000101001110" then
                y <= "0000000011011110"; -- 222
            elsif x<="0000000101011110" then
                y <= "0000000011100010"; -- 226
            elsif x<="0000000101110001" then
                y <= "0000000011100110"; -- 230
            elsif x<="0000000110000111" then
                y <= "0000000011101010"; -- 234
            elsif x<="0000000110100001" then
                y <= "0000000011101110"; -- 238
            elsif x<="0000000111000000" then
                y <= "0000000011110010"; -- 242
            elsif x<="0000000111101010" then
                y <= "0000000011110110"; -- 246
            elsif x<="0000001000101000" then
                y <= "0000000011111010"; -- 250
            elsif x<="0000001010110110" then
                y <= "0000000011111111"; -- 255
            else
                y <= "0000000100000000"; -- 256
            end if;        
        end process;
    end rtl_256;