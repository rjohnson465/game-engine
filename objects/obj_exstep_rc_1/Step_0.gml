if status != ExerciseStepStatus.InProgress exit;

if inventoryContainsItem(obj_hand_item_shortbow) {
	status = ExerciseStepStatus.Completed;
}


