if ds_exists(persistentElements, ds_type_map) {
	ds_map_destroy(persistentElements); persistentElements = -1;
}
if ds_exists(enemiesData, ds_type_map) {
	ds_map_destroy(enemiesData); enemiesData = -1;
}