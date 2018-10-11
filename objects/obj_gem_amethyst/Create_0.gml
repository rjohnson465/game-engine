/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

subType = GemTypes.Amethyst;
var condi = condition == NORMAL ? "" : condition+" ";
name = stringCapitalize(condi) + "Amethyst";
itemSprite = asset_get_index("spr_gem_amethyst_"+condition);

switch condition {
	case CRACKED: {
		gemWeaponBonusMin = 0; gemWeaponBonusMax = 6;
		gemShieldBonus = 5; gemHatBonus = 3;
		break;
	}
	case NORMAL: {
		gemWeaponBonusMin = 1; gemWeaponBonusMax = 8;
		gemShieldBonus = 10; gemHatBonus = 6;
		break;
	}
	case EXQUISITE: {
		gemWeaponBonusMin = 2; gemWeaponBonusMax = 16;
		gemShieldBonus = 15; gemHatBonus = 10;
		break;
	}
	case FLAWLESS: {
		gemWeaponBonusMin = 4; gemWeaponBonusMax = 32;
		gemShieldBonus = 25; gemHatBonus = 15;
		break;
	}
}