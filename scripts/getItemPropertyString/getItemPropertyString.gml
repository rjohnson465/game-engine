/// getItemPropertyString(property,*macro)
/// @param property ItemProperty enum value
/// @param *macro

var prop = argument[0];
var macro = noone;
if argument_count == 2 {
	macro = argument[1];
}

var s = "";

switch prop {
	case ModifiableProperties.HpMax: {
		s = " max HP"; break;
	}
	case ModifiableProperties.HpRegen: {
		s = " HP regen"; break;
	}
	case ModifiableProperties.CriticalsChance: {
		s = "% critical hit chance"; break;
	}
	case ModifiableProperties.CriticalsDamage: {
		s = "% critical hit damage"; break;
	}
	case ModifiableProperties.WeaponTypesDamage: {
		s = " base damage"; break;
	}
	case ModifiableProperties.PhysicalDamageTypesMultiplier: {
		s = "% damage"; break;
	}
	case ModifiableProperties.ElementalDamageTypesMultiplier: {
		s = "% damage"; break;
	}
	case ModifiableProperties.Poise: {
		s = " poise"; break;
	}
	case ModifiableProperties.XpMultiplier: {
		s = "% XP gained from kills"; break;
	}
	case ModifiableProperties.Defenses: {
		var absoluteDefenses = [PIERCE,CRUSH,SLASH];
		var percentOrNah = arrayIncludes(absoluteDefenses,macro) ? " " : "% ";
		var defenseOrResistance = arrayIncludes(absoluteDefenses,macro) ? " defense": " resistance";
		s = percentOrNah + macro + defenseOrResistance;
		break;
	}
}

switch macro {
	case SWORD1H: {
		s += " with 1H Swords";
		break;
	}
	case SWORD2H: {
		s += " with 2H Swords";
		break;
	}
	case BOW: {
		s += " with bows";
		break;
	}
	case CRUSH: {
		if	prop == ModifiableProperties.PhysicalDamageTypesMultiplier {
			s += " with crush attacks";
		}
		break;
	}
	case SLASH: {
		if	prop == ModifiableProperties.PhysicalDamageTypesMultiplier {
			s += " with slash attacks";
		}
		break;
	}
	case PIERCE: {
		if	prop == ModifiableProperties.PhysicalDamageTypesMultiplier {
			s += " with pierce attacks";
		}
		break;
	}
	case MAGIC: {
		if	prop == ModifiableProperties.ElementalDamageTypesMultiplier {
			s += " with magic attacks";
		}
		break;
	}
	case FIRE: {
		if	prop == ModifiableProperties.ElementalDamageTypesMultiplier {
			s += " with fire attacks";
		}
		break;
	}
	case ICE: {
		if	prop == ModifiableProperties.ElementalDamageTypesMultiplier {
			s += " with ice attacks";
		}
		break;
	}
	case POISON: {
		if	prop == ModifiableProperties.ElementalDamageTypesMultiplier {
			s += " with poison attacks";
		}
		break;
	}
	case LIGHTNING: {
		if	prop == ModifiableProperties.ElementalDamageTypesMultiplier {
			s += " with lightning attacks";
		}
		break;
	}
}

return s;