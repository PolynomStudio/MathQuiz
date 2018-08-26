addon, ns = ...

ns.util = {}

-- Returns which function table to use according to the depth of the node
function ns.util.decide_table(d, function_wrapper_table_all_levels, function_wrapper_table_low_level)
  local table_to_use
  if d <= 1 then
    table_to_use = function_wrapper_table_low_level
  else
    table_to_use = function_wrapper_table_all_levels
  end
  return table_to_use
end

-- selects a random item from a table with indices from 1 to #table.
function ns.util.random_choice_from_table(table)
  choice = table[math.random(#table)]
  return choice
end


--[[ Tree Node Class
]]
ns.TreeNode = {}
ns.TreeNode.__index = ns.TreeNode

--[[ Constructor, takes two arguments
- fn: an instance of class FunctionWrapper
- parent: an instance of class Node that represents the parent node. By convention, the parent of the root is nil
- value: the node value if the node is a leaf
]]
function ns.TreeNode:create(fn, parent, value)
  local node = {}
  setmetatable(node, ns.TreeNode)
  node.operator = fn
  node.parent = parent
  node.value = value
  node.children = {}
  return node
end

-- returns the parent node
function ns.TreeNode:get_parent()
  return self.parent
end

-- Returns the children of that node
function ns.TreeNode:get_children()
  return self.children
end

-- method for recursive computation of the value at each node
function ns.TreeNode:compute_value()
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
function ns.TreeNode:generate_leaf_values()
  if self.value then -- the node is already a leaf, so we can just skip it
    return
  end
  if #self.children <= 0 then -- leaf node, so we can compute the values based on the generate_input function
    local x, y = self.operator.generate_input()
    local ch1 = ns.TreeNode:create(nil, self, x)
    self.children[#self.children + 1] = ch1
    if y then
      local ch2 = ns.TreeNode:create(nil, self, y)
      self.children[#self.children + 1] = ch2
    end
  else
    for i = 1, #self.children do
      self.children[i]:generate_leaf_values()
    end
  end
end

--[[ This method generates an exercise string from the computation tree. 
First attempt on minimal parantheses support, this needs to be tested thoroughly
]]
function ns.TreeNode:generate_exercise()
  if self.operator == nil then
    return tostring(self.value)
  elseif self.operator.is_binary then -- binary operator
    if self:needs_parantheses() then
      return "(" .. self.operator:to_string(self.children[1]:generate_exercise(), self.children[2]:generate_exercise()) .. ")"
    else -- no parantheses
      if self.parent then
      end
      return self.operator:to_string(self.children[1]:generate_exercise(), self.children[2]:generate_exercise())
    end
  else -- unary
    if self:needs_parantheses() then
      return "(" .. self.operator:to_string(self.children[1]:generate_exercise()) .. ")"
    else
      return self.operator:to_string(self.children[1]:generate_exercise())
    end
  end
end

-- Helper method to decide if parantheses are needed
function ns.TreeNode:needs_parantheses()
  if self.operator.is_binary then
    return (self.parent
            and ( self.operator.priority > self.parent.operator.priority
                or
                    (self.operator.priority == self.parent.operator.priority
                    and not self.parent.operator.is_associative
                    and self.parent.children[1] ~= self)
                )
            )
  else -- unary
    return (self.parent and (self.operator.priority > self.parent.operator.priority 
                        or self.operator.priority == self.parent.operator.priority and not self.parent.operator.is_associative
                          )
            )
  end
end

--[[ Tree Class
]]
ns.Tree = {}
ns.Tree.__index = ns.Tree

--[[ Constructor, builds a tree of max depth d.
The function wrapper table should contain all functions as FunctionWrapper instances to choose from
and should be indexed with consecutive integers starting from 1!
p is the proability of a node being a value instead of an operator
]]
function ns.Tree:create(d, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
  local tree = {}
  setmetatable(tree, ns.Tree)
  tree.depth = d
  tree.root = ns.TreeNode:create(ns.util.random_choice_from_table(function_wrapper_table_all_levels), nil, nil)
  tree.root:make_subtree(d-1, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
  tree.root:generate_leaf_values()
  return tree
end

-- A helper to generate the exercise corresponding to that tree
function ns.Tree:generate_exercise()
  return self.root:generate_exercise()
end

-- Helper method to compute the value of that tree's exercise.
function ns.Tree:compute_value()
  return self.root:compute_value()
end

-- Helper method to compute the number of operations in the tree
function ns.Tree:get_num_operations()
  return self.root:get_num_operations()
end

--[[ Build subtrees by recursive calls
This will add new children to the current node according to how many operands the corresponding operator
at the current node expects. Functions in the table "function_wrapper_table_low_level" will only be
used in the lowest level to avoid absurd numbers.
p is the probability of a new node being a value instead of an operator
]]
function ns.TreeNode:make_subtree(d, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
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
function ns.TreeNode:build_child(d, function_wrapper_table_all_levels, function_wrapper_table_low_level, p, is_left_child)
  local table_to_use = ns.util.decide_table(d, function_wrapper_table_all_levels, function_wrapper_table_low_level)
  local child, value
  if math.random() <= p then
    local a, b = self.operator.generate_input()
    if is_left_child then
      value = a
    else
      value = b or a -- if it is a right child, we should account for special cases in operator
      -- input generation, like zero divisions. For unary operators, b might be nil, so use b or a.
    end
    child = ns.TreeNode:create(nil, self, value)
  else
    child = ns.TreeNode:create(ns.util.random_choice_from_table(table_to_use), self, nil)
    child:make_subtree(d-1, function_wrapper_table_all_levels, function_wrapper_table_low_level, p)
  end
  return child
end

-- Method to get the number of operations that are contained within the subtree rooted at that node
function ns.TreeNode:get_num_operations()
  -- If a value is at this node, it does not contain any operations in its subtree
  if self.value ~= nil then
    return 0
  else -- Now, it must be an operation
    local num_operations = 1
    for i, child in pairs(self.children) do
      num_operations = num_operations + child:get_num_operations()
    end
    return num_operations
  end
end
