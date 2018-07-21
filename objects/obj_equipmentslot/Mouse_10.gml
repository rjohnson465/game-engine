if item && item.name != "Unarmed" && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	global.equippedItemsManager.selectedItem = item;
}