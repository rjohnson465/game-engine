// this always means we're going back to the main menu?
// save / exit was selected
if instance_exists(fade) {
	if fade.frame == .5*fade.fadeDuration {
		fs_save_game(); // this SHOULD flush temp data cache
		//game_restart();
		with all {
			//if object_index != obj_game_manager {
				instance_destroy(id,1);
			//}
		}
		// just kill everything, hard reset
		var partSystems = ds_list_create();
		for (var i = 0; i < 100000; i++) {
			var s = i;
			if ds_exists(s, ds_type_map) {
				ds_map_destroy(s);
			}
			if ds_exists(s, ds_type_list) && s != partSystems {
				ds_list_destroy(s);
			}
			if part_type_exists(s) {
				part_type_destroy(s);
			}
			if audio_emitter_exists(s) {
				audio_emitter_free(s);
			}
			if path_exists(s) {
				path_delete(s);
			}
			if ds_exists(s, ds_type_grid) {
				ds_grid_destroy(s);
			}
			if surface_exists(s) {
				surface_free(s);
			}
			if part_system_exists(s) {
				ds_list_add(partSystems, s);
			}
			s = -1;
		}
		
		for (var i = 0; i < ds_list_size(partSystems); i++) {
			var ps = ds_list_find_value(partSystems, i);
			part_emitter_destroy_all(ps);;
			part_system_destroy(ps);
		}
		
		ds_list_destroy(partSystems); partSystems = -1;
		room_goto(game_menu);
	}
}