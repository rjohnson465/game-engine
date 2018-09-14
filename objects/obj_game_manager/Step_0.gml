var a = ds_list_create();
var b = ds_map_create();
ds_list_destroy(a); a = -1;
ds_map_destroy(b); b = -1;

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