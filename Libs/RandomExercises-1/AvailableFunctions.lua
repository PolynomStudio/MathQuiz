--[[
This file defines the functions that are available by the system.
Each function has to be wrapped into a FunctionWrapper
]]

addon, ns = ...

ns.AvailableFunctions = {}
ns.AvailableFunctions.usable_on_all_levels = {}
ns.AvailableFunctions.usable_on_low_level = {}

-- Helpers
local function add_to_usability_table(fn, is_usable_on_all_levels)
  ns.AvailableFunctions.usable_on_low_level[#ns.AvailableFunctions.usable_on_low_level + 1] =  fn
  if is_usable_on_all_levels then
    ns.AvailableFunctions.usable_on_all_levels[#ns.AvailableFunctions.usable_on_all_levels + 1] =  fn
  end
end

local function generate_random_inputs(min, max)
  return math.random(min, max), math.random(min, max)
end

local function input1_symbol_input2(input1, symbol, input2)
  return tostring(input1) .. " " .. symbol .. " " .. tostring(input2)
end

-- Addition
local function add(x, y)
  return x + y
end

local function generate_addition_input()
  return generate_random_inputs(1, 10)
end

local function make_string_addition(x, y)
  return input1_symbol_input2(x, "+", y)
end

  --fn, is_binary, usable_on_all_levels, generate_input, name, alias_symbol)
local addition = ns.FunctionWrapper:create(
  "Addition", -- The operator name
  add, -- The function that represents the operation
  true, -- true if the function takes two operands, else false
  true, -- true if the function can safely be used on every node in the tree
  -- this is probably not the case for divsion, square root, etc due to domain restrictions
  generate_addition_input, -- a function that randomly generates input for the operator
  make_string_addition, -- the function that makes string representations of that operation
  4, -- the priority (higher is less priority)
  true) -- addition is associative
  
add_to_usability_table(addition, true)

-- Subtraction
local function subtract(x, y)
  return x - y
end

local function generate_subtraction_input()
  return generate_random_inputs(1, 10)
end

local function make_string_subtraction(x, y)
  return input1_symbol_input2(x, "-", y)
end

local subtraction = ns.FunctionWrapper:create("Subtraction", subtract, true, true, generate_subtraction_input, make_string_subtraction, 4, false)

add_to_usability_table(subtraction, true)

-- Multiplication
local function multiply(x, y)
  return x * y
end

local function generate_multiplication_input()
  return generate_random_inputs(1, 10)
end

function make_string_multiplication(x, y)
  return input1_symbol_input2(x, "*", y)
end

local multiplication = ns.FunctionWrapper:create("Multiplication", multiply, true, true, generate_multiplication_input, make_string_multiplication, 3, true)

add_to_usability_table(multiplication, true)

-- Division
local function divide(x, y)
  return x / y
end

local function generate_division_input()
  result = math.random(1, 10)
  tmp = math.random(1, 10)
  return result * tmp, tmp
end

local function make_string_division(x, y)
  return input1_symbol_input2(x, "/", y)
end

local division = ns.FunctionWrapper:create("Division", divide, true, false, generate_division_input, make_string_division, 3, false)

add_to_usability_table(division, false)


-- Gamma / Factorial
local function gamma(n)
  assert(math.floor(n) == n and n >= 0)
  if n <= 1 then
    return 1
  else
    return n * gamma(n - 1)
  end
end

local function generate_gamma_input()
  return math.random(0, 5)
end

local function make_string_gamma(n)
  return tostring(n) .. "!"
end

local _gamma = ns.FunctionWrapper:create("Gamma", gamma, false, false, generate_gamma_input, make_string_gamma, 2, nil)

add_to_usability_table(_gamma, false)

-- integer-Based Exponential / Power
local function power2(x)
  return x * x
end

local function generate_power2_input()
  return math.random(1, 10)
end

local function make_string_power2(x)
  return tostring(x) .. "^2"
end

local _power2 = ns.FunctionWrapper:create("Power2", power2, false, true, generate_power2_input, make_string_power2, 2, false)

add_to_usability_table(_power2, true)
