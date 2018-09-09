with obj_combatant_parent {
	if place_meeting_layer(x,y,other) && isMoving {
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