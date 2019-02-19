ownerTouchingWater = false;
/*with obj_water {
	if distance_to_object(other.owner) < 2 && layer == other.owner.layer {
		other.ownerTouchingWater = true;
	}
}*/

with owner {
	var floorNum = getLayerFloorNumber(layer);
	var s = "tiles_water_floor_"+string(floorNum);
	var l = layer_get_id(s);
	if !layer_exists(l) break;
	var tmap = layer_tilemap_get_id(l);
	if tmap >= 0 {
		var tile = tilemap_get_at_pixel(tmap,x,y);
		if tile {
			other.ownerTouchingWater = true;
		}
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
if !doNotShutUp && !ownerTouchingWater {
	audio_stop_sound(owner.walkingInWaterSoundId);
	owner.walkingInWaterSoundId = noone;
	audio_emitter_gain(owner.walkingInWaterEmitter,0);
}