if !isActive || !ui.isShowingMenus exit;

if isSelectorInEquippedItems() {
	moveSelectorInEquippedItems("up");
	eq.selectedItem = getItemAtSelectorPosition(id);
}