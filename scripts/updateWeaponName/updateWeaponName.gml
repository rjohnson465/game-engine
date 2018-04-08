/// updateWeaponName(weapon)
/// @param weapon
/// update weapon name based on its gems

var weapon = argument[0];

// iterate over gems 
var gemTypesSeen = ds_list_create(); // stores up to three different gem types
for (var i = 0; i < ds_list_size(weapon.socketedGems); i++) {
	var gem = ds_list_find_value(weapon.socketedGems,i);
	if ds_list_find_index(gemTypesSeen,gem.subType) == -1 {
		ds_list_add(gemTypesSeen,gem.subType);
	}
}

var newName = "";
switch ds_list_size(gemTypesSeen) {
	case 0: {
		break;
	}
	case 1: {
		var gemType = ds_list_find_value(gemTypesSeen,0);
		switch gemType {
			case GemTypes.Lapis: {
				newName = "Enchanted " + weapon.baseName;
				break;
			}
			case GemTypes.Aquamarine: {
				newName = "Frozen " + weapon.baseName;
				break;
			}
			case GemTypes.Topaz: {
				newName = "Electrified " + weapon.baseName;
				break;
			}
			case GemTypes.Ruby: {
				newName = "Burning " + weapon.baseName;
				break;
			}
			case GemTypes.Emerald: {
				newName = "Poisoned " + weapon.baseName;
				break;
			}
			case GemTypes.Hematite: {
				newName = "Sharp " + weapon.baseName;
				break;
			}
		}
	}
	case 2: {
		var gemType1 = ds_list_find_value(gemTypesSeen,0);
		var gemType2 = ds_list_find_value(gemTypesSeen,1);
		var gemTypes = [gemType1,gemType2];
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Aquamarine]) {
			newName = "Santa's " + weapon.baseName; break;
		}

	}
	case 3: {
		var gemType1 = ds_list_find_value(gemTypesSeen,0);
		var gemType2 = ds_list_find_value(gemTypesSeen,1);
		var gemType3 = ds_list_find_value(gemTypesSeen,2);
		var gemTypes = [gemType1,gemType2,gemType3];
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Aquamarine,GemTypes.Hematite]) {
			newName = "Unrequited " + weapon.baseName; break;
		}
	}
}

weapon.name = newName;
/*with obj_hand_item_parent {
	if copyOf != noone && copyOf == weapon {
		name = newName;
	}
}*/

ds_list_destroy(gemTypesSeen);