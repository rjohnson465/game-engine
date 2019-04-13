var pad = global.player.gamePadIndex;
if global.inventory.isConfirmingDestroyItem exit;
if global.player.isEquippingBeltItem exit;


if gamepad_is_connected(pad) {

	if gamepad_button_check_released(pad, gp_face2) && !isShowingMenus  {
		if justClosedMenus {
			justClosedMenus = false;
		}
	}

	// show menus
	if gamepad_button_check_pressed(pad,gp_start) && !isShowingMenus {
		showHideInventory();
	} else if gamepad_button_check_pressed(pad,gp_start) && isShowingMenus
		|| (isShowingMenus && gamepad_button_check_pressed(pad,gp_face2) /*&& moveSelector.isActive*/) {
		// stop any equipping that might be going on
		with obj_item_selector {
			if global.ui.isShowingMenus && type == SelectorTypes.Equip {
				performSelectorBackspacePressed();
			}
		}
		isShowingMenus = false;
		justClosedMenus = true; // flag that disables player dodging immediately on menus exit
		audio_play_sound(snd_ui_click1,1,0);
	}
	
	if gamepad_button_check_pressed(pad,gp_shoulderlb) && isShowingMenus {
		audio_play_sound(snd_ui_tab1,1,0);
		// stop any equipping that might be going on
		with obj_item_selector {
			if global.ui.isShowingMenus && type == SelectorTypes.Equip {
				performSelectorBackspacePressed();
			}
		}
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
	
	if gamepad_button_check_pressed(pad,gp_shoulderrb) && isShowingMenus {
		audio_play_sound(snd_ui_tab1,1,0);
		// stop any equipping that might be going on
		with obj_item_selector {
			if global.ui.isShowingMenus && type == SelectorTypes.Equip {
				performSelectorBackspacePressed();
			}
		}
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