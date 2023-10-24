local M = {}

function M.printTable(table)
    for _, value in pairs(table) do
        print(value)
    end
end

function M.max(table)
    local max = 0
    for _, value in pairs(table) do
        if max < value then
            max = value
        end
    end
    return max
end

return M
