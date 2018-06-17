/// getItemPropertySuffix1(props)
/// @param props

var props = argument[0];

switch array_length_1d(props) {
	case 0: {
		return noone;
	}
	case 1: {
		if arrayIncludes(props,ModifiableProperties.HpSteal) {
			return "Bloodthirsty"; break;
		}
		if arrayIncludes(props,ModifiableProperties.StaminaSteal) {
			return "Leeching"; break;
		}
		if arrayIncludes(props,ModifiableProperties.HpRegen) {
			return "Vital"; break;
		}
		if arrayIncludes(props,ModifiableProperties.StaminaRegen) {
			return "Athletic"; break;
		}
	}
	case 2: {
		if arrayIncludesMultiple(props, [ModifiableProperties.HpSteal, ModifiableProperties.StaminaSteal]) {
			return "Greedy"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.HpSteal, ModifiableProperties.HpRegen]) {
			return "Lively"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.HpSteal, ModifiableProperties.StaminaRegen]) {
			return "Vampire"; break;
		}
		
		if arrayIncludesMultiple(props, [ModifiableProperties.StaminaSteal, ModifiableProperties.HpRegen]) {
			return "Insatiable"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.StaminaSteal, ModifiableProperties.StaminaRegen]) {
			return "Agile"; break;
		}
		
		if arrayIncludesMultiple(props, [ModifiableProperties.HpRegen, ModifiableProperties.StaminaRegen]) {
			return "Strong"; break;
		}
	}
}