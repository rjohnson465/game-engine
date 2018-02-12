if !isActive || !ui.isShowingMenus exit;

// move selector to next slot on left, if it exists
if !isSelectorAtFirstInventoryColumn() && isSelectorInInventory() {
	x1 -= slotWidth;
	if isSelectorInInventory() {
		inv.selectedItem = getItemAtSelectorPosition(id);
	}
}

else if isSelectorInEquippedItems() {
	moveSelectorInEquippedItems("left");
	eq.selectedItem = getItemAtSelectorPosition(id);
}