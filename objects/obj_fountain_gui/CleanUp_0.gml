if ds_exists(menuButtonCoordinates,ds_type_map) {
	ds_map_destroy(menuButtonCoordinates); menuButtonCoordinates = -1;
}
ds_list_destroy(menuOptions); menuOptions = -1;