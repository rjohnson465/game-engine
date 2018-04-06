/// getGoldCount()

// find coins object in inventory

for (var i = 0; i < ds_list_size(global.player.inventory); i++) {
	var item = ds_list_find_value(global.player.inventory, i);
	if item.object_index == obj_item_coins {
		return item.count;
	}
}

return 0;