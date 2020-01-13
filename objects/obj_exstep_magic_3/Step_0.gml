if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

if getItemInEquipmentSlot(EquipmentSlots.RightHand1).object_index == obj_hand_item_wand {
	status = ExerciseStepStatus.Completed;
}


