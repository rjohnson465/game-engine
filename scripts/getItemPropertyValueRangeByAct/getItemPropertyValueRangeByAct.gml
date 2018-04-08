/// getItemPropertyValueRangeByAct(prop,act)
/// @param prop
/// @param act

var prop = argument[0];
var act = argument[1];

var range = noone;
switch prop {
	case ModifiableProperties.HpMax: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.HpRegen: {
		switch act {
			case 1: {
				return [.1,1];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.CriticalsChance: {
		switch act {
			case 1: {
				return [2,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.CriticalsDamage: {
		switch act {
			case 1: {
				return [2,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.HpSteal: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.StaminaSteal: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.WeaponTypesDamage: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.PhysicalDamageTypesMultiplier: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.ElementalDamageTypesMultiplier: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.Poise: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.XpMultiplier: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
	case ModifiableProperties.Defenses: {
		switch act {
			case 1: {
				return [1,10];
				break;
			}
		}
		break;
	}
}

return range;