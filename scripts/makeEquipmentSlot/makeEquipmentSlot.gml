/// makeItemSlot(slot,x,y)
/// @param slot
/// @param x
/// @param y

global.equipmentSlot = argument[0];
global.x1 = argument[1];
global.y1 = argument[2];

// construct relational data for each slot
switch (global.equipmentSlot) {
	case EquipmentSlots.Head: {
		global.up = noone;
		global.down = EquipmentSlots.LeftHand1;
		global.left = EquipmentSlots.RightHand1;
		global.right = EquipmentSlots.LeftHand2;
		break;
	}
	case EquipmentSlots.LeftHand1: {
		global.up = EquipmentSlots.Head;
		global.down = EquipmentSlots.LeftRing1;
		global.left = "inventory";
		global.right = EquipmentSlots.RightHand1;
		break;
	}
	case EquipmentSlots.RightHand1: {
		global.up = EquipmentSlots.Head;
		global.down = EquipmentSlots.LeftRing1;
		global.left = EquipmentSlots.LeftHand1;
		global.right = EquipmentSlots.LeftHand2;
		break;
	}
	case EquipmentSlots.LeftHand2: {
		global.up = EquipmentSlots.Head;
		global.down = EquipmentSlots.RightRing1;
		global.left = EquipmentSlots.RightHand1;
		global.right = EquipmentSlots.RightHand2;
		break;
	}
	case EquipmentSlots.RightHand2: {
		global.up = EquipmentSlots.Head;
		global.down = EquipmentSlots.RightRing1;
		global.left = EquipmentSlots.LeftHand2;
		global.right = noone;
		break;
	}
	case EquipmentSlots.LeftRing1: {
		global.up = EquipmentSlots.LeftHand1;
		global.down = EquipmentSlots.LeftRing2;
		global.left = "inventory";
		global.right = EquipmentSlots.RightRing1;
		break;
	}
	case EquipmentSlots.LeftRing2: {
		global.up = EquipmentSlots.LeftRing1;
		global.down = noone;
		global.left = "inventory";
		global.right = EquipmentSlots.RightRing2;
		break;
	}
	case EquipmentSlots.RightRing1: {
		global.up = EquipmentSlots.LeftHand2;
		global.down = EquipmentSlots.RightRing2;
		global.left = EquipmentSlots.LeftRing1;
		global.right = noone;
		break;
	}
	case EquipmentSlots.RightRing2: {
		global.up = EquipmentSlots.RightRing1;
		global.down = noone;
		global.left = EquipmentSlots.LeftRing2;
		global.right = noone;
		break;
	}
}

instance_create_depth(global.x1,global.y1,1,obj_equipmentslot);