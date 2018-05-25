var pad = global.player.gamePadIndex;
if joystickInputFrame < joystickInputTotalFrames {
	joystickInputFrame++;
}

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
	
	if isInteractingWithPlayer && !isInConversation && !showBuySell {
		
		if selectedConversation == noone && ds_list_size(conversations) > 0 {
			selectedConversation = ds_list_find_value(conversations,0);
		}
		var pos = ds_list_find_index(conversations,selectedConversation);
			
		
		if gamepad_button_check_pressed(pad,gp_padu) || (angleBetween(45,135,pdir) && pdir != noone  && acceptingJoystickInput) {
			if pos > 0 {
				selectedConversation = ds_list_find_value(conversations,pos-1);
			} else {
				selectedConversation = ds_list_find_value(conversations,ds_list_size(conversations)-1);
			}
			joystickInputFrame = 0;
		}
		
		if gamepad_button_check_pressed(pad,gp_padd) || (angleBetween(225,315,pdir) && pdir != noone  && acceptingJoystickInput) {
			if pos == ds_list_size(conversations)-1 {
				selectedConversation = ds_list_find_value(conversations,0);
			} else {
				selectedConversation = ds_list_find_value(conversations,pos+1);
			}
			joystickInputFrame = 0;
		}
		
		if gamepad_button_check_pressed(pad,gp_face1) && selectedConversation {
			beginSelectedConversation();
		}
		
	}
	
	if gamepad_button_check_pressed(pad,gp_face2) && isInteractingWithPlayer {
			if global.isTrading {
				var playerItemsObj = obj_player_items;
				var vendorItemsObj = obj_vendor_items;
				if playerItemsObj.isConfirming || vendorItemsObj.isConfirming exit;
			}
			isInteractingWithPlayer = false;
			showBuySell = false;
			global.isInteractingWithNpc = false;
			global.isTrading = false;
		}
}