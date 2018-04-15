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
		// Case: Shields
		else {
			ds_list_add(item.socketedGems,gem);
			
			var absorptionBoost = 0;
			switch gem.condition {
				case CRACKED: {
					absorptionBoost = 5;
					break;
				}
			}
			var oldAbs = ds_map_find_value(item.defenses,gemElement);
			var newAbs = oldAbs + absorptionBoost;
			if newAbs > 100 newAbs = 100;
			if gem.subType != GemTypes.Hematite {
				ds_map_replace(item.defenses,gemElement,newAbs);
			}
			// hematite is an annoying special case
			else {
				ds_map_replace(item.defenses,SLASH,newAbs);
				ds_map_replace(item.defenses,CRUSH,newAbs);
				ds_map_replace(item.defenses,PIERCE,newAbs);
				ds_map_replace(item.defenses,PHYSICAL,newAbs);
			}
			updateItemName(item);
			break;
		}
		break;
	}
	case ItemTypes.Head: {
		ds_list_add(item.socketedGems,gem);
		
		var defOrResBoost = 0;
		switch gem.condition {
			case CRACKED: {
				defOrResBoost = 3;
			}
		}
		var oldDef = ds_map_find_value(item.defenses,gemElement);
		var newDef = oldDef + defOrResBoost;
		if gemElement != PHYSICAL {
			if newDef > 100 newDef = 100;
		}
		if gem.subType != GemTypes.Hematite {
			ds_map_replace(item.defenses,gemElement,newDef);
		} else {
			ds_map_replace(item.defenses,SLASH,newDef);
			ds_map_replace(item.defenses,CRUSH,newDef);
			ds_map_replace(item.defenses,PIERCE,newDef);
			ds_map_replace(item.defenses,PHYSICAL,newDef);
		}
		updateItemName(item);
		break;
	}
}

var gemIndex = ds_list_find_index(global.player.inventory,gem);
if gemIndex != -1 {
	ds_list_delete(global.player.inventory,gemIndex);
}