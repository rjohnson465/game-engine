/// unequipItem(item)
/// @param item

var item = argument[0];

// make sure item is the "copy" item
if item.copyOf == noone {
	for (var i = 0; i < ds_list_size(global.player.equippedItems);i++) {
		var el = ds_list_find_value(global.player.equippedItems,i);
		if el.copyOf == item {
			item = el;
		}
	}
}

// need to do this for player limb (hand) / weapon refresh
if item.equipmentSlot == EquipmentSlots.LeftHand1 {
	ds_map_replace(global.player.equippedLimbItems,"l",global.player.unarmed);
} else if item.equipmentSlot == EquipmentSlots.RightHand1 {
	ds_map_replace(global.player.equippedLimbItems,"r",global.player.unarmed);
}
			
// remove this item from player's equipped items list
if item.type == ItemTypes.HandItem && item.weaponType == UNARMED {
} else {
	ds_list_delete(global.player.equippedItems,ds_list_find_index(global.player.equippedItems,item));
	//ds_list_delete(global.player.inventory,ds_list_find_index(global.player.inventory,item));
	item.equipmentSlot = noone;
	
	// unequip original item (still in inventory)
	if item.copyOf != noone {
		ds_list_delete(global.player.equippedItems,ds_list_find_index(global.player.equippedItems,item.copyOf));
		item.copyOf.equipmentSlot = noone;
	}
	
}

//instance_destroy(item,false);

// add this item back to player inventory
//ds_list_add(global.player.inventory,item);
