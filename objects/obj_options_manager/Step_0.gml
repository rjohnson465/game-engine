// this always means we're going back to the main menu?
// save / exit was selected
if instance_exists(fade) {
	if fade.frame == .5*fade.fadeDuration {
		fs_save_game();
		game_restart();
	}
}