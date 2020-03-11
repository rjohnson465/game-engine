/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

isFinished = ds_map_find_value(properties, "isFinished");

isActive = ds_map_find_value(properties, "isActive");

// this is probably due to player loading a game with an active event
// since most events lock you in place until you succeed or die (cannot be active and have a room change)
if isActive && !isFinished {
	isActive = false; // silly but needed rn
	scr_event_start(id);
}

if isFinished {
	sprite_index = noone;
}