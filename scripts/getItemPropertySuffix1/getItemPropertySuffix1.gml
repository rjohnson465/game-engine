/// getItemPropertySuffix1(props)
/// @param props

var props = argument[0];

switch array_length_1d(props) {
	case 0: {
		return noone;
	}
	case 1: {
		if arrayIncludes(props,ModifiableProperties.StaminaRegen) {
			return "Athletic"; break;
		}
	}
}