/// appraiseItem(item)
/// @param item
/// how much is this item worth? Sets the "value" property of an item

var item = argument[0];

var value = 0;

switch item.type {
	
	case ItemTypes.Ring: {
		value = appraiseRing(item);
		break;
	}
	
}

item.value = value;