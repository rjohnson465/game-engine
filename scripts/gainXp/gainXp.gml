/// gainXp(amount) 
/// @param amount

global.player.xpTemp += argument[0];
global.xpAmount = argument[0];
instance_create_depth(x,y,1,obj_xp);