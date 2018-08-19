var pad = global.player.gamePadIndex;
if global.inventory.isConfirmingDestroyItem exit;

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

// gamepad input
if gamepad_is_connected(pad) && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	
	var h_point = gamepad_axis_value(pad, gp_axislh);
	var v_point = gamepad_axis_value(pad, gp_axislv);
	var pdir = noone;
	if (h_point != 0 || v_point != 0) {
		pdir = point_direction(0, 0, h_point, v_point);
	} else {
		joystickInputFrame = joystickInputTotalFrames;
	}
	
	var acceptingJoystickInput = joystickInputFrame >= joystickInputTotalFrames;
	//var acceptingJoystickInput = true;
	// move selector left
	if gamepad_button_check_pressed(pad,gp_padl) || (angleBetween(135,225,pdir) && pdir != noone && acceptingJoystickInput) {
		performSelectorLeft();
		joystickInputFrame = 0;
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) || (angleBetween(315,45,pdir) && pdir != noone && acceptingJoystickInput) {
		performSelectorRight();
		joystickInputFrame = 0;
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
		performSelectorUp();
		joystickInputFrame = 0;
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
		performSelectorDown();
		joystickInputFrame = 0;
	}
	
	// handle select / equip with selector
	if gamepad_button_check_pressed(pad,gp_face1) {
		performSelectorEnterPressed();
	} 
	
	// handle canceling selector event (square / x button) or unequipping hovered item
	if gamepad_button_check_pressed(pad,gp_face3) {
		performSelectorBackspacePressed();
	}
	
}