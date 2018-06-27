if (!global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY) && !global.isTrading exit;
if isUsable && !global.isTrading {
	alert("Used " + name,c_yellow);
	isInUse = true;
	audio_play_sound(soundUse,1,0);
}

if global.isTrading && isSellable {
	var playerItemsObj = obj_player_items;
	var vendorItemsObj = obj_vendor_items;
	if !playerItemsObj.isConfirming || !vendorItemsObj.isConfirming {
		// if item in inventory, it's the selectedItem of obj_player_items
		if ds_list_find_index(global.player.inventory,id) != -1 {
			playerItemsObj.selectedItem = id;
			playerItemsObj.isConfirming = true;
		} else {
			vendorItemsObj.selectedItem = id;
			vendorItemsObj.isConfirming = true;
		}
	}
}