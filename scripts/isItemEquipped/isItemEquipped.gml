/// isItemEquipped(item)
/// @param item

var item = argument[0];

/*var s = item.equipmentSlot;

if  getItemInEquipmentSlot(s) == noone 
	|| (s == EquipmentSlots.LeftHand1 || s == EquipmentSlots.LeftHand2 
	|| s == EquipmentSlots.RightHand1 || s == EquipmentSlots.RightHand2) {
		return false;
	}
	
return true;*/
return item.equipmentSlot != noone;