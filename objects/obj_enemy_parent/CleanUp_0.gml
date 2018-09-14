/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

ds_map_destroy(persistentProperties); persistentProperties = -1;
if ds_exists(droppedItems, ds_type_list) {
	ds_list_destroy(droppedItems); droppedItems = -1;
}