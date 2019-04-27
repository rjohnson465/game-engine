global.isWishing = false;
global.fountainGui = noone;

if ds_exists(menuButtonCoordinates,ds_type_map) {
	ds_map_destroy(menuButtonCoordinates); menuButtonCoordinates = -1;
}
if ds_exists(menuOptions, ds_type_list) {
	ds_list_destroy(menuOptions); menuOptions = -1;
}