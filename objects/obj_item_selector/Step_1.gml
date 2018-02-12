if isActive && isSelectorInInventory {
	inv.selectedItem = getItemAtSelectorPosition(id);
}

/*if	isSelectorInInventory && isActive 
	&& (inv.selectedItem != getItemAtSelectorPosition(id) || getItemAtSelectorPosition(id) == noone) {
	
	// if this item is not null, make it the selected one
	if getItemAtSelectorPosition(id) != noone {
		inv.selectedItem = getItemAtSelectorPosition(id);
	} else {
		// if it is, find the last item in the inventory, set the selector position to that, and set selected item to that
		var lastItemInInventory = ds_list_find_value(global.player.inventory,ds_list_size(global.player.inventory)-1);
		x1 = lastItemInInventory.x1;
		y1 = lastItemInInventory.y1;
		inv.selectedItem = getItemAtSelectorPosition(id);
	}
}