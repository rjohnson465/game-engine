with obj_combatant_parent {
	if place_meeting_layer(x,y,other) && isMoving {
		if isBurning {
			audio_play_sound_at(snd_magic_fire_hit,x,y,depth,100,300,1,0,1);
			ds_map_replace(conditionPercentages,FIRE,0);
		}
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