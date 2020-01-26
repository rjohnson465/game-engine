/// modifyWeaponDurabilityOrAmmo(weapon, buff)
/// @param weapon
/// @param buff

var weapon = argument[0];
var buff = argument[1];
buff = round(buff);
var adjustedBuff = buff;
// if ranged, buff ammo
var dummyWep = instance_create_depth(x, y, 1, weapon.object_index);
if weapon.isRanged {
	weapon.ammoMax = dummyWep.ammoMax + buff;
	if !global.gameManager.isLoading {
		weapon.ammo += buff;
	}
}
// else, buff durability
else {
	weapon.durabilityMax = dummyWep.durabilityMax + buff;
	if !global.gameManager.isLoading {
		weapon.durability += buff;
	}
}
instance_destroy(dummyWep);

// adjustedBuff is simply how many ammo / durability points were added
ds_map_replace(weapon.itemPropertyModifiers, WeaponProperties.DurabilityAmmoBonus, adjustedBuff);
ds_map_replace(weapon.itemPropertyModifiersPts, WeaponProperties.DurabilityAmmoBonus, buff);