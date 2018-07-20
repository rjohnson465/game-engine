/// modifyWeaponElementalDamage(weapon, element, buff)
/// @param weapon
/// @param element
/// @param buff

var weapon = argument[0];
var element = argument[1];
var buff = argument[2];

// two cases -- 1 where the base elemental damage is nonzero, and one where it is zero
var currentElementalDamage = ds_map_find_value(weapon.damages, element);

// the case where the elemental damage is zero
if currentElementalDamage[0] == 0 {
	// TODO -- maybe multiply these numbers by the weapon's associated act?
	
	// a buff between 0 and 15 adds 0-2
	if buff < 15 {
		currentElementalDamage[0] = 0;
		currentElementalDamage[1] = 2;
	}
	// a buff between 15 and 30 adds 2-6
	else if buff > 15 && buff < 30 {
		currentElementalDamage[0] = 2;
		currentElementalDamage[1] = 6;
	}
	// a buff between 30 and 45 adds 4-8
	else if buff > 30 && buff < 45 {
		currentElementalDamage[0] = 4;
		currentElementalDamage[1] = 8;
	}
	// a buff between 45 and up adds 5-10
	else if buff > 45 {
		currentElementalDamage[0] = 5;
		currentElementalDamage[1] = 10;
	}
}

// the case where the elemental damage is nonzero -- affect by percentage, like phys damage
// if this percentage buff affects no change, just add 1 to both range values
else {
	var d1 = currentElementalDamage[0];
	currentElementalDamage[0] = round(currentElementalDamage[0] * (1+(buff/100)));
	if currentElementalDamage[0] == d1 {
		currentElementalDamage[0] += 1;
	}
	var d2 = currentElementalDamage[1];
	currentElementalDamage[1] = round(currentElementalDamage[1] * (1+(buff/100)));
	if currentElementalDamage[1] == d2 {
		currentElementalDamage[1] += 1;
	}
}

ds_map_replace(weapon.damages, element, currentElementalDamage);