/// makeLimb(ownerId,limbKey)
/// @param ownerId
/// @param limbKey

var ownerId = argument0;
var limbKey = argument1;

global.owner = ownerId;
global.limbKey = limbKey;
global.isPersistent = false;
if ownerId.type == CombatantTypes.Player {
	global.isPersistent = true;
}
instance_create_depth(x,y,1,obj_limb);