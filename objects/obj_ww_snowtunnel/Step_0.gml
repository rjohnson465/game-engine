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

if	p.currentInteractableObject == id 
	&& origLayer == p.layer && interactInputReceived && p.isAlive && !global.isLooting && !isInConvo {
	
	if !isOpen {
		alert("Trapdoor locked from other side!", c_red);
	}
	else {
		// take player to other end of tunnel
		var otherTunnelEntrance = noone;
		with obj_ww_snowtunnel {
			if tunnelEntranceKey == other.otherTunnelEntranceKey {
				otherTunnelEntrance = id;
			}
		}
		
		if instance_exists(otherTunnelEntrance) {
			
			with obj_player {
				
				// stop player from doing anything
				global.isTrading = true;
				audio_play_sound(snd_snow_crunch, 1, 0);
				visible = false;
				isInvulnerable = true;
				
				// assign path to player
				var pathToTunnel = path_add();
				
				x = other.x; y = other.y;
				
				path_add_point(pathToTunnel, x, y, 100);
				path_add_point(pathToTunnel, otherTunnelEntrance.x - 0, otherTunnelEntrance.y - 0, 100);
				// path_add_point(pathToTunnel, otherTunnelEntrance.x - 500, otherTunnelEntrance.y - 100, 100);
				
				path_set_closed(pathToTunnel, false);
				path_start(pathToTunnel, 25, path_action_stop, true);
				
				global.gameManager.deactivationSteps = 2;
			}

			
		}
		
	}
	
} 

// collision with player moving to this tunnel
if p.path_index >= 0 && global.isTrading && p.path_position > .5 && distance_to_object(p) < 50 {
	if !isOpen {
		isOpen = true;
		// ds_map_replace(properties, "IsOpen", true);
		updatePersistentElementProperty(id, "IsOpen", true);
		audio_play_sound_at(snd_door_open, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		sprite_index = spr_ww_snowtunnel_open;
	}
	global.isTrading = false;
		with p {
			isInvulnerable = false;
			var pathToTunnel = path_index;
			path_end();
			path_delete(pathToTunnel);
			visible = true;
		}
		global.gameManager.deactivationSteps = DEACTIVATION_STEPS_DEFAULT;
}