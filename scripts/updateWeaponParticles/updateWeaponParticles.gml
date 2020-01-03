/// updateWeaponParticles(weapon)
/// @param weapon
/// must be called from obj_weapon OR obj_attack (need to have weaponParticles and weaponParticlesNums array properties)

var weapon = argument0;
var attackObj = noone;
if weapon.object_index == obj_attack || object_is_ancestor(weapon.object_index, obj_attack) {
	attackObj = weapon;
	if (attackObj.weapon != noone) {
		weapon = attackObj.weapon;
	} else weapon = attackObj.attackData;
}

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

// if weapon comes from an obj_attack, also consider the additionalDamages map property
if attackObj != noone {
	var currentDamageType = ds_map_find_first(attackObj.additionalDamages);
	for (var i = 0; i < ds_map_size(attackObj.additionalDamages); i++) {
		if currentDamageType != PHYSICAL && currentDamageType != SLASH && currentDamageType != PIERCE && currentDamageType != CRUSH {
			var damagesArray = ds_map_find_value(attackObj.additionalDamages,currentDamageType);
			if (damagesArray[0] > 0 || damagesArray[1] > 0) && ds_list_find_index(damageTypes, currentDamageType) == -1 {
				ds_list_add(damageTypes,currentDamageType);
			}
		}
		currentDamageType = ds_map_find_next(attackObj.additionalDamages,currentDamageType);
	}
}

var wpMap = global.weaponParticlesMap;
// particles for all elemental damages (up to 5)
for (var i = 0; i < ds_list_size(damageTypes); i++) {
	var damageType = ds_list_find_value(damageTypes,i);
	var part = ds_map_find_value(wpMap,damageType);
	weaponParticles[i] = part;
	
	// TODO -- calculate weapon particle amount based on sq px of base weapon sprite
	// baseline -- 2700px sq (52x52) should return -1
	
	var numParticles = -2;
	var baseSprite = sprite_index;
	var sw = sprite_get_bbox_right(baseSprite) - sprite_get_bbox_left(baseSprite);
	var sh = sprite_get_bbox_bottom(baseSprite) - sprite_get_bbox_top(baseSprite);
	var pxSq = sw * sh;
	numParticles = ((1/2700)*pxSq)-3;
	numParticles = round(numParticles);
	
	if numParticles == 0 {
		numParticles = -1;
	}
	
	weaponParticlesNums[i] = numParticles;
	
	if damageType == LIGHTNING {
		weaponParticlesNums[i] = numParticles + 2;
		
		if numParticles + 2 > -2 && numParticles + 2 < 2 {
			weaponParticlesNums[i] =  2;
		}
	}
	
	if damageType == MAGIC {
		weaponParticlesNums[i] = numParticles + 2;
		
		if numParticles + 2 > -2 && numParticles + 2 < 2 {
			weaponParticlesNums[i] =  2;
		}
	}

}
ds_list_destroy(damageTypes); damageTypes = -1;