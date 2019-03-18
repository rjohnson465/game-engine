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
		room_goto(game_menu);
	}
}