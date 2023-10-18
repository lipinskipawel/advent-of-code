local M = {};


function M.pop(stack)
  return table.remove(stack, #stack);
end

function M.push(element, stack)
  table.insert(stack, #stack + 1, element);
end

function M.pop_sub_stack(stack, number)
  local sub_stack = {};
  local to_pop_index = #stack - number + 1;
  for i = 1, number, 1 do
    local poped = table.remove(stack, to_pop_index);
    M.push(poped, sub_stack);
  end
  return sub_stack;
end

function M.push_sub_stack(sub_stack, stack)
  for i, val in pairs(sub_stack) do
    M.push(val, stack);
  end
end

function M.peek(stack)
  return stack[#stack];
end

function M.printStack(stack)
  for i, el in pairs(stack) do
    print(el);
  end
end

return M;
