var pad = global.player.gamePadIndex;

if gamepad_is_connected(pad) {
	
	if currentMenu == FOUNTAIN {
		
		if gamepad_button_check_pressed(pad, gp_face2) {
			leaveFountain();
		}
		
		if gamepad_button_check_pressed(pad,gp_face1) {
			switch selectedOption {
				case INSERTGEM: {
					startInsertGemMenu();
					break;
				}
				case BREAKDOWNITEM: {
					currentMenu = BREAKDOWNITEM; break;
				}
				case LEAVEFOUNTAIN: {
					leaveFountain(); break;
				}
			}
		}
		
		if gamepad_button_check_pressed(pad,gp_padd) {
			if ds_list_find_value(menuOptions,ds_list_find_index(menuOptions,selectedOption)+1) != undefined {
				selectedOption = ds_list_find_value(menuOptions,ds_list_find_index(menuOptions,selectedOption)+1);
			} else {
				selectedOption = ds_list_find_value(menuOptions,0);
			}
		}
	
		if gamepad_button_check_pressed(pad,gp_padu) {
			if ds_list_find_value(menuOptions,ds_list_find_index(menuOptions,selectedOption)-1) != undefined {
				selectedOption = ds_list_find_value(menuOptions,ds_list_find_index(menuOptions,selectedOption)-1);
			} else {
				selectedOption = ds_list_find_value(menuOptions,ds_list_size(menuOptions)-1);
			}
		}
	}
	
}