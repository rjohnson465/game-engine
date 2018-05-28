var pad = global.player.gamePadIndex;
if gamepad_is_connected(pad) {

	// show menus
	if gamepad_button_check_pressed(pad,gp_start) && !isShowingMenus {
		showHideInventory();
	} else if gamepad_button_check_pressed(pad,gp_start) && isShowingMenus
		|| (isShowingMenus && gamepad_button_check_pressed(pad,gp_face2) /*&& moveSelector.isActive*/) {
		//showHideInventory();
		isShowingMenus = false;
	}
	
	if gamepad_button_check_pressed(pad,gp_shoulderl) && isShowingMenus {
		switch currentMenu {
			case INVENTORY: {
				currentMenu = OPTIONS; break;
			}
			case OPTIONS: {
				currentMenu = SKILLS; break;
			}
			case SKILLS: {
				currentMenu = INVENTORY; break;
			}
		}
	}
	
	if gamepad_button_check_pressed(pad,gp_shoulderr) && isShowingMenus {
		switch currentMenu {
			case INVENTORY: {
				currentMenu = SKILLS; break;
			}
			case OPTIONS: {
				currentMenu = INVENTORY; break;
			}
			case SKILLS: {
				currentMenu = OPTIONS; break;
			}
		}
	}

}