var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}


if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY {
	isConfirmingDestroyItem = false;
	exit;
}

isScrollUpPressed = false;
isScrollDownPressed = false;
pressedFilter = noone;

if mouse_check_button(mb_left) {

	// cycle through buttons and see if we've pressed on a button
	var currentButton = ds_map_find_first(menuButtonCoordinates);
	for (var i = 0; i < ds_map_size(menuButtonCoordinates); i++) {
		var arr = ds_map_find_value(menuButtonCoordinates,currentButton);
		var x1 = arr[0];
		var y1 = arr[1];
		var x2 = arr[2];
		var y2 = arr[3];
	
	
		if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
			switch (currentButton) {
				case "InventoryScrollUp":{
					isScrollUpPressed = true;
					break;
				}
				case "InventoryScrollDown":{
					isScrollDownPressed = true;
					break;
				}
				case InventoryFilters.None: {
					pressedFilter = InventoryFilters.None;
					scrollLevel = 0;
					break;
				}
				case InventoryFilters.Melee: {
					pressedFilter = InventoryFilters.Melee;
					scrollLevel = 0;
					break;
				}
				case InventoryFilters.Ranged: {
					pressedFilter = InventoryFilters.Ranged;
					scrollLevel = 0;
					break;
				}
				case InventoryFilters.Other: {
					pressedFilter = InventoryFilters.Other;
					scrollLevel = 0;
					break;
				}
				case InventoryFilters.Shields: {
					pressedFilter = InventoryFilters.Shields;
					scrollLevel = 0;
					break;
				}
				case InventoryFilters.Rings: {
					pressedFilter = InventoryFilters.Rings;
					scrollLevel = 0;
					break;
				}
				case InventoryFilters.Head: {
					pressedFilter = InventoryFilters.Head;
					scrollLevel = 0;
					break;
				}
			}
		}
	
		currentButton = ds_map_find_next(menuButtonCoordinates,currentButton);
	}
}