/// updateWeaponParticles(weapon)
/// @param weapon
/// must be called from obj_weapon

var weapon = argument0;

// rest arrays
weaponParticles = [noone, noone, noone, noone, noone];
weaponParticlesNums = [noone, noone, noone, noone, noone];

// iterate over weapon damages
var currentDamageType = ds_map_find_first(weapon.damages);
var damageTypes = ds_list_create();
for (var i = 0; i < ds_map_size(weapon.damages); i++) {
	if currentDamageType != PHYSICAL && currentDamageType != SLASH && currentDamageType != PIERCE && currentDamageType != CRUSH {
		var damagesArray = ds_map_find_value(weapon.damages,currentDamageType);
		if damagesArray[0] > 0 || damagesArray[1] > 0 {
			ds_list_add(damageTypes,currentDamageType);
		}
	}
	currentDamageType = ds_map_find_next(weapon.damages,currentDamageType);
}

var wpMap = global.weaponParticlesMap;
// particles for all elemental damages (up to 5)
for (var i = 0; i < ds_list_size(damageTypes); i++) {
	var damageType = ds_list_find_value(damageTypes,i);
	var part = ds_map_find_value(wpMap,damageType);
	weaponParticles[i] = part;
	weaponParticlesNums[i] = -2;
	
	if damageType == LIGHTNING weaponParticlesNums[i] = 2;

}
ds_list_destroy(damageTypes); damageTypes = -1;