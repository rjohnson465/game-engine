ds_map_destroy(menuButtonCoordinates);
if inv != noone && inv != undefined && ds_exists(inv,ds_type_list) {
	ds_list_destroy(inv);
}