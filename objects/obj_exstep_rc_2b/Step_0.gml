if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

if getItemInEquipmentSlot(EquipmentSlots.LeftHand1).object_index == obj_hand_item_shortbow {
	status = ExerciseStepStatus.Completed;
}


