if item && item.name != "Unarmed" && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	if global.equippedItemsManager.selectedItem != item {
		audio_play_sound(snd_ui_option_change,1,0);
	}
	global.equippedItemsManager.selectedItem = item;
	
}