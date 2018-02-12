/// isSelectorAtFirstInventoryColumn()
// must be called by an instance of selector
//with obj_item_selector {
	// true if in last column or last item in inventory
	var lastItemInInventory = ds_list_find_value(global.player.inventory,ds_list_size(global.player.inventory)-1);
	return	x1 == global.inventory.invTopLeftX+(4*global.inventory.slotWidth)
			|| (lastItemInInventory.x1 == x1 && lastItemInInventory.y1 == y1) ;
//}
