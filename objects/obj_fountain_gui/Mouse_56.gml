/*var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);


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
			case INSERTGEM: {
				if currentMenu != FOUNTAIN exit;
				startInsertGemMenu();
				break;
			}
			case BREAKDOWNITEM: {
				if currentMenu != FOUNTAIN exit;
				startBreakDownItemMenu();
				break;
			}
			case REPAIRITEM: {
				if currentMenu != FOUNTAIN exit;
				startRepairItemMenu();
				break;
			}
			case LEAVEFOUNTAIN: {
				if currentMenu != FOUNTAIN exit;
				leaveFountain();
				break;
			}
			case "closeButton": {
				if !hasSetAlarm {
					alarm[0] = 1;
					hasSetAlarm = true;
				}
				break;
			}
		}
	}
	
	currentButton = ds_map_find_next(menuButtonCoordinates,currentButton);
}

