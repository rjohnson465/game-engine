var pad = global.player.gamePadIndex;

if gamepad_is_connected(pad) {
	
	if currentMenu == FOUNTAIN {
		
		if gamepad_button_check_pressed(pad, gp_face2) {
			if !hasSetAlarm {
				alarm[0] = 1;
				hasSetAlarm = true;
			}
			
		}
		
		if gamepad_button_check_pressed(pad,gp_face1) {
			switch selectedOption {
				case FountainOptions.InsertGem: {
					currentMenu = INSERTGEM; 
					currentSubMenu = CHOOSEITEM; 
					instance_create_depth(x,y,1,obj_fountain_gui_socketeditems);
					instance_create_depth(x,y,1,obj_fountain_gui_gems);
					break;
				}
				case FountainOptions.BreakdownItem: {
					currentMenu = BREAKDOWNITEM; break;
				}
			}
		}
		
		if gamepad_button_check_pressed(pad,gp_padd) {
			switch selectedOption {
				case FountainOptions.InsertGem: {
					selectedOption = FountainOptions.BreakdownItem; break;
				}
				case FountainOptions.BreakdownItem: {
					selectedOption = FountainOptions.InsertGem; break;
				}
			}
		}
	
		if gamepad_button_check_pressed(pad,gp_padu) {
			switch selectedOption {
				case FountainOptions.InsertGem: {
					selectedOption = FountainOptions.BreakdownItem; break;
				}
				case FountainOptions.BreakdownItem: {
					selectedOption = FountainOptions.InsertGem; break;
				}
			}
		}
	}
	
	// other menus
	
}