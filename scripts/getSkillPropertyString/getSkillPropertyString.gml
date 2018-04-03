/// getSkillPropertyString(property)
/// @param property ModifiableProperty enum value

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
	case ModifiableProperties.CriticalsChance: {
		return " % critical hit chance"; break;
	}
	case ModifiableProperties.CriticalsDamage: {
		return " % critical hit damage"; break;
	}
	case ModifiableProperties.WeaponTypesDamage: {
		return " base damage"; break;
	}
	case ModifiableProperties.OffHandDamage: {
		return " % weapon damage "; break;
	}
}