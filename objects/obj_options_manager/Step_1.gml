// controller interaction
if !ui.isShowingMenus || ui.currentMenu != OPTIONS exit;
var p = global.gamePadIndex;

if gamepad_is_connected(p) {
	
	if gamepad_button_check_pressed(p, gp_padd) {
		var curIndex = arrayGetIndex(currentOptionsArr, selectedOption);
		var nextIndex = curIndex + 1;
		if array_length_1d(currentOptionsArr) - 1 < nextIndex {
			nextIndex = 0;
		}
		audio_play_sound(snd_ui_option_change,1,0);
		selectedOption = currentOptionsArr[nextIndex];
	}
	
	if gamepad_button_check_pressed(p, gp_padu) {
		var curIndex = arrayGetIndex(currentOptionsArr, selectedOption);
		var nextIndex = curIndex - 1;
		if nextIndex < 0 {
			nextIndex = array_length_1d(currentOptionsArr)-1;
		}
		audio_play_sound(snd_ui_option_change,1,0);
		selectedOption = currentOptionsArr[nextIndex];
	}

}