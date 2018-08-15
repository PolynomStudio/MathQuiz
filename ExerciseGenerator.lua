require("ComputationTree");
availableFunctions = require("AvailableFunctions");

ExerciseGenerator = {}
ExerciseGenerator.__index = ExerciseGenerator

-- Helper class to generate exercises
function ExerciseGenerator:create(max_depth, pruning_factor, usable_on_all_levels, usable_on_low_level)
  local gen = {}
  setmetatable(gen, ExerciseGenerator)
  gen.max_depth = max_depth
  gen.pruning_factor = pruning_factor
  gen.usable_on_all_levels = usable_on_all_levels or availableFunctions.usable_on_all_levels
  gen.usable_on_low_level = usable_on_low_level or availableFunctions.usable_on_low_level
  return gen
end

-- Wrapper function to generate an exercise and return its string represenation along with the result.
function ExerciseGenerator:random_exercise()
  local tree = Tree:create(self.max_depth, self.usable_on_all_levels, self.usable_on_low_level, self.pruning_factor)
  return tree:generate_exercise(), tree:compute_value()
end
