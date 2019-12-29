if status != ExerciseStepStatus.InProgress exit;

// This step is done when player equips weapon
var itemIsEquipped = false;

if	getItemInEquipmentSlot(EquipmentSlots.LeftHand1) != global.player.unarmed ||
	getItemInEquipmentSlot(EquipmentSlots.LeftHand2) != global.player.unarmed ||
	getItemInEquipmentSlot(EquipmentSlots.RightHand1) != global.player.unarmed ||
	getItemInEquipmentSlot(EquipmentSlots.RightHand2) != global.player.unarmed  {
		itemIsEquipped = true;
	}

if itemIsEquipped && !global.ui.isShowingMenus {
	status = ExerciseStepStatus.Completed;
}

