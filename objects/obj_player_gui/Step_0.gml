var pad = global.player.gamePadIndex;
if gamepad_is_connected(pad) {

	// show menus
	if gamepad_button_check_pressed(pad,gp_start) && !isShowingMenus {
		isShowingMenus = !isShowingMenus;
		currentMenu = INVENTORY;
		if isShowingMenus {
			// move any items that are equipped to their slots
			var equippedItems = global.player.equippedItems;
			for (var i = 0; i < ds_list_size(equippedItems); i++) {
				var equippedItem = ds_list_find_value(equippedItems,i);
				var equippedItemSlot = equippedItem.equipmentSlot;
				var slotObj = getEquipmentSlotObject(equippedItemSlot);
		
				equippedItem.x1 = slotObj.x1;
				equippedItem.y1 = slotObj.y1;
			}
		} 
	} else if gamepad_button_check_pressed(pad,gp_start) && isShowingMenus
		|| (isShowingMenus && gamepad_button_check_pressed(pad,gp_face2) && moveSelector.isActive) {
		isShowingMenus = false;
	}

}