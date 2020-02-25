/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if ds_exists(ghostsSpawnedList, ds_type_list) {
	ds_list_destroy(ghostsSpawnedList); ghostsSpawnedList = -1;
}