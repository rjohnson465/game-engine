/// @description Insert description here
// You can write your code in this editor

// Inherit the parent event
event_inherited();

var p = global.player;
if isInUse {
	
	with p {
		
		var rhItem1 = getItemInEquipmentSlot(EquipmentSlots.RightHand1);
		var rhItem2 = getItemInEquipmentSlot(EquipmentSlots.RightHand2);
		var lhItem1 = getItemInEquipmentSlot(EquipmentSlots.LeftHand1);
		var lhItem2 = getItemInEquipmentSlot(EquipmentSlots.LeftHand2);
		
		var items = [ rhItem1, rhItem2, lhItem1, lhItem2];
		
		// retore all magic charges
		for (var i = 0; i < array_length_1d(items); i++) {
			var it = items[i];
			if variable_instance_exists(it, "chargesMax") && it.chargesMax >= 0 {
				it.charges = it.chargesMax;
			}
		}
		
		// get rid of all temp xp
		xpTemp = 0;
	}
	
	isInUse = false;
}