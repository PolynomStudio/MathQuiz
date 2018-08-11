
require("ComputationTree");
availableFunctions = require("AvailableFunctions");


math.randomseed(os.time())
--math.randomseed(22)


local tree = Tree:create(4, availableFunctions.usable_on_all_levels, availableFunctions.usable_on_low_level, .25)
  

print(tree.root:generate_exercise())
print(tree.root:compute_value())
