var pad = global.player.gamePadIndex;
if gamepad_is_connected(pad) {

	// show menus
	if gamepad_button_check_pressed(pad,gp_start) && !isShowingMenus {
		showHideInventory();
	} else if gamepad_button_check_pressed(pad,gp_start) && isShowingMenus
		|| (isShowingMenus && gamepad_button_check_pressed(pad,gp_face2) /*&& moveSelector.isActive*/) {
		/*isShowingMenus = false;
		moveSelector.isActive = true;
		equipSelector.isActive = false;
		imbueSelector.isActive = false;
		equipSelector.acceptableEquipmentSlots = [];*/
		showHideInventory();
	}

}