/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

name = "Antidote";
spriteName = "antidote";
itemSprite = spr_item_antidote;

type = ItemTypes.Other;

isStackable = true;
isUsable = true;

soundUse = snd_iu_gulp;

description = "Cures poison. If used when not poisoned, grants poison resistance for a brief period of time.";

baseValue = 500;