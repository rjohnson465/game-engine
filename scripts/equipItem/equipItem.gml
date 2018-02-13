/// equipItem(item,slot)
/// @param item
/// @param slot

// Pre-Condition -- this item is able to to in this slot

var itemOriginal = argument[0];
var slot = argument[1];

var item  = noone;

// itemOriginal might actually be the copy; CHECK
if itemOriginal.copyOf != noone {
	var temp = itemOriginal;
	itemOriginal = itemOriginal.copyOf;
	item = temp;
}
else {
	// see if there is already an "equipped" copy of item
	for (var i = 0; i < ds_list_size(global.player.equippedItems); i++) {
		var el = ds_list_find_value(global.player.equippedItems,i);
		if el.copyOf == itemOriginal {
			item = el;
		}
	}

	if item == noone {
		with itemOriginal {
			item = instance_copy(false);
			item.copyOf = itemOriginal;
		}
	}
}



// set equipmentSlot property for item and add it to equippedItems list
var equippedItems = global.player.equippedItems;
ds_list_add(equippedItems,item);
ds_list_add(equippedItems,itemOriginal);
item.equipmentSlot = slot;
itemOriginal.equipmentSlot = slot;

// set x1 and y1 values for newly equipped item
var equipmentSlotObj = getEquipmentSlotObject(slot);
item.x1 = equipmentSlotObj.x1;
item.y1 = equipmentSlotObj.y1;

// set equippedLimbItem if slot was LeftHand1 or RightHand1
if slot == EquipmentSlots.LeftHand1 {
	ds_map_replace(global.player.equippedLimbItems, "l", item);
} else if slot == EquipmentSlots.RightHand1 {
	ds_map_replace(global.player.equippedLimbItems, "r", item);
}

// if this was the inventory selected item, its not anymore
if global.inventory.selectedItem == item {
	global.inventory.selectedItem = noone;
}
