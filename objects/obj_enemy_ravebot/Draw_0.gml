if state == "Eat" {
	if sprite_index != spr_enemy_ravebot_summon {
		sprite_index = spr_enemy_ravebot_summon;
	}
	draw_sprite_ext(spr_enemy_ravebot_summon, image_index, x, y, 1, 1, facingDirection, c_white, 1);
}
else {
	event_inherited();
}