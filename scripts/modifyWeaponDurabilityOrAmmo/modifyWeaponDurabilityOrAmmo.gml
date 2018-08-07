/// modifyWeaponDurabilityOrAmmo(weapon, buff)
/// @param weapon
/// @param buff

var weapon = argument[0];
var buff = argument[1];

var adjustedBuff = 0;
// if ranged, buff ammo
if weapon.isRanged {
	var newAmmo = round(weapon.ammoMax * (1 + (buff/100)));
	if newAmmo == weapon.ammoMax {
		newAmmo += 1;
	}
	if adjustedBuff == 0 {
		var fraction = newAmmo / weapon.ammoMax;
		adjustedBuff = (fraction-1)*100;
	}
	weapon.ammoMax = newAmmo;
	weapon.ammo = newAmmo;
}

// else, buff durability
else {
	var newDurability = round(weapon.durabilityMax * (1 + (buff/100)));
	if newDurability == weapon.durabilityMax {
		newDurability += 1;
	}
	if adjustedBuff == 0 {
		var fraction = newDurability / weapon.durabilityMax;
		adjustedBuff = (fraction-1)*100;
	}
	weapon.durability = newDurability;
	weapon.durabilityMax = newDurability;
}

ds_map_replace(weapon.itemPropertyModifiers, WeaponProperties.DurabilityAmmoBonus, adjustedBuff);