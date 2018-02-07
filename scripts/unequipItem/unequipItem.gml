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
ds_list_delete(global.player.equippedItems,ds_list_find_index(global.player.equippedItems,item));
// set the equipmentSlot property to noone
item.equipmentSlot = noone;
			
// add this item back to player inventory
ds_list_add(global.player.inventory,item);