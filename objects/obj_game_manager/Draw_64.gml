
if room == game_menu {

	// game title
	var vw = view_get_wport(view_camera[0]);
	draw_set_color(c_white); draw_set_halign(fa_center); draw_set_valign(fa_center);
	draw_set_font(font_big);
	draw_text(vw/2,50,"UNFAIRYTALE");

	switch state {
		
		// Main title screen
		case TitleScreenState.Options: {
			drawGameMenuScreen();
			break;
		}
		case TitleScreenState.Load: {
			drawLoadGameScreen();
			break;
		}
		case TitleScreenState.New: {
			drawNewGameScreen();
			break;
		}
	}
	
}

