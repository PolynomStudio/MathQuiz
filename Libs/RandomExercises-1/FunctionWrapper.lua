--[[ Function wrapper to store functions in addition to some additional information about that function.
]]

addon, ns = ...

ns.FunctionWrapper = {}
ns.FunctionWrapper.__index = ns.FunctionWrapper

--- Constructor for a wrapper class that stores useful properties along with a function.
-- @param name The name of the operator or function, e.g. "Addition"
-- @param fn A reference to the function to be stored
-- @param is_binary A boolean value to indicate if the functions takes two arguments (true) or one argument (false)
-- @param usable_on_all_levels A boolean to indicate if the function is usable on all levels of the computation tree. This should be false if the function requires special input like perfect squares.
-- @param generate_input A reference to a function that generates input for this operator
-- @param make_string A reference to a function that makes a string out of the operator and its input(s), e.g. make_string(1, 2) returns "1 + 2"
-- @param priority Operator precedence. A lower number means higher precedence. Only relative order is important.
-- @param is_associative A boolean to indicate whether the function is associative like e.g. addition or not like e.g. subtraction
-- @return A FunctionWrapper instance with some utility related to functions and its properties
function ns.FunctionWrapper:create(name, fn, is_binary, usable_on_all_levels, generate_input, make_string, priority, is_associative)
  local f = {}
  setmetatable(f, ns.FunctionWrapper)
  f.name = name
  f.fn = fn
  f.is_binary = is_binary
  f.usable_on_all_levels = usable_on_all_levels
  f.generate_input = generate_input
  f.make_string = make_string
  f.priority = priority
  f.is_associative = is_associative
  return f
end

--- A method to compute the output of the function given inputs.
-- @param x The first input parameter
-- @param y The second input parameter (may be omitted for unary operators)
-- @return The return value of the stored function for inputs x and y
function ns.FunctionWrapper:compute(x, y)
  if self.is_binary then
    return self.fn(x, y)
  else
    return self.fn(x)
  end
end

--- A method to generate inputs for the specified parameter.
-- @return The generated inputs for the stored operator
function ns.FunctionWrapper:generate_input()
  return self.generate_input()
end

--- A method to make a string out of the operator and the operand(s)
-- @return The string representation of the computation
function ns.FunctionWrapper:to_string(x, y)
  return self.make_string(x, y)
end
