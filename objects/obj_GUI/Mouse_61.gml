if position_meeting(mouse_x,mouse_y,obj_item_parent) && currentMenu == INVENTORY {
	var inv = global.player.inventory;
	// do not keep scrolling down if last shown row contains last item in player inventory
	if !is_undefined(ds_list_find_value(inv, 19 + (5*global.ui.inventoryScrollLevel))) {
		inventoryScrollLevel++;
	}
}