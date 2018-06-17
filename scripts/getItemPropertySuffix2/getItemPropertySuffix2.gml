/// getItemPropertySuffix2(props)
/// @param props

var props = argument[0];

switch array_length_1d(props) {
	case 0: {
		return noone;
	}
	case 1: {
		if arrayIncludes(props,ModifiableProperties.Poise) {
			return "Cat"; break;
		}
		if arrayIncludes(props,ModifiableProperties.XpMultiplier) {
			return "Owl"; break;
		}
		if arrayIncludes(props,ModifiableProperties.HpMax) {
			return "Ox"; break;
		}
		if arrayIncludes(props,ModifiableProperties.StaminaMax) {
			return "Hummingbird"; break;
		}
		if arrayIncludes(props,ModifiableProperties.OffHandDamage) {
			return "Budgie"; break;
		}
		if arrayIncludes(props,ModifiableProperties.GoldDrop) {
			return "Boar"; break;
		}
	}
	case 2: {
		if arrayIncludesMultiple(props, [ModifiableProperties.Poise, ModifiableProperties.XpMultiplier]) {
			return "Panther"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.Poise, ModifiableProperties.HpMax]) {
			return "Lion"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.Poise, ModifiableProperties.StaminaMax]) {
			return "Cheetah"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.Poise, ModifiableProperties.OffHandDamage]) {
			return "Lynx"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.Poise, ModifiableProperties.GoldDrop]) {
			return "Fox"; break;
		}
		
		if arrayIncludesMultiple(props, [ModifiableProperties.XpMultiplier, ModifiableProperties.HpMax]) {
			return "Elephant"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.XpMultiplier, ModifiableProperties.StaminaMax]) {
			return "Eagle"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.XpMultiplier, ModifiableProperties.OffHandDamage]) {
			return "Human"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.XpMultiplier, ModifiableProperties.GoldDrop]) {
			return "Raven"; break;
		}
		
		if arrayIncludesMultiple(props, [ModifiableProperties.HpMax, ModifiableProperties.StaminaMax]) {
			return "Wolf"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.HpMax, ModifiableProperties.OffHandDamage]) {
			return "Gorilla"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.HpMax, ModifiableProperties.GoldDrop]) {
			return "Cobra"; break;
		}
		
		if arrayIncludesMultiple(props, [ModifiableProperties.StaminaMax, ModifiableProperties.OffHandDamage]) {
			return "Monkey"; break;
		}
		if arrayIncludesMultiple(props, [ModifiableProperties.StaminaMax, ModifiableProperties.GoldDrop]) {
			return "Badger"; break;
		}
		
		if arrayIncludesMultiple(props, [ModifiableProperties.OffHandDamage, ModifiableProperties.GoldDrop]) {
			return "Adder"; break;
		}
	}
}