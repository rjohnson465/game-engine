if isFlinching || global.ui.isShowingMenus {
	exit;
}
if global.isWishing exit;
var UP = keyboard_check(ord("W"));
var DOWN = keyboard_check(ord("S"));
var LEFT = keyboard_check(ord("A"));
var RIGHT = keyboard_check(ord("D"));
var SHIFT = keyboard_check(vk_shift) || gamepad_button_check(gamePadIndex, gp_stickl) || gamepad_button_check(gamePadIndex,gp_face4);
speed = 0;
var canMove = false;
var gamePadInputReceived = false;
if gamepad_is_connected(gamePadIndex) {
	var h_point = gamepad_axis_value(gamePadIndex, gp_axislh);
	var v_point = gamepad_axis_value(gamePadIndex, gp_axislv);
	if h_point != 0 || v_point != 0 {
		gamePadInputReceived = true;
		direction = (point_direction(0,0,h_point,v_point))%360;
	}
} else {
	var usingSpeed = SHIFT ? functionalSpeed*2 : functionalSpeed;
	if UP && RIGHT {
		direction = 45;
	}
	else if UP && LEFT  {
		direction = 135;
	}
	else if DOWN && LEFT {
		direction = 225;
	}
	else if DOWN && RIGHT {
		direction = 315;
	}
	else if RIGHT {
		direction = 0;
	}
	else if LEFT {
		direction = 180;
	}
	else if UP {
		direction = 90;
	}
	else if DOWN {
		direction = 270;
	}
}
		
if (UP || DOWN || LEFT || RIGHT || gamePadInputReceived) && !global.ui.isShowingMenus && !global.isInteractingWithNpc {
	var useSpeed = functionalSpeed;
	if SHIFT && stamina > 0 {
		useSpeed = functionalSpeed*1.25;
		stamina -= .35;
	}
	// walking backwards is slow
	dirDiff = abs(direction - facingDirection);
	if (dirDiff > 135 && dirDiff < 225) || isShielding  {
		var modifier = .5;
		if SHIFT modifier = .8;
		moveToNearestFreePoint(direction,modifier*useSpeed);
	}	
	else {
		moveToNearestFreePoint(direction,useSpeed);
	}
}	
		
var isInteractingWithNpc = false;
with obj_npc_parent {
	if isInteractingWithPlayer isInteractingWithNpc = true;
}		

if gamepad_is_connected(gamePadIndex) && !isInteractingWithNpc {
	var h_point = gamepad_axis_value(gamePadIndex, gp_axisrh);
	var v_point = gamepad_axis_value(gamePadIndex, gp_axisrv);
	if h_point == 0 && v_point == 0 && lockOnTarget == noone {
		var xx = x+lengthdir_x(100,direction);
		var yy = y+lengthdir_y(100,direction);
		turnToFacePoint(turnSpeed,xx,yy);
	}
}