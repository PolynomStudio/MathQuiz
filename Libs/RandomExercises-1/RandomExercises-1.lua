addon, ns = ...

local MAJOR, MINOR = "RandomExercises-1", 1
local lib = LibStub:NewLibrary(MAJOR, MINOR)

if not lib then return end

lib.generator = {}

--- Set the properties of exercises to generate.
-- @param max_depth The maximum depth the ComputationTree may have
-- @param pruning_factor The probability that a child of this node will be a numeric value despite not having reached max_depth
-- @param usable_on_all_levels A table of functions usable on all levels of the tree with keys being FunctionWrapper instances and values being true
-- @param usable_on_all_levels A table of functions usable on the first level of the tree with keys being FunctionWrapper instances and values being true
-- @return An ExerciseGenerator object that is capable of generating ComputationTree instances to create exercises
function lib:settings(max_depth, pruning_factor, usable_on_all_levels, usable_on_low_level)
	lib.generator = ns.ExerciseGenerator:create(max_depth, pruning_factor, usable_on_all_levels, usable_on_low_level)
end

--- Wrapper function to generate an exercise and return its string represenation along with the result.
-- @returns A triple: First output is the exercise as a string, second output is the result and third output is the number of operations in the tree indicated by operators
function lib:random_exercise()
	return lib.generator:random_exercise()
end

return lib
