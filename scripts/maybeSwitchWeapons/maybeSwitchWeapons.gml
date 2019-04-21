/// maybeSwitchWeapons()


// must be called an an ai combatant
// combatant must be in Attack state 
// combatant must know attackData

// this is an object index
var wr = attackData.weaponRequired;

// search through all hand items for an instance of this object_index 
var ck = ds_map_find_first(handItems); 
for (var i = 0; i < ds_map_size(handItems); i++) {

	var hi = ds_map_find_value(handItems, ck); 
	if hi != noone && hi != undefined && hi > 0 && instance_exists(hi) {
		if hi.object_index == wr {
			ds_map_replace(equippedLimbItems, "l", hi);
		}
	}

	ck = ds_map_find_next(handItems, ck);
}