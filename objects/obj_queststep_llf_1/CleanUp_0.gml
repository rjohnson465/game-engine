if ds_exists(eventListeners, ds_type_map) {
	ds_map_destroy(eventListeners); eventListeners = -1;
}