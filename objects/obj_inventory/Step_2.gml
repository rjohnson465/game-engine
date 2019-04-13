if !global.ui.isShowingMenus || global.ui.currentMenu != INVENTORY exit;
if isConfirmingDestroyItem exit;

// don't allow filter swapping if in equip mode
var isEquipping = false;
var p = global.player;
var pad = p.gamePadIndex;
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
		// enter the 'belt item equipping' mode
		if !p.isEquippingBeltItem {
			p.isEquippingBeltItem = true;
			justStartedBeltEquipping = true;
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
	if !global.player.isEquippingBeltItem && selectedItem != noone && selectedItem.isDestroyable && isSelectorInInventory(global.ui.moveSelector) {
		isConfirmingDestroyItem = true;
		audio_play_sound(snd_ui_tab1,1,0);
	}
}

// show explanations
if gamepad_button_check_pressed(global.player.gamePadIndex,gp_select) {
	global.ui.isShowingExplanations = !global.ui.isShowingExplanations;
	audio_play_sound(snd_ui_option_change,1,0);
}

// maybe allow for belt item equipping
if p.isEquippingBeltItem {
	// TODO -- also allow for jostick input
	if gamepad_button_check_pressed(pad, gp_padl) {
		var proposedNewIndex = selectedBeltItemIndex;
		proposedNewIndex--;
		if proposedNewIndex < 0 {
			proposedNewIndex = array_length_1d(p.beltItems) - 1;
		}
		selectedBeltItemIndex = proposedNewIndex;
		audio_play_sound(snd_ui_option_change, 1, 0);
	}
	if gamepad_button_check_pressed(pad, gp_padr) {
		var proposedNewIndex = selectedBeltItemIndex;
		proposedNewIndex++;
		if proposedNewIndex > array_length_1d(p.beltItems) - 1 {
			proposedNewIndex = 0;
		}
		selectedBeltItemIndex = proposedNewIndex;
		audio_play_sound(snd_ui_option_change, 1, 0);
	}
	
	// cancel belt equipping
	if gamepad_button_check_pressed(pad, gp_face2) {
		p.isEquippingBeltItem = false;
		audio_play_sound(snd_ui_click1, 1, 0);
	}
	
	// unequip selected belt item
	if gamepad_button_check_pressed(pad, gp_face3) && !justStartedBeltEquipping {
		unequipBeltItem(selectedBeltItemIndex);
	}
	
	// make justStartedBeltEquipping false after x button is released
	if gamepad_button_check_released(pad, gp_face3) && justStartedBeltEquipping {
		justStartedBeltEquipping = false;
	}
	
	// equip belt item
	if gamepad_button_check_pressed(pad, gp_face1) {
		equipBeltItem(selectedBeltItemIndex, selectedItem);
		
	}
}