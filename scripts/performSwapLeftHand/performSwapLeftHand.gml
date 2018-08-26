/// performSwapRightHand	

if global.isWishing exit;
if global.isInteractingWithNpc exit;
if scr_is_fading() exit;

var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
var rightHandItem = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
var leftHandItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
var rightHandItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);

// switch weapon sets
if	(state == CombatantStates.Idle || state == CombatantStates.Moving)  {
	isShielding = false;
	comboNumber = 0;
	comboEffectiveNumber = 0;
	// new combo hits to next level dependent on weapon in main hand
	var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
	comboHitsToNextLevel = ds_map_find_value(comboHitsToNextLevelMap,leftHandItem.weaponType);
	
	// base case: current left hand item is one handed and backup left hand item is one handed
	if !leftHandItem.isTwoHanded && !leftHandItem2.isTwoHanded {
		ds_map_replace(equippedLimbItems,"l",leftHandItem2);
		ds_map_replace(equippedLimbItems,"l2",leftHandItem);
		if leftHandItem unequipItem(leftHandItem);
		if leftHandItem2 unequipItem(leftHandItem2);
		if leftHandItem equipItem(leftHandItem,EquipmentSlots.LeftHand2);
		if leftHandItem2 equipItem(leftHandItem2,EquipmentSlots.LeftHand1);
	}
	
	
	// case: left hand item is 2h
	if leftHandItem.isTwoHanded || leftHandItem2.isTwoHanded {
		ds_map_replace(equippedLimbItems,"r",rightHandItem2);
		ds_map_replace(equippedLimbItems,"r2",rightHandItem);
		ds_map_replace(equippedLimbItems,"l",leftHandItem2);
		ds_map_replace(equippedLimbItems,"l2",leftHandItem);
		if leftHandItem unequipItem(leftHandItem);
		if leftHandItem2 unequipItem(leftHandItem2);
		if leftHandItem equipItem(leftHandItem,EquipmentSlots.LeftHand2);
		if leftHandItem2 equipItem(leftHandItem2,EquipmentSlots.LeftHand1);
		if rightHandItem unequipItem(rightHandItem);
		if rightHandItem2 unequipItem(rightHandItem2);
		if rightHandItem equipItem(rightHandItem,EquipmentSlots.RightHand2);
		if rightHandItem2 equipItem(rightHandItem2,EquipmentSlots.RightHand1);
	}
	
	audio_play_sound(snd_item_pickup,1,0);
	
} 