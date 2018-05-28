// prompts
var playerItemsObj = obj_player_items;
var vendorItemsObj = obj_vendor_items;


// instructions / prompts
var promptsStartX = MENUS_TOPLEFT_X+18;
var promptsY = MENUS_BOTTOMRIGHT_Y+25;
var xOffset = 20;
var w = 0;
if gamepad_is_connected(global.player.gamePadIndex) {
	
	if playerItemsObj.isConfirming || vendorItemsObj.isConfirming {
		w += drawPrompt("Confirm Choice", Input.F,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Back",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	}
	
	else if playerItemsObj.isActive {
		if playerItemsObj.selectedItem != noone && playerItemsObj.selectedItem != undefined && instance_exists(playerItemsObj.selectedItem) && playerItemsObj.selectedItem.isSellable {
			w += drawPrompt("Sell " + playerItemsObj.selectedItem.name, Input.F,promptsStartX+w,promptsY)+xOffset;
		} else {
			//w += drawPrompt("Sell item" + playerItemsObj.selectedItem.name, Input.F)+xOffset;
		}
		w+= drawPrompt("Browse " + vendorItemsObj.owner.name + "'s items",Input.LT,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Exit",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	}
	
	else if vendorItemsObj.isActive {
		if vendorItemsObj.selectedItem != noone && vendorItemsObj.selectedItem != undefined && instance_exists(vendorItemsObj.selectedItem) && vendorItemsObj.selectedItem.isSellable {
			w += drawPrompt("Buy " + vendorItemsObj.selectedItem.name, Input.F,promptsStartX+w,promptsY)+xOffset;
		} else {
			//w += drawPrompt("Sell item" + playerItemsObj.selectedItem.name, Input.F)+xOffset;
		}
		w+= drawPrompt("Browse your items",Input.RT,promptsStartX+w,promptsY)+xOffset;
		w += drawPrompt("Exit",Input.Escape,promptsStartX+w,promptsY)+xOffset;
	} 
	
	
} else {
	w += drawPrompt("View item info",Input.LMB,promptsStartX+w,promptsY)+xOffset;
	w += drawPrompt("Buy/sell item",Input.RMB,promptsStartX+w,promptsY)+xOffset;
	//w += drawPrompt("Close Menu",Input.Escape,promptsStartX+w,promptsY)+xOffset;
}



		