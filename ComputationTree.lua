--[[ TODO
      * Random generation of input values
      * Basic functions including all information for wrapper construction
]]


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
  if self.value then -- the node is already a leaf, so we can just skip it
    return
  end
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

--[[ ToDo: This _should_ be refactored to make use of a StringBuilder-like functionality.
As of now, it is extremely slow.
]]
function Node:generate_exercise()
  if self.operator == nil then
    return tostring(self.value)
  elseif self.operator.is_binary then -- binary operator
    local alias = self.operator.alias_symbol
    local func_name = self.operator.name or "unnamed"
    if alias then
      return "(" .. self.children[1]:generate_exercise() .. " " .. alias .. " " .. self.children[2]:generate_exercise() .. ")"
    else -- use function name instead
      return func_name .. "(" .. self.children[1]:generate_exercise() .. ", " .. self.children[2]:generate_exercise() .. ")"
    end
  else -- unary
    local alias = self.operator.alias_symbol
    local func_name = self.operator.name or "unnamed"
    if alias then
      return self.children[1]:generate_exercise() .. alias
    else
      return func_name .. "(" .. self.children[1]:generate_exercise() .. ")"
    end
  end
end

--[[ Tree Class
]]
Tree = {}
Tree.__index = Tree

--[[ Constructor, builds a tree of max depth d.
The function wrapper table should contain all functions as FunctionWrapper instances to choose from
and should be indexed with consecutive integers starting from 1!
p is the proability of a node being a value instead of an operator
]]
function Tree:create(d, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
  local tree = {}
  setmetatable(tree, Tree)
  tree.depth = d
  tree.root = Node:create(random_choice_from_table(function_wrapper_table_all_levels), nil, nil)
  tree.root:make_subtree(d-1, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
  tree.root:generate_leaf_values()
  return tree
end

--[[ Build subtrees by recursive calls
This will add new children to the current node according to how many operands the corresponding operator
at the current node expects. Functions in the table "function_wrapper_table_low_level" will only be
used in the lowest level to avoid absurd numbers.
p is the probability of a new node being a value instead of an operator
ToDo: Implement some helper functions, this monstrosity should be killed before it lays eggs ...
]]
function Node:make_subtree(d, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
  if d <= 0 then
    return
  else
    local table_to_use = {}
    if d <= 1 then
      table_to_use = function_wrapper_table_low_level
    else
      table_to_use = function_wrapper_table_all_levels
    end
    local left_child
    if math.random() <= p then
      value, _ = self.operator.generate_input()
      left_child = Node:create(nil, self, value)
    else
      left_child = Node:create(random_choice_from_table(table_to_use), self, nil)
      left_child:make_subtree(d-1, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
    end
    self.children[#self.children + 1] = left_child
    if self.operator.is_binary then -- create a second child
      local right_child
      if math.random() <= p then
        _, value = self.operator.generate_input()
        right_child = Node:create(nil, self, value)
      else
        right_child = Node:create(random_choice_from_table(table_to_use), self, nil)
        right_child:make_subtree(d-1, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
      end
      self.children[#self.children + 1] = right_child
    end
    return
  end
end

--[[
Prunes the tree by replacing a subtree with its computed value
Useful to avoid extremely long exercises
]]
function Node:prune()
end

-- selects a random item from a table with indices from 1 to #table.
function random_choice_from_table(table)
  return table[math.random(#table)]
end
