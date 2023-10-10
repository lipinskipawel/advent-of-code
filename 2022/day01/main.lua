package.path = package.path .. ';../utils/utils.lua';
local util = require("utils");


local t = {};
local tempElfCalories = 0;
for line in io.lines("input.txt") do
  if line ~= '' then
    tempElfCalories = tempElfCalories + tonumber(line);
  else
    table.insert(t, tempElfCalories);
    tempElfCalories = 0;
  end
end

table.sort(t, function(a, b)
  return a < b;
end);

local sumOfThree = 0;
for i = 0, 2 do
  sumOfThree = sumOfThree + t[#t - i];
end

print(util.max(t));
print(sumOfThree);

