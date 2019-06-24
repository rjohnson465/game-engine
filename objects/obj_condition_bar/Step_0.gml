var conditionPercent = ds_map_find_value(owner.conditionPercentages,condition);
var buildupPercent = ds_map_find_value(owner.conditionsBuildupMap,condition);
if conditionPercent <= 0 && buildupPercent <= 0 {
	global.conditionBarCount--;
	var barNum = conditionBarNumber;
	with (obj_condition_bar) {
		if conditionBarNumber > barNum {
			conditionBarNumber--;
		}
	}
	instance_destroy(id,false);
}