// prompts
var playerItemsObj = obj_player_items;
var vendorItemsObj = obj_vendor_items;

// instructions / prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
visible = true;

if gamepad_is_connected(global.player.gamePadIndex) {
	
	if playerItemsObj.isConfirming || vendorItemsObj.isConfirming {
		w += drawPrompt("Confirm Choice", Input.F,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Back",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	}
	
	else if playerItemsObj.isActive {
		if playerItemsObj.selectedItem != noone && playerItemsObj.selectedItem != undefined && instance_exists(playerItemsObj.selectedItem) && playerItemsObj.selectedItem.isSellable {
			w += drawPrompt("Sell " + playerItemsObj.selectedItem.name, Input.F,promptsStartX+w,promptsY)+xOffset;
		
			
		} 
		if playerItemsObj.selectedItem != undefined && playerItemsObj.selectedItem >= 0 && instance_exists(playerItemsObj.selectedItem) 
			&& (playerItemsObj.selectedItem.type == ItemTypes.HandItem || playerItemsObj.selectedItem.type == ItemTypes.Head) && !playerItemsObj.selectedItem.isUsable {
			w += drawPrompt("Toggle Item Info",Input.Backspace,promptsStartX+w,promptsY)+xOffset;
		}
		if global.ui.isShowingExplanations {
			w += drawPrompt("Show Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
		} else {
			w += drawPrompt("Explain Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
		}
		w+= drawPrompt("Browse " + vendorItemsObj.owner.name + "'s items",Input.LT,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Exit",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	}
	
	else if vendorItemsObj.isActive {
		if vendorItemsObj.selectedItem != noone && vendorItemsObj.selectedItem != undefined && instance_exists(vendorItemsObj.selectedItem) && vendorItemsObj.selectedItem.isSellable {
			w += drawPrompt("Buy " + vendorItemsObj.selectedItem.name, Input.F,promptsStartX+w,promptsY)+xOffset;
		} 
		if vendorItemsObj.selectedItem != undefined && vendorItemsObj.selectedItem >= 0 && instance_exists(vendorItemsObj.selectedItem) 
			&& (vendorItemsObj.selectedItem.type == ItemTypes.HandItem || vendorItemsObj.selectedItem.type == ItemTypes.Head) && !vendorItemsObj.selectedItem.isUsable {
			w += drawPrompt("Toggle Item Info",Input.Backspace,promptsStartX+w,promptsY)+xOffset;
		}
		if global.ui.isShowingExplanations {
			w += drawPrompt("Show Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
		} else {
			w += drawPrompt("Explain Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
		}
		w+= drawPrompt("Browse Your Items",Input.RT,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Exit",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	} 
	
	
} else {
	w += drawPrompt("View Item Info",Input.LMB,promptsStartX+w,promptsY)+xOffset;
	w += drawPrompt("Buy/Sell Item",Input.RMB,promptsStartX+w,promptsY)+xOffset;
	
	var activeItems = playerItemsObj.isActive ? playerItemsObj : vendorItemsObj;
	
	with activeItems {
		if selectedItem != undefined && selectedItem >= 0 && instance_exists(selectedItem) 
			&& (selectedItem.type == ItemTypes.HandItem || selectedItem.type == ItemTypes.Head) && !selectedItem.isUsable {
			w += drawPrompt("Toggle Item Info",Input.Control,promptsStartX+w,promptsY)+xOffset;
		}
		if global.ui.isShowingExplanations {
			w += drawPrompt("Show Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
		} else {
			w += drawPrompt("Explain Stats",Input.Shift,promptsStartX+w,promptsY)+xOffset;
		}
	}

}




		