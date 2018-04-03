if !isActive || !ui.isShowingMenus || ui.currentMenu != INVENTORY exit;

if isSelectorInEquippedItems() {
	moveSelectorInEquippedItems("up");
	eq.selectedItem = getItemAtSelectorPosition(id);
} 

else if isSelectorInInventory {
	
	// if we're not at the highest row in inventory, move up
	if y1 > inv.invTopLeftY {
		y1 -= inv.slotHeight;
		inv.selectedItem = getItemAtSelectorPosition(id);
	}
	
	
	else if inv.scrollLevel != 0 {
		inv.scrollLevel--;
		inv.selectedItem = getItemAtSelectorPosition(id);
	}
}