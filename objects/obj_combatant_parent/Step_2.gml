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

if	type != CombatantTypes.Player && attackData != noone && attackData.prepPart1 != noone 
	&& part_type_exists(attackData.prepPart1) && ds_map_size(preparingLimbs) != 0 {
	var parttype = attackData.prepPart1;
	// TODO maybe define a more specific burst region
	if attackData.prepPart1BelowOwner {
		part_system_depth(appSystem, layer_get_depth(layer)+1);
	}
	part_emitter_region(appSystem,appEmitter,bbox_left, bbox_right, bbox_top, bbox_bottom, ps_shape_ellipse, ps_distr_gaussian);
	part_emitter_burst(appSystem,appEmitter,parttype, attackData.prepPart1Num);
}