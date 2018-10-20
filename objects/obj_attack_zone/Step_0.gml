image_angle = facingDirection;
if !hasSetAlarm && part_type_exists(particle) {
	if layer >= global.player.layer {
		var x1 = bbox_left; var x2 = bbox_right;
		var y1 = bbox_top; var y2 = bbox_bottom;
		var w = x2-x1; var h = y2 - y1;
		var area = w*h;
		//show_debug_message(sprite_get_name(sprite_index) + " " + string(image_index) + ": " + string(bbox_left) + " " + string(bbox_right));
		// randomly spawn 4(??) particles somewhere in the collision mask of sprite_index
		for (var i = 0; i < 4; i++) {
			var xx = -50; var yy = -50;
			var pm = false;
			do {
				randomize();
				xx = random_range(x1,x2); yy = random_range(y1,y2);
				var parti = instance_create_depth(xx,yy,1,obj_attack_zone_part);
				var pm = place_meeting(x,y,parti);
				instance_destroy(parti,1);
			} until (pm)
			//part_particles_create(system,xx,yy,particle,1);
			part_emitter_region(system,emitter,xx,xx,yy,yy,ps_shape_ellipse,ps_distr_gaussian);
			part_emitter_burst(system,emitter,particle, 1);
		}
		
	}
}

if owner.state == CombatantStates.Staggering && !hasSetAlarm {
	// once the attack is done, remove the id from the list of attacks that have hit all the combatants this attack hit
if combatantsHit {
	for (var i = 0; i < ds_list_size(combatantsHit); i++) {
		var combatantHitWithThisAttack = ds_list_find_value(combatantsHit,i);
		ds_list_delete(combatantHitWithThisAttack.beenHitWith, ds_list_find_index(combatantHitWithThisAttack.beenHitWith,id));
		}
	}

	// set recoveringLimbs at limbKey to the attackNumberInChain that is recovering
	var attackInChain = ds_map_find_value(owner.attackingLimbs,limbKey);
	ds_map_replace(owner.recoveringLimbs,limbKey,attackInChain);
		
	// set recoverFrames to -1
	ds_map_replace(owner.recoverFrames,limbKey,-1);
		
	// remove limbKey from attackingLimbs map
	ds_map_delete(owner.attackingLimbs,limbKey);
		
	owner.prevAttackHand = limbKey;
	//instance_destroy(id, true);
	alarm[0] = 30;
	hasSetAlarm = true;
	image_speed = 0;
}

if hasSetAlarm {
	var gain = alarm[0]/30;
	audio_emitter_gain(sndEmitter,gain);
}