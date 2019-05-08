var pad = global.player.gamePadIndex;

if gamepad_is_connected(pad) {
	// toggle item info display
	if gamepad_button_check_pressed(pad,gp_face3) {
		global.inventory.isShowingItemInfo2 = !global.inventory.isShowingItemInfo2;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// show explanations
	if gamepad_button_check_pressed(global.player.gamePadIndex,gp_select) {
		global.ui.isShowingExplanations = !global.ui.isShowingExplanations;
		audio_play_sound(snd_ui_option_change,1,0);
	}
}