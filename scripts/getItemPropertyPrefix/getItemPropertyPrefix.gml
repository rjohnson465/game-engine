/// getItemPropertyPrefix(prop,*macro)
/// @param prop
/// @param macro

var prop = argument[0];

var macro = argument[1];

switch prop {
	case ModifiableProperties.WeaponTypesDamage: {
		return ds_map_find_value(global.weaponTypesDamagePrefixes,macro); break;
	}
	case ModifiableProperties.CriticalsChance: {
		return ds_map_find_value(global.criticalsChancePrefixes,macro); break;
	}
	case ModifiableProperties.CriticalsDamage: {
		return ds_map_find_value(global.criticalsDamagePrefixes,macro); break;
	}
	case ModifiableProperties.PhysicalDamageTypesMultiplier: {
		return ds_map_find_value(global.physicalMultiplierPrefixes,macro); break;
	}
	case ModifiableProperties.ElementalDamageTypesMultiplier: {
		return ds_map_find_value(global.elementalMultipliersPrefixes,macro); break;
	}
	case ModifiableProperties.Defenses: {
		return ds_map_find_value(global.defensePrefixes,macro); break;
	}
}

/*
ds_map_destroy(weaponTypesDamagePrefixes);
ds_map_destroy(global.criticalsChancePrefixes);
ds_map_destroy(criticalsDamagePrefixes);
ds_map_destroy(physicalMultiplierPrefixes);
ds_map_destroy(elementalMultipliersPrefixes);
ds_map_destroy(defensePrefixes);
