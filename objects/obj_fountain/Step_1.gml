var pad = global.player.gamePadIndex;

if gamepad_is_connected(pad) {
	
	if gamepad_button_check_pressed(pad, gp_face2) {
		global.isWishing = false;
	}
	
}