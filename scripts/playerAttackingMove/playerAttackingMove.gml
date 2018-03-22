if !isFlinching && currentUsingSpell != noone || (leftHandItem.subType == HandItemTypes.Ranged && leftHandItem.isTwoHanded) {
	speed = 0;
	var UP = keyboard_check(ord("W"));
	var DOWN = keyboard_check(ord("S"));
	var LEFT = keyboard_check(ord("A"));
	var RIGHT = keyboard_check(ord("D"));
	var SHIFT = keyboard_check(vk_shift) || gamepad_button_check(gamePadIndex, gp_stickl) || gamepad_button_check(gamePadIndex,gp_face4);
	var canMove = false;
	var usingSpeed = SHIFT ? functionalSpeed*2 : functionalSpeed;
	var gamePadInputReceived = false;
	if gamepad_is_connected(gamePadIndex) {
		var h_point = gamepad_axis_value(gamePadIndex, gp_axislh);
		var v_point = gamepad_axis_value(gamePadIndex, gp_axislv);
		if h_point != 0 || v_point != 0 {
			gamePadInputReceived = true;
			direction = (point_direction(0,0,h_point,v_point))%360;
		}
	} else {
		if UP && RIGHT && !place_meeting_layer(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 45;
		}
		else if UP && LEFT && !place_meeting_layer(x-usingSpeed, y-usingSpeed, obj_solid_parent) {
			direction = 135;
		}
		else if DOWN && LEFT && !place_meeting_layer(x-usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 225;
		}
		else if DOWN && RIGHT && !place_meeting_layer(x+usingSpeed, y+usingSpeed, obj_solid_parent) {
			direction = 315;
		}
		else if RIGHT && !place_meeting_layer(x+usingSpeed, y, obj_solid_parent) {
			direction = 0;
		}
		else if LEFT && !place_meeting_layer(x-usingSpeed, y, obj_solid_parent) {
			direction = 180;
		}
		else if UP && !place_meeting_layer(x, y-usingSpeed, obj_solid_parent) {
			direction = 90;
		}
		else if DOWN && !place_meeting_layer(x, y+usingSpeed, obj_solid_parent) {
			direction = 270;
		}
	}
		
	if (UP || DOWN || LEFT || RIGHT || gamePadInputReceived) && !global.ui.isShowingMenus {
		var useSpeed = functionalSpeed;
		if SHIFT && stamina > 0 {
			useSpeed = .5*(functionalSpeed*1.25);
			stamina -= .35;
		}
		// walking backwards is slow
		dirDiff = abs(direction - facingDirection);
		if dirDiff > 135 && dirDiff < 225  {
			moveToNearestFreePoint(direction,.25*useSpeed);
		}	
		else {
			moveToNearestFreePoint(direction,.5*useSpeed);
		}
	}
}