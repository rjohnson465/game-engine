var pad = global.player.gamePadIndex;
if gamepad_is_connected(pad) {
	if isInteractingWithPlayer && !isInConversation {
		
		if selectedConversation == noone && ds_list_size(conversations) > 0 {
			selectedConversation = ds_list_find_value(conversations,0);
		}
		var pos = ds_list_find_index(conversations,selectedConversation);
		
		if gamepad_button_check_pressed(pad,gp_padd) {
			if pos > 0 {
				selectedConversation = ds_list_find_value(conversations,pos-1);
			} else {
				selectedConversation = ds_list_find_value(conversations,ds_list_size(conversations)-1);
			}
		}
		
		if gamepad_button_check_pressed(pad,gp_padu) {
			if pos == ds_list_size(conversations)-1 {
				selectedConversation = ds_list_find_value(conversations,0);
			} else {
				selectedConversation = ds_list_find_value(conversations,pos+1);
			}
		}
		
		if gamepad_button_check_pressed(pad,gp_face1) && selectedConversation {
			beginSelectedConversation();
		}
	}
}