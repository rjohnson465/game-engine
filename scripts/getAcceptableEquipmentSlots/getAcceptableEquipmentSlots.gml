/// getAcceptableEquipmentSlots(item)
/// @param item

var item = argument0;

if !instance_exists(item) return [];

switch item.type {

	case ItemTypes.HandItem: {
		// 2H -- always left hand
		if item.isTwoHanded {
			return [EquipmentSlots.LeftHand1, EquipmentSlots.LeftHand2];
		}
		// shield -- always in right hand
		else if item.subType == HandItemTypes.Shield {
			return [EquipmentSlots.RightHand1, EquipmentSlots.RightHand2];
		}
		// torch -- always in right hand
		else if item.object_index == obj_hand_item_torch {
			return [EquipmentSlots.RightHand1, EquipmentSlots.RightHand2];
		}
		// else, general hand item, can go in any hand
		else return [EquipmentSlots.LeftHand1, EquipmentSlots.LeftHand2, 
		EquipmentSlots.RightHand1, EquipmentSlots.RightHand2];
		
		break;
	}
	case ItemTypes.Ring: {
		return [EquipmentSlots.LeftRing1,EquipmentSlots.RightRing1,EquipmentSlots.LeftRing2,EquipmentSlots.RightRing2];
		break;
	}
	case ItemTypes.Head: {
		return [EquipmentSlots.Head]; break;
	}
	case ItemTypes.Other: {
		if item.isUsable {
			return [
				EquipmentSlots.BeltItem1,
				EquipmentSlots.BeltItem2,
				EquipmentSlots.BeltItem3,
				EquipmentSlots.BeltItem4,
				EquipmentSlots.BeltItem5,
			];
		}
	}

}