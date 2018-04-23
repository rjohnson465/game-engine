var pad = global.player.gamePadIndex;

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

if gamepad_is_connected(pad) && isAcceptingInput {
	
	var h_point = gamepad_axis_value(pad, gp_axislh);
	var v_point = gamepad_axis_value(pad, gp_axislv);
	var pdir = noone;
	if (h_point != 0 || v_point != 0) {
		pdir = point_direction(0, 0, h_point, v_point);
	} else {
		joystickInputFrame = joystickInputTotalFrames;
	}
	
	var acceptingJoystickInput = joystickInputFrame >= joystickInputTotalFrames;
	
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
					if currentMenu != FOUNTAIN exit;
					startBreakDownItemMenu();
					break;
				}
				case LEAVEFOUNTAIN: {
					leaveFountain(); break;
				}
			}
		}
		
		// move selector up
		if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
			var currentPos = ds_list_find_index(menuOptions,selectedOption);
			var listSize = ds_list_size(menuOptions);
			if currentPos == 0 {
				currentPos = listSize;
			}
			selectedOption = ds_list_find_value(menuOptions,(abs(currentPos-1))%listSize);
			joystickInputFrame = 0;
		}
	
		// move selector down 
		if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
			var currentPos = ds_list_find_index(menuOptions,selectedOption);
			var listSize = ds_list_size(menuOptions);
			selectedOption = ds_list_find_value(menuOptions,(currentPos+1)%listSize);
			joystickInputFrame = 0;
		}
		
		/*
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
		*/
	}
	
}