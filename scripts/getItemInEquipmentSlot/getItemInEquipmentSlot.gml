/// getItemInEquipmentSlot(slotEnumVal)
/// @param slotEnumVal

var s = argument[0];
/*
with obj_item_parent {
	if equipmentSlot == s && copyOf != noone {
		return id;
	}
}
*/
var ei = global.player.equippedItems;
for (var i = 0; i < ds_list_size(ei); i++) {
	var item = ds_list_find_value(ei,i);
	if item.equipmentSlot == s {
		return item;
	}
}

if	s == EquipmentSlots.LeftHand1 || s == EquipmentSlots.LeftHand2 
	|| s == EquipmentSlots.RightHand1 || s == EquipmentSlots.RightHand2 {
		return global.player.unarmed;
	}

return noone;