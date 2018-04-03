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
		s = " max HP";
		break;
	}
	case ModifiableProperties.HpRegen: {
		s = " HP regen";
		break;
	}
	case ModifiableProperties.CriticalsChance: {
		s = "% critical hit chance";
		break;
	}
}

switch macro {
	case SWORD1H: {
		s += " with 1H Swords";
		break;
	}
}

return s;