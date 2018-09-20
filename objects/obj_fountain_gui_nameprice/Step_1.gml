if global.fountainGui.currentSubMenu != NAMEPRICE || !isAcceptingInput exit;

// controller stuff
var pad = global.player.gamePadIndex;

if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

// gamepad input
if gamepad_is_connected(pad) {
	
	var h_point = gamepad_axis_value(pad, gp_axislh);
	var v_point = gamepad_axis_value(pad, gp_axislv);
	var pdir = noone;
	if (h_point != 0 || v_point != 0) {
		pdir = point_direction(0, 0, h_point, v_point);
	} else {
		joystickInputFrame = joystickInputTotalFrames;
	}
	
	var acceptingJoystickInput = joystickInputFrame >= joystickInputTotalFrames;
	// move selector left
	if gamepad_button_check_pressed(pad,gp_padl) || (angleBetween(135,225,pdir) && pdir != noone && acceptingJoystickInput) {
		switch selectedPriceIncrease {
			case WISH: {
				selectedPriceIncrease = RESETPRICE; break;
			}
			case RESETPRICE: {
				selectedPriceIncrease = WISH; break;
			}
		}
		if ds_list_find_index(allPriceIncrements, selectedPriceIncrease) != -1 {
			var newIndex = ds_list_find_index(allPriceIncrements, selectedPriceIncrease) - 1;
			if newIndex == -1 {
				newIndex = ds_list_size(allPriceIncrements) - 1;
			}
			selectedPriceIncrease = ds_list_find_value(allPriceIncrements, newIndex);
		}
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) || (angleBetween(315,45,pdir) && pdir != noone && acceptingJoystickInput) {
		switch selectedPriceIncrease {
			case WISH: {
				selectedPriceIncrease = RESETPRICE; break;
			}
			case RESETPRICE: {
				selectedPriceIncrease = WISH; break;
			}
		}
		if ds_list_find_index(allPriceIncrements, selectedPriceIncrease) != -1 {
			var newIndex = ds_list_find_index(allPriceIncrements, selectedPriceIncrease) + 1;
			if newIndex > ds_list_size(allPriceIncrements) - 1 {
				newIndex = 0;
			}
			selectedPriceIncrease = ds_list_find_value(allPriceIncrements, newIndex);
		}
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
		if selectedPriceIncrease == WISH {
			selectedPriceIncrease = INCREASE100;
		} else if selectedPriceIncrease == RESETPRICE {
			selectedPriceIncrease = INCREASE10K;
		} else if selectedPriceIncrease == INCREASE100 || selectedPriceIncrease == INCREASE1K {
			selectedPriceIncrease = WISH;
		} else if selectedPriceIncrease == INCREASE10K || selectedPriceIncrease == INCREASE100K {
			selectedPriceIncrease = RESETPRICE;
		}
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
		if selectedPriceIncrease == WISH {
			selectedPriceIncrease = INCREASE100;
		} else if selectedPriceIncrease == RESETPRICE {
			selectedPriceIncrease = INCREASE10K;
		} else if selectedPriceIncrease == INCREASE100 || selectedPriceIncrease == INCREASE1K {
			selectedPriceIncrease = WISH;
		} else if selectedPriceIncrease == INCREASE10K || selectedPriceIncrease == INCREASE100K {
			selectedPriceIncrease = RESETPRICE;
		}
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// attempt to perform action (i.e. insert gem) with this price
	if gamepad_button_check_pressed(pad,gp_face1) {
		if selectedPriceIncrease == WISH {
			if global.fountainGui.currentMenu == INSERTGEM {
				attemptGemInsertion(); 
			} else if global.fountainGui.currentMenu == BREAKDOWNITEM {
				attemptItemBreakDown();
			} else if global.fountainGui.currentMenu == REPAIRITEM {
				attemptRepairItem();
			}
		} else {
			var newProposal = namedPrice;
			switch selectedPriceIncrease {
				case RESETPRICE: {
					newProposal = 0; break;
				}
				case INCREASE100: {
					newProposal += 100; break;
				}
				case INCREASE1K: {
					newProposal += 1000; break;
				}
				case INCREASE10K: {
					newProposal += 10000; break;
				}
				case INCREASE100K: {
					newProposal += 100000; break;
				}
			}
			if newProposal < getGoldCount() {
				namedPrice = newProposal;
				audio_play_sound(snd_item_coins,1,0);
			} else {
				alert("You do not have enough gold", c_red);
			}
		}
	} 
	
	if gamepad_button_check_pressed(pad,gp_face2) {
		goBackFromNamePrice();
	}
}