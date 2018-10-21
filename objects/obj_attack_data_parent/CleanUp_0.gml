if ds_exists(damages, ds_type_map) {
	ds_map_destroy(damages); damages = -1;
}

if ds_exists(conditionsChances, ds_type_map) {
	ds_map_destroy(conditionsChances); conditionsChances = -1;
}