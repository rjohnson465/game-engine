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
ds_map_replace(weaponTypesDamagePrefixes,SWORD2H,"Swordsman's");
ds_map_replace(weaponTypesDamagePrefixes,DAGGER,"Bandit's");
ds_map_replace(weaponTypesDamagePrefixes,AXE1H,"Executioner's");
ds_map_replace(weaponTypesDamagePrefixes,AXE2H,"Barbarian's");
ds_map_replace(weaponTypesDamagePrefixes,BLUNT1H,"Smith's");
ds_map_replace(weaponTypesDamagePrefixes,BLUNT2H,"Giant's");
ds_map_replace(weaponTypesDamagePrefixes,RAPIER,"Fencer's");
ds_map_replace(weaponTypesDamagePrefixes,SPEAR,"Pikeman's");
ds_map_replace(weaponTypesDamagePrefixes,SHURIKEN,"Assassin's");
ds_map_replace(weaponTypesDamagePrefixes,BOW,"Ranger's");
ds_map_replace(weaponTypesDamagePrefixes,MUSKET,"Marksman's");
ds_map_replace(weaponTypesDamagePrefixes,THROWN,"Rogue's");
ds_map_replace(weaponTypesDamagePrefixes,CROSSBOW,"Bowman's");
ds_map_replace(weaponTypesDamagePrefixes,PISTOL,"Pirate's");

var criticalsChancePrefixes = ds_map_create();
ds_map_replace(criticalsChancePrefixes,SWORD1H,"Slashing");
ds_map_replace(criticalsChancePrefixes,SWORD2H,"Sweeping");
ds_map_replace(criticalsChancePrefixes,DAGGER,"Cutting");
ds_map_replace(criticalsChancePrefixes,AXE1H,"Chopping");
ds_map_replace(criticalsChancePrefixes,AXE2H,"Mangling");
ds_map_replace(criticalsChancePrefixes,BLUNT1H,"Crushing");
ds_map_replace(criticalsChancePrefixes,BLUNT2H,"Smashing");
ds_map_replace(criticalsChancePrefixes,RAPIER,"Stabbing");
ds_map_replace(criticalsChancePrefixes,SPEAR,"Goring");
ds_map_replace(criticalsChancePrefixes,SHURIKEN,"Twirling");
ds_map_replace(criticalsChancePrefixes,BOW,"Whistling");
ds_map_replace(criticalsChancePrefixes,MUSKET,"Blasting");
ds_map_replace(criticalsChancePrefixes,THROWN,"Arcing");
ds_map_replace(criticalsChancePrefixes,CROSSBOW,"Hissing");
ds_map_replace(criticalsChancePrefixes,PISTOL,"Firing");

var criticalsDamagePrefixes = ds_map_create();
ds_map_replace(criticalsDamagePrefixes,SWORD1H,"Sharpened");
ds_map_replace(criticalsDamagePrefixes,SWORD2H,"Weighted");
ds_map_replace(criticalsDamagePrefixes,DAGGER,"Bloodstained");
ds_map_replace(criticalsDamagePrefixes,AXE1H,"Entrusted");
ds_map_replace(criticalsDamagePrefixes,AXE2H,"Emboldened");
ds_map_replace(criticalsDamagePrefixes,BLUNT1H,"Hammered");
ds_map_replace(criticalsDamagePrefixes,BLUNT2H,"Strengthened");
ds_map_replace(criticalsDamagePrefixes,RAPIER,"Attuned");
ds_map_replace(criticalsDamagePrefixes,SPEAR,"Distanced");
ds_map_replace(criticalsDamagePrefixes,SHURIKEN,"Silenced");
ds_map_replace(criticalsDamagePrefixes,BOW,"Composed");
ds_map_replace(criticalsDamagePrefixes,MUSKET,"Hawkeyed");
ds_map_replace(criticalsDamagePrefixes,THROWN,"Pointed");
ds_map_replace(criticalsDamagePrefixes,CROSSBOW,"Loaded");
ds_map_replace(criticalsDamagePrefixes,PISTOL,"Quickdrawn");

var physicalMultiplierPrefixes = ds_map_create();
ds_map_replace(physicalMultiplierPrefixes,SLASH,"Edged");
ds_map_replace(physicalMultiplierPrefixes,CRUSH,"Blunt");
ds_map_replace(physicalMultiplierPrefixes,PIERCE,"Razored");

var elementalMultipliersPrefixes = ds_map_create();
ds_map_replace(elementalMultipliersPrefixes,MAGIC,"Mystical");
ds_map_replace(elementalMultipliersPrefixes,FIRE,"Fiery");
ds_map_replace(elementalMultipliersPrefixes,ICE,"Arctic");
ds_map_replace(elementalMultipliersPrefixes,POISON,"Toxic");
ds_map_replace(elementalMultipliersPrefixes,LIGHTNING,"Galvanic");

var defensePrefixes = ds_map_create();
ds_map_replace(defensePrefixes,SLASH,"Chain");
ds_map_replace(defensePrefixes,CRUSH,"Plate");
ds_map_replace(defensePrefixes,PIERCE,"Scale");
ds_map_replace(defensePrefixes,MAGIC,"Rune");
ds_map_replace(defensePrefixes,FIRE,"Obsidian");
ds_map_replace(defensePrefixes,ICE,"Glacial");
ds_map_replace(defensePrefixes,POISON,"Filtered");
ds_map_replace(defensePrefixes,LIGHTNING,"Clouded");

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
