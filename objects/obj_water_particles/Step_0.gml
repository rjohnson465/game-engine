if owner.isMoving && !isDestroying && ownerTouchingWater {
	var dir = owner.movingDirection;
	dir = (dir+180)%360;
	var emitterGain = audio_emitter_get_gain(owner.walkingInWaterEmitter);
	if emitterGain < 1 {
		emitterGain += .1;
		if emitterGain > 1 emitterGain = 1;
		audio_emitter_gain(owner.walkingInWaterEmitter,emitterGain);	
	}
	audio_emitter_gain(owner.walkingInWaterEmitter,1);
	
	//var water = part_type_create();
	part_type_shape(part1,pt_shape_explosion);
	part_type_size(part1,.05,.15,0,0);
	part_type_color2(part1,c_aqua,c_ltgray);
	part_type_alpha3(part1,1,1,0); 
	part_type_speed(part1,1,2,0,0);
	part_type_direction(part1,dir-45,dir+45,0,0);
	part_type_blend(part1,1);
	part_type_life(part1,15,25);
	
	part_system_depth(system,owner.depth+1);
	part_emitter_region(system, emitter, owner.x-1, owner.x+1, owner.y-1, owner.y+1,ps_shape_ellipse,ps_distr_gaussian);
	part_emitter_burst(system,emitter,part1,-1);
} else {
	var emitterGain = audio_emitter_get_gain(owner.walkingInWaterEmitter);
	if emitterGain > 0 {
		emitterGain -= .1;
		if emitterGain < 0 emitterGain = 0;
		audio_emitter_gain(owner.walkingInWaterEmitter,emitterGain);	
	}
}