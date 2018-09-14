if ds_exists(conversationsToAdd, ds_type_list) {
	ds_list_destroy(conversationsToAdd); conversationsToAdd = -1;
}
if ds_exists(conversations, ds_type_map) {
	ds_map_destroy(conversations); conversations = -1;
}