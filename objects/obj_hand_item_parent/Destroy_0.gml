event_inherited();

if ds_exists(damages,ds_type_map) {
	ds_map_destroy(damages); damages = -1;
}