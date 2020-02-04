var pad = global.player.gamePadIndex;
if gamepad_is_connected(pad) {	
		
	if gamepad_button_check_pressed(pad,gp_face1) && canBeSkipped {
		if audio_is_playing(currentSound) {
			audio_stop_sound(currentSound);
			canBeSkipped = false;
			alarm[0] = CONV_SKIP_DELAY_FRAMES;
		}
	}
}