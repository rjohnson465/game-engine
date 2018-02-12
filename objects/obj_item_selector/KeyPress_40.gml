if !isActive || !ui.isShowingMenus exit;

if isSelectorInEquippedItems() {
	moveSelectorInEquippedItems("down");
	eq.selectedItem = getItemAtSelectorPosition(id);
}