event_inherited();

if !hasSetAlarm {
	if layer == global.player.layer {
		with obj_attack {
			// TODO
			if hasHitMaxDestructables(owner, id) exit;
			
			var cpexists = script_execute(scr_collision_point,id,other.id)
			if place_meeting_layer(x,y,other.id) || cpexists || (isRanged && distance_to_object(other.id) < 5) {
				with other {
					var wallsBetween = scr_collision_line_list_layer(x, y, other.x, other.y, obj_wall_parent, true, true);
					if wallsBetween == noone {
					
						// burst particles
						part_emitter_region(system, emitter, x, x, y, y, ps_shape_ellipse, ps_distr_gaussian);
						for (var i = 0; i < array_length_1d(particles); i++) {
							var pArr = particles[i];
							var p = pArr[0];
							if part_type_exists(p) {
								var pNum = pArr[1];
								part_emitter_burst(system, emitter, p, pNum);
							}
						}
					
						// play destruction sound
						audio_play_sound_at(destructionSound, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
						
						// add this destructable object to the attack's destructablesHit list
						if variable_instance_exists(other, "destructablesHit") && ds_exists(other.destructablesHit, ds_type_list) {
							ds_list_add(other.destructablesHit, other);
						}
						
						// if ranged attack, destroy it 
						with other {
							if isRanged {
								instance_destroy(id, 1);
							}
						}
					
						// destroy item (after 2 second delay)
						visible = false;
						sprite_index = -1;
						alarm[0] = 60;
						hasSetAlarm = true;
					
					} else {
						ds_list_destroy(wallsBetween); wallsBetween = -1;
					}
				}
			}
		}
	}
}