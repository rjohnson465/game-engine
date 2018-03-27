/// getAcceptableEquipmentSlots(item)
/// @param item

var item = argument0;

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
		// else, general hand item, can go in any hand
		else return [EquipmentSlots.LeftHand1, EquipmentSlots.LeftHand2, 
		EquipmentSlots.RightHand1, EquipmentSlots.RightHand2];
		
		break;
	}
	case ItemTypes.Ring: {
		return [EquipmentSlots.LeftRing1,EquipmentSlots.LeftRing2,EquipmentSlots.RightRing1,EquipmentSlots.RightRing2];
		break;
	}

}