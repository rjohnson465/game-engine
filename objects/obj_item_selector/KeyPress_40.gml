if !isActive || !ui.isShowingMenus exit;

if isSelectorInEquippedItems() {
	moveSelectorInEquippedItems("down");
	eq.selectedItem = getItemAtSelectorPosition(id);
}

else if isSelectorInInventory {
	
	// if we're not at the lowest row in inventory, move down
	// AND there is an item at the resultant row / column
	/*var proposedX = x1;
	var proposedY = y1 + inv.slotHeight;
	var itemAtProposedLoc = noone;
	with obj_item_parent {
		
	}*/
	if y1 < inv.invTopLeftY+(3*inv.slotHeight) {
		
		y1 += inv.slotHeight;
		if getItemAtSelectorPosition(id) {
			inv.selectedItem = getItemAtSelectorPosition(id);
		} else y1 -= inv.slotHeight;
	}
	
	// are there more items than shown?
	else {
		if !is_undefined(ds_list_find_value(global.player.inventory, 19 + (5*inv.scrollLevel))) {
			inv.scrollLevel++;
		}
	}
}