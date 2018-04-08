/// getPropertyMacro(prop)
/// @param prop
/// return an appropriate macro (FIRE,SWORD1H) for the given property, or noone

var prop = argument[0];

var weaponTypeProps = [
	ModifiableProperties.CriticalsDamage,
	ModifiableProperties.CriticalsChance,
	ModifiableProperties.WeaponTypesDamage
];

var defenseProps = [
	ModifiableProperties.Defenses
];

var damageTypeProps = [
	ModifiableProperties.PhysicalDamageTypesMultiplier,
	ModifiableProperties.ElementalDamageTypesMultiplier
];

randomize();
if arrayIncludes(weaponTypeProps,prop) {
	var rand = round(random_range(0,array_length_1d(global.ALL_WEAPON_TYPES)-1));
	return global.ALL_WEAPON_TYPES[rand];
}

if arrayIncludes(defenseProps,prop) {
	var macro = noone;
	while macro == noone || macro == PHYSICAL {
		randomize();
		var rand = round(random_range(0,array_length_1d(global.ALL_DAMAGE_TYPES)-1));
		macro = global.ALL_DAMAGE_TYPES[rand];
	}
	return macro;
}

if prop == ModifiableProperties.PhysicalDamageTypesMultiplier {
	var macro = noone;
	var physicalDamageTypes = [SLASH,CRUSH,PIERCE];
	while macro == noone || macro == PHYSICAL || arrayIncludes(global.ALL_ELEMENTS,macro) {
		randomize();
		var rand = round(random_range(0,array_length_1d(global.ALL_DAMAGE_TYPES)-1));
		macro = global.ALL_DAMAGE_TYPES[rand];
	}
	return macro;
}

if prop == ModifiableProperties.ElementalDamageTypesMultiplier {
	var macro = noone;
	while macro == noone {
		randomize();
		var rand = round(random_range(0,array_length_1d(global.ALL_ELEMENTS)-1));
		macro = global.ALL_ELEMENTS[rand];
	}
	return macro;
}

return noone;