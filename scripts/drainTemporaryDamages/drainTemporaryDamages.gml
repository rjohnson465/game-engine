/// drainTemporaryDamages(weapon)
/// @param weapon

/// drains temporary damage boosts, removes all empty entries

var weapon = argument[0];

var td = weapon.temporaryDamages;

if !ds_exists(td, ds_type_list) exit;
if ds_list_size(td) == 0 exit;

for (var i = 0; i < ds_list_size(td); i++) {
	var entry = ds_list_find_value(td, i);
	if !is_array(entry) continue;
	var damageType = entry[0];
	var framesLeft = entry[1];
	var damageAmount = entry[2]; // array, [lower bound, upper bound]
	var newFramesLeft = framesLeft - 1;
	var newEntry = [damageType, newFramesLeft, damageAmount];
	ds_list_replace(td, i, newEntry);
	
}

// remove any dead defense boosts 
for (var i = 0; i < ds_list_size(td); i++) {
	var entry = ds_list_find_value(td, i);
	var damageType = entry[0];
	var framesLeft = entry[1];
	
	// delete this damage bonus from weapon when it expires
	if framesLeft <= 0 {
		var damageAmount = entry[2];
		var dal = damageAmount[0]; var dau = damageAmount[1];
		
		// adjust the weapon damages map accordingly
		var currentDamage = ds_map_find_value(weapon.damages, damageType);
		var cdl = currentDamage[0]; var cdu = currentDamage[1];
		var newDamageEntry = [cdl - dal, cdu - dau];
		ds_map_replace(weapon.damages, damageType, newDamageEntry);
		with obj_weapon {
			if limbItem == weapon {
				refreshParticles = true;
			}
		}
		
		// remove this temporary damage entry from temporaryDamages list
		ds_list_delete(td, i);
	}
}


