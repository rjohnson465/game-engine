if questSteps != noone && questSteps != undefined && ds_exists(questSteps,ds_type_list) {
	for (var i = 0; i < ds_list_size(questSteps); i++) {
		var step = ds_list_find_value(questSteps,i);
		instance_destroy(step,1);
	}
	ds_list_destroy(questSteps); questSteps = -1;
}

if rewardItems != noone && rewardItems != undefined && ds_exists(rewardItems,ds_type_list) {
	for (var i = 0; i < ds_list_size(rewardItems); i++) {
		var ri = ds_list_find_value(rewardItems,i);
		instance_destroy(ri,1);
	}
}