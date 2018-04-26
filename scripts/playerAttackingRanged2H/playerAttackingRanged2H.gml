// handle 2h ranged weapon attacks
// this is a 2h ranged weapon, so limb must be "l"
var RIGHTRELEASED = mouse_check_button_released(mb_right);
var RIGHTHELD = mouse_check_button(mb_right);
if gamepad_is_connected(gamePadIndex) {
	RIGHTRELEASED = mouse_check_button_released(mb_left) 
	|| gamepad_button_check_released(gamePadIndex,gp_shoulderrb);
	RIGHTHELD = gamepad_button_check(gamePadIndex,gp_shoulderrb);
}

/*if RIGHTHELD && chargeFrame < CHARGE_FRAME_THRESHOLD {
	chargeFrame++;
}
else if RIGHTHELD && chargeFrame <= CHARGE_FRAME_TOTAL {
	chargeFrame++;
}*/

if isReadyToFire && RIGHTRELEASED && stamina > 0 {
	speed = 0;
	var attackInChain = ds_map_find_value(preparingLimbs,"l"); // pretty sure this is always gonna be 1
	ds_map_replace(prepFrames,"l",-1);
	ds_map_replace(prepFrameTotals,"l",0);
	isReadyToFire = false;
	ds_map_replace(attackingLimbs,"l",attackInChain);
	stamina -= leftHandItem.staminaCostArray[attackInChain-1];
	ds_map_delete(preparingLimbs,"l");
	global.owner = id;
	global.limbKey = "l";
	/*if chargeFrame > 0 {
		instance_create_depth(x,y,1,obj_attack_charge);
		chargeFrame = -10;
	} else {*/
		instance_create_depth(x,y,1,obj_attack);
	//}
}