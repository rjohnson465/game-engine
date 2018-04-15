/// updateWeaponName(item)
/// @param item
/// update item name based on its gems

var item = argument[0];

// iterate over gems 
var gemTypesSeen = ds_list_create(); // stores up to three different gem types
for (var i = 0; i < ds_list_size(item.socketedGems); i++) {
	var gem = ds_list_find_value(item.socketedGems,i);
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
				newName = "Enchanted " + item.baseName;
				break;
			}
			case GemTypes.Aquamarine: {
				newName = "Frozen " + item.baseName;
				break;
			}
			case GemTypes.Topaz: {
				newName = "Electrified " + item.baseName;
				break;
			}
			case GemTypes.Ruby: {
				newName = "Burning " + item.baseName;
				break;
			}
			case GemTypes.Emerald: {
				newName = "Poisoned " + item.baseName;
				break;
			}
			case GemTypes.Hematite: {
				newName = "Sharp " + item.baseName;
				break;
			}
		}
	}
	case 2: {
		var gemType1 = ds_list_find_value(gemTypesSeen,0);
		var gemType2 = ds_list_find_value(gemTypesSeen,1);
		var gemTypes = [gemType1,gemType2];
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Emerald]) {
			newName = "Venemous " + item.baseName; break;
		} 
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Aquamarine]) {
			newName = "Hellish " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Lapis]) {
			newName = "Pyromancing " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Topaz]) {
			newName = "Sparking " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Hematite]) {
			newName = "Tempered " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Aquamarine]) {
			newName = "Frostbitten " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Lapis]) {
			newName = "Intoxicating " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Topaz]) {
			newName = "Caffeinated " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Hematite]) {
			newName = "Assassin's " + item.baseName; break;
		}
		
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Lapis]) {
			newName = "Santa's " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Topaz]) {
			newName = "Hailstorm " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Hematite]) {
			newName = "Icicle " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Topaz]) {
			newName = "Charged " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Hematite]) {
			newName = "Alchemical " + item.baseName; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Topaz,GemTypes.Hematite]) {
			newName = "Lightning " + item.baseName; break;
		}

	}
	case 3: {
		var gemType1 = ds_list_find_value(gemTypesSeen,0);
		var gemType2 = ds_list_find_value(gemTypesSeen,1);
		var gemType3 = ds_list_find_value(gemTypesSeen,2);
		var gemTypes = [gemType1,gemType2,gemType3];
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Aquamarine,GemTypes.Hematite]) {
			newName = "Unrequited " + item.baseName; break;
		}
	}
}

item.name = newName;
with obj_hand_item_parent {
	if copyOf != noone && copyOf == item {
		name = newName;
	}
}

ds_list_destroy(gemTypesSeen);