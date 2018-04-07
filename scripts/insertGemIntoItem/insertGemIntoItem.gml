/// insertGemIntoItem(gem,item)
/// @param gem
/// @param item

var gem = argument[0];
var item = argument[1];

if item.numberOfSockets == 0 || ds_list_size(item.socketedGems) >= item.numberOfSockets {
	alert(item.name + " does not have any free sockets",c_yellow);
	exit;
}

var gemElement = noone;
switch gem.subType {
	case GemTypes.Lapis: {
		gemElement = MAGIC; break;
	}
	case GemTypes.Hematite: { ////// fuck 
		gemElement = PHYSICAL; break;
	}
	case GemTypes.Aquamarine: {
		gemElement = ICE; break;
	}
	case GemTypes.Topaz: {
		gemElement = LIGHTNING; break;
	}
	case GemTypes.Emerald: {
		gemElement = POISON; break;
	}
	case GemTypes.Ruby: {
		gemElement = FIRE; break;
	}
}

switch item.type {
	case ItemTypes.HandItem: {
		// for weapons, gems increase damage
		if item.subType != HandItemTypes.Shield {
			ds_list_add(item.socketedGems,gem);
			
			var damageMin = 0; var damageMax = 0;
			switch gem.condition {
				case CRACKED: {
					damageMin = 2;
					damageMax = 4;
					break;
				}
			}
			if gem.subType != GemTypes.Hematite {
				var oldDamageArray = ds_map_find_value(item.damages,gemElement);
				var newDamageArray = [oldDamageArray[0]+damageMin,oldDamageArray[1]+damageMax];
				ds_map_replace(item.damages,gemElement,newDamageArray);
			}
			// hematite is an annoying special case
			else {
				var slashDamageArray = ds_map_find_value(item.damages,SLASH);
				var crushDamageArray = ds_map_find_value(item.damages,CRUSH);
				var pierceDamageArray = ds_map_find_value(item.damages,PIERCE);
				var physicalDamagesLength = array_length_1d(slashDamageArray);
				for (var i = 0; i < physicalDamagesLength; i += 2) {
					if array_length_1d(slashDamageArray) >= i && slashDamageArray[i] != 0 {
						slashDamageArray[i] += damageMin;
						slashDamageArray[i+1] += damageMax;
					} else if array_length_1d(crushDamageArray) >= i && crushDamageArray[i] != 0 {
						crushDamageArray[i] += damageMin;
						crushDamageArray[i+1] += damageMax;
					} else if array_length_1d(pierceDamageArray) >= i && pierceDamageArray[i] != 0 {
						pierceDamageArray[i] += damageMin;
						pierceDamageArray[i+1] += damageMax;
					}
				}
				ds_map_replace(item.damages,SLASH,slashDamageArray);
				ds_map_replace(item.damages,CRUSH,crushDamageArray);
				ds_map_replace(item.damages,PIERCE,pierceDamageArray);
			}
			updateItemName(item);
			break;
		}
		break;
	}
}