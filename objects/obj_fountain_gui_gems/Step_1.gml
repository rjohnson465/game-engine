if !isAcceptingInput exit;
// controller stuff
var pad = global.player.gamePadIndex;

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

if global.fountainGui.currentSubMenu != CHOOSEGEM exit;

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
	
	// select gem to insert, move on to name price
	if gamepad_button_check_pressed(pad,gp_face1) {
		proceedFromChooseGem();
	} 
	
	if gamepad_button_check_pressed(pad,gp_face2) {
		goBackFromChooseGem();
	}
}