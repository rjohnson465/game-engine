isShowingMenus = !isShowingMenus;
currentMenu = INVENTORY;
if isShowingMenus {
	// move any items that are equipped to their slots
	var equippedItems = global.player.equippedItems;
	for (var i = 0; i < ds_list_size(equippedItems); i++) {
		var equippedItem = ds_list_find_value(equippedItems,i);
		var equippedItemSlot = equippedItem.equipmentSlot;
		var slotObj = getEquipmentSlotObject(equippedItemSlot);
		
		equippedItem.x1 = slotObj.x;
		equippedItem.y1 = slotObj.y;
	}
} 

cursor_sprite = -1;