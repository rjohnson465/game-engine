/// @description Insert description here
// You can write your code in this editor

// reformat description
if description == "Sample description" {
	description = "Apply " + string(gemWeaponBonusMin) + "-" + string(gemWeaponBonusMax) + " " + element + " damage to left hand weapon for " + string(duration / 30) + " seconds.";
}

// Inherit the parent event

// do not allow usage if no weapon in left hand
var leftHandItem = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
if isInUse {
	if leftHandItem.object_index == obj_hand_item_unarmed {
		alert("No left hand weapon equipped",c_red);
		isInUse = false;
		exit;
	}
}

// also, only allow one bonus at a time
if isInUse && ds_list_size(leftHandItem.temporaryDamages) == 1 {
	alert("Only one gem piece bonus can be applied at once", c_red); 
	isInUse = false;
	exit;
}

event_inherited();

var p = global.player;
if isInUse {
	
	var entry = [element, duration, [gemWeaponBonusMin, gemWeaponBonusMax]];
	applyTemporaryDamageBonus(leftHandItem, entry);
	
	isInUse = false;
}