require("ComputationTree");
availableFunctions = require("AvailableFunctions");

ExerciseGenerator = {}
ExerciseGenerator.__index = ExerciseGenerator

--- Helper class to generate exercises.
-- @param max_depth The maximum depth the ComputationTree may have
-- @param pruning_factor The probability that a child of this node will be a numeric value despite not having reached max_depth
-- @param usable_on_all_levels A table of functions usable on all levels of the tree with keys being FunctionWrapper instances and values being true
-- @param usable_on_all_levels A table of functions usable on the first level of the tree with keys being FunctionWrapper instances and values being true
-- @return An ExerciseGenerator object that is capable of generating ComputationTree instances to create exercises
function ExerciseGenerator:create(max_depth, pruning_factor, usable_on_all_levels, usable_on_low_level)
  local gen = {}
  setmetatable(gen, ExerciseGenerator)
  gen.max_depth = max_depth
  gen.pruning_factor = pruning_factor
  gen.usable_on_all_levels = usable_on_all_levels or availableFunctions.usable_on_all_levels
  gen.usable_on_low_level = usable_on_low_level or availableFunctions.usable_on_low_level
  return gen
end

--- Wrapper function to generate an exercise and return its string represenation along with the result.
-- @returns A triple: First output is the exercise as a string, second output is the result and third output is the number of operations in the tree indicated by operators
function ExerciseGenerator:random_exercise()
  local tree = Tree:create(self.max_depth, self.usable_on_all_levels, self.usable_on_low_level, self.pruning_factor)
  return tree:generate_exercise(), tree:compute_value(), tree:get_num_operations()
end
