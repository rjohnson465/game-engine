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
maybeAddOrRemoveFromInteractablesList(20);

if	p.currentInteractableObject == id &&
	origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	isActive = !isActive;
	updatePersistentElementProperty(id, "IsActive", isActive);
	
	// deactivate every lever in group and their associated bridges
	if group != noone {
		with obj_ww_lever {
			if id == other continue;
			if group == other.group {
				isActive = false;
				for (var i = 0; i < ds_list_size(associatedBridges); i++) {
					var br = ds_list_find_value(associatedBridges, i);
					br.isActive = false;
					br.image_xscale = 0; br.image_yscale = 0; 
					with br {
						light_set_alpha(0);
					}
				}
			}
		}
	}

	for (var i = 0; i < ds_list_size(associatedBridges); i++) {
		var br = ds_list_find_value(associatedBridges, i);
		br.isActive = isActive;
		if isActive {
			br.image_xscale = br.xscale; br.image_yscale = br.yscale;
			with br {
				light_set_alpha(lightAlpha);
			}
		}
		else {
			br.image_xscale = 0; br.image_yscale = 0; 
			with br {
				light_set_alpha(0);
			}
		}
	}
	
	/* ????
	for (var i = 0; i < ds_list_size(deactivateBridges); i++) {
		var br = ds_list_find_value(deactivateBridges, i);
		br.isActive = !isActive;
		if !isActive {
			br.image_xscale = br.xscale; br.image_yscale = br.yscale;
			with br {
				light_set_alpha(lightAlpha);
			}
		}
		else {
			br.image_xscale = 0; br.image_yscale = 0; 
			with br {
				light_set_alpha(0);
			}
		}
	} */
	
	if repopulatesGrids {
		global.isPopulatingGrids = true;
	}

	
	// deactivate bridges not associated with this lever, and in turn, all levers that aren't this one
	// this only applies to belts and levers on the same layer
	/*with obj_factory_cb_parent {
		if origLayer == other.origLayer {
			if lever != other {
				with lever {
					isActive = false;
					updatePersistentElementProperty(id, "IsActive", isActive);
				}
			}
		}
	}*/
	
	audio_play_sound_at(snd_metalhit1, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
} 