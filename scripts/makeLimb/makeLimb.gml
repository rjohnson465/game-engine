/// makeLimb(ownerId,limbKey,*isLimbLimited)
/// @param ownerId
/// @param limbKey
/// @param *isLimbLimited

var ownerId = argument[0];
var limbKey = argument[1];
var isLimbLimited = false;
if argument_count > 2 {
	isLimbLimited = argument[2];
}

global.owner = ownerId;
global.limbKey = limbKey;
global.isPersistent = false;
global.isLimbLimited = isLimbLimited;
if ownerId.type == CombatantTypes.Player {
	global.isPersistent = true;
}
instance_create_depth(x,y,1,obj_limb);