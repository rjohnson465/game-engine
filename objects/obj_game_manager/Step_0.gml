if gamepad_is_connected(global.gamePadIndex) window_set_cursor(cr_none);
else window_set_cursor(cr_default);
if isLoading {
	// wait until we're at the right room to actually load
	if isReadyToMoveRooms && room_get_name(room) == roomToGoTo {
		alert("Loading " + currentSaveFile, c_yellow);
		
		roomToGoTo = noone;
		isReadyToMoveRooms = false;
	
		fs_load_game(currentSaveFile);
		
		// debug shit
		var mapsCount = 0;
		for (var i = 0; i < 100000; i++) {
			var map = i;
			if (ds_exists(map, ds_type_map)) {
				mapsCount++;
				var ck = ds_map_find_first(map);
				for (var j = 0; j < ds_map_size(map); j++) {
					var val = ds_map_find_value(map, ck);
					//show_debug_message("map" + string(i) + " at key " + string(ck) + ": " + string(val));
					ck = ds_map_find_next(map, ck);
				}
			}
		}
		show_debug_message("Total maps: " + string(mapsCount));

		var listsCount = 0;
		for (var i = 0; i < 100000; i++) {
			var list = i;
			if (ds_exists(list, ds_type_list)) {
				listsCount++;

				for (var j = 0; j < ds_list_size(list); j++) {
					var val = ds_list_find_value(list, j);
					// show_debug_message("list" + string(i) + " at key " + string(j) + ": " + string(val));

				}
			}
		}
		show_debug_message("Total lists: " + string(listsCount));

		var instancesCount = 0;
		with all {
	
			instancesCount++;
		}
		show_debug_message("Total instances: " + string(instancesCount));



		
		
		
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