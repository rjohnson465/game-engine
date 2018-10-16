if global.fountainGui.currentSubMenu != NAMEPRICE exit;
// calc guaranteed price
if instance_number(obj_fountain_gui_gemmeditems) > 0 {
	var gi = instance_nearest(x,y,obj_fountain_gui_gemmeditems);
	var item = gi.selectedItem;
	guaranteedPrice = appraiseItemForBreakdown(item);
} else if instance_number(obj_fountain_gui_gems) > 0 {
	var guiGems = instance_nearest(x,y,obj_fountain_gui_gems);
	var guiItems = instance_nearest(x,y,obj_fountain_gui_socketeditems);
	var item = guiItems.selectedItem;
	var gem = guiGems.selectedItem;
	guaranteedPrice = appraiseItemForInsertion(item, gem);
} else if instance_number(obj_fountain_gui_brokenitems) > 0 {
	var guiBroken = instance_nearest(x,y,obj_fountain_gui_brokenitems);
	var item = guiBroken.selectedItem;
	guaranteedPrice = appraiseItemForRepair(item);
}

if gamepad_is_connected(global.player.gamePadIndex) exit;

var vx = camera_get_view_x(view_camera[0]);
var vy = camera_get_view_y(view_camera[0]);

isBackButtonPressed = false;

// cycle through buttons and see if we've clicked on one
var currentButton = ds_map_find_first(menuButtonCoordinates);
for (var i = 0; i < ds_map_size(menuButtonCoordinates); i++) {
	var arr = ds_map_find_value(menuButtonCoordinates,currentButton);
	var x1 = arr[0];
	var y1 = arr[1];
	var x2 = arr[2];
	var y2 = arr[3];
	
	if point_in_rectangle(mouse_x,mouse_y,vx+x1,vy+y1,vx+x2,vy+y2) {
		
		if currentButton != "Back" {
			selectedPriceIncrease = currentButton;
		} else if mouse_check_button(mb_left) {
			isBackButtonPressed = true;
		}
	}
	
	currentButton = ds_map_find_next(menuButtonCoordinates,currentButton);
}
