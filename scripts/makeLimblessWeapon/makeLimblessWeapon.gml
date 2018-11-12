/// makeLimb(ownerId,limbKey)
/// @param ownerId
/// @param limbKey

var ownerId = argument0;
var limbKey = argument1;

global.owner = ownerId;
global.limbKey = limbKey;
instance_create_depth(x,y,1,obj_weapon_limbless);