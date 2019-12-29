if status != ExerciseStepStatus.InProgress exit;

if global.ui.isShowingMenus {
	with exercise {
		doNotShowParticles = true;
	}
} else {
	exercise.doNotShowParticles = false;
}

var shieldEquippedInSet1 = false;
if	getItemInEquipmentSlot(EquipmentSlots.RightHand1).object_index == obj_hand_item_woodshield {	
	shieldEquippedInSet1 = true;
}

if shieldEquippedInSet1 && !global.ui.isShowingMenus {
	status = ExerciseStepStatus.Completed;
}


