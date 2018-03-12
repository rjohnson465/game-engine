// update attackFrames values
if ds_map_size(attackingLimbs) != 0 {
var limb = ds_map_find_first(attackingLimbs);
for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
	var attackObj = noone;
	with obj_attack {
		if owner = other.id && limbKey == limb {
			attackObj = id;
		}
	}
	if attackObj != noone {
		ds_map_replace(attackFrames,limb,attackObj.image_index);
	}
	limb = ds_map_find_next(attackingLimbs, limb);
}
}