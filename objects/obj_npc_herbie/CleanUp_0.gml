/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

if path_exists(gridPath) {
	path_delete(gridPath); gridPath = -1;
}

if ds_exists(personalGrid, ds_type_grid) {
	mp_grid_destroy(personalGrid); personalGrid = -1;
}
