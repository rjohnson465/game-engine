/// modifyBasePropertiesShield(shield, rarity, pointsToSpend)
/// @param shield
/// @param rarity
/// @param pointsToSpend

var shield = argument[0];
var rarity = argument[1];
var pts = argument[2];

randomize();
var numPropsToBuff = round(random_range(1, ShieldProperties.length));
var buffAmounts = splitMIntoNParts(pts,numPropsToBuff);
// pick buffAmounts random properties from ShieldProperties enum
var propsToBuff = pickNUniqueNumbersInRange(numPropsToBuff,0,ShieldProperties.length);

// create a map of the <prop><buff>. Do not allow physical to be buffed over 100%
var buffsMap = ds_map_create();
for (var i = 0; i < array_length_1d(propsToBuff); i++) {
	var prop = propsToBuff[i];
	var buff = buffAmounts[i];
	
	ds_map_replace(buffsMap, prop, buff);
}

var currentProp = ds_map_find_first(buffsMap);
// iterate through the proposed buffsMap. Do not allow buffing of any defense past 100% 
for (var i = 0; i < ds_map_size(buffsMap); i++) {
	var val = ds_map_find_value(buffsMap, currentProp);
	
	if currentProp == ShieldProperties.PhysicalBlockBonus {
		var currentPhysicalBlock = ds_map_find_value(shield.defenses, PHYSICAL);
		if currentPhysicalBlock + buff >= 100 {
			var amountOver100 = (currentPhysicalBlock + buff) - 100;
			// apply this to either elemental block or durability
			randomize();
			var rand = random_range(0,10);
			var otherProp = rand > 5 ? ShieldProperties.DurabilityBonus : ShieldProperties.ElementalBlockBonus;
			var otherPropVal = ds_map_find_value(buffsMap, otherProp);
			if otherPropVal == undefined otherPropVal = 0;
			ds_map_replace(buffsMap, otherProp, otherPropVal + amountOver100);
			// reset the physical block buff so it buffs physical def to 100 but not over
			var amountTo100 = 100 - currentPhysicalBlock;
			ds_map_replace(buffsMap, ShieldProperties.PhysicalBlockBonus, amountTo100);
		}
	}
	
	currentProp = ds_map_find_next(buffsMap, currentProp);
}

// delete any 0 value buffs
currentProp = ds_map_find_first(buffsMap);
for (var i = 0; i < ds_map_size(buffsMap); i++) {
	var val = ds_map_find_value(buffsMap, currentProp);
	if val == 0 {
		ds_map_delete(buffsMap, currentProp);
	}
	currentProp = ds_map_find_next(buffsMap, currentProp);
}

currentProp = ds_map_find_first(buffsMap);
for (var i = 0; i < ds_map_size(buffsMap); i++) {
	var buff = ds_map_find_value(buffsMap, currentProp);
	var prop = currentProp;
	switch prop {
		case ShieldProperties.PhysicalBlockBonus: {
			ds_map_replace(shield.itemPropertyModifiers, prop, buff);
			break;
		}
		case ShieldProperties.ElementalBlockBonus: {
			// need to pick an element macro
			var macro = noone; var currentElDef = 100;
			while (macro == noone || currentElDef == 100) {
				randomize();
				var rand = round(random_range(0,array_length_1d(global.ALL_ELEMENTS)-1));
				macro = global.ALL_ELEMENTS[rand];
				currentElDef = ds_map_find_value(shield.defenses, macro);
			}
			// do not buff an elemental defense over 100 
			if currentElDef + buff > 100 {
				var amountOver100 = (currentElDef + buff) - 100;
				randomize();
				var rand = random_range(0,10);
				var otherProp = rand > 5 ? ShieldProperties.DurabilityBonus : ShieldProperties.PhysicalBlockBonus;
				
				// possibly apply pts overage to physical block bonus
				if otherProp == ShieldProperties.PhysicalBlockBonus {
					var currentPropMod = ds_map_find_value(shield.itemPropertyModifiers, ShieldProperties.PhysicalBlockBonus);
					
					// ensure the overage application does not make phys block exceed 100
					var newPropMod = currentPropMod + amountOver100;
					var currentPhysicalBlock = ds_map_find_value(shield.defenses, PHYSICAL);
					newPropMod = currentPhysicalBlock + newPropMod < 100 ? newPropMod : 100 - currentPhysicalBlock;
					ds_map_replace(shield.itemPropertyModifiers, ShieldProperties.PhysicalBlockBonus, newPropMod);
					
					// apply any secondary overage to durability bonus
					if currentPhysicalBlock + newPropMod > 100 {
						var amtOver100Two = (currentPhysicalBlock + currentPropMod + amountOver100) - 100;
						var currentDurabilityBonus = ds_map_find_value(buffsMap, ShieldProperties.DurabilityBonus);
						ds_map_replace(buffsMap, ShieldProperties.DurabilityBonus, currentDurabilityBonus + amtOver100Two);
					}
				}
				// else, apply pts overage to durability bonus
				else {
					var currentDurabilityBonus = ds_map_find_value(buffsMap, ShieldProperties.DurabilityBonus);
					ds_map_replace(buffsMap, ShieldProperties.DurabilityBonus, currentDurabilityBonus + amountOver100);
				}
				// reset the elemental block buff so it sets el def to 100 but not over 100
				var amountTo100 = 100 - currentElDef;
				ds_map_replace(buffsMap, ShieldProperties.ElementalBlockBonus, amountTo100);
			}
			ds_map_replace(shield.itemPropertyModifiers, prop, [macro, buff]);
			break;
		}
		case ShieldProperties.DurabilityBonus: {
			ds_map_replace(shield.itemPropertyModifiers, prop, buff);
			break;
		}
	}
	currentProp = ds_map_find_next(buffsMap, currentProp);
}

ds_map_destroy(buffsMap);