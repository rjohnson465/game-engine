if hp <= 0 && isActive && !isSurrendering {
	isSurrendering = true;
	sprite_index = spr_hershel_defeat;
	audio_play_sound_at(snd_enemy_golem_die_1,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
}

if isGoingToAri {
	// grid path your way to Ari
	var ari = instance_nearest(x, y, obj_npc_ari);
	if instance_exists(ari) && !isPathSet {
		mp_grid_path(grid, gridPath, x, y, ari.x, ari.y, true);
		path_start(gridPath, 5, path_action_stop, true);
		isPathSet = true;
		sprite_index = spr_hershel_move;
		// play walk sound
		walkingSoundIndex = audio_play_sound_on(walkingEmitter, snd_walking_heavy, 1, 0);
	} 
	
	if isPathSet {
		
		image_angle = direction;
	}
	
	// if near Ari, jchill
	if instance_exists(ari) && distance_to_object(ari) < 50 {
		path_end();
		audio_stop_sound(walkingSoundIndex)
		sprite_index = spr_hershel_idle;
		isPathSet = false;
		isGoingToAri = false;
		isWithAri = true;
		// TODO emit heart particles lol
	}
}

if isWithAri {
	part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(system, emitter, particle, -8);
}