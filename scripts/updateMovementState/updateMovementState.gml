if global.isInteractingWithNpc || global.isTrading exit;
var UP = keyboard_check(ord("W"));
var DOWN = keyboard_check(ord("S"));
var LEFT = keyboard_check(ord("A"));
var RIGHT = keyboard_check(ord("D"));
var SHIFT = keyboard_check(vk_shift) || gamepad_button_check(gamePadIndex, gp_stickl) || gamepad_button_check(gamePadIndex,gp_face4);
var GAMEPADHMOVE = false;
var GAMEPADVMOVE = false;
if gamepad_is_connected(gamePadIndex) {
	GAMEPADHMOVE = gamepad_axis_value(gamePadIndex, gp_axislh) != 0;
	GAMEPADVMOVE = gamepad_axis_value(gamePadIndex, gp_axislv) != 0;
}
var isMoveInputReceived = UP || DOWN || LEFT || RIGHT || GAMEPADHMOVE || GAMEPADVMOVE;

if isMoveInputReceived && state != CombatantStates.Attacking && state != CombatantStates.Staggering && state != CombatantStates.Dodging {
	state = CombatantStates.Moving;
}
if !isMoveInputReceived && state == CombatantStates.Moving {
	state = CombatantStates.Idle;
}