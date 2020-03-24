/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if ds_exists(damages,ds_type_map) {
	ds_map_destroy(damages); damages = -1;
}

if ds_exists(damagesPoise,ds_type_map) {
	ds_map_destroy(damagesPoise); damagesPoise = -1;
}