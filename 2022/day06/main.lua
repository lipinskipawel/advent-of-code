package.path = package.path .. ";../utils/utils.lua"
local util = require("utils")

local function loadFromFile()
    for line in io.lines("input.txt") do
        return line
    end
end

-- local signal = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
-- local signal = "bvwbjplbgvbhsrlpgdmjqwftvncz"
-- local signal = "nppdvjthqldpwncqszvftbrmjlhg"
-- local signal = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
-- local signal = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
local signal = loadFromFile()

function marker(charStream, num)
    for i = 4, #charStream, 1 do
        local c = charStream:sub(i - (num - 1), i)
        if doesNotRepeat(c, num) then
            return i
        end
    end
    return #charStream
end

function doesNotRepeat(str, num)
    local chars = uniqueChars(str)
    return #chars == num
end

function uniqueChars(str)
    local strc = {}
    for c in str:gmatch(".") do
        if not util.contains(strc, c) then
            table.insert(strc, c)
        end
    end
    return strc
end

print(marker(signal, 4))
print(marker(signal, 14))
