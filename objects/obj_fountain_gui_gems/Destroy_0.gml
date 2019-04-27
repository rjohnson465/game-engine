if ds_exists(menuButtonCoordinates,ds_type_map) {
	ds_map_destroy(menuButtonCoordinates); menuButtonCoordinates = -1;
}
if inv != noone && inv != undefined && ds_exists(inv,ds_type_list) {
	ds_list_destroy(inv); inv = -1;
}