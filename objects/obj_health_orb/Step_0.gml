if isMoving {
	var actualSpeed = moveSpeed * (alarm[0] / 45);
	moveToNearestFreePoint(moveDirection, actualSpeed, 1, 1);
	audio_emitter_position(sndEmitter, x, y, depth);
}

if !hasSetAlarm {
	part_emitter_region(system, emitter, bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(system, emitter, particle, 5);
}

var p = global.player;
if !isMoving && distance_to_object(p) < 50 && layer == p.layer && !hasSetAlarm {
	if !place_meeting(x, y, p) {
		// gravitate toward player
		move_towards_point(p.x, p.y, 8);
	}
	// actually get picked up by player
	else {
		// burst pick up particles
		part_emitter_region(system, emitter2, p.x, p.x, p.y, p.y, ps_shape_ellipse, ps_distr_gaussian);
		part_emitter_burst(system, emitter2, particle2, 30);
		
		with lightRadius {
			instance_destroy(id, 1);
		}
		
		// set alarm[1] to 30 (destroy the object in 30 frames, so particles can fade out)
		alarm[1] = 60;
		hasSetAlarm = true;
		
		// play sound, stop idle sound
		audio_play_sound(soundPickup, 1, 0);
		audio_emitter_gain(sndEmitter, 0);
		
		// add a charge to flask, if it is not already full
		var healthFlask = instance_nearest(x, y, obj_item_health_flask);
		if (healthFlask != noone && healthFlask != undefined && healthFlask > 0 && instance_exists(healthFlask) && healthFlask.owner == p) {
			// give at most 1 health charge
			var chargesCount = ds_map_find_value(healthFlask.customItemProperties, hfs_charges);
			var chargesMax = ds_map_find_value(healthFlask.customItemProperties, hfs_max_charges);
			if chargesCount != chargesMax {
				ds_map_replace(healthFlask.customItemProperties, hfs_charges, chargesCount+1);
			} 
			// if charges are already maxed, heal player for 50 hp
			else {
				p.hp += 50;
				if p.hp > p.maxHp {
					p.hp = p.maxHp;
				}
			}
		}
		else {
			// if no flask in inventory, heal the player for 50 hp
			p.hp += 50;
			if p.hp > p.maxHp {
				p.hp = p.maxHp;
			}
		}
	}
}