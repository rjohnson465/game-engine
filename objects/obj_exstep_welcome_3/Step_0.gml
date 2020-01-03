if status != ExerciseStepStatus.InProgress exit;

// This step is done when player equips weapon
var itemIsEquipped = false;

if	getItemInEquipmentSlot(EquipmentSlots.LeftHand1) != global.player.unarmed {
		itemIsEquipped = true;
	}

if itemIsEquipped && !global.ui.isShowingMenus {
	status = ExerciseStepStatus.Completed;
}

