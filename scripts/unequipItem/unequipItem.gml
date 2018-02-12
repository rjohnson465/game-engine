/// unequipItem(item)
/// @param item

var item = argument[0];

// need to do this for player limb (hand) / weapon refresh
if item.equipmentSlot == EquipmentSlots.LeftHand1 {
	ds_map_replace(global.player.equippedLimbItems,"l",global.player.unarmed);
} else if item.equipmentSlot == EquipmentSlots.RightHand1 {
	ds_map_replace(global.player.equippedLimbItems,"r",global.player.unarmed);
}
			
// remove this item from player's equipped items list
if item.type == ItemTypes.HandItem && item.weaponType == WeaponTypes.Unarmed {
} else {
	ds_list_delete(global.player.equippedItems,ds_list_find_index(global.player.equippedItems,item));
	
	
	// unequip original item (still in inventory)
	if item.copyOf != noone {
		item.copyOf.equipmentSlot = noone;
	}
	// destroy copy item
	//instance_destroy(item);
	//item.equipmentSlot = noone;
}
			
// add this item back to player inventory
//ds_list_add(global.player.inventory,item);
