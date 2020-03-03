if ds_exists(parameters,ds_type_map) {
	ds_map_destroy(parameters); parameters = -1;
}

if variable_instance_exists(id, "eventListeners") && ds_exists(eventListeners, ds_type_map) {
	ds_map_destroy(eventListeners); eventListeners = -1;
}