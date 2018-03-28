/// makeGem(gem,condition)
/// @param gem
/// @param condition enum value

var gem = argument[0];
var condition = argument[1];

global.gemCondition = condition;
return instance_create_depth(x,y,1,gem);