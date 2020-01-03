if status != ExerciseStepStatus.InProgress exit;

if inventoryContainsItem(obj_item_health_flask) {
	status = ExerciseStepStatus.Completed;
}


