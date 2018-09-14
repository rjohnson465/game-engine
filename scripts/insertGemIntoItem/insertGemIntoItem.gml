/// insertGemIntoItem(gem,item,*isRemoving)
/// @param gem
/// @param item
/// @param *isRemoving

var gem = argument[0];
var item = argument[1];
var isRemoving = false;
if argument_count > 2 {
	isRemoving = argument[2];
}

gem.owner = item.owner;

var isEquipped = item.equipmentSlot != noone;
var slot = noone;
if isEquipped {
	slot = item.equipmentSlot;
	unequipItem(item);
}

if !isRemoving {
	if item.numberOfSockets == 0 || ds_list_size(item.socketedGems) >= item.numberOfSockets {
		alert(item.name + " does not have any free sockets",c_red);
		exit;
	}
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
	case GemTypes.Amethyst: {
		gemElement = LIGHTNING; break;
	}
	case GemTypes.Emerald: {
		gemElement = POISON; break;
	}
	case GemTypes.Ruby: {
		gemElement = FIRE; break;
	}
}

if isRemoving {
	var gemIndex = ds_list_find_index(item.socketedGems,gem);
	ds_list_delete(item.socketedGems,gemIndex);
} else {
	ds_list_add(item.socketedGems,gem);
}

switch item.type {
	case ItemTypes.HandItem: {
		// for weapons, gems increase damage
		if item.subType != HandItemTypes.Shield {
			
			var damageMin = gem.gemWeaponBonusMin; var damageMax = gem.gemWeaponBonusMax;
			if isRemoving {
				damageMin = damageMin * -1;
				damageMax = damageMax * -1;
			}
			if gem.subType != GemTypes.Hematite {
				var oldDamageArray = ds_map_find_value(item.damages,gemElement);
				var newDamageArray = noone;
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
			
			var absorptionBoost = gem.gemShieldBonus;
			if isRemoving absorptionBoost = absorptionBoost * -1;
			var oldAbs = ds_map_find_value(item.defenses,gemElement);
			var newAbs = oldAbs + absorptionBoost;
			//if newAbs > 100 newAbs = 100;
			// newAbs can be greater than 100, but only 100 is displayed in gui
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
		
		var defOrResBoost = gem.gemHatBonus;
		if isRemoving defOrResBoost = defOrResBoost * -1;
		var oldDef = ds_map_find_value(item.defenses,gemElement);
		var newDef = oldDef + defOrResBoost;
		if gemElement != PHYSICAL {
			if newDef > 100 newDef = 100;
		}
		if gem.subType != GemTypes.Hematite {
			ds_map_replace(item.defenses,gemElement,newDef);
		} else {
			var slashDef = ds_map_find_value(item.defenses,SLASH);
			ds_map_replace(item.defenses,SLASH,slashDef+defOrResBoost);
			var crushDef = ds_map_find_value(item.defenses,CRUSH);
			ds_map_replace(item.defenses,CRUSH,crushDef+defOrResBoost);
			var pierceDef = ds_map_find_value(item.defenses,PIERCE);
			ds_map_replace(item.defenses,PIERCE,pierceDef+defOrResBoost);
			var physDef = ds_map_find_value(item.defenses,PHYSICAL);
			ds_map_replace(item.defenses,PHYSICAL,physDef+defOrResBoost);
		}
		updateItemName(item);
		//updatePlayerPropertiesItem(item,0);
		break;
	}
}

// gems in sockets are not "owner" by player (for consistency with saving inventory)
if isRemoving {
	gem.owner = global.player;
} else {
	gem.owner = "socket";
}

var gemIndex = ds_list_find_index(global.player.inventory,gem);
if gemIndex != -1 {
	var gemObj = ds_list_find_value(global.player.inventory,gemIndex);
	if gemObj.count == 1 {
		ds_list_delete(global.player.inventory,gemIndex);
	} else gemObj.count--;
}


if isEquipped {
	equipItem(item,slot)
}

