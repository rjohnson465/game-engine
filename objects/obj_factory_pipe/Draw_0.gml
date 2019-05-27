if isActive {
	draw_sprite_ext(sprOn, image_index, x, y, 1, 1, image_angle, c_white, 1);
} else {
	draw_sprite_ext(sprOff, 1, x, y, 1, 1, image_angle, c_white, 1);
}