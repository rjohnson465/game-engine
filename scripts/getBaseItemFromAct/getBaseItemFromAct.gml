/// getBaseItemFromAct(itemType,act,*subTypeMap)
/// @param itemType ItemType enum val
/// @param act number
/// @param *subTypeMap map i.e. (<WeaponType>,<chance 0-100>)

// returns Real

var itemType = argument[0];
var act = argument[1];
var subTypeMap = getDefaultItemSubTypeChanceMap(itemType);
if argument_count == 3 {
	subTypeMap = argument[2];
}

var possibleItems = noone;

// only use subTypeMap for HandItem and Other ItemTypes
if itemType == ItemTypes.HandItem || itemType == ItemTypes.Other {
	
	// Melee, Ranged, or Shield hand item?
	if itemType == ItemTypes.HandItem {
		
		randomize();
		var rand = random_range(0,100);
		var lowestSeen = 100; var st = HandItemTypes.Melee;
		var currentSubType = ds_map_find_first(subTypeMap);
		for (var i = 0; i < ds_map_size(subTypeMap); i++) {
					
			var chanceRange = ds_map_find_value(subTypeMap,i);
			var chanceMin = chanceRange[0]; var chanceMax = chanceRange[1];
			if (rand <= chanceMax && rand > chanceMin) && chanceMin < lowestSeen {
				lowestSeen = chanceMin;
				st = i;
			}
					
			currentSubType = ds_map_find_next(subTypeMap,currentSubType);
		}
		
		switch st {
			case HandItemTypes.Melee: {
				possibleItems = ds_map_find_value(global.meleeWeaponsByAct,act);
				break;
			}
			case HandItemTypes.Ranged: {
				possibleItems = ds_map_find_value(global.rangedWeaponsByAct,act);
				break;
			}
			case HandItemTypes.Shield: {
				possibleItems = ds_map_find_value(global.shieldsByAct,act);
				break;
			}
		}
		
	}

	// TODO
	else if itemType == ItemTypes.Other {
		// Gem or Revive Orb?
		randomize();
		var rand = random_range(0,100);
		possibleItems = rand < 5 ? [obj_item_revive_orb] : [obj_gem_parent];
	}
}
// Rings and Head Items -- don't need to factor a subType when looking for possibleItems
else if itemType == ItemTypes.Ring {
	possibleItems = [obj_item_ring];
} 
else if itemType == ItemTypes.Head {
	possibleItems = ds_map_find_value(global.hatsByAct,act);
}

// randomly choose an element of possibleItems
randomize();
var index = round(random_range(0,array_length_1d(possibleItems)-1));
var item = possibleItems[index];

return item;

ds_map_destroy(subTypeMap); // prevent mem leak
