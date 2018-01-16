var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

// clicked on x button
if	mouse_x > vx + 892 && mouse_y > vy + 134 && mouse_x < vx + 912 && mouse_y < vy + 154 {
	isShowingMenus = false;
	instance_deactivate_object(obj_menucategory);
	instance_deactivate_object(obj_inventoryscroll);
	var inv = global.player.inventory;
	for (var i = 0; i < ds_list_size(inv); i++) {
		var el = ds_list_find_value(inv,i);
		el.x1 = -50;
		el.y1 = -50;
	}
}

// clicked on none filter
if	mouse_x > vx + 212 && mouse_y > vy + 154 && mouse_x < vx + 242 && mouse_y < vy + 184 {
	inventoryFilter = InventoryFilters.None;
}

// melee filter
if	mouse_x > vx + 242 && mouse_y > vy + 154 && mouse_x < vx + 272 && mouse_y < vy + 184 {
	inventoryFilter = InventoryFilters.Melee;
}

// ranged filter
if	mouse_x > vx + 272 && mouse_y > vy + 154 && mouse_x < vx + 302 && mouse_y < vy + 184 {
	inventoryFilter = InventoryFilters.Ranged;
}

// shields filter
if	mouse_x > vx + 302 && mouse_y > vy + 154 && mouse_x < vx + 332 && mouse_y < vy + 184 {
	inventoryFilter = InventoryFilters.Shields;
}

// magic filter
if	mouse_x > vx + 332 && mouse_y > vy + 154 && mouse_x < vx + 362 && mouse_y < vy + 184 {
	inventoryFilter = InventoryFilters.Magic;
}