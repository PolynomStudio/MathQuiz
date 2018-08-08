--[[
This file defines the functions that are available by the system.
Each function has to be wrapped into a FunctionWrapper
]]

require("FunctionWrapper")

AvailableFunctions = {}

-- Helpers
function generate_random_inputs(min, max)
  return math.random(min, max), math.random(min, max)
end

-- Addition
function add(x, y)
  return x + y
end

function generate_addition_input()
  return generate_random_inputs(1, 10)
end

  --fn, is_binary, usable_on_all_levels, generate_input, name, alias_symbol)
local addition = FunctionWrapper:create(
  add, -- The function that represents the operation
  true, -- true if the function takes to operands, else false
  usable_on_all_levels, -- true if the function can safely be used on every node in the tree
  -- this is probably not the case for divsion, square root, etc due to domain restrictions
  generate_addition_input, -- a function that randomly generates input for the operator
  "add", -- a name for the function, e.g. sin, cos, sqrt, ...
  "+") -- an alias name. if the function can be represent with a symbol
  
AvailableFuntions.addition = addition

-- Subtraction
-- ...



return AvailableFunctions
  