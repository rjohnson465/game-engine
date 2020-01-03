if status != ExerciseStepStatus.InProgress exit;

var hf = instance_nearest(x, y, obj_item_health_flask);
var chargesCount = ds_map_find_value(hf.customItemProperties, hfs_charges);
if instance_exists(hf) && chargesCount > 0 {
	status = ExerciseStepStatus.Completed;
}


