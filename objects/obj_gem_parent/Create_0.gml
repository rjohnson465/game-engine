/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

enum GemTypes {
	Ruby,
	Emerald,
	Aquamarine,
	Lapis,
	Amethyst,
	Hematite	
}

#macro CRACKED "cracked"
#macro NORMAL "normal"
#macro EXQUISITE "exquisite"
#macro FLAWLESS "flawless"

global.ALL_GEM_CONDITIONS = [CRACKED,NORMAL,EXQUISITE,FLAWLESS];
subType = GemTypes.Hematite;
type = ItemTypes.Other;
condition = global.gemCondition;
isStackable = true;

gemWeaponBonusMin = 0; gemWeaponBonusMax = 0;
gemShieldBonus = 0; gemHatBonus = 0;
switch condition {
	case CRACKED: {
		gemWeaponBonusMin = 2; gemWeaponBonusMax = 4;
		gemShieldBonus = 5; gemHatBonus = 3;
		break;
	}
	case NORMAL: {
		gemWeaponBonusMin = 4; gemWeaponBonusMax = 8;
		gemShieldBonus = 10; gemHatBonus = 6;
		break;
	}
	case EXQUISITE: {
		gemWeaponBonusMin = 8; gemWeaponBonusMax = 16;
		gemShieldBonus = 15; gemHatBonus = 10;
		break;
	}
	case FLAWLESS: {
		gemWeaponBonusMin = 12; gemWeaponBonusMax = 22;
		gemShieldBonus = 25; gemHatBonus = 15;
		break;
	}
}

soundDrop = snd_item_gem;