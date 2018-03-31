//performSelectorBackspacePressed();
/*// if Equip or Imbue selectors are active, deactivate them and re-activate the Select selector
if type == SelectorTypes.Equip || type == SelectorTypes.Imbue {
	isActive = false;
	acceptableEquipmentSlots = [];
	ui.moveSelector.isActive = true;
}

// unequip selected item 
if type == SelectorTypes.Select && isSelectorInEquippedItems && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	var item = getItemAtSelectorPosition(id);
	if item && isActive {
		unequipItem(getItemAtSelectorPosition(id));
	}
}