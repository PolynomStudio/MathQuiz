--[[ TODO
	  * Namespace usage for this module
      * Random generation of input values
      * Basic functions including all information for wrapper construction
      * Conversion of tree to human-readable exercise string
]]

--[[ Function wrapper to store functions in addition to some additional information about that function.
]]
Function = {}
Function.__index = Function

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
function Function:create(fn, is_binary, usable_on_all_levels, generate_input, name, alias_symbol)
  local f = {}
  setmetatable(f, Function)
  f.fn = fn
  f.is_binary = is_binary
  f.usable_on_all_levels = usable_on_all_levels
  f.generate_input = generate_input
  f.name = name
  return f
end

-- method to actually compute the output of that function given 1 or 2 inputs 
function Function:compute(x, y)
  if self.is_binary then
    return self.fn(x, y)
  else
    return self.fn(x)
  end
end

-- Method to initiate input generation for that operator.
function Function:generate_input()
  return self.generate_input()
end

--[[ Tree Node Class
]]
Node = {}
Node.__index = Node

--[[ Constructor, takes two arguments
- fn: an instance of class Function
- parent: an instance of class Node that represents the parent node. By convention, the parent of the root is nil
- value: the node value if the node is a leaf
]]
function Node:create(fn, parent, value)
  local node = {}
  setmetatable(node, Node)
  node.operator = fn
  node.parent = parent
  node.value = value
  node.children = {}
  return node
end

-- returns the parent node
function Node:get_parent()
  return self.parent
end

-- Returns the children of that node
function Node:get_children()
  return self.children
end

-- method for recursive computation of the value at each node
function Node:compute_value()
  local x, y = nil
  if #self.children <= 0 then -- leaf node, so we can just return the value of that leaf
  --  x, y = self.operator.generate_input()
    return self.value
  elseif #self.children == 1 then -- not a leaf, so we must go down recursively and compute the value at each node below
    x = self.children[1]:compute_value()
  else -- two children nodes
    x = self.children[1]:compute_value()
    y = self.children[2]:compute_value()
  end
  return self.operator:compute(x, y)
end

-- method to generate values at leaves which are the basic input for the computation tree
-- this method absolutely _has_ to be called before the computation can start.
function Node:generate_leaf_values()
  if #self.children <= 0 then -- leaf node, so we can compute the values based on the generate_input function
    local x, y = self.operator.generate_input()
    local ch1 = Node:create(nil, self, x)
    self.children[#self.children + 1] = ch1
    if y then
      local ch2 = Node:create(nil, self, y)
      self.children[#self.children + 1] = ch2
    end
  else
    for i = 1, #self.children do
      self.children[i]:generate_leaf_values()
    end
  end
end
