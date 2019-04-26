if ds_exists(steps, ds_type_list) {
	for (var i = 0; i < ds_list_size(steps); i++) {
		var step = ds_list_find_value(steps,i);
		if instance_exists(step) {
			instance_destroy(step,1);
		}
	}


	ds_list_destroy(steps); steps = -1;
}