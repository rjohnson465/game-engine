if layer == global.player.layer && fallFrame >= fallTotalFrames {
	with obj_attack {
		var cpexists = script_execute(scr_collision_point,id,other.id)
		if place_meeting_layer(x,y,other.id) || cpexists || (isRanged && distance_to_object(other.id) < 5) {
			with other {
				calculateDamage();
			}
		}
	}
}
previousFacingDirection = facingDirection;

if part_type_exists(sprintParticle) && isSprinting {
	part_type_direction(sprintParticle,movingDirection-45,movingDirection+45,0,0);
	part_type_orientation(sprintParticle,facingDirection, facingDirection,0,0,0);
	part_system_depth(sprintParticleSystem,depth+1);
	part_emitter_region(sprintParticleSystem, sprintParticleEmitter, x-1, x+1, y-1, y+1,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(sprintParticleSystem,sprintParticleEmitter,sprintParticle,-1);
}

