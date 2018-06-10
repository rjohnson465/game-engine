if ds_exists(socketedGems,ds_type_list) && ds_list_size(socketedGems) > 0 {
	for (var i = 0; i < ds_list_size(socketedGems); i++) {
		var gem = ds_list_find_value(socketedGems,i);
		instance_destroy(gem,1);
	}
}