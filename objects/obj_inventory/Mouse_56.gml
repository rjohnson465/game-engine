var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

if !global.ui.isShowingMenus exit;

// cycle through buttons and see if we've clicked on one
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
				if scrollLevel != 0 {
					scrollLevel--;
				}
				break;
			}
			case "InventoryScrollDown":{
				var inv = global.player.inventory;
				if !is_undefined(ds_list_find_value(inv, 19 + (5*scrollLevel))) {
					scrollLevel++;
				}
				break;
			}
			case InventoryFilters.None: {
				filter = InventoryFilters.None;
				break;
			}
			case InventoryFilters.Melee: {
				filter = InventoryFilters.Melee;
				break;
			}
			case InventoryFilters.Ranged: {
				filter = InventoryFilters.Ranged;
				break;
			}
			case InventoryFilters.Other: {
				filter = InventoryFilters.Other;
				break;
			}
			case InventoryFilters.Shields: {
				filter = InventoryFilters.Shields;
				break;
			}
			case InventoryFilters.Rings: {
				filter = InventoryFilters.Rings;
				break;
			}
			case InventoryFilters.Head: {
				filter = InventoryFilters.Head;
				break;
			}
			
		}
	}
	
	currentButton = ds_map_find_next(menuButtonCoordinates,currentButton);
}