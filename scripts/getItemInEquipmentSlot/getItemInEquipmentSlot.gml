/// getItemInEquipmentSlot(slotEnumVal)
/// @param slotEnumVal

var s = argument[0];

with obj_item_parent {
	if equipmentSlot == s && copyOf != noone {
		return id;
	}
}

if	s == EquipmentSlots.LeftHand1 || s == EquipmentSlots.LeftHand2 
	|| s == EquipmentSlots.RightHand1 || s == EquipmentSlots.RightHand2 {
		return global.player.unarmed;
	}

return noone;