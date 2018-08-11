--[[ Function wrapper to store functions in addition to some additional information about that function.
]]
FunctionWrapper = {}
FunctionWrapper.__index = FunctionWrapper

--[[ Constructor
- fn: a function pointer to the actual computation function for that node, e.g. to a function add(x, y)
- is_binary: if false, the correspondig operator takes exactly one argument (e.g. factorial), else it takes exactly two arguments (e.g. add)
- usable_on_all_levels: if true, the operator that has been passed can be used on all levels of the
- generate_input: a function that generates exactly two inputs for fn. If fn is unary (i.e. not binary), the second return value should be nil.
- make_string: a function that converts the two inputs into an ouput string, e.g. for addition make_string(1, 2) returns "1 + 2".
- priority: the priority for calculations. only relativ order is important, e.g. multiplication should have a lower number than addition since
  multiplication takes precedence.
]]
function FunctionWrapper:create(name, fn, is_binary, usable_on_all_levels, generate_input, make_string, priority)
  local f = {}
  setmetatable(f, FunctionWrapper)
  f.name = name
  f.fn = fn
  f.is_binary = is_binary
  f.usable_on_all_levels = usable_on_all_levels
  f.generate_input = generate_input
  f.make_string = make_string
  f.priority = priority
  return f
end

-- method to actually compute the output of that function given 1 or 2 inputs 
function FunctionWrapper:compute(x, y)
  if self.is_binary then
    return self.fn(x, y)
  else
    return self.fn(x)
  end
end

-- Method to initiate input generation for that operator.
function FunctionWrapper:generate_input()
  return self.generate_input()
end

-- Method to make a string from output
function FunctionWrapper:to_string(x, y)
  return self.make_string(x, y)
end
