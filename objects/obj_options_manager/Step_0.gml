// this always means we're going back to the main menu?
// save / exit was selected
if instance_exists(fade) {
	if fade.frame == .5*fade.fadeDuration {
		fs_save_game();
		game_restart();
		//instance_destroy(global.player);
		//fs_save_game();
		//with global.player {
		//	instance_destroy(id,1);
		//}
		//with global.player {
		//	global.playerDoNothing = true;
			//event_perform(ev_create, 0);
		//}
		//room_goto(game_menu);
	}
}