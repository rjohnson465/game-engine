/// useItem(item)
/// @param item
/// item must be usable
/// must be called by player obj

var item = argument[0];
if item == noone exit;
if !item.canUse exit;

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
	// alert("Used " + name,c_yellow);
	isInUse = true;
	if other.state != CombatantStates.Healing {
		// audio_play_sound(soundUse,1,0);
	}
}