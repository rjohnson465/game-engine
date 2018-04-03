/// getPhysicalDamageTypesString(item,*isOffHand,*useModifiers)
/// @param item
/// @param *isOffHand
/// @param *useModifiers (account for weaponTypesDamage map bonuses,
	/// used in stats display but not item display)

// returns [physicalDamagesTypesString,physicalDamagesString]

var item = argument[0];
var isOffHand = false;
if argument_count >= 2 {
	isOffHand = argument[1];
}
if item.weaponType == UNARMED isOffHand = false;
var useModifiers = false;
if argument_count == 3 {
	useModifiers = argument[2];
}

var p = global.player;

// keys -- attack number, values -- [damageType, rangeMin, rangeMax]
var physicalDamagesMap = ds_map_create();
	
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	var damageType = global.ALL_DAMAGE_TYPES[i];
	var damageArray = ds_map_find_value(item.damages,damageType);
	var minDamage = 100000; var maxDamage = 0;

	if damageType == CRUSH || damageType == PIERCE || damageType == SLASH {
				
		for (var j = 0; j < array_length_1d(damageArray); j+=2) {
			var num = damageArray[j];
			if num > 0 {
				var num1 = num;
				var num2 = damageArray[j+1];
				// maybe account for bonus damage
				
				if useModifiers {
					// account for physical damage multipliers (%)
					var physicalDamageMultiplier = ds_map_find_value(p.physicalDamageTypesMultipliers,damageType) / 100;
					num1 = num1*physicalDamageMultiplier;
					num2 = num2*physicalDamageMultiplier;
					// account for weapon damage modifier (+ k constant)
					var weaponDamageModifier = ds_map_find_value(p.weaponTypesDamage,item.weaponType);
					num1 += weaponDamageModifier;
					num2 += weaponDamageModifier;
				}
				
				if !isOffHand {
					ds_map_add(physicalDamagesMap,j/2,[damageType,num1,num2]);
				} else {
					var offHandModifier = global.player.offHandDamagePercent/100;
					num1 = num1*offHandModifier;
					num2 = num2*offHandModifier;
					ds_map_add(physicalDamagesMap,j/2,[damageType,num1,num2]);
				}
			}
		}
	}
}
		
// order attacks
var currentPhysicalDamageIndex = ds_map_find_first(physicalDamagesMap);
var physicalDamageTypesArray = [];
for (var i = 0; i < ds_map_size(physicalDamagesMap); i++) {
	var damageArray = ds_map_find_value(physicalDamagesMap,currentPhysicalDamageIndex);
	var damageType = damageArray[0];
	physicalDamageTypesArray[currentPhysicalDamageIndex] = damageType;
	currentPhysicalDamageIndex = ds_map_find_next(physicalDamagesMap,currentPhysicalDamageIndex);
}
var physicalDamageTypesString = ""; var physicalDamagesString = "";
for (var i = 0; i < array_length_1d(physicalDamageTypesArray); i++) {
	var damageType = physicalDamageTypesArray[i];
	var damageArray = ds_map_find_value(physicalDamagesMap,i);
	var minDamage = round(damageArray[1]); var maxDamage = round(damageArray[2]);
	var damageString = string(minDamage) + "-" + string(maxDamage);
	if i == 0 {
		physicalDamageTypesString = stringCapitalize(damageType);
		physicalDamagesString = damageString;
	}
	else {
		physicalDamageTypesString += "/" + stringCapitalize(damageType);
		physicalDamagesString += "/" + damageString;
	}
			
}
ds_map_destroy(physicalDamagesMap);
return [physicalDamageTypesString,physicalDamagesString];