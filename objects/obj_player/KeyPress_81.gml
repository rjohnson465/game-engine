/*var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var leftHandItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
var rightHandItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);

// switch weapon sets
if	(state == CombatantStates.Idle || state == CombatantStates.Moving)  {
	
	ds_map_replace(equippedLimbItems,"l",leftHandItem2);
	ds_map_replace(equippedLimbItems,"l2",leftHandItem);
	ds_map_replace(equippedLimbItems,"r",rightHandItem2);
	ds_map_replace(equippedLimbItems,"r2",rightHandItem);
	
	isShielding = false;
	if leftHandItem unequipItem(leftHandItem);
	if leftHandItem2 unequipItem(leftHandItem2);
	if leftHandItem equipItem(leftHandItem,EquipmentSlots.LeftHand2);
	if leftHandItem2 equipItem(leftHandItem2,EquipmentSlots.LeftHand1);
	if rightHandItem unequipItem(rightHandItem);
	if rightHandItem2 unequipItem(rightHandItem2);
	if rightHandItem equipItem(rightHandItem,EquipmentSlots.RightHand2);
	if rightHandItem2 equipItem(rightHandItem2,EquipmentSlots.RightHand1);
} 