/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Revive Orb";
spriteName = "revive_orb";
itemSprite = spr_item_revive_orb;
baseValue = 5000;

type = ItemTypes.Other;

isStackable = true;
isUsable = true;

soundUse = snd_iu_choirheal;

description = "Use to revive when killed. You will revive where you died and you will lose no XP.";