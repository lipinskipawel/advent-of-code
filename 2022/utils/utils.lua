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

function M.contains(array, element)
    for _, v in ipairs(array) do
        if v == element then
            return true
        end
    end
    return false
end

return M
