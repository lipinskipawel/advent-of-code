local function splitPairToRange(elfPair)
  local range = string.find(elfPair, "-");
  if range == nil then
    error("[-] not found in a string [" .. elfPair .. "]");
  end
  local firstElfRange = tonumber(string.sub(elfPair, 1, range - 1));
  local secondElfRange = tonumber(string.sub(elfPair, range + 1, #elfPair));
  return { lower = firstElfRange, upper = secondElfRange };
end

local function loadFromFile()
  local assignments = {};
  for line in io.lines("input.txt") do
    local commaSeparator = string.find(line, ",");
    if commaSeparator == nil then
      error("[,] not found in a string [" .. line .. "]");
    end
    local firstElf = string.sub(line, 1, commaSeparator - 1);
    local secondElf = string.sub(line, commaSeparator + 1, #line);

    local firstPair = splitPairToRange(firstElf);
    local secondPair = splitPairToRange(secondElf);

    table.insert(assignments, { first = firstPair, second = secondPair });
  end
  return assignments;
end

local assignments = loadFromFile();


local function isOverlap(pair)
  local firstContainsSecond = pair.first.lower <= pair.second.lower and
    pair.first.upper >= pair.second.upper;
  local secondContainFirst = pair.first.lower >= pair.second.lower and
    pair.first.upper <= pair.second.upper;

  return firstContainsSecond or secondContainFirst;
end

local function isOverlapSecond(pair)
  local firstOverlap =  pair.first.upper >= pair.second.lower and
    pair.first.lower <= pair.second.upper;
  local secondOverlap = pair.second.upper <= pair.first.lower and
    pair.second.upper >= pair.first.lower;

  return firstOverlap or secondOverlap;
end

local overlaps = 0;
for _, val in pairs(assignments) do
  local isTrue = isOverlap(val);
  if isTrue == true then
    overlaps = overlaps + 1;
  end
end

print(overlaps);

local overlaps = 0;
for _, val in pairs(assignments) do
  local isTrue = isOverlapSecond(val);
  if isTrue == true then
    overlaps = overlaps + 1;
  end
end

print(overlaps);

