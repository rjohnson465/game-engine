/// makeEnvironmentParticles(part1,part2,layerName, num1, num2, initNum1*, initNum2*)
/// @param part1
/// @param part2
/// @param layerName
/// @param num1
/// @param num2
/// @param initNum1* How manu particles to burst before resorting to step event
/// @param initNum2*


global.enviroPart1 = argument[0];
global.enviroPart2 = argument[1];
var layerName = argument[2];
var layerDepth = layer_get_depth(layerName);
global.enviroPartLayer = layer_get_id(layerName);
global.enviroPartDepth = layerDepth;
global.enviroPartNum1 = argument[3];
global.enviroPartNum2 = argument[4];

var initNum1 = 50;
var initNum2 = 50;
if argument_count > 5 {
	initNum1 = argument[5];
}
if argument_count > 6 {
	initNum2 = argument[6];
}

global.enviroPartInitNum1 = initNum1;
global.enviroPartInitNum2 = initNum2;

instance_create_depth(x,y,depth,obj_environment_particles);