// controller stuff
var pad = global.player.gamePadIndex;

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

// gamepad input
if gamepad_is_connected(pad) && isBeingLooted {
	
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
		moveLootItemSelector("left");
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) || (angleBetween(315,45,pdir) && pdir != noone && acceptingJoystickInput) {
		moveLootItemSelector("right");
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
		moveLootItemSelector("up");
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
		moveLootItemSelector("down");
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// handle select / equip with selector
	if gamepad_button_check_pressed(pad,gp_face1) && isBeingLooted && ds_exists(items,ds_type_list) && !global.isReadingTutorial {
		// loot item
		lootItem(selectedItem,id);
	} 
	
	if gamepad_button_check_pressed(pad,gp_face2) && isBeingLooted {
		isBeingLooted = false;
	}
}