/// performSelectorBackspacePressed()

/// Either backspace or X button event for Selectors

if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

// if Equip or Imbue selectors are active, deactivate them and re-activate the Select selector
if type == SelectorTypes.Equip || type == SelectorTypes.Imbue {
	isActive = false;
	acceptableEquipmentSlots = [];
	ui.moveSelector.isActive = true;
	audio_play_sound(snd_ui_option_change,1,0);
}

// unequip selected item 
if type == SelectorTypes.Select && isSelectorInEquippedItems && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	var item = noone;
	if isSelectorInInventory() {
		item = getItemAtSelectorPosition(id);
	} else if isSelectorInEquippedItems(id) {
		var slotObj = getSlotAtSelector(id);
		item = getItemInEquipmentSlot(slotObj.slot);
	}
	if item && isActive && item.equipmentSlot != noone {
		audio_play_sound(item.soundDrop,1,0);
		unequipItem(item);
	}
}