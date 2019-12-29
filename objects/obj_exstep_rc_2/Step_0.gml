if status != ExerciseStepStatus.InProgress exit;

if getItemInEquipmentSlot(EquipmentSlots.LeftHand2).object_index == obj_hand_item_shortbow && !global.ui.isShowingMenus {
	status = ExerciseStepStatus.Completed;
}


