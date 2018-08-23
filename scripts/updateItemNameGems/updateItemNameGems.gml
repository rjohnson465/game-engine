/// updateWeaponName(item)
/// @param item
/// update item name based on its gems

var item = argument[0];

// iterate over gems 
var gemTypesSeen = ds_list_create(); // stores up to three different gem types
for (var i = 0; i < ds_list_size(item.socketedGems); i++) {
	var gem = ds_list_find_value(item.socketedGems,i);
	if instance_exists(gem) {
		if ds_list_find_index(gemTypesSeen,gem.subType) == -1 {
			ds_list_add(gemTypesSeen,gem.subType);
		}
	}
}

var newName = "";
switch ds_list_size(gemTypesSeen) {
	case 0: {
		newName = item.baseNameModified;
		break;
	}
	case 1: {
		var gemType = ds_list_find_value(gemTypesSeen,0);
		switch gemType {
			case GemTypes.Lapis: {
				newName = "Enchanted " + item.baseNameModified;
				break;
			}
			case GemTypes.Aquamarine: {
				newName = "Frozen " + item.baseNameModified;
				break;
			}
			case GemTypes.Amethyst: {
				newName = "Electrified " + item.baseNameModified;
				break;
			}
			case GemTypes.Ruby: {
				newName = "Burning " + item.baseNameModified;
				break;
			}
			case GemTypes.Emerald: {
				newName = "Poisoned " + item.baseNameModified;
				break;
			}
			case GemTypes.Hematite: {
				newName = "Sharp " + item.baseNameModified;
				break;
			}
		}
	}
	case 2: {
		var gemType1 = ds_list_find_value(gemTypesSeen,0);
		var gemType2 = ds_list_find_value(gemTypesSeen,1);
		var gemTypes = [gemType1,gemType2];
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Emerald]) {
			newName = "Venemous " + item.baseNameModified; break;
		} 
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Aquamarine]) {
			newName = "Hellish " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Lapis]) {
			newName = "Pyromancing " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Amethyst]) {
			newName = "Sparking " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Hematite]) {
			newName = "Tempered " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Aquamarine]) {
			newName = "Frostbitten " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Lapis]) {
			newName = "Intoxicating " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Amethyst]) {
			newName = "Caffeinated " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Hematite]) {
			newName = "Assassin's " + item.baseNameModified; break;
		}
		
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Lapis]) {
			newName = "Santa's " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Amethyst]) {
			newName = "Hailstorm " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Hematite]) {
			newName = "Icicle " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Amethyst]) {
			newName = "Charged " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Hematite]) {
			newName = "Alchemical " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Amethyst,GemTypes.Hematite]) {
			newName = "Lightning " + item.baseNameModified; break;
		}

	}
	case 3: {
		var gemType1 = ds_list_find_value(gemTypesSeen,0);
		var gemType2 = ds_list_find_value(gemTypesSeen,1);
		var gemType3 = ds_list_find_value(gemTypesSeen,2);
		var gemTypes = [gemType1,gemType2,gemType3];
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Emerald,GemTypes.Aquamarine]) {
			newName = "Apocalyptic " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Emerald,GemTypes.Lapis]) {
			newName = "Alcoholic " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Emerald,GemTypes.Amethyst]) {
			newName = "Nuclear " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Emerald,GemTypes.Hematite]) {
			newName = "Serpentine " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Aquamarine,GemTypes.Lapis]) {
			newName = "Satanic " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Aquamarine,GemTypes.Amethyst]) {
			newName = "Torturous " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Aquamarine,GemTypes.Hematite]) {
			newName = "Culinary " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Lapis,GemTypes.Amethyst]) {
			newName = "Cauterizing " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Lapis,GemTypes.Hematite]) {
			newName = "Draconic " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Ruby,GemTypes.Amethyst,GemTypes.Hematite]) {
			newName = "Jupiter's " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Aquamarine,GemTypes.Lapis]) {
			newName = "Petrifying " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Aquamarine,GemTypes.Amethyst]) {
			newName = "Paralyzing " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Aquamarine,GemTypes.Hematite]) {
			newName = "Murderous " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Lapis,GemTypes.Amethyst]) {
			newName = "Fuming " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Lapis,GemTypes.Hematite]) {
			newName = "Infectious " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Emerald,GemTypes.Amethyst,GemTypes.Hematite]) {
			newName = "Ionizing " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Lapis,GemTypes.Amethyst]) {
			newName = "Refrigerating " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Lapis,GemTypes.Hematite]) {
			newName = "Unrequited " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Aquamarine,GemTypes.Amethyst,GemTypes.Hematite]) {
			newName = "Exacerbating " + item.baseNameModified; break;
		}
		
		if arrayIncludesMultiple(gemTypes,[GemTypes.Lapis,GemTypes.Amethyst,GemTypes.Hematite]) {
			newName = "Electrocuting " + item.baseNameModified; break;
		}
	}
}

item.name = newName;
item.gemmedName = newName;

ds_list_destroy(gemTypesSeen); gemTypesSeen = -1;