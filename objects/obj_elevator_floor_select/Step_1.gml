// controller stuff
var pad = global.player.gamePadIndex;

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

var h_point = gamepad_axis_value(pad, gp_axislh);
var v_point = gamepad_axis_value(pad, gp_axislv);
var pdir = noone;
if (h_point != 0 || v_point != 0) {
	pdir = point_direction(0, 0, h_point, v_point);
} else {
	joystickInputFrame = joystickInputTotalFrames;
}
	
var acceptingJoystickInput = joystickInputFrame >= joystickInputTotalFrames;

if gamepad_is_connected(pad) {
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
		audio_play_sound(snd_ui_option_change, 1, 0);
		selectedFloor -= 1;
		if selectedFloor < startFloor {
			selectedFloor = numFloors;
		}
		joystickInputFrame = 0;
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
		audio_play_sound(snd_ui_option_change, 1, 0);
		selectedFloor += 1;
		if selectedFloor > numFloors {
			selectedFloor = startFloor;
		}
		joystickInputFrame = 0;
	}
	
	if gamepad_button_check_pressed(pad,gp_face1) {
		audio_play_sound(snd_ui_click1, 1, 0);
		associatedElevator.elevatorFloorToMoveTo = selectedFloor;
		alarm[0] = 3;
		hasSetAlarm = true;
	}
	
	// press B button, exit menu
	if gamepad_button_check_pressed(pad,gp_face2) {
		audio_play_sound(snd_ui_click1, 1, 0);
		alarm[0] = 3;
		hasSetAlarm = true;
	}
	
}
