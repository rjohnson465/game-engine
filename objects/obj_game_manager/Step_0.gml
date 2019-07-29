if global.isUpdatingRoomLayers {
	
	// ????
	updateRoomLayers();
	
	// must activate all instances on step 1,
	if !hasReactivatedObjectsForLayers {
		instance_activate_all();
		hasReactivatedObjectsForLayers = true;
	}
	// then when next step happens, actually update layer elements visibility
	else {
		updateRoomLayers();
		hasReactivatedObjectsForLayers = false;
		global.isUpdatingRoomLayers = false;
	}
} 



if gamepad_is_connected(global.gamePadIndex) window_set_cursor(cr_none);
else window_set_cursor(cr_default);
if isLoading {
	// wait until we're at the right room to actually load
	if isReadyToMoveRooms && room_get_name(room) == roomToGoTo {
		alert("Loading " + currentSaveFile, c_yellow);
		
		roomToGoTo = noone;
		isReadyToMoveRooms = false;
	
		fs_load_game(currentSaveFile);
		
		// recreate all global maps
		// event_perform(ev_create, 0);
		
		// end loading process after player is created?
		isLoading = false;
	}
}

if instance_exists(fade) {
	if state == TitleScreenState.Load {
		if fade.frame == .5*fade.fadeDuration {
			with global.player {
				global.playerDoNothing = false;
				global.populateInventory = false;
				event_perform(ev_create, 0);
			}
			loadGame();
		}
	}
	
	if state == TitleScreenState.New {
		if fade.frame == .5*fade.fadeDuration {
			with global.player {
				global.playerDoNothing = false;
				event_perform(ev_create, 0);
			}
			newGame();
		}
	}
}