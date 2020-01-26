if ds_exists(associatedBridges, ds_type_list) {
	ds_list_destroy(associatedBridges); associatedBridges = -1;
}

if ds_exists(deactivateBridges, ds_type_list) {
	ds_list_destroy(deactivateBridges); deactivateBridges = -1;
}