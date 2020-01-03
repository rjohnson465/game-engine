if status != ExerciseStepStatus.InProgress exit;

if global.player.hp != global.player.maxHp * .5 {
	status = ExerciseStepStatus.Completed;
}

var hf = instance_nearest(x, y, obj_item_health_flask);
var chargesCount = ds_map_find_value(hf.customItemProperties, hfs_charges);
if chargesCount == 0 && status == ExerciseStepStatus.InProgress {
	ds_map_replace(hf.customItemProperties, hfs_charges, 1);
}