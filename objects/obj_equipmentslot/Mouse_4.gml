if item && item.name != "Unarmed" && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY && !hasSetAlarm {
	//global.ui.grabbedItem = item;
	alarm[0] = 1;
	hasSetAlarm = true;
}
