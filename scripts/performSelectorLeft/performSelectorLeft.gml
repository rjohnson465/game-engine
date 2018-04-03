if !isActive || !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

// move selector to next slot on left, if it exists
if !isSelectorAtFirstInventoryColumn() && isSelectorInInventory() {
	x1 -= slotWidth;
	if isSelectorInInventory() {
		inv.selectedItem = getItemAtSelectorPosition(id);
	}
}

else if isSelectorInEquippedItems() {
	moveSelectorInEquippedItems("left");
	if !isSelectorInInventory {
		eq.selectedItem = getItemAtSelectorPosition(id);
	}
}