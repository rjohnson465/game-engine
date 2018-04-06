/// makeSkillObj(skillObj,x,y)
/// @param skillObj
/// @param x
/// @param y

var skillObj = argument[0];
global.x1 = argument[1];
global.y1 = argument[2];


return instance_create_depth(global.x1,global.y1,1,skillObj);