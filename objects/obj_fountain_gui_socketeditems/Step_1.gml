// controller stuff
var pad = global.player.gamePadIndex;

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

if global.fountainGui.currentSubMenu != CHOOSEITEM exit;

// gamepad input
if gamepad_is_connected(pad) {
	
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
		moveFountainInvSelector("left");
		joystickInputFrame = 0;
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) || (angleBetween(315,45,pdir) && pdir != noone && acceptingJoystickInput) {
		moveFountainInvSelector("right");
		joystickInputFrame = 0;
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
		moveFountainInvSelector("up");
		joystickInputFrame = 0;
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
		moveFountainInvSelector("down");
		joystickInputFrame = 0;
	}
	
	// select item to insert gem into (selectedItem), move onto to choose gem
	if gamepad_button_check_pressed(pad,gp_face1) {
		var gemGui = instance_nearest(x,y,obj_fountain_gui_gems);
		gemGui.isAcceptingInput = false;
		gemGui.alarm[0] = 1;
		global.fountainGui.currentSubMenu = CHOOSEGEM; 
	} 
	
	// go back to main fountain menu
	if gamepad_button_check_pressed(pad,gp_face2)  {
		global.fountainGui.currentMenu = FOUNTAIN;
		instance_destroy(obj_fountain_gui_gems,1);
		instance_destroy(obj_fountain_gui_nameprice,1);
		instance_destroy(id,1);
	}
}