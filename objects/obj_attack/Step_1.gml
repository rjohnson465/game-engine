life --;

if isMelee {
	image_angle = owner.facingDirection;
	x = owner.x;
	y = owner.y;
	image_xscale = owner.scale;
	var isNeg = image_yscale < 0;
	image_yscale = owner.scale;
	if isNeg image_yscale *= -1;
}

// special case - 2h club on 3rd attack create dust particles from hitting the ground
if (weapon != noone && weapon.weaponType == BLUNT2H && attackNumber == 3) {
	
	if image_index != 7 exit;
	
	var xo = weapon.dustXOffset; var yo = weapon.dustYOffset;
	var ofd = owner.facingDirection;
	var sx = owner.x + xo; var sy = owner.y + yo;
	var cx = owner.x; var cy = owner.y;
	var radians = (pi/180) * ofd;
	var cs = cos(radians);
	var sn = sin(radians);
	var nx = (cs * (sx - cx)) + (sn * (sy - cy)) + cx;
	var ny = (cs * (sy - cy)) - (sn * (sx - cx)) + cy;
	
	xx = nx;
	yy = ny;
	global.damageType = "Ground";
	global.x1 = xx;
	global.y1 = yy;
	global.particleDirection = 0;
	global.hitParticlesLayer = layer;
	global.victim = noone;
	instance_create_depth(x,y,1,obj_hit_particles);
	audio_play_sound(snd_crunchy_thud,1,0);
}

// special case -- sconces light arrows / bolts on fire
var fieryObjs = [obj_sconce, obj_sconce_icy, obj_firepit];
for (var i = 0; i < array_length_1d(fieryObjs); i++) {
	var obj = fieryObjs[i];
	with obj {
		if origLayer == other.layer && isLit && distance_to_object(other) < 2 &&
			!other.isOnFire && other.weapon != noone && (other.weapon.weaponType == BOW || other.weapon.weaponType == CROSSBOW) {
		
			audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,25,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			other.isOnFire = true;
			ds_map_replace(other.additionalDamages,FIRE,[1,5]);
			with other {
				updateWeaponParticles(id);
			}
		}
	}
}
/*
with obj_sconce {
	if origLayer == other.layer && isLit && distance_to_object(other) < 2 &&
		!other.isOnFire && other.weapon != noone && (other.weapon.weaponType == BOW || other.weapon.weaponType == CROSSBOW) {
		
		audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,25,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		other.isOnFire = true;
		ds_map_replace(other.additionalDamages,FIRE,[1,5]);
		with other {
			updateWeaponParticles(id);
		}
	}
} */

/*
with obj_firepit {
	if origLayer == other.layer && isLit && distance_to_object(other) < 2 &&
		!other.isOnFire && other.weapon != noone && (other.weapon.weaponType == BOW || other.weapon.weaponType == CROSSBOW) {
		
		audio_play_sound_at(snd_magic_fire_shoot,x,y,depth,25,AUDIO_MAX_FALLOFF_DIST,1,0,1);
		other.isOnFire = true;
		ds_map_replace(other.additionalDamages,FIRE,[1,5]);
		with other {
			updateWeaponParticles(id);
		}
	}
} */

// general ranged particles algorithm
for (var i = 0; i < array_length_1d(weaponParticles); i++) {
	var part = weaponParticles[i];
	if part != noone && part != undefined && part_type_exists(part) {
		var x1 = bbox_left + lengthdir_x(1,facingDirection); var x2 = bbox_right + lengthdir_x(1,facingDirection);
		var y1 = bbox_top + lengthdir_y(1,facingDirection); var y2 = bbox_bottom + lengthdir_y(2,facingDirection);
	
		part_emitter_region(system, emitter, x1,x2,y1,y2,ps_shape_line,ps_distr_linear);
		part_emitter_burst(system, emitter, part, 2);
	}
}







var isHittingSolid = false;
with obj_solid_environment {
	var _dist = distance_to_object(other);
	if _dist <= 1 && layer == other.layer {
		isHittingSolid = true;
		var a = 3;
	}
}


if place_meeting_layer(x,y,obj_solid_environment) || isHittingSolid {
	var x1 = x + lengthdir_x(100,facingDirection);
	var y1 = y + lengthdir_y(100,facingDirection);
	var firstObj = noone;
	var possibleSolids = scr_collision_line_list_layer(x,y,x1,y1,obj_solid_parent,true,true, true);
	if possibleSolids != noone {
		//var closestDist = 1000;
		for (var i = 0; i < ds_list_size(possibleSolids); i++) {
			var el = ds_list_find_value(possibleSolids,i);
			var _dist = distance_to_object(el);
			var _isTouching = place_meeting_layer(x,y,el);
			if !object_is_ancestor(el.object_index,obj_combatant_parent) && _isTouching {
				firstObj = el;
			}
		}
	}
	
	if possibleSolids != noone && ds_exists(possibleSolids, ds_type_list) {
		ds_list_destroy(possibleSolids); possibleSolids = -1;
	}
	
	if firstObj == noone || !firstObj.stopsAttacks exit;
	
	if firstObj.object_index == obj_sconce && isRanged exit; // sconces are a special case

	with obj_enemy_parent {
		if layer == global.player.layer && fallFrame >= fallTotalFrames {
			if place_meeting_layer(x,y,firstObj.id) && state != CombatantStates.Dodging {
				// check if there is a wall between the player and the enemy
				exit;
			}
		}
	}

	if object_is_ancestor(firstObj.object_index,obj_combatant_parent) {
		var a = 3;
		exit;
	}

	if object_is_ancestor(firstObj.object_index, obj_npc_parent) {
		// instance_destroy(id);
		exit;
	}

	if global.player.layer == layer && (firstObj.layer != layer && abs(abs(firstObj.depth)-abs(depth)) > 5) {
		exit;
	}
	
	//var hitsWallFirst = object_is_ancestor(firstObj.object_index
	if isMelee {
		if owner.type == CombatantTypes.Player {
			if weapon.weaponType != UNARMED {
				damageItem(weapon,1/3);
			}
		}
		owner.staggerFrame = 0;
		owner.staggerDuration = 5;
		owner.staggerDirection = (owner.facingDirection+180)%360;
		path_end();
		// run to get __x and __y (collision point where attack meet this combatant)
		if script_execute(scr_collision_point,id,firstObj.id) {

			global.damageType = firstObj.material == METAL ? "Block" : "Dust";
			if firstObj.material == ICE_MAT {
				global.damageType = ICE;
			}
			if owner.type == CombatantTypes.Player && weapon.weaponType == UNARMED {
				global.damageType = "Dust";
			}
			global.x1 = __x;
			global.y1 = __y;
			global.particleDirection = facingDirection;
			global.hitParticlesLayer = layer;
			global.victim = firstObj;
			instance_create_depth(0,0,1,obj_hit_particles);
			if !isSpell {
				// play wall hit sound, dependent on type of material wall is
				var snd = global.damageType == "Dust" ? snd_shield_hit_wood : snd_wallhit;
					if firstObj.material == ICE_MAT {
					snd = snd_hit_ice_1;
				}
				audio_play_sound_at(snd,__x,__y,depth,100,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			}
		}
	
		if owner.hasHands {
			ds_map_delete(owner.attackingLimbs,limbKey);
		}
	
		instance_destroy(id,true);
		if !owner.cannotStagger {
			owner.state = CombatantStates.Staggering;
		}
	}
	
	// make dust / spark particles, play sound, for range
	if isRanged && !hasSetAlarm {
		
		if attackData != noone && !attackData.stopsAtObstacles {
			exit;
		}
		else if attackData != noone && attackData.bouncesOffWalls {
			// iff bounce of walls, set direction to some kinda perpindicular direction
			randomize();
			var rand = random_range(-45, 45);
			direction = ((direction+180) %360) + rand;
			facingDirection = direction;
			var snd = firstObj.material == METAL ? snd_wallhit : snd_shield_hit_wood;
			if firstObj.material == ICE_MAT {
				snd = snd_hit_ice_1;
			}
			
			// only play bounce sound once every 7 frames, at maximum
			if alarm[2] <= 0 {
				audio_play_sound_at(snd,x,y,depth,20,AUDIO_MAX_FALLOFF_DIST,1,0,1);
				alarm[2] = 7;
			}
			exit;
			
		} else {
			global.damageType = firstObj.material == METAL ? "Block" : "Dust";
			if isSpell {
				global.damageType = spellElement;
			}
			if firstObj.material == ICE_MAT {
				global.damageType = ICE;
			}
			global.x1 = x + lengthdir_x(bbox_right-bbox_left,facingDirection);
			global.y1 = bbox_bottom;
			global.particleDirection = facingDirection;
			global.hitParticlesLayer = layer; 
			global.victim = firstObj;
			instance_create_depth(0,0,1,obj_hit_particles);
			alarm[0] = 60;
			if attackData != noone && attackData.hasLightRadius {
				alarm[0] = 15;
			}
			visible = 0;
			speed = 0;
			hasSetAlarm = true;
			if !isSpell {
				var snd = firstObj.material == METAL ? snd_wallhit : snd_shield_hit_wood;
				if firstObj.material == ICE_MAT {
					snd = snd_hit_ice_1;
				}
				audio_play_sound_at(snd,global.x1,global.y1,depth,20,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			} else {
				audio_stop_sound(sound);
				var snd = noone;
				if owner.object_index == global.player {
					snd = asset_get_index("snd_magic_"+owner.currentSpellAttunement+"_hit");
				} else {
					// var dmgArr = ds_map_find_value(attackData.damages, 0);
					var dmgType = ds_map_find_first(attackData.damages);
					switch dmgType {
						case MAGIC: { snd = snd_magic_magic_hit; break; }
						case FIRE: { snd = snd_magic_fire_hit; break; }
						case ICE: { snd = snd_magic_ice_hit; break; }
						case POISON: { snd = snd_magic_poison_hit; break; }
						case LIGHTNING: { snd = snd_magic_lightning_hit; break; }
					}
				}
				audio_play_sound_at(snd,global.x1,global.y1,depth,20,AUDIO_MAX_FALLOFF_DIST,1,0,1);
			}
		}
	}

	if isSpell && !hasSetAlarm {
		var attunement = MAGIC;
		for (var i = 0; i < array_length_1d(global.ALL_ELEMENTS); i++) {
			var el = global.ALL_ELEMENTS[i];
			var arr = ds_map_find_value(spell.damages,el);
			if arr[1] != 0 {
				attunement = global.ALL_ELEMENTS[i];
			}
		}
		global.damageType = attunement;
		global.x1 = x + lengthdir_x(bbox_right-bbox_left,facingDirection);
		global.y1 = bbox_bottom;
		global.particleDirection = facingDirection;
		global.hitParticlesLayer = layer;
		instance_create_depth(0,0,1,obj_hit_particles);
		//instance_destroy(id,true);
		alarm[0] = 60;
		if attackData != noone && attackData.hasLightRadius {
			alarm[0] = 15;
		}
		visible = 0;
		speed = 0;
		x = global.x1;
		y = global.y1;
		hasSetAlarm = true;
	}

	if isRanged && !hasSetAlarm {
		var idd = id;
		with obj_light_radius {
			if owner == idd {
				instance_destroy(id);
			}
		}
	}
	
}


