/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if isInUse {
	var condi = SLASH;
	ds_map_replace(global.player.conditionLevels, condi, 1);
	ds_map_replace(global.player.conditionPercentages, condi, 100);
	/*global.owner = global.player;
	global.condition = condi;
	// global.conditionBarCount += 1;
	instance_create_depth(x,y,1,obj_condition_bar);*/
	isInUse = false;
}