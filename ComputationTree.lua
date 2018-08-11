--[[ Tree Node Class
]]
Node = {}
Node.__index = Node

--[[ Constructor, takes two arguments
- fn: an instance of class FunctionWrapper
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
  --if #self.children <= 0 then -- leaf node, so we can just return the value of that leaf
  if self.value then
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

--[[ This method generates an exercise string from the computation tree. 
Currently, no support for minimal parantheses output! ToDo: Add minimal parantheses support.
]]
function Node:generate_exercise()
  if self.operator == nil then
    return tostring(self.value)
  elseif self.operator.is_binary then -- binary operator
    return "(" .. self.operator:to_string(self.children[1]:generate_exercise(), self.children[2]:generate_exercise()) .. ")"
  else -- unary
    return "(" .. self.operator:to_string(self.children[1]:generate_exercise()) .. ")"
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
    self.children[#self.children + 1] = self:build_child(d, function_wrapper_table_all_levels, function_wrapper_table_low_level, p, false)
    if self.operator.is_binary then -- create a second child
      self.children[#self.children + 1] = self:build_child(d, function_wrapper_table_all_levels, function_wrapper_table_low_level, p, false)
    end
    return
  end
end

-- Builds a new child for the given node
function Node:build_child(d, function_wrapper_table_all_levels, function_wrapper_table_low_level, p, is_left_child)
  local table_to_use = decide_table(d, function_wrapper_table_all_levels, function_wrapper_table_low_level)
  local child, value
  if math.random() <= p then
    local a, b = self.operator.generate_input()
    if is_left_child then
      value = a
    else
      value = b
    end
    child = Node:create(nil, self, value)
  else
    child = Node:create(random_choice_from_table(table_to_use), self, nil)
    child:make_subtree(d-1, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
  end
  return child
end

-- Returns which function table to use according to the depth of the node
function decide_table(d, function_wrapper_table_all_levels, function_wrapper_table_low_level)
  local table_to_use
  if d <= 1 then
    table_to_use = function_wrapper_table_low_level
  else
    table_to_use = function_wrapper_table_all_levels
  end
  return table_to_use
end

-- selects a random item from a table with indices from 1 to #table.
function random_choice_from_table(table)
  return table[math.random(#table)]
end
