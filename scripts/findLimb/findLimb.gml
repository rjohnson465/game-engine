/// findLimb(ownerId,limbKey)
/// @param ownerId
/// @param limbKey

var oId = argument0;
var lk = argument1;

with obj_limb {
	if owner == oId && lk == limbKey {
		return id;
	}
}
return noone;