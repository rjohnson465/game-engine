/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if room == rm_boss_lighteater {
	if y < 75 {
		instance_destroy(id, 1);
	}
}