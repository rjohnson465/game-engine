/// equipItem(item,slot)
/// @param item
/// @param slot

var item = argument[0];
var slot = argument[1];

// Pre-Condition -- this item is able to to in this slot

// remove item from inventory
var inv = global.player.inventory;
ds_list_delete(inv,ds_list_find_index(inv,item));

// set equipmentSlot property for item and add it to equippedItems list
var equippedItems = global.player.equippedItems;
ds_list_add(equippedItems,item);
item.equipmentSlot = slot;

// set x1 and y1 values for newly equipped item
var equipmentSlotObj = getEquipmentSlotObject(slot);
item.x1 = equipmentSlotObj.x;
item.y1 = equipmentSlotObj.y;

// set equippedLimbItem if slot was LeftHand1 or RightHand1
if slot == EquipmentSlots.LeftHand1 {
	ds_map_replace(global.player.equippedLimbItems, "l", item);
} else if slot == EquipmentSlots.RightHand1 {
	ds_map_replace(global.player.equippedLimbItems, "r", item);
}
