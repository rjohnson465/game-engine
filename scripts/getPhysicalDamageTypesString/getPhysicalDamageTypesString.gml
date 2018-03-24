/// getPhysicalDamageTypesString(item,*isOffHand)
/// @param item
/// @param isOffHand

// returns [physicalDamagesTypesString,physicalDamagesString]

var item = argument[0];
var isOffHand = false;
if argument_count == 2 {
	isOffHand = argument[1];
}
if item.weaponType == UNARMED isOffHand = false;

// keys -- attack number, values -- [damageType, rangeMin, rangeMax]
var physicalDamagesMap = ds_map_create();
	
for (var i = 0; i < array_length_1d(global.ALL_DAMAGE_TYPES); i++) {
	var damageType = global.ALL_DAMAGE_TYPES[i];
	var damageArray = ds_map_find_value(item.damages,damageType);
	var minDamage = 100000; var maxDamage = 0;
	// TODO account for slash / pierce / crush
	if damageType == CRUSH || damageType == PIERCE || damageType == SLASH {
				
		for (var j = 0; j < array_length_1d(damageArray); j+=2) {
			var num = damageArray[j];
			if num > 0 {
				if !isOffHand {
					ds_map_add(physicalDamagesMap,j/2,[damageType,num,damageArray[j+1]]);
				} else {
					var modifier = global.player.offHandDamagePercent/100;
					var num1 = num*modifier;
					var num2 = damageArray[j+1]*modifier;
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
	var minDamage = damageArray[1]; var maxDamage = damageArray[2];
	var damageString = string(minDamage) + "-" + string(maxDamage);
	if i == 0 {
		physicalDamageTypesString = damageType;
		physicalDamagesString = damageString;
	}
	else {
		physicalDamageTypesString += "/" + damageType;
		physicalDamagesString += "/" + damageString;
	}
			
}
ds_map_destroy(physicalDamagesMap);
return [physicalDamageTypesString,physicalDamagesString];