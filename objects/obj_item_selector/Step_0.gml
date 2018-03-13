var pad = global.player.gamePadIndex;

// gamepad input
if gamepad_is_connected(pad) {
	
	// move selector left
	if gamepad_button_check_pressed(pad,gp_padl) {
		performSelectorLeft();
	}
	
	// move selector right
	if gamepad_button_check_pressed(pad,gp_padr) {
		performSelectorRight();
	}
	
	// move selector up
	if gamepad_button_check_pressed(pad,gp_padu) {
		performSelectorUp();
	}
	
	// move selector down 
	if gamepad_button_check_pressed(pad,gp_padd) {
		performSelectorDown();
	}
	
	// handle select / equip with selector
	if gamepad_button_check_pressed(pad,gp_face1) {
		performSelectorEnterPressed();
	} 
	
	// handle canceling selector event (square / x button) or unequipping hovered item
	if gamepad_button_check_pressed(pad,gp_face3) {
		performSelectorBackspacePressed();
	}
	
}