if isActive && isSelectorInInventory() {
	inv.selectedItem = getItemAtSelectorPosition(id);
}

if isActive && isSelectorInEquippedItems() {
	eq.selectedItem = getItemAtSelectorPosition(id);
}