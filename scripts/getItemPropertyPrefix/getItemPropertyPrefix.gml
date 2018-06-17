/// getItemPropertyPrefix(prop,*macro)
/// @param prop
/// @param macro

var prop = argument[0];
//var macro = noone;

//if argument_count == 2 {
var macro = argument[1];
//}

var weaponTypesDamagePrefixes = ds_map_create();
ds_map_replace(weaponTypesDamagePrefixes,SWORD1H,"Soldier's");

var criticalsChancePrefixes = ds_map_create();
ds_map_replace(criticalsChancePrefixes,SWORD1H,"Slashing");

var criticalsDamagePrefixes = ds_map_create();
ds_map_replace(criticalsDamagePrefixes,SWORD1H,"Sharpened");

var physicalMultiplierPrefixes = ds_map_create();
var elementalMultipliersPrefixes = ds_map_create();
var defensePrefixes = ds_map_create();

switch prop {
	case ModifiableProperties.WeaponTypesDamage: {
		return ds_map_find_value(weaponTypesDamagePrefixes,macro); break;
	}
	case ModifiableProperties.CriticalsChance: {
		return ds_map_find_value(criticalsChancePrefixes,macro); break;
	}
	case ModifiableProperties.CriticalsDamage: {
		return ds_map_find_value(criticalsDamagePrefixes,macro); break;
	}
	case ModifiableProperties.PhysicalDamageTypesMultiplier: {
		return ds_map_find_value(physicalMultiplierPrefixes,macro); break;
	}
	case ModifiableProperties.ElementalDamageTypesMultiplier: {
		return ds_map_find_value(elementalMultipliersPrefixes,macro); break;
	}
	case ModifiableProperties.Defenses: {
		return ds_map_find_value(defensePrefixes,macro); break;
	}
}


ds_map_destroy(weaponTypesDamagePrefixes);
ds_map_destroy(criticalsChancePrefixes);
ds_map_destroy(criticalsDamagePrefixes);
ds_map_destroy(physicalMultiplierPrefixes);
ds_map_destroy(elementalMultipliersPrefixes);
ds_map_destroy(defensePrefixes);
