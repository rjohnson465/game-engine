 if !isActive || !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

if isSelectorInEquippedItems() {
	moveSelectorInEquippedItems("down");
	eq.selectedItem = getItemAtSelectorPosition(id);
}

else if isSelectorInInventory {
	
	// if we're not at the lowest row in inventory, move down
	// AND there is an item at the resultant row / column
	if y1 < inv.invTopLeftY+(3*inv.slotHeight) {
		var origX = x1;
		var origY = y1;
		y1 += inv.slotHeight;
		if getItemAtSelectorPosition(id) {
			inv.selectedItem = getItemAtSelectorPosition(id);
		} else {
			do {
				x1 -= inv.slotWidth;
				//y1 -= inv.slotHeight;
			} until getItemAtSelectorPosition(id) || x1 <= (MENUS_TOPLEFT_X+inv.slotWidth)+camera_get_view_x(view_camera[0]);
			//y1 -= inv.slotHeight;
			if getItemAtSelectorPosition(id) == noone {
				x1 = origX; y1 = origY;
			}
		}
	}
	
	// are there more items than shown?
	else {
		if !is_undefined(ds_list_find_value(global.player.inventory, 20 + (5*inv.scrollLevel))) {
			inv.scrollLevel++;
		}
	}
}