/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if ds_exists(pathObjects, ds_type_list) {
	ds_list_destroy(pathObjects); pathObjects = -1;
}