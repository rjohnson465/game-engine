ownerTouchingWater = false;
with obj_water {
	if distance_to_object(other.owner) < 2 && layer == other.owner.layer {
		other.ownerTouchingWater = true;
	}
}

if !owner.isMoving && !isDestroying {
	isDestroying = true;
	alarm[0] = 30;
} 

var doNotShutUp = false;
// only stop the walking in water sound if there are no other water_particles instances with this owner that arent destroying
with obj_water_particles {
	if owner == other.owner && !isDestroying {
		doNotShutUp = true;
	}
}
if !doNotShutUp && !ownerTouchingWater audio_emitter_gain(owner.walkingInWaterEmitter,0);