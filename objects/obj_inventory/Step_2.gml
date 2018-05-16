// controller stuff
if gamepad_button_check_pressed(global.player.gamePadIndex,gp_shoulderrb) && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	var currentFilter = ds_map_find_value(filterSprites, filter);
	var nextFilter = ds_map_find_next(filterSprites,filter);
	if nextFilter != undefined {
		filter = nextFilter;
	} else {
		filter = ds_map_find_first(filterSprites);
	}
	scrollLevel = 0;

}
if gamepad_button_check_pressed(global.player.gamePadIndex,gp_shoulderlb) && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	var currentFilter = ds_map_find_value(filterSprites, filter);
	var prevFilter = ds_map_find_previous(filterSprites,filter);
	if prevFilter != undefined {
		filter = prevFilter;
	} else {
		filter = ds_map_find_last(filterSprites);
	}
	scrollLevel = 0;
}

if gamepad_button_check_pressed(global.player.gamePadIndex,gp_face4) && global.ui.isShowingMenus && global.ui.currentMenu == INVENTORY {
	global.ui.isShowingExplanations = !global.ui.isShowingExplanations;
}