with obj_combatant_parent {
	// only damage non-player combatants if the player has shoved them into the wall
	// this is so the auto-pathing doesnt make AI combatants kill themselves all the time
	var doNotDamage = false;
	if type != CombatantTypes.Player {
		if !isFlinching && state != CombatantStates.Staggering {
			doNotDamage = true;
		}
	}
	if !doNotDamage && other.isActive && distance_to_object(other) < 1 && layer == other.origLayer && other.alarm[7] == 1 {
		damageCombatant(other.damages, 5, (facingDirection + 180) mod 360, snd_magic_fire_hit, other);
	}
}
with obj_factory_pipe {
	if isActive && distance_to_object(other) <1 && origLayer == other.origLayer && other.isActive && !other.isCoolingDown {
		// other.isActive = false;
		audio_play_sound_at(snd_douse_fire, other.x, other.y, other.depth, 100, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
		other.isCoolingDown = true;
		other.alarm[1] = 30;
		other.douser = id;
	}
}

if instance_exists(douser) && !douser.isActive && (!isActive || isCoolingDown) {
	isActive = true;
	isCoolingDown = false;
	sprite_index = spr_block_orange;
	image_xscale = origXScale;
	image_yscale = origYScale;
	light_set_alpha(.95);
	alarm[0] = smokeSteps;
}


if !isActive {
	light_set_alpha(0);
	sprite_index = -1;
}
else if isCoolingDown {
	var alpha = (1/30) * alarm[1];
	light_set_alpha(alpha);
	if alarm[1] < 0 {
		light_set_alpha(.95);
	}
}
else if sprite_index == -1 {
	isCoolingDown = false;
	isActive = true;
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
if isActive && !isCoolingDown {
	// var area = sprite_width * sprite_height;
	// var num = (area) / 9216;
	var floorNum = getLayerFloorNumber(origLayer);
	var pFloorNum = getLayerFloorNumber(global.player.layer);
	if floorNum > pFloorNum exit;
	part_emitter_burst(system, emitter, partCinder, -3);
}