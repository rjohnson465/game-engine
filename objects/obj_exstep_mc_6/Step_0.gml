if status != ExerciseStepStatus.InProgress exit;

var shieldEquipped = false;
if	getItemInEquipmentSlot(EquipmentSlots.RightHand1).object_index == obj_hand_item_woodshield ||
	getItemInEquipmentSlot(EquipmentSlots.RightHand2).object_index == obj_hand_item_woodshield {
	
		shieldEquipped = true;
	}

if shieldEquipped && !global.ui.isShowingMenus {
	status = ExerciseStepStatus.Completed;
}


