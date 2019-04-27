if ds_exists(menuButtonCoordinates,ds_type_map) {
	ds_map_destroy(menuButtonCoordinates); menuButtonCoordinates = -1;
}
if ds_exists(allPriceIncrements,ds_type_list) {
	ds_list_destroy(allPriceIncrements); allPriceIncrements = -1;
}