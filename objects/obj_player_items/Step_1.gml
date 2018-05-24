// controller stuff
var pad = global.player.gamePadIndex;

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

if gamepad_is_connected(pad) && isActive {
	
	var h_point = gamepad_axis_value(pad, gp_axislh);
	var v_point = gamepad_axis_value(pad, gp_axislv);
	var pdir = noone;
	if (h_point != 0 || v_point != 0) {
		pdir = point_direction(0, 0, h_point, v_point);
	} else {
		joystickInputFrame = joystickInputTotalFrames;
	}
	
	var acceptingJoystickInput = joystickInputFrame >= joystickInputTotalFrames;
	// move selector left
	if gamepad_button_check_pressed(pad,gp_padl) || (angleBetween(135,225,pdir) && pdir != noone && acceptingJoystickInput) {
		moveTradeSelector("left");
		joystickInputFrame = 0;
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) || (angleBetween(315,45,pdir) && pdir != noone && acceptingJoystickInput) {
		moveTradeSelector("right");
		joystickInputFrame = 0;
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
		moveTradeSelector("up");
		joystickInputFrame = 0;
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
		moveTradeSelector("down");
		joystickInputFrame = 0;
	}

	if gamepad_button_check_pressed(pad,gp_shoulderrb) {
		var currentFilter = ds_map_find_value(filterSprites, filter);
		var nextFilter = ds_map_find_next(filterSprites,filter);
		if nextFilter != undefined {
			filter = nextFilter;
		} else {
			filter = ds_map_find_first(filterSprites);
		}
		scrollLevel = 0;
		selectedItem = noone;
	}
	if gamepad_button_check_pressed(pad,gp_shoulderlb) {
		var currentFilter = ds_map_find_value(filterSprites, filter);
		var prevFilter = ds_map_find_previous(filterSprites,filter);
		if prevFilter != undefined {
			filter = prevFilter;
		} else {
			filter = ds_map_find_last(filterSprites);
		}
		scrollLevel = 0;
		selectedItem = noone;
	}
	
	// switch to sell 
	if gamepad_button_check_pressed(pad,gp_shoulderl) {
		var vendorItemsObj = obj_vendor_items;
		vendorItemsObj.isActive = true;
		isActive = false;
	}
	
	if gamepad_button_check_pressed(pad,gp_face4) {
		global.ui.isShowingExplanations = !global.ui.isShowingExplanations;
	}
}

	