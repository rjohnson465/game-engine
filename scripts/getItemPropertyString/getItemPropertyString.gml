/// getItemPropertyString(property)
/// @param property ItemProperty enum value

var prop = argument[0];

switch prop {
	case ItemProperties.HpMax: {
		return " max HP";
		break;
	}
	case ItemProperties.HpRegen: {
		return " HP regen";
		break;
	}
}