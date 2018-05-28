if steps != noone && steps != undefined && ds_exists(steps,ds_type_list) {
	for (var i = 0; i < ds_list_size(steps); i++) {
		var step = ds_list_find_value(steps,i);
		instance_destroy(step,1);
	}
	ds_list_destroy(steps);
}

if rewardItems != noone && rewardItems != undefined && ds_exists(rewardItems,ds_type_list) {
	for (var i = 0; i < ds_list_size(rewardItems); i++) {
		var ri = ds_list_find_value(rewardItems,i);
		instance_destroy(ri,1);
	}
}