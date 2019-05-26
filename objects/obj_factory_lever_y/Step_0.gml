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

if distance_to_object(obj_player) < 20 && origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	isActive = !isActive;
	updatePersistentElementProperty(id, "IsActive", isActive);
	
	// deactivate conveyer belts not associated with this lever, and in turn, all levers that aren't this one
	// this only applies to belts and levers on the same layer
	with obj_factory_cb_parent {
		if origLayer == other.origLayer {
			if lever != other {
				with lever {
					isActive = false;
					updatePersistentElementProperty(id, "IsActive", isActive);
				}
			}
		}
	}
	
	audio_play_sound_at(snd_metalhit1, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
} 