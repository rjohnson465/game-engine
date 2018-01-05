// switch weapon sets
if	(state == CombatantStates.Idle || state == CombatantStates.Moving) &&
	rightHandItem2 {
	isShielding = false;
	var tempR = rightHandItem;
	ds_map_replace(equippedItems,EquipmentSlots.RightHand1,rightHandItem2);
	//rightHandItem = rightHandItem2;
	ds_map_replace(equippedItems,EquipmentSlots.RightHand2,tempR);
	//rightHandItem2 = tempR;
	var tempL = leftHandItem;
	ds_map_replace(equippedItems,EquipmentSlots.LeftHand1,leftHandItem2);
	//leftHandItem = leftHandItem2;
	ds_map_replace(equippedItems,EquipmentSlots.LeftHand2,tempL);
	//leftHandItem2 = tempL;
} 