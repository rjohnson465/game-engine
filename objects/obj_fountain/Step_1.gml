/*var pad = global.player.gamePadIndex;

if gamepad_is_connected(pad) {
	
	if gamepad_button_check_pressed(pad, gp_face2) {
		global.isWishing = false;
	}
	
	if currentMenu == FOUNTAIN {
		
		if gamepad_button_check_pressed(pad,gp_face1) {
			switch selectedOption {
				case FountainOptions.InsertGem: {
					currentMenu = INSERTGEM; break;
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