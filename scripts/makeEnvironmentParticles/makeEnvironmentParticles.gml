/// makeEnvironmentParticles(part1,part2,layerName, num1, num2)
/// @param part1
/// @param part2
/// @param layerName
/// @param num1
/// @param num2

global.enviroPart1 = argument[0];
global.enviroPart2 = argument[1];
var layerName = argument[2];
var layerDepth = layer_get_depth(layerName);
global.enviroPartDepth = layerDepth;
global.enviroPartNum1 = argument[3];
global.enviroPartNum2 = argument[4];
instance_create_depth(x,y,depth,obj_environment_particles);