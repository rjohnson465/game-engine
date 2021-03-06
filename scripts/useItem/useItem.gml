/// useItem(item)
/// @param item
/// item must be usable
/// must be called by player obj

var item = argument[0];
if item == noone exit;
if !item.canUse exit;

with obj_tutorial_exercise_beltitems {
	// the belt items tutorial is teaching to equip to belt and use from there
	// so do not allow usage from inventory screen
	if isActive && global.ui.isShowingMenus exit; 
}

if item.object_index == obj_item_health_flask && state != CombatantStates.Healing {
	if global.ui.isShowingMenus {
		with global.ui {
			showHideInventory();
		}
	}
	state = CombatantStates.Healing;
	audio_play_sound(item.soundUse,1,0);
	exit;
}

with item {
	isInUse = true;
}

if item.equipmentSlot != noone {
	if item.count < 1 && item.isStackable {
		var eq = global.player.equippedItems;
		var pos = ds_list_find_index(eq, item);
		ds_list_delete(eq, pos);
	}
}