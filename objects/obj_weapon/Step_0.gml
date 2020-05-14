if room == game_menu exit;
if global.isUpdatingRoomLayers exit;

if !instance_exists(limb) {
	instance_destroy(id,1);
}

if !instance_exists(limbItem) || limbItem == noone {
	limbItem = noone; exit;
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
	if (torchSoundId == noone) {
		torchSoundId = audio_play_sound_on(torchAudioEmitter,snd_torch_loop,1,0);
	}
} else {
	if (torchSoundId != noone) {
		audio_stop_sound(torchSoundId); torchSoundId = noone;
	}
	fireOffsetX = noone; fireOffsetY = noone;
	if torchLightRadius != noone || !instance_exists(torchLightRadius) {
		if instance_exists(torchLightRadius) {
			instance_destroy(torchLightRadius,1);
		}
		torchLightRadius = noone;
	}
	audio_emitter_gain(torchAudioEmitter,0);
}


if layer_get_depth(owner.layer) >= layer_get_depth(global.player.layer) &&
	fireOffsetX != noone && owner.isAlive && owner.currentUsingSpell == noone && owner.state != CombatantStates.Dodging && owner.state != CombatantStates.Healing {
	var lr = noone;
	with obj_light_radius {
		if owner == other lr = id;
	}
	

	
	audio_emitter_gain(torchAudioEmitter,.4);
	// destroy torch parts, emitters, and systems to avoid mem leak
	if part_type_exists(torchParticle1) part_type_destroy(torchParticle1);
	if part_type_exists(torchParticle2) part_type_destroy(torchParticle2);
	
	// fire particle
	var fire = part_type_create();
	part_type_sprite(fire,spr_particle_fire,0,0,1);
	part_type_size(fire,.09*owner.fallScaleFactor,.15*owner.fallScaleFactor,0,0);
	part_type_color2(fire,c_orange,c_red);
	part_type_alpha3(fire,1,1,0);
	part_type_speed(fire,4,7,0,0);
	part_type_direction(fire,85,95,0,5);
	part_type_orientation(fire,0,359,0,0,0);
	part_type_blend(fire,1);
	part_type_life(fire,3,8);
	torchParticle1 = fire;
		
	// Smoke Particle
	var smoke = part_type_create();
	part_type_shape(smoke,pt_shape_smoke);
	part_type_size(smoke,.1,.2,0,0);
	part_type_color2(smoke,c_dkgray,c_gray);
	part_type_alpha3(smoke,.5,.2,0); 
	part_type_speed(smoke,.5,1.5,0,0);
	part_type_direction(smoke,85,95,0,0);
	part_type_blend(smoke,1);
	part_type_life(smoke,25,50);
	torchParticle2 = smoke;
	
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
	
	part_system_depth(torchSystem1,owner.depth-2);
	part_emitter_region(torchSystem1,torchEmitter1,xx-1,xx+1,yy-1,yy+1,ps_shape_diamond,ps_distr_gaussian);
	part_emitter_burst(torchSystem1,torchEmitter1,smoke,-3);
	part_emitter_burst(torchSystem1,torchEmitter1,fire,6);
	// audio_emitter_position(torchAudioEmitter,xx,yy,owner.depth-1);
	
	audio_emitter_position(torchAudioEmitter,owner.x,owner.y,owner.depth-1);
	
	// set the torch light radius position
	with torchLightRadius {
		
		var positionTorchAtOwner = false;
		with obj_wall_parent {
			if distance_to_point(xx,yy) < 20 && layer == other.layer {
				positionTorchAtOwner = true;
			}
		}
		
		// if the torch light is actually in a caster, this can look like shit, so make sure its not
		if !positionTorchAtOwner {
			x = xx; y = yy;
		} else {
			x = owner.x; y = owner.y;
		}
	}
}

