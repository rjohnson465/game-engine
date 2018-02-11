if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

if ds_list_find_index(global.player.inventory,id) != -1 {
	var idd = id;
	with obj_inventory {
		selectedItem = idd;
	}
} else if ds_list_find_index(global.player.equippedItems,id) != -1 {
	var idd = id;
	with obj_equipped_items_manager {
		selectedItem = idd;
	}
}

mightGrab = true;