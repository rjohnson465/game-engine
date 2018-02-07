var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if !isShowingMenus exit;

// cycle through buttons and see if we've clicked on one
var currentButton = ds_map_find_first(menuButtonCoordinates);
for (var i = 0; i < ds_map_size(menuButtonCoordinates); i++) {
	var arr = ds_map_find_value(menuButtonCoordinates,currentButton);
	var x1 = arr[0];
	var y1 = arr[1];
	var x2 = arr[2];
	var y2 = arr[3];
	
	
	
	//if mouse_x > vx + x1 && mouse_y > vy + y1 && mouse_x < vx + x2 && mouse_y < vy + y2 {
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
		switch (currentButton) {
			case "closeButton": {
				isShowingMenus = false;
				break;
			}
			case INVENTORY: {
				currentMenu = INVENTORY;
				break;
			}
			case SKILLS: {
				currentMenu = SKILLS;
				break;
			}
			case OPTIONS: {
				currentMenu = OPTIONS;
				break;
			}
		}
	}
	
	currentButton = ds_map_find_next(menuButtonCoordinates,currentButton);
}

/*
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