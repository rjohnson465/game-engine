if global.player.hp <= 0 exit;
if global.isWishing exit;
if global.isInteractingWithNpc && !global.isTrading exit;
if scr_is_fading() exit;
audio_play_sound(snd_ui_click1,1,0);
if global.isTrading {
	var vi = obj_vendor_items; //var pli = obj_player_items; var bs = obj_buy_sell;
	with vi {
		owner.isInteractingWithPlayer = false;
		global.isInteractingWithNpc = false;
		owner.showBuySell = false;
		global.isTrading = false;
	}
}

with obj_item_selector {
	if global.ui.isShowingMenus && type == SelectorTypes.Equip {
		performSelectorBackspacePressed();
	}
}

if isShowingMenus && currentMenu == INVENTORY {
	isShowingMenus = false;
} else {
	isShowingMenus = true;
	currentMenu = INVENTORY;
}

if isShowingMenus {
	// move any items that are equipped to their slots
	var equippedItems = global.player.equippedItems;
	for (var i = 0; i < ds_list_size(equippedItems); i++) {
		var equippedItem = ds_list_find_value(equippedItems,i);
		var equippedItemSlot = equippedItem.equipmentSlot;
		var slotObj = getEquipmentSlotObject(equippedItemSlot);
		
		equippedItem.x1 = slotObj.x1;
		equippedItem.y1 = slotObj.y1;
	}
} 

cursor_sprite = -1;

if !isShowingMenus {
	moveSelector.isActive = true;
	equipSelector.isActive = false;
	imbueSelector.isActive = false;
	equipSelector.acceptableEquipmentSlots = [];
	isShowingExplanations = false;
}