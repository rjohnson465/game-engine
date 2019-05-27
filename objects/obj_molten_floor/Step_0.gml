with obj_combatant_parent {
	if other.isActive && distance_to_object(other) < 1 && layer == other.origLayer && other.alarm[7] == 1 {
		damageCombatant(other.damages, 5, (facingDirection + 180) mod 360, snd_magic_fire_hit, other);
	}
}
with obj_factory_pipe {
	if isActive && distance_to_object(other) <1 && origLayer == other.origLayer {
		other.isActive = false;
		other.douser = id;
	}
}

if instance_exists(douser) && !douser.isActive {
	isActive = true;
}


if !isActive {
	light_set_alpha(0);
	sprite_index = -1;
} else if sprite_index == -1 {
	sprite_index = spr_block_orange;
	image_xscale = origXScale;
	image_yscale = origYScale;
	light_set_alpha(.95);
	alarm[0] = smokeSteps;
}

scale = .1*cos((pi*scaleFrame)/(scaleTotalFrames * .5))+1.3;
scaleFrame = (scaleFrame + 1)%scaleTotalFrames;

light_set_multiscale(lightScaleX*scale, lightScaleY*scale);

// cinder particles
if isActive {

	var area = sprite_width * sprite_height;
	var num = (area) / 9216;
	part_emitter_burst(system, emitter, partCinder, -3);
	
}