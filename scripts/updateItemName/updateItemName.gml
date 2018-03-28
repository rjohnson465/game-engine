/// updateItemName(item)
/// @param item
/// update item name based on its stats and/or itemProperties map

var item = argument[0];

switch item.type {
	case ItemTypes.HandItem: {
		if item.subType != HandItemTypes.Shield {
			updateWeaponName(item);
			break;
		} else {
		}
		break;
	}
	case ItemTypes.Ring: {
		break;
	}
	case ItemTypes.Head: {
	}
}