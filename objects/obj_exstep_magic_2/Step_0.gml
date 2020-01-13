if status != ExerciseStepStatus.InProgress exit;

if	(getItemInEquipmentSlot(EquipmentSlots.RightHand1).object_index == obj_hand_item_wand || getItemInEquipmentSlot(EquipmentSlots.RightHand2).object_index == obj_hand_item_wand)
	&& !global.ui.isShowingMenus {
	status = ExerciseStepStatus.Completed;
}


