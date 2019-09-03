/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

#macro GRAINS "grains"
#macro PILE "pile"
#macro CHUNKS "chunks"
#macro SHARDS "shards"

global.ALL_GEMPIECES_CONDITIONS = [GRAINS,PILE,CHUNKS,SHARDS];
subType = GemTypes.Lapis;
type = ItemTypes.Other;
condition = global.gemPiecesCondition;
conditionString = "";
isStackable = true;
isUsable = true;
duration = 900; // 30 second duration
element = PHYSICAL;

gemWeaponBonusMin = 0; gemWeaponBonusMax = 0;
switch condition {
	case GRAINS: {
		gemWeaponBonusMin = 2; gemWeaponBonusMax = 4;
		gemShieldBonus = 5; gemHatBonus = 3;
		conditionString = "dust Grains";
		baseValue = 1000;
		break;
	}
	case PILE: {
		gemWeaponBonusMin = 4; gemWeaponBonusMax = 8;
		gemShieldBonus = 10; gemHatBonus = 6;
		conditionString = "dust Pile";
		baseValue = 3000;
		break;
	}
	case CHUNKS: {
		gemWeaponBonusMin = 8; gemWeaponBonusMax = 16;
		gemShieldBonus = 15; gemHatBonus = 10;
		conditionString = " Chunks";
		baseValue = 7000;
		break;
	}
	case SHARDS: {
		gemWeaponBonusMin = 12; gemWeaponBonusMax = 22;
		gemShieldBonus = 25; gemHatBonus = 15;
		conditionString = " Shards";
		baseValue = 1100;
		break;
	}
}

soundDrop = snd_item_gem;
itemInside = noone;

