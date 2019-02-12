if gamepad_is_connected(global.gamePadIndex) window_set_cursor(cr_none);
else window_set_cursor(cr_default);
if isLoading {
	// wait until we're at the right room to actually load
	if isReadyToMoveRooms && room_get_name(room) == roomToGoTo {
		alert("Loading " + currentSaveFile, c_yellow);
		isLoading = false;
		roomToGoTo = noone;
		isReadyToMoveRooms = false;
	
		fs_load_game(currentSaveFile);
	}
}

if instance_exists(fade) {
	if state == TitleScreenState.Load {
		if fade.frame == .5*fade.fadeDuration {
			with global.player {
				global.playerDoNothing = false;
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