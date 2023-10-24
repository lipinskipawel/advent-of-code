local utils = require("utils")

local function lodaFromFile()
    local rucksacks = {}
    for line in io.lines("input.txt") do
        table.insert(rucksacks, line)
    end
    return rucksacks
end

local rucksacks = lodaFromFile()

local function pointsForRecord(record)
    local lenghtOfRecord = #record
    local commonLetters = {}
    for i = 1, lenghtOfRecord / 2 do
        local byte = string.byte(record, i)
        local character = string.char(byte)
        commonLetters[character] = 0
    end
    for i = lenghtOfRecord / 2 + 1, #record do
        local byte = string.byte(record, i)
        local character = string.char(byte)
        local count = commonLetters[character]
        if count == 0 then
            commonLetters[character] = 1
        end
    end

    local result = utils.filter(commonLetters, function(arg)
        return arg >= 1
    end)
    return utils.mapReduce(result)
end

local sum = 0
for i, val in pairs(rucksacks) do
    local scoreForRow = pointsForRecord(val)
    sum = sum + scoreForRow
end

print(sum)

local function pointsForGroup(one, two, three)
    local commonLetters = {}
    for i = 1, #one do
        local byte = string.byte(one, i)
        local character = string.char(byte)
        commonLetters[character] = 0
    end
    for i = 1, #two do
        local byte = string.byte(two, i)
        local character = string.char(byte)
        local count = commonLetters[character]
        if count == 0 then
            commonLetters[character] = 1
        end
    end
    for i = 1, #three do
        local byte = string.byte(three, i)
        local character = string.char(byte)
        local count = commonLetters[character]
        if count == 1 then
            commonLetters[character] = 2
        end
    end

    local result = utils.filter(commonLetters, function(arg)
        return arg >= 2
    end)
    return utils.mapReduce(result)
end

local secondSum = 0
for i = 1, #rucksacks, 3 do
    local groupPoints =
        pointsForGroup(rucksacks[i], rucksacks[i + 1], rucksacks[i + 2])
    secondSum = secondSum + groupPoints
end

print(secondSum)
