/// modifyWeaponPhysicalDamage(weapon, buff) 
/// @param weapon
/// @param buff

var weapon = argument[0];
var buff = argument[1];

ds_map_replace(weapon.itemPropertyModifiersPts, WeaponProperties.PhysicalDamageBonus, buff);
// increase by buff%
// if buff% increase does no effective change, just add 1 to all max / min phys damages

var adjustedBuff = 0; // this is the min # of buff "pts" that would have had to be added to get the resultant effect
var slashDamageArray = ds_map_find_value(weapon.damages,SLASH);
var crushDamageArray = ds_map_find_value(weapon.damages,CRUSH);
var pierceDamageArray = ds_map_find_value(weapon.damages,PIERCE);
var physicalDamagesLength = array_length_1d(slashDamageArray);
for (var i = 0; i < physicalDamagesLength; i += 2) {
	if array_length_1d(slashDamageArray) >= i && slashDamageArray[i] != 0 {
		var d1 = slashDamageArray[i];
		slashDamageArray[i] = round(slashDamageArray[i] * (1+(buff/100)));
		if slashDamageArray[i] == d1 {
			slashDamageArray[i] += 1;
		}
		var d2 = slashDamageArray[i+1];
		slashDamageArray[i+1] = round(slashDamageArray[i+1] * (1+(buff/100)));
		if slashDamageArray[i+1] == d2 {
			slashDamageArray[i+1] += 1;
		}
		// calculate adjustedBuff 
		var totalDamageIncrease = (slashDamageArray[i+1]-d2)+(slashDamageArray[i]-d1);
		if adjustedBuff == 0 {
			//var fraction = slashDamageArray[i+1] / d2;
			//adjustedBuff = (fraction - 1)*100;
			adjustedBuff = totalDamageIncrease;
		}

	} else if array_length_1d(crushDamageArray) >= i && crushDamageArray[i] != 0 {
		var d1 = crushDamageArray[i];
		crushDamageArray[i] = round(crushDamageArray[i] * (1+(buff/100)));
		if crushDamageArray[i] == d1 {
			crushDamageArray[i] += 1;
		}
		var d2 = crushDamageArray[i+1];
		crushDamageArray[i+1] = round(crushDamageArray[i+1] * (1+(buff/100)));
		if crushDamageArray[i+1] == d2 {
			crushDamageArray[i+1] += 1;
		}
		// calculate adjustedBuff 
		var totalDamageIncrease = (crushDamageArray[i+1]-d2)+(crushDamageArray[i]-d1);
		if adjustedBuff == 0 {
			//var fraction = crushDamageArray[i+1] / d2;
			//adjustedBuff = (fraction - 1)*100;
			adjustedBuff = totalDamageIncrease;
		}
	} else if array_length_1d(pierceDamageArray) >= i && pierceDamageArray[i] != 0 {
		var d1 = pierceDamageArray[i];
		pierceDamageArray[i] = round(pierceDamageArray[i] * (1+(buff/100)));
		if pierceDamageArray[i] == d1 {
			pierceDamageArray[i] += 1;
		}
		var d2 = pierceDamageArray[i+1];
		pierceDamageArray[i+1] = round(pierceDamageArray[i+1] * (1+(buff/100)));
		if pierceDamageArray[i+1] == d2 {
			pierceDamageArray[i+1] += 1;
		}
		// calculate adjustedBuff 
		var totalDamageIncrease = (pierceDamageArray[i+1]-d2)+(pierceDamageArray[i]-d1);
		if adjustedBuff == 0 {
			//var fraction = crushDamageArray[i+1] / d2;
			//adjustedBuff = (fraction - 1)*100;
			adjustedBuff = totalDamageIncrease;
		}
	}
}
ds_map_replace(weapon.damages,SLASH,slashDamageArray);
ds_map_replace(weapon.damages,CRUSH,crushDamageArray);
ds_map_replace(weapon.damages,PIERCE,pierceDamageArray);
// adjustedBuff now contains the total physical damage increase this weapon got
ds_map_replace(weapon.itemPropertyModifiers, WeaponProperties.PhysicalDamageBonus, adjustedBuff);
