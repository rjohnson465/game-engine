var pad = global.player.gamePadIndex;
if gamepad_is_connected(pad) {

	// show menus
	if gamepad_button_check_pressed(pad,gp_start) && !isShowingMenus {
		showHideInventory();
	} else if gamepad_button_check_pressed(pad,gp_start) && isShowingMenus
		|| (isShowingMenus && gamepad_button_check_pressed(pad,gp_face2) /*&& moveSelector.isActive*/) {
		showHideInventory();
	}
	
	if gamepad_button_check_pressed(pad,gp_face4) && isShowingMenus {
		isShowingExplanations = !isShowingExplanations;
	}

}