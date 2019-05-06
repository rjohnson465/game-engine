if (!global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY) && !global.isTrading exit;
if isUsable && !global.isTrading {
	with global.player {
		useItem(other);
	}
} else if !global.isTrading {
	alert(name + " is not usable", c_yellow);
}

var isRewardSelection = false;
if instance_number(obj_item_reward) > 0 {
	var ir = instance_nearest(x, y, obj_item_reward);
	isRewardSelection = true;
	ir.selectedItem = id;
	ir.isConfirming = true;
	audio_play_sound(snd_ui_click1, 1, 0);
}

if global.isTrading && isSellable && !isRewardSelection {
	var playerItemsObj = obj_player_items;
	var vendorItemsObj = obj_vendor_items;
	if !playerItemsObj.isConfirming && !vendorItemsObj.isConfirming {
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