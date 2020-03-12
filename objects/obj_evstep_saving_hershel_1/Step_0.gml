if status != EventStepStatus.InProgress exit;

// This step is marked as done when the player's lock on target is a valid enemy
var hershel = instance_nearest(x, y, obj_hershel);

if hershel.hp <= 0 {
	
	//// delete all dybukks
	//if ds_exists(ghostsSpawnedList, ds_type_list) {
	//	for (var i = 0; i < ds_list_size(ghostsSpawnedList); i++) {
	//		var g = ds_list_find_value(ghostsSpawnedList, i);
	//		audio_stop_sound(g.beamSoundLoopIndex);
	//		g.x = -1000; g.y = -1000;
	//		instance_destroy(g, 1);
	//	}
	//}
	
	scr_event_fail(event);
	
}

if ds_exists(ghostsSpawnedList, ds_type_list) {
	
	var isAtLeastOneAlive = false;
	// if all ghosts this step spawned were killed, this step is done
	for (var i = 0; i < ds_list_size(ghostsSpawnedList); i++) {
		var g = ds_list_find_value(ghostsSpawnedList, i);
		if g.hp >= 1 {
			isAtLeastOneAlive = true;
		}
		
		
		with g {
			
			show_debug_message(alarm[3]);
			
			// if ghost is aggroed, alarm3 tracks how long its been since aggro
			if isAggroed && !hasSetUnaggroAlarm {
				// dybukks de-aggro every 5 seconds not hit
				alarm[3] = GHOST_TIME_TO_DEAGGRO;
				hasSetUnaggroAlarm = true;
				audio_stop_sound(beamSoundLoopIndex);
			}
			
			// at alarm3 == 0, dybukks de-aggro and focus on hershel
			if alarm[3] <= 0 && hasSetUnaggroAlarm {
				hasSetUnaggroAlarm = false;
				isAggroed = false;
				beamSoundShootIndex = audio_play_sound_at(snd_magic_magic_shoot, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0 , 1);
				beamSoundLoopIndex = audio_play_sound_at(snd_magic_magic_loop, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 1, 1);
			}
			
			if !isAggroed {
				// turn to hershel 
				turnToFacePoint(2, hershel.x, hershel.y);
				
				// damage hershel
				var angleToHershel = point_direction(x, y, hershel.x, hershel.y);
				var isFacing = angleBetween(facingDirection-90,facingDirection+90,angleToHershel);
				if isFacing {
					hershel.hp -= .05;
				}
			}
			
		}
		
	}
	
	if ds_list_size(ghostsSpawnedList) == GHOSTS_TO_SPAWN_COUNT && !isAtLeastOneAlive {
		status = EventStepStatus.Completed;
		
		hershel.isGoingToAri = true;
	}
	
}