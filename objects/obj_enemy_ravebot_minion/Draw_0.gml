

if state == "Growing" {
	image_xscale += (1/room_speed)/3;
	image_yscale += (1/room_speed)/3;
	image_alpha += (1/room_speed)/3;
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, facingDirection, c_white, image_alpha);
	
	part_emitter_region(summonPartSystem, summonPartEmitter, x-16, x+16, y-16, y+16, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(summonPartSystem, summonPartEmitter, summonParticle1, 3);
	part_emitter_burst(summonPartSystem, summonPartEmitter, summonParticle2, 3);
	
	if image_xscale >= 1 {
		image_xscale = 1;
		image_yscale = 1;
		image_alpha = 1;
		state = CombatantStates.Idle;
		jumpToNearestFreePoint(true, true);
	}
} else {
	image_xscale = 1;
		image_yscale = 1;
		image_alpha = 1;
	event_inherited();
}