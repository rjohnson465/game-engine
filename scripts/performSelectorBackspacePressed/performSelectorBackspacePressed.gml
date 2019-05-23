/// performSelectorBackspacePressed()

/// Either backspace or X button event for Selectors

if !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

var item = noone;
if isSelectorInInventory() {
	item = getItemAtSelectorPosition(id);
} else if isSelectorInEquippedItems(id) {
	var slotObj = getSlotAtSelector(id);
	item = getItemInEquipmentSlot(slotObj.slot);
}

var eqSel = global.ui.equipSelector;

// Cancel Equip: if Equip or Imbue selectors are active, deactivate them and re-activate the Select selector
if type == SelectorTypes.Equip || type == SelectorTypes.Imbue {
	isActive = false;
	acceptableEquipmentSlots = [];
	ui.moveSelector.isActive = true;
	audio_play_sound(snd_ui_option_change,1,0);
}
else if item && item.equipmentSlot != noone && !eqSel.isActive {
	// unequip selected item, iff this is not a cancel equip event
	audio_play_sound(item.soundDrop,1,0);
	unequipItem(item);
} 
/*
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