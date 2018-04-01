/// getItemPropertyString(property)
/// @param property ItemProperty enum value

var prop = argument[0];

switch prop {
	case ModifiableProperties.HpMax: {
		return " max HP";
		break;
	}
	case ModifiableProperties.HpRegen: {
		return " HP regen";
		break;
	}
}