if !instance_exists(limb) {
	instance_destroy(id,1);
}

if limbItem.baseName == "Torch" {
	fireOffsetX = 50; fireOffsetY = 0;
	if torchLightRadius == noone || !instance_exists(torchLightRadius) {
		global.owner = id;
		global.makeLightOnCreate = true;
		torchLightRadius = instance_create_depth(x,y,owner.depth,obj_light_radius);
	}
	if owner.hp < 1 {
		audio_emitter_gain(torchAudioEmitter,0);
		instance_destroy(torchLightRadius,1);
		torchLightRadius = noone;
	}
} else {
	fireOffsetX = noone; fireOffsetY = noone;
	if torchLightRadius != noone || !instance_exists(torchLightRadius) {
		if instance_exists(torchLightRadius) {
			instance_destroy(torchLightRadius,1);
		}
		torchLightRadius = noone;
	}
	audio_emitter_gain(torchAudioEmitter,0);
}


if fireOffsetX != noone && owner.isAlive && owner.currentUsingSpell == noone {
	audio_emitter_gain(torchAudioEmitter,.4);
	// destroy torch parts, emitters, and systems to avoid mem leak
	if part_type_exists(torchParticle1) part_type_destroy(torchParticle1);
	if part_type_exists(torchParticle2) part_type_destroy(torchParticle2);
	
	// fire particle
	var fire = part_type_create();
	part_type_sprite(fire,spr_particle_fire,0,0,1);
	part_type_size(fire,.05*owner.scale,.15*owner.scale,0,0);
	part_type_color2(fire,c_orange,c_red);
	part_type_alpha3(fire,1,1,0);
	part_type_speed(fire,4,10,0,0);
	part_type_direction(fire,85,95,0,5);
	part_type_orientation(fire,0,359,0,0,0);
	part_type_blend(fire,1);
	part_type_life(fire,5,8);
	torchParticle1 = fire;
		
	// cinder Particle
	var cinder = part_type_create();
	part_type_shape(cinder,pt_shape_flare);
	part_type_size(cinder,0,.1,0,0);
	part_type_color2(cinder,c_orange,c_red);
	part_type_alpha3(cinder,1,1,0); 
	part_type_speed(cinder,1,2,0,0);
	part_type_direction(cinder,85,95,0,0);
	part_type_blend(cinder,1);
	part_type_life(cinder,25,50);
	torchParticle2 = cinder;
	
	// get state and frame
	var frame = 0; var state = "";
	// preparing limb
	if ds_map_find_value(owner.preparingLimbs,limbKey) >= 0 {
		frame = ds_map_find_value(owner.prepFrames,limbKey)
		state = "prep";
	
	}

	// attacking limb
	else if ds_map_find_value(owner.attackingLimbs,limbKey) >= 0 {
		frame = ds_map_find_value(owner.attackFrames,limbKey)
		state = "attack";
	}

	// recovering limb
	else if ds_map_find_value(owner.recoveringLimbs,limbKey) >= 0 {
		frame = ds_map_find_value(owner.recoverFrames,limbKey)
		state = "recover";
	}
	
	var offsets = getTorchOffset(state,frame);
	var xo = offsets[0]; var yo = offsets[1];
	
	var ofd = owner.facingDirection;
	var sx = owner.x + xo; var sy = owner.y + yo;
	var cx = owner.x; var cy = owner.y;
	var radians = (pi/180) * ofd;
	var cs = cos(radians);
	var sn = sin(radians);
	var nx = (cs * (sx - cx)) + (sn * (sy - cy)) + cx;
	var ny = (cs * (sy - cy)) - (sn * (sx - cx)) + cy;
	
	var xx = nx;
	var yy = ny;
	
	part_emitter_region(torchSystem1,torchEmitter1,xx-1,xx+1,yy-1,yy+1,ps_shape_diamond,ps_distr_gaussian);
	part_emitter_burst(torchSystem1,torchEmitter1,fire,5);
	audio_emitter_position(torchAudioEmitter,xx,yy,owner.depth);
	with torchLightRadius {
		x = xx; y = yy;
	}
}