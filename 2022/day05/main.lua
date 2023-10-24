local stack = require("stack")

-- [H]                 [Z]         [J]
-- [L]     [W] [B]     [G]         [R]
-- [R]     [G] [S]     [J] [H]     [Q]
-- [F]     [N] [T] [J] [P] [R]     [F]
-- [B]     [C] [M] [R] [Q] [F] [G] [P]
-- [C] [D] [F] [D] [D] [D] [T] [M] [G]
-- [J] [C] [J] [J] [C] [L] [Z] [V] [B]
-- [M] [Z] [H] [P] [N] [W] [P] [L] [C]
--  1   2   3   4   5   6   7   8   9

local firstStack = { "M", "J", "C", "B", "F", "R", "L", "H" }
local secondStack = { "Z", "C", "D" }
local thirdStack = { "H", "J", "F", "C", "N", "G", "W" }
local fourthStack = { "P", "J", "D", "M", "T", "S", "B" }
local fifthStack = { "N", "C", "D", "R", "J" }
local sixthStack = { "W", "L", "D", "Q", "P", "J", "G", "Z" }
local seventhStack = { "P", "Z", "T", "F", "R", "H" }
local eightStack = { "L", "V", "M", "G" }
local ninethStack = { "C", "B", "G", "P", "F", "Q", "R", "J" }

local stacks = {
    [1] = firstStack,
    [2] = secondStack,
    [3] = thirdStack,
    [4] = fourthStack,
    [5] = fifthStack,
    [6] = sixthStack,
    [7] = seventhStack,
    [8] = eightStack,
    [9] = ninethStack,
}

local function loadFromFile()
    local rearragement = {}
    for line in io.lines("input.txt") do
        local recipe = {}
        for num in string.gmatch(line, "%d+") do
            table.insert(recipe, tonumber(num))
        end
        table.insert(rearragement, recipe)
    end
    return rearragement
end

-- local rearragement = loadFromFile();
--
-- for i, recipe in pairs(rearragement) do
--   for j = 1, recipe[1] do
--     local pop = stack.pop(stacks[recipe[2]]);
--     stack.push(pop, stacks[recipe[3]]);
--   end
-- end
--
-- print(
--   stack.peek(firstStack)
--   .. stack.peek(secondStack)
--   .. stack.peek(thirdStack)
--   .. stack.peek(fourthStack)
--   .. stack.peek(fifthStack)
--   .. stack.peek(sixthStack)
--   .. stack.peek(seventhStack)
--   .. stack.peek(eightStack)
--   .. stack.peek(ninethStack)
-- );

local plan = loadFromFile()

for i, recipe in pairs(plan) do
    local sub_stack = stack.pop_sub_stack(stacks[recipe[2]], recipe[1])
    stack.push_sub_stack(sub_stack, stacks[recipe[3]])
end

print(
    stack.peek(firstStack)
        .. stack.peek(secondStack)
        .. stack.peek(thirdStack)
        .. stack.peek(fourthStack)
        .. stack.peek(fifthStack)
        .. stack.peek(sixthStack)
        .. stack.peek(seventhStack)
        .. stack.peek(eightStack)
        .. stack.peek(ninethStack)
)
