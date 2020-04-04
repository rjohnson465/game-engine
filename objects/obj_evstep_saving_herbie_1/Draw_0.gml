
with herbie {
	
	/*
	draw_set_color(c_lime);
	draw_path(gridPath, x, y, false);
	
	draw_set_alpha(.25);
	mp_grid_draw(personalGrid);
	*/
	
	if other.message == other.DESC_FIGHT || other.message == other.DESC_LONELY {
		draw_sprite_ext(spr_icon_fear, 1, x, y - 64, scale, scale, 0, c_white, .75);
	}
	
}