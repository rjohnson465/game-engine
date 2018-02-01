var leftHandItem = ds_map_find_value(equippedLimbItems,"l");
var rightHandItem = ds_map_find_value(equippedLimbItems,"r");
var leftHandItem2 = ds_map_find_value(equippedLimbItems,"l2");
var rightHandItem2 = ds_map_find_value(equippedLimbItems,"r2");

// switch weapon sets
if	(state == CombatantStates.Idle || state == CombatantStates.Moving) &&
	rightHandItem2 {
	isShielding = false;
	var tempR = rightHandItem;
	ds_map_replace(equippedItems,EquipmentSlots.RightHand1,rightHandItem2);
	ds_map_replace(equippedItems,EquipmentSlots.RightHand2,tempR);
	var tempL = leftHandItem;
	ds_map_replace(equippedItems,EquipmentSlots.LeftHand1,leftHandItem2);
	ds_map_replace(equippedItems,EquipmentSlots.LeftHand2,tempL);
} 