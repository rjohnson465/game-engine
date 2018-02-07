/// makeItemSlot(slot,x,y)
/// @param slot
/// @param x
/// @param y

global.equipmentSlot = argument[0];
global.x1 = argument[1];
global.y1 = argument[2];
instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);