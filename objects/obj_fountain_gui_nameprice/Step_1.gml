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
		//moveFountainInvSelector("left");
		joystickInputFrame = 0;
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) || (angleBetween(315,45,pdir) && pdir != noone && acceptingJoystickInput) {
		//moveFountainInvSelector("right");
		joystickInputFrame = 0;
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
		var currentPos = ds_list_find_index(allPriceIncrements,selectedPriceIncrease);
		var listSize = ds_list_size(allPriceIncrements);
		if currentPos == 0 {
			currentPos = listSize;
		}
		selectedPriceIncrease = ds_list_find_value(allPriceIncrements,(abs(currentPos-1))%listSize);
		joystickInputFrame = 0;
		audio_play_sound(snd_ui_option_change,1,0);
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
		var currentPos = ds_list_find_index(allPriceIncrements,selectedPriceIncrease);
		var listSize = ds_list_size(allPriceIncrements);
		selectedPriceIncrease = ds_list_find_value(allPriceIncrements,(currentPos+1)%listSize);
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
				case INCREASE1M: {
					newProposal += 1000000; break;
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