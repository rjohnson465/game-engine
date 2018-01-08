var conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
if conditionPercent <= 0 {
	global.conditionBarCount--;
	var barNum = conditionBarNumber;
	with (obj_condition_bar) {
		if conditionBarNumber > barNum {
			conditionBarNumber--;
		}
	}
	instance_destroy(id,false);
}