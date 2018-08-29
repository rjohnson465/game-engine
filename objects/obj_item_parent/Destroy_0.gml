if ds_exists(socketedGems,ds_type_list) && ds_list_size(socketedGems) > 0 {
	for (var i = 0; i < ds_list_size(socketedGems); i++) {
		var gem = ds_list_find_value(socketedGems,i);
		instance_destroy(gem,1);
	}
	ds_list_destroy(socketedGems); socketedGems = -1;
}

if ds_exists(itemProperties,ds_type_list) {
	ds_list_destroy(itemProperties); itemProperties = -1;
}
if ds_exists(itemPropertyModifiers,ds_type_list) {
	ds_list_destroy(itemPropertyModifiers); itemPropertyModifiers = -1;
}
if ds_exists(itemPropertyModifiersPts,ds_type_list) {
	ds_list_destroy(itemPropertyModifiersPts); itemPropertyModifiersPts = -1;
}