if !ui.isShowingMenus || ui.currentMenu != OPTIONS exit;

draw_set_font(font_main);
draw_set_halign(fa_center); draw_set_valign(fa_center);

switch subMenu {
	
	case SM_MAIN: {
		drawOptionsMain();
		break;
	} // end case SM_MAIN
	case SM_SOUND: {
		// TODO: drawOptionsSound()
		break;
	}
	case SM_DISPLAY: {
		drawOptionsDisplay();
		break;
	}
	case SM_GAMEPLAY: {
		drawOptionsGameplay();
		break;
	}
}

var p = global.gamePadIndex;
// back option toggling
if gamepad_is_connected(p) {
	if gamepad_button_check_pressed(p, gp_face1) && selectedOption == OPT_BACK {
		// audio_play_sound(snd_ui_tab1,1,0);
		subMenu = SM_MAIN;
		currentOptionsArr = navOptionsArr;
	}
}
else if selectedOption == OPT_BACK && mouse_check_button_released(mb_left) {
	// audio_play_sound(snd_ui_tab1,1,0);
	subMenu = SM_MAIN;
	currentOptionsArr = navOptionsArr;
}