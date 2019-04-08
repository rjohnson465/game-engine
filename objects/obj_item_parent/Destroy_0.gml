if ds_exists(socketedGems,ds_type_list) {
	for (var i = 0; i < ds_list_size(socketedGems); i++) {
		var gem = ds_list_find_value(socketedGems,i);
		instance_destroy(gem,1);
	}
	ds_list_destroy(socketedGems); socketedGems = -1;
}

if ds_exists(itemProperties,ds_type_map) {
	ds_map_destroy(itemProperties); itemProperties = -1;
}
if ds_exists(itemPropertyModifiers,ds_type_map) {
	ds_map_destroy(itemPropertyModifiers); itemPropertyModifiers = -1;
}
if ds_exists(itemPropertyModifiersPts,ds_type_map) {
	ds_map_destroy(itemPropertyModifiersPts); itemPropertyModifiersPts = -1;
}
if ds_exists(customItemProperties,ds_type_map) {
	ds_map_destroy(customItemProperties); customItemProperties = -1;
}