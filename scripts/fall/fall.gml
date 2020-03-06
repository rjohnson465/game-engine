/// fall(isRidgeFall)
/// @param isRidgeFall

var isRidgeFall = false;
if argument_count > 0 {
	isRidgeFall = argument[0];
}

// stop any and all attacks

if object_index == global.player {
	currentInteractableObject = noone;
}

if currentSpellPrepSound != noone {
	audio_stop_sound(currentSpellPrepSound);
}

// stop preparing attacks
if ds_map_size(preparingLimbs) != 0 {
	var hand = ds_map_find_first(preparingLimbs);
	for (var i = 0; i < ds_map_size(preparingLimbs); i++) {
		ds_map_replace(prepFrames,hand,-1);
		ds_map_replace(prepFrameTotals,hand,0);
		ds_map_delete(preparingLimbs,hand);
		hand = ds_map_find_next(preparingLimbs,hand);
	}
}
// stop attacking
if ds_map_size(attackingLimbs) != 0 {
	var hand = ds_map_find_first(attackingLimbs);
	for (var i = 0; i < ds_map_size(attackingLimbs); i++) {
		ds_map_delete(attackingLimbs,hand);
		hand = ds_map_find_next(attackingLimbs,hand);
	}
}
// stop recovering attacks
if ds_map_size(recoveringLimbs) != 0 {
	var hand = ds_map_find_first(recoveringLimbs);
	for (var i = 0; i < ds_map_size(recoveringLimbs); i++) {
		ds_map_replace(recoveringLimbs,hand,-1);
		ds_map_replace(recoveringLimbs,hand,0);
		ds_map_delete(recoveringLimbs,hand);
		hand = ds_map_find_next(recoveringLimbs,hand);
	}
}
isStrafing = false;
currentUsingSpell = noone;
attackNumberInChain = noone;
isShielding = false;
isSprinting = false;
dodgeFrame = 0;

jumpFrame = jumpTotalFrames; // cannot jump while falling
if fallFrame == 0 {
	audio_play_sound_at(snd_fall, x, y, depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
}
fallFrame++;

if fallFrame >= fallTotalFrames && isRidgeFall {
	mightFallOffRidge = false;
}

if fallFrame == .5*fallTotalFrames {
	
	if !isRidgeFall {
		var layerName = layer_get_name(layer);
		var layerNum = real(string_char_at(layerName,string_length(layerName)));
		var lowerLayerNum = layerNum-1;
		var lowerLayer = layer_get_id("instances_floor_"+string(lowerLayerNum));
	
		// lower layer doesn't exit? we fallin to our deaths brotha
		if lowerLayer < 0 || lowerLayerNum < 1 {
			hp = 0;
		
			// check if the layer we were on had deep water and that we were standing on it when we fell
			var deepWaterLayer = layer_get_id("tiles_waterdeep_floor_"+string(layerNum));
			if deepWaterLayer >= 0 {
				var tmap = layer_tilemap_get_id(deepWaterLayer);
				var tile = tilemap_get_at_pixel(tmap,x,y);
				if tile >= 0 {
					// if so, play splash snd
					audio_play_sound_at(snd_splash,x,y,layer_get_depth(layer),50,AUDIO_MAX_FALLOFF_DIST,1,0,1);
				
					// Make splash particles
					var ftn = instance_nearest(x, y, obj_fountain);
					if instance_exists(ftn) {
						var waterPart = ftn.particle;
						part_system_depth(sprintParticleSystem, depth-1);
						part_emitter_region(sprintParticleSystem, sprintParticleEmitter, x-10, x+10, y-10, y+10, ps_shape_ellipse, ps_distr_gaussian);
						part_emitter_burst(sprintParticleSystem, sprintParticleEmitter, waterPart, 100);
					}
				}
			} else {
				audio_play_sound_at(snd_crunchy_thud,x,y,layer_get_depth(layer),50,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			}
			exit;
		}

		var oldLayer = layer;
		layer = lowerLayer;
		var lr = noone;
		with obj_light_radius {
			if owner == other lr = id;
		}
		if lr != noone {
			updateLightLayer(lr,oldLayer,layer);
		}
		global.isUpdatingRoomLayers = true;
	}
	
	// check if we should keep falling
	var keepFalling = false;
	with obj_fallzone {
		var d = point_in_rectangle(other.bbox_left+10,other.bbox_top+10,bbox_left,bbox_top,bbox_right,bbox_bottom);
		var e = point_in_rectangle(other.bbox_right-10,other.bbox_bottom-10,bbox_left,bbox_top,bbox_right,bbox_bottom);
		if	d && e && layer == other.layer {
			if !place_meeting_layer(other.x, other.y, obj_bridge_parent) {
				keepFalling = true;
			}
		}
	}
	if keepFalling {
		fallFrame = 0;
		floorsFallen++;
	}
	else {
		isFalling = false;
		jumpToNearestFreePoint();
		// take damage if you did not land on a fallbreaker
		var fallbreaker = noone;
		with obj_fallbreaker_parent {
			if origLayer == other.layer && place_meeting(x, y, other) {
				fallbreaker = id;
			}
		}
		if !instance_exists(fallbreaker) {
			global.damageType = PHYSICAL;
			global.x1 = x;
			global.y1 = y;
			global.particleDirection = direction;
			global.hitParticlesLayer = layer;
			global.victim = id;
			instance_create_depth(0,0,1,obj_hit_particles);
			var fallDamage = 10*floorsFallen;
			if fallDamage > hp {
				fallDamage = hp;
			}
			global.damageAmount = fallDamage;
			global.victim = id;
			global.healingSustained = 0;
			global.isCriticalHit = false;
			instance_create_depth(x,y,1,obj_damage);
			hp -= fallDamage;
			audio_play_sound(snd_crunchy_thud,1,0);
		} else {
			// if fallbreaker is landed on...
			if instance_exists(fallbreaker) {
				with fallbreaker {
					// emit particles below fallen combatant
					part_system_depth(system, other.depth + 5);
					part_emitter_region(system, emitter, other.x, other.x, other.y, other.y, ps_shape_ellipse, ps_distr_gaussian);
					for (var i = 0; i < array_length_1d(particles); i++) {
						var pArr = particles[i];
						var p = pArr[0];
						if part_type_exists(p) {
							var pNum = pArr[1];
							part_emitter_burst(system, emitter, p, pNum);
						}
					}
				
					// play sound
					audio_play_sound_at(fallbreakSound, other.x, other.y, other.depth, 50, AUDIO_MAX_FALLOFF_DIST, 1, 0, 1);
				}
			}
		}
		floorsFallen = 0;
		tempPostX = x;
		tempPostY = y;
		if type == CombatantTypes.Enemy {
			updatePersistentElementProperty(id, "TempPostX", tempPostX);
			updatePersistentElementProperty(id, "TempPostY", tempPostY);
			updatePersistentElementProperty(id, "TempPostZ", layer);
		}
		populatePersonalGrid();
	}
}
state = CombatantStates.Idle;
path_end();
speed = 0;