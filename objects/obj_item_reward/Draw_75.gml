// instructions / prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
if gamepad_is_connected(global.player.gamePadIndex) {
	
	if isConfirming {
		w += drawPrompt("Confirm Choice", Input.F,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Back",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	}
	
	else {
		if selectedItem != noone && selectedItem != undefined && instance_exists(selectedItem) {
			w += drawPrompt("Choose " + selectedItem.name, Input.F,promptsStartX+w,promptsY)+xOffset;
		} 
		if selectedItem != undefined && selectedItem >= 0 && instance_exists(selectedItem) && 
			(selectedItem.type == ItemTypes.HandItem || selectedItem.type == ItemTypes.Head) && !selectedItem.isUsable {
			w += drawPrompt("Toggle Item Info",Input.Backspace,promptsStartX+w,promptsY)+xOffset;
		}
		if global.ui.isShowingExplanations {
			w += drawPrompt("Show Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
		} else {
			w += drawPrompt("Explain Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
		}
	}
	
} else {
	w += drawPrompt("View Item Info",Input.LMB,promptsStartX+w,promptsY)+xOffset;
	w += drawPrompt("Choose Item",Input.RMB,promptsStartX+w,promptsY)+xOffset;
	if selectedItem != undefined && selectedItem >= 0 && instance_exists(selectedItem) && 
		(selectedItem.type == ItemTypes.HandItem || selectedItem.type == ItemTypes.Head) && !selectedItem.isUsable {
		w += drawPrompt("Toggle Item Info",Input.Control,promptsStartX+w,promptsY)+xOffset;
	}
	if global.ui.isShowingExplanations {
		w += drawPrompt("Show Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
	} else {
		w += drawPrompt("Explain Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
	}
}
