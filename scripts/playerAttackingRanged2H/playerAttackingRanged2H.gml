if !(leftHandItem.isRanged && leftHandItem.isTwoHanded) exit;
// handle 2h ranged weapon attacks
// this is a 2h ranged weapon, so limb must be "l"
var RIGHTRELEASED = mouse_check_button_pressed(mb_left);
var RIGHTHELD = mouse_check_button(mb_left);
if gamepad_is_connected(gamePadIndex) {
	RIGHTRELEASED = mouse_check_button_pressed(mb_left) 
	|| gamepad_button_check_pressed(gamePadIndex,gp_shoulderlb);
	RIGHTHELD = gamepad_button_check(gamePadIndex,gp_shoulderlb);
}

var percentCharged = ds_map_find_value(prepFrames,"l") / (ds_map_find_value(prepFrameTotals,"l")-2);
if percentCharged > .25 && RIGHTRELEASED && stamina > 0 {
	speed = 0;
	var attackInChain = ds_map_find_value(preparingLimbs,"l"); // pretty sure this is always gonna be 1
	if percentCharged < 1 percentCharged*=.5;
	if percentCharged < 0 percentCharged = 0;
	global.percentCharged = percentCharged;
	ds_map_replace(prepFrames,"l",-1);
	ds_map_replace(prepFrameTotals,"l",0);
	isReadyToFire = false;
	ds_map_replace(attackingLimbs,"l",attackInChain);
	stamina -= leftHandItem.staminaCostArray[attackInChain-1];
	ds_map_delete(preparingLimbs,"l");
	global.owner = id;
	global.limbKey = "l";

	instance_create_depth(x,y,1,obj_attack);
	leftHandItem.ammo -= 1;
	if leftHandItem.ammo < 1 {
		alert(leftHandItem.name + " out of ammo", c_red);
	}
}