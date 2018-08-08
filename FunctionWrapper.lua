--[[ Function wrapper to store functions in addition to some additional information about that function.
]]
FunctionWrapper = {}
FunctionWrapper.__index = FunctionWrapper

--[[ Constructor
- fn: a function pointer to the actual computation function for that node, e.g. to a function add(x, y)
- is_binary: if false, the correspondig operator takes exactly one argument (e.g. factorial), else it takes exactly two arguments (e.g. add)
- usable_on_all_levels: if true, the operator that has been passed can be used on all levels of the
- generate_input: a function that generates exactly two inputs for fn. If fn is unary (i.e. not binary), the second return value should be nil.
- name: the name of the operation, e.g. "add"
- alias_symbol: a symbol to replace the function name for display. For example, if a function with name "f" that takes two parameters x and y is
                given the symbol "s", then instead of "add(x, y)" the function will print "x s y". If the function is unary, it will be displayed
                as "xs".
]]
function FunctionWrapper:create(fn, is_binary, usable_on_all_levels, generate_input, name, alias_symbol)
  local f = {}
  setmetatable(f, FunctionWrapper
)
  f.fn = fn
  f.is_binary = is_binary
  f.usable_on_all_levels = usable_on_all_levels
  f.generate_input = generate_input
  f.name = name
  f.alias_symbol = alias_symbol
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