isShowingMenus = !isShowingMenus;
currentMenu = INVENTORY;
if isShowingMenus {
} else {
	var inv = global.player.inventory;
	for (var i = 0; i < ds_list_size(inv); i++) {
		var el = ds_list_find_value(inv,i);
		el.x1 = -50;
		el.y1 = -50;
	}
}

cursor_sprite = -1;