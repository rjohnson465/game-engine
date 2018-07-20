/// modifyBasePropertiesWeapon(weapon, rarity, pointsToSpend)
/// @param weapon
/// @param rarity
/// @param pointsToSpend

var weapon = argument[0];
var rarity = argument[1];
var pts = argument[2];

randomize();
var numPropsToBuff = round(random_range(1, WeaponProperties.length));
var buffAmounts = splitMIntoNParts(pts,numPropsToBuff);
// pick buffAmounts random properties from WeaponProperties enum
var propsToBuff = pickNUniqueNumbersInRange(numPropsToBuff,0,WeaponProperties.length);

for (var i = 0; i < array_length_1d(propsToBuff); i++) {
	var buff = buffAmounts[i];
	var prop = propsToBuff[i];
	switch prop {
		case WeaponProperties.PhysicalDamageBonus: {
			ds_map_replace(weapon.itemPropertyModifiers, prop, buff);
			break;
		}
		case WeaponProperties.ElementalDamageBonus: {
			// need to pick an element macro
			var macro = noone;
			randomize();
			var rand = round(random_range(0,array_length_1d(global.ALL_ELEMENTS)-1));
			macro = global.ALL_ELEMENTS[rand];
			ds_map_replace(weapon.itemPropertyModifiers, prop, [macro, buff]);
			break;
		}
		case WeaponProperties.DurabilityAmmoBonus: {
			ds_map_replace(weapon.itemPropertyModifiers, prop, buff);
			break;
		}
		case WeaponProperties.ChargesBonus: {
			ds_map_replace(weapon.itemPropertyModifiers, prop, buff);
			break;
		}
	}
}