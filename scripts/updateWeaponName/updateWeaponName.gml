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

switch ds_list_size(gemTypesSeen) {
	case 0: {
		break;
	}
	case 1: {
		var gemType = ds_list_find_value(gemTypesSeen,0);
		switch gemType {
			case GemTypes.Lapis: {
				weapon.name = "Enchanted " + weapon.baseName;
				break;
			}
			case GemTypes.Aquamarine: {
				weapon.name = "Frozen " + weapon.baseName;
				break;
			}
			case GemTypes.Topaz: {
				weapon.name = "Electrified " + weapon.baseName;
				break;
			}
			case GemTypes.Ruby: {
				weapon.name = "Burning " + weapon.baseName;
				break;
			}
			case GemTypes.Emerald: {
				weapon.name = "Poisoned " + weapon.baseName;
				break;
			}
			case GemTypes.Hematite: {
				weapon.name = "Sharp " + weapon.baseName;
				break;
			}
		}
	}
	case 2: {
		var gemType1 = ds_list_find_value(gemTypesSeen,0);
		var gemType2 = ds_list_find_value(gemTypesSeen,1);
		var gemTypes = [gemType1,gemType2];
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Aquamarine]) {
			weapon.name = "Santa's " + weapon.baseName; break;
		}
	}
	case 3: {
		var gemType1 = ds_list_find_value(gemTypesSeen,0);
		var gemType2 = ds_list_find_value(gemTypesSeen,1);
		var gemType3 = ds_list_find_value(gemTypesSeen,2);
		var gemTypes = [gemType1,gemType2,gemType3];
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Aquamarine,GemTypes.Hematite]) {
			weapon.name = "Unrequited " + weapon.baseName; break;
		}
	}
}

ds_list_destroy(gemTypesSeen);