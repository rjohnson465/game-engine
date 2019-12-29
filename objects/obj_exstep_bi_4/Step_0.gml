if status != ExerciseStepStatus.InProgress exit;

if !inventoryContainsItem(obj_item_healthshard) {
	status = ExerciseStepStatus.Completed;
}


