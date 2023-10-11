-- predict
-- A  | rock
-- B  | paper
-- C  | scissors
--
-- recommendation
-- X  | rock
-- Y  | paper
-- Z  | scissors

local function loadFromFile()
  local strategy = {};
  for line in io.lines('input.txt') do
    local firstByte = string.byte(line, 1);
    local lastByte = string.byte(line, 3);
    table.insert(strategy, { predict = string.char(firstByte), recommendation = string.char(lastByte)} );
  end
  return strategy;
end

local strategy = loadFromFile();

-- local strategy = {
--   { predict = 'A', recommendation = 'Y' },
--   { predict = 'B', recommendation = 'X' },
--   { predict = 'C', recommendation = 'Z' }
-- };

local pieceValue = {
  { piece = 'X', value = 1 },
  { piece = 'Y', value = 2 },
  { piece = 'Z', value = 3 }
};

local function iterate(key, compare, tableToIterate, value)
  for _, val in ipairs(tableToIterate) do
    if val[key] == compare then
      return val[value];
    end
  end
end

-- 0 for lose, 3 for draw, 6 for win
local function winPoints(round)
  if round.predict == 'A' and round.recommendation == 'X' then
    return 3;
  end
  if round.predict == 'A' and round.recommendation == 'Y' then
    return 6;
  end
  if round.predict == 'A' and round.recommendation == 'Z' then
    return 0;
  end
  if round.predict == 'B' and round.recommendation == 'X' then
    return 0;
  end
  if round.predict == 'B' and round.recommendation == 'Y' then
    return 3;
  end
  if round.predict == 'B' and round.recommendation == 'Z' then
    return 6;
  end
  if round.predict == 'C' and round.recommendation == 'X' then
    return 6;
  end
  if round.predict == 'C' and round.recommendation == 'Y' then
    return 0;
  end
  if round.predict == 'C' and round.recommendation == 'Z' then
    return 3;
  end
end

local function newWinPoints(round)
  if round.recommendation == 'X' then
    return 0;
  end
  if round.recommendation == 'Y' then
    return 3;
  end
  if round.recommendation == 'Z' then
    return 6;
  end
end

local function pointsForWin(round)
  if round.predict == 'A' then
    return 2;
  end
  if round.predict == 'B' then
    return 3;
  end
  if round.predict == 'C' then
    return 1;
  end
end

local function pointsForLose(round)
  if round.predict == 'A' then
    return 3;
  end
  if round.predict == 'B' then
    return 1;
  end
  if round.predict == 'C' then
    return 2;
  end
end

local function pointsForDraw(round)
  if round.predict == 'A' then
    return 1;
  end
  if round.predict == 'B' then
    return 2;
  end
  if round.predict == 'C' then
    return 3;
  end
end

local function scoreForRound(round)
  -- first problem
  -- local piecePoints = iterate('piece', round.recommendation, pieceValue, 'value');
  -- local winPoints = winPoints(round);
  -- return piecePoints + winPoints;


  local winPoints = newWinPoints(round);
  local piecePoints = 0;
  if winPoints == 6 then
    piecePoints = pointsForWin(round);
  end
  if winPoints == 3 then
    piecePoints = pointsForDraw(round);
  end
  if winPoints == 0 then
    piecePoints = pointsForLose(round);
  end
  return winPoints + piecePoints;
end

local result = 0;
for _, val in pairs(strategy) do
  result = result + scoreForRound(val);
end

print(result);

