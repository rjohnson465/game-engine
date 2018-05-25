if menuOptions != undefined && menuOptions != noone && ds_exists(menuOptions,ds_type_list) {
	ds_list_destroy(menuOptions);
}
ds_map_destroy(menuButtonCoordinates);
global.fountainGui = noone;