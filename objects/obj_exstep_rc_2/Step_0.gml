if status != ExerciseStepStatus.InProgress exit;

if getItemInEquipmentSlot(EquipmentSlots.LeftHand1).object_index == obj_hand_item_shortbow {
	status = ExerciseStepStatus.Completed;
}


