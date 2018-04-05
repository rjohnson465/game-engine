/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();
sprite_index = spr_item_slot;
visible = false;
level = 0;
levelMax = 1000;
name = "";
description = "";
slot = noone;

if x1 == noone || x1 == undefined {
	x1 = -100; y1 = -100;
}

bonusesMap = ds_map_create();
nextLevelBonusesMap = ds_map_create();

isLevelingUp = false;
