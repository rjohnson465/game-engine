if global.ui.isShowingMenus {
	global.ui.isShowingExplanations = !global.ui.isShowingExplanations;
	audio_play_sound(snd_ui_option_change,1,0);
}