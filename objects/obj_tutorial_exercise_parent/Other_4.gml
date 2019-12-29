/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

global.isTutorialInProgress = false;

isFinished = ds_map_find_value(properties, "isFinished");

if isFinished {
	sprite_index = noone;
}