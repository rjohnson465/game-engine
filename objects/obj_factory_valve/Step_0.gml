var p = global.player;

var interactInputReceived = keyboard_check_released(ord("F"));
if gamepad_is_connected(global.player.gamePadIndex) {
	interactInputReceived = keyboard_check_released(ord("F")) || 
	(gamepad_button_check_pressed(global.player.gamePadIndex,gp_face1) && !global.ui.isShowingMenus)
}

var isInConvo = false;
with obj_npc_parent {
	if isInConversation isInConvo = true;
}

// cannot turn valve if one of its pipes is currently cooling down a floor
var canTurnValve = true;
for (var i = 0; i < ds_list_size(associatedPipes); i++) {
	var pipe = ds_list_find_value(associatedPipes, i);
	with obj_molten_floor {
		if instance_exists(douser) && douser == pipe && isCoolingDown {
			canTurnValve = false;
		}
	}
}

if canTurnValve && distance_to_object(obj_player) < 20 && origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	isActive = !isActive;
	updatePersistentElementProperty(id, "IsActive", isActive);
	
	audio_play_sound_at(snd_metalhit1, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
} 