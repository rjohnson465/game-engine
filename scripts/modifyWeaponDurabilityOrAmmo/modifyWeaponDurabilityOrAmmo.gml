/// modifyWeaponDurabilityOrAmmo(weapon, buff)
/// @param weapon
/// @param buff

var weapon = argument[0];
var buff = argument[1];
buff = round(buff);
var adjustedBuff = buff;
// if ranged, buff ammo
if weapon.isRanged {
	weapon.ammoMax += buff;
	weapon.ammo += buff;
}

// else, buff durability
else {
	weapon.durability += buff;
	weapon.durabilityMax += buff;
}
// adjustedBuff is simply how many ammo / durability points were added
ds_map_replace(weapon.itemPropertyModifiers, WeaponProperties.DurabilityAmmoBonus, adjustedBuff);
ds_map_replace(weapon.itemPropertyModifiersPts, WeaponProperties.DurabilityAmmoBonus, buff);