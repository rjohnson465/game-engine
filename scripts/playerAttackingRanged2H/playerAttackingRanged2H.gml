if !(rightHandItem.isRanged && rightHandItem.isTwoHanded) exit;
// handle 2h ranged weapon attacks
// this is a 2h ranged weapon, so limb must be "r"
var RIGHTRELEASED = mouse_check_button_pressed(mb_left);
var RIGHTHELD = mouse_check_button(mb_left);
if gamepad_is_connected(gamePadIndex) {
	RIGHTRELEASED = mouse_check_button_pressed(mb_left) 
	|| gamepad_button_check_pressed(gamePadIndex,gp_shoulderl);
	RIGHTHELD = gamepad_button_check(gamePadIndex,gp_shoulderl);
}

var percentCharged = ds_map_find_value(prepFrames,"r") / (ds_map_find_value(prepFrameTotals,"r")-2);

show_debug_message(string(percentCharged) + ", " + string(RIGHTRELEASED));

if percentCharged > .25 && RIGHTRELEASED && stamina > 0 {
	speed = 0;
	var attackInChain = ds_map_find_value(preparingLimbs,"r"); // pretty sure this is always gonna be 1
	if attackInChain == undefined attackInChain = 1;
	if percentCharged < 1 percentCharged*=.5;
	if percentCharged < 0 percentCharged = 0;
	global.percentCharged = percentCharged;
	ds_map_replace(prepFrames,"r",-1);
	ds_map_replace(prepFrameTotals,"r",0);
	isReadyToFire = false;
	ds_map_replace(attackingLimbs,"r",attackInChain);
	stamina -= rightHandItem.staminaCostArray[attackInChain-1];
	ds_map_delete(preparingLimbs,"r");
	global.owner = id;
	global.limbKey = "r";

	instance_create_depth(x,y,1,obj_attack);
	rightHandItem.ammo -= 1;
	if rightHandItem.ammo < 1 {
		alert(rightHandItem.name + " out of ammo", c_red);
	}
}

if RIGHTRELEASED {
	ds_map_replace(prepFrames,"r",-1);
	ds_map_replace(prepFrameTotals,"r",0);
	isReadyToFire = false;
}