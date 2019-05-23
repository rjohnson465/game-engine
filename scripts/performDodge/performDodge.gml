/// performDodge

if global.isWishing exit;
if global.isTrading exit;
if global.isInteractingWithNpc exit;
if global.ui.isShowingMenus exit;

var isFading = false;
with obj_fade {
	if instance_count > 0 {
		isFading = true;
	}
}
if isFading exit;

isSprinting = false;

if  stamina > 0 &&
	(state == CombatantStates.Idle || state == CombatantStates.Moving)
	&& !isFrozen
	{
	
	stamina-= 15;
	var UP = keyboard_check(ord("W"));
	var DOWN = keyboard_check(ord("S"));
	var LEFT = keyboard_check(ord("A"));
	var RIGHT = keyboard_check(ord("D"));
	var GAMEPADHMOVE = false;
	var GAMEPADVMOVE = false;
	if gamepad_is_connected(gamePadIndex) {
		GAMEPADHMOVE = gamepad_axis_value(gamePadIndex, gp_axislh) != 0;
		GAMEPADVMOVE = gamepad_axis_value(gamePadIndex, gp_axislv) != 0;
	}
		
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
	
	if UP || DOWN || LEFT || RIGHT {
		dodgeDirection = direction;
	} else if GAMEPADHMOVE || GAMEPADVMOVE {
		var h_point = gamepad_axis_value(gamePadIndex, gp_axislh);
		var v_point = gamepad_axis_value(gamePadIndex, gp_axislv);
		if h_point != 0 || v_point != 0 {
			gamePadInputReceived = true;
			dodgeDirection = (point_direction(0,0,h_point,v_point))%360;
		}
	}
	else dodgeDirection = facingDirection;
	state = CombatantStates.Dodging;
} 