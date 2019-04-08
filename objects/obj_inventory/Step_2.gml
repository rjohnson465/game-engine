if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;
if isConfirmingDestroyItem exit;

// don't allow filter swapping if in equip mode
var isEquipping = false;
var p = global.player;
with obj_item_selector {
	// if type == SelectorTypes.Equip && isActive isEquipping = true;
}
// controller stuff
if gamepad_button_check_pressed(global.player.gamePadIndex,gp_shoulderr) && !isEquipping  {
	audio_play_sound(snd_ui_tab2,1,0);
	// var currentFilter = ds_map_find_value(filterSprites, filter);
	var nextFilter = ds_map_find_next(filterSprites,filter);
	if nextFilter != undefined {
		filter = nextFilter;
	} else {
		filter = ds_map_find_first(filterSprites);
	}
	scrollLevel = 0;

}

// equip belt item
if filter == InventoryFilters.Other && gamepad_button_check_pressed(global.player.gamePadIndex, gp_face3) {
	if selectedItem != noone && selectedItem.isUsable {
		p.beltItems[0] = selectedItem;
		selectedItem.beltItemIndex = 0;
		// unequip whatever item used to be at that belt index
		with obj_item_parent {
			if id != other.selectedItem && beltItemIndex == 0 {
				beltItemIndex = noone;
			}
		}
	}
}

if gamepad_button_check_pressed(global.player.gamePadIndex,gp_shoulderl) && !isEquipping {
	audio_play_sound(snd_ui_tab2,1,0);
	// var currentFilter = ds_map_find_value(filterSprites, filter);
	var prevFilter = ds_map_find_previous(filterSprites,filter);
	if prevFilter != undefined {
		filter = prevFilter;
	} else {
		filter = ds_map_find_last(filterSprites);
	}
	scrollLevel = 0;
}

// destroy item
if gamepad_button_check_pressed(global.player.gamePadIndex,gp_face4) {
	if selectedItem != noone && selectedItem.isDestroyable && isSelectorInInventory(global.ui.moveSelector) {
		isConfirmingDestroyItem = true;
		audio_play_sound(snd_ui_tab1,1,0);
	}
}

if gamepad_button_check_pressed(global.player.gamePadIndex,gp_select) {
	global.ui.isShowingExplanations = !global.ui.isShowingExplanations;
	audio_play_sound(snd_ui_option_change,1,0);
}