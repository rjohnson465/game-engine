if chosenRewardsCount >= chosenRewardsLimit {
	instance_destroy(id,1);
}

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

if gamepad_is_connected(pad) && !isConfirming {
	
	// move selector left
	if gamepad_button_check_pressed(pad,gp_padl) || (angleBetween(135,225,pdir) && pdir != noone && acceptingJoystickInput) {
		moveRewardSelector("left");
		joystickInputFrame = 0;
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) || (angleBetween(315,45,pdir) && pdir != noone && acceptingJoystickInput) {
		moveRewardSelector("right");
		joystickInputFrame = 0;
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
		moveRewardSelector("up");
		joystickInputFrame = 0;
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
		moveRewardSelector("down");
		joystickInputFrame = 0;
	}
	
	if gamepad_button_check_pressed(pad,gp_face1) {
		isConfirming = true;
		audio_play_sound(snd_ui_click1,1,0);
		alarm[0] = 1;
	}
	
	// toggle item info display
	if gamepad_button_check_pressed(pad,gp_face3) {
		global.inventory.isShowingItemInfo2 = !global.inventory.isShowingItemInfo2;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// show explanations
	if gamepad_button_check_pressed(global.player.gamePadIndex,gp_select) {
		global.ui.isShowingExplanations = !global.ui.isShowingExplanations;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
}

if gamepad_is_connected(pad) && isConfirming && selectedItem != noone && selectedItem != undefined && instance_exists(selectedItem) && isAcceptingConfirmInput {
	
	if gamepad_button_check_pressed(pad,gp_face2) {
		isConfirming = false;
		isAcceptingConfirmInput = false;
		audio_play_sound(snd_ui_click1,1,0);
	}
	
	if	gamepad_button_check_pressed(pad,gp_padl) ||
		gamepad_button_check_pressed(pad,gp_padr) ||
		(angleBetween(135,225,pdir) && pdir != noone && acceptingJoystickInput) ||
		(angleBetween(315,45,pdir) && pdir != noone && acceptingJoystickInput) 
		{
			isYes = !isYes;
			joystickInputFrame = 0;
			audio_play_sound(snd_ui_option_change,1,0);
		}
	
	if gamepad_button_check_pressed(pad,gp_face1) {
		if isYes {
			chooseRewardItem(selectedItem);
			isConfirming = false;
		} else {
			isConfirming = false;
			audio_play_sound(snd_ui_click1,1,0);
		}
		isAcceptingConfirmInput = false;
	}
}