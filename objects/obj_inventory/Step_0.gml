var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;

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
					break;
				}
				case InventoryFilters.Melee: {
					pressedFilter = InventoryFilters.Melee;
					break;
				}
				case InventoryFilters.Ranged: {
					pressedFilter = InventoryFilters.Ranged;
					break;
				}
				case InventoryFilters.Magic: {
					pressedFilter = InventoryFilters.Magic;
					break;
				}
				case InventoryFilters.Shields: {
					pressedFilter = InventoryFilters.Shields;
					break;
				}
			}
		}
	
		currentButton = ds_map_find_next(menuButtonCoordinates,currentButton);
	}
}