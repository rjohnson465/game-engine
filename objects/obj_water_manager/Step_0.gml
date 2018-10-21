with obj_combatant_parent {
	
	var floorNum = getLayerFloorNumber(layer);
	var s = "tiles_water_floor_"+string(floorNum);
	var l = layer_get_id(s);
	if !layer_exists(l) continue;
	var tmap = layer_tilemap_get_id(l);
	if tmap >= 0 {
		var tile = tilemap_get_at_pixel(tmap,x,y);
		if tile {
			if isBurning {
				audio_play_sound_at(snd_magic_fire_hit,x,y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
				ds_map_replace(conditionPercentages,FIRE,0);
			}
			
			if !isMoving exit;
			
			var currentWaterParticlesObj = noone; 
			var currentWaterParticlesObjIsDestroying = false;
			with obj_water_particles {
				if owner == other {
					currentWaterParticlesObj = id;
				}
			}
			if currentWaterParticlesObj != noone && currentWaterParticlesObj.isDestroying {
				currentWaterParticlesObjIsDestroying = true;
			}
			if currentWaterParticlesObj == noone || currentWaterParticlesObjIsDestroying {
				global.owner = id;
				instance_create_depth(x,y,1,obj_water_particles);
			}
		}
	}
}