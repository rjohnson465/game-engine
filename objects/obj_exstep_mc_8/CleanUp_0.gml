/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if ds_exists(eventListeners, ds_type_map) {
	ds_map_destroy(eventListeners); eventListeners = -1;
}