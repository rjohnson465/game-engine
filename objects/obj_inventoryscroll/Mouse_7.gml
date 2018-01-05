if scrollDirection == "up" && global.ui.inventoryScrollLevel != 0 {
	global.ui.inventoryScrollLevel --;
} else if scrollDirection == "down" {
	var inv = global.player.inventory;
	// do not keep scrolling down if last shown row contains last item in player inventory
	if !is_undefined(ds_list_find_value(inv, 19 + (5*global.ui.inventoryScrollLevel))) {
		global.ui.inventoryScrollLevel++;
	}
	
}