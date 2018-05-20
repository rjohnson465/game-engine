var pad = global.player.gamePadIndex;
if gamepad_is_connected(pad) {	
		
	if gamepad_button_check_pressed(pad,gp_face1) {
		if audio_is_playing(currentSound) {
			audio_stop_sound(currentSound);
		}
	}
}